{*******************************************}
{  TSmoothingFunction                       }
{  Copyright (c) 2002-2004 by David Berneda }
{  With permission from M. v. Engeland      }
{*******************************************}
Unit TeeSpline;
{$I TeeDefs.inc}

{------------------------------------------------------------------------------}
{                                                                              }
{ This code was written by : M. v. Engeland                                    }
{                                                                              }
{ This code is copyright 2000 by                                               }
{       M. v. Engeland                                                         }
{                                                                              }
{                                                                              }
{   This is the followup of the B-splines component posted in 1997.            }
{   Some bugs were fixed, and some changes were made. The splines now use      }
{   dynamic allocation of memory when needed when adding points to the spline. }
{   If the number of points to be added is known in advance, the the precise   }
{   amount of memory can be allocated setting the capacity property.           }
{                                                                              }
{   The conditions for using this component however are not changed:           }
{   You may use this component in any way you want to, whether it is for       }
{   commercial purposes or not, as long as you don't hold me responsible for   }
{   any disasters it may cause. But I would appreciate it if you would send me }
{   an e-mail (martijn@dutw38.wbmt.tudelft.nl) to tell me what you use it for  }
{   because over the last three years I've learned that it has been used for   }
{   a wide variaty of interesting applications which it was initially never    }
{   intended for. Besides, it's nice to know how your offspring's doing.       }
{   Also all comments and/or remarks are welcome.                              }
{                                                                              }
{   See the demo program for how to use the component.                         }
{   Special attention is payed on the possibility of interpolating the         }
{   vertices. As you may or may not know, B-Splines normally do not            }
{   interpolate the used controlpoints. Thanks to simple matrix calculation    }
{   however it is possible to interpolate the controlpoints by calculating     }
{   new vertices in such a way that the spline interpolates the original ones. }
{------------------------------------------------------------------------------}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, TeEngine;

const MaxFragments            = 600; // The maximum of straight line segments allowed for drawing the spline
      MaxResults              = MaxFragments+10; // Max. number of calculated intersections

  // 6.01 Removed max limit. No longer necessary.
  // Warning: More than 500 points takes huge CPU time.
  // MaxInterpolatedVertices :Integer= 250; // The maximum number of vertices that can be interpolated, up to 16000 allowed

      MaxCalcSteps            = 150; // Number of steps for numerical intersection calculating
      MaxError                = 1e-5;// Max error for intersection calculating
      MaxIterations           = 80;
      VerticesIncrement       = 25;  // Number of vertices to allocate memory for when the count property exceeds the current capacity

type
   TDataType=Double;

   TVertex=packed record
     X,Y : TDataType;
   end;

   // The following dynamic array is used to store the desired user-specified controlpoints
   T2DPointList = array of TVertex;

   // The vertexlist is used internally to make the spline interpolate the controlpoints
   TVertexList  = array of TVertex;

   // The knuckle list stores a flag to see whether a point is a knuckle or not
   TKnuckleList = array of Boolean;

   // The following tpes are used for the interpolation routines
   TMatrixRow = array of TDataType;

   // 2D B-spline class
   TBSpline=class {$IFDEF CLR}sealed{$ENDIF}
   private
    Matrix         : Array of TMatrixRow;
    FNoPoints      : Integer;
    FCapacity      : Integer;
    FPointList     : T2DPointList;
    FVertexList    : TVertexList;
    FKnuckleList   : TKnuckleList;
    FBuild         : Boolean;
    FNoVertices    : Integer;
    FInterpolated  : boolean;
    FFragments     : Integer;

    procedure ClearVertexList;
    procedure FSetBuild(Val:Boolean);
    procedure SetCapacity(NewCapacity:Integer);
    procedure FSetInterpolated(const Value:Boolean);
    procedure FSetFragments(Const Value:Integer);
    function  FGetPoint(Index:Integer):TVertex;
    procedure FSetPoint(Index:Integer; const Value:TVertex);
    function  FGetKnuckle(Index:Integer):Boolean;
    procedure FSetKnuckle(Index:Integer; Value:Boolean);
    function  FGetNumberOfVertices:Integer;
    procedure FInterpolate;
    procedure FPhantomPoints;
   public
    Constructor Create;
    destructor Destroy; override;

    procedure AddPoint(const X,Y:TDataType);
    procedure Clear;
    property Count:Integer read FNoPoints;
    function Value(const Parameter:TDataType):TVertex;
    procedure Rebuild;
    property Build: Boolean read FBuild write FSetBuild;
    property Fragments: Integer read FFragments write FSetFragments;
    property Interpolated: Boolean read FInterpolated write FSetInterpolated;
    property NumberOfVertices: Integer read FGetNumberOfVertices;
    property Point[Index:Integer]: TVertex read FGetPoint write FSetPoint;
    property Knuckle[Index:integer]: Boolean read FGetKnuckle write FSetKnuckle;
  end;

  TSmoothingFunction=class(TTeeFunction)
  private
    FInterpolate: Boolean;
    FFactor: Integer;
    procedure SetFactor(const Value: Integer);
    procedure SetInterpolate(const Value: Boolean);
  protected
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    property Interpolate: Boolean read FInterpolate write SetInterpolate default True;
    property Factor:Integer read FFactor write SetFactor default 4;
  end;

implementation

uses Math, SysUtils, Chart, TeeConst, TeeProCo;

{ TBSpline }
constructor TBSpline.Create;
begin
  inherited;
  Clear;
end;

destructor TBSpline.Destroy;
begin
  Clear;
  inherited;
end;

procedure TBSpline.FSetBuild(val:boolean);
begin
  if not val then
  begin
    // Release allocated memory for vertices
    if FBuild then ClearVertexList;
    FNoVertices:=0;
  end;
  FBuild:=Val;
end;

procedure TBSpline.SetCapacity(NewCapacity:Integer);
var t : Integer;
begin
  if NewCapacity<>FCapacity then
  begin
    if NewCapacity>0 then
    begin
      SetLength(FPointList,NewCapacity*SizeOf(TVertex));
      SetLength(FKnuckleList,NewCapacity);
      for t:=0 to NewCapacity-1 do FKnuckleList[t]:=False;
    end;

    FCapacity:=NewCapacity;
  end;
end;

procedure TBSpline.FSetFragments(Const Value:integer);
begin
  if FFragments<>value then
  begin
    FFragments:=Value;
    if FFragments>MaxFragments then FFragments:=MaxFragments;
 end;
end;

procedure TBSpline.FSetInterpolated(const Value:boolean);
begin
  if Value<>FInterpolated then
  begin
    FInterpolated:=value;
    Build:=false;
  end;
end;

function TBSpline.FGetPoint(Index:Integer):TVertex;
begin
  Result:=FPointList[Index];
end;

procedure TBSpline.FSetPoint(Index:Integer; const Value:TVertex);
begin
  FPointList[Index]:=Value;
  Build:=False;
end;

function TBSpline.FGetKnuckle(Index:integer):Boolean;
begin
  if (Index=1) or (Index=FNoPoints) then
     result:=False
  else
     result:=FKnuckleList[Index]
end;

procedure TBSpline.FSetKnuckle(Index:integer;Value:Boolean);
begin
  FKnuckleList[Index]:=Value;
  Build:=False;
end;

function TBSpline.FGetNumberOfVertices:integer;
begin
  if not FBuild then Rebuild;
  result:=FNoVertices;
end;

procedure TBSpline.Rebuild;

  procedure FillMatrix;
  Const MinLimit=1e-5;
  var I,J : integer;
  begin
    if (FNoVertices>2)
      // and (FNoVertices<=MaxInterpolatedVertices)
      then
    begin
      for i:=2 to FNoVertices-1 do
      begin
        Matrix[I][I-1]:=1/6;
        Matrix[I][I]:=2/3;
        Matrix[I][I+1]:=1/6;
      end;

      Matrix[1][1]:=1;
      Matrix[FNoVertices][FNoVertices]:=1;

      I:=3;
      while I<FNoVertices-1 do
      begin
        if (Abs(FVertexList[I].X-FVertexList[I-1].X)<MinLimit) and
           (Abs(FVertexList[I+1].X-FVertexList[I].X)<MinLimit) and
           (Abs(FVertexList[I].Y-FVertexList[I-1].Y)<MinLimit) and
           (Abs(FVertexList[I+1].Y-FVertexList[I].Y)<MinLimit) then
        begin
          for J:=I-1 to I+1 do
          begin
            Matrix[J][J-1]:=0;
            Matrix[J][J]:=1;
            Matrix[J][J+1]:=0;
          end;

          Inc(I,2);
        end
        else Inc(I);
      end;
    end;
  end;


var I,J,t    : integer;
    Vertex2D : TVertex;
begin
  if FNoPoints>1 then
  begin
    ClearVertexList;
    FNoVertices:=0;

    for i:=1 to FNoPoints do
        if Knuckle[I] then Inc(FNoVertices,3)
                      else Inc(FNoVertices,1);

    SetLength(FVertexList,FNoVertices+2);

    J:=0;
    for i:=1 to FNoPoints do
    begin
      Vertex2D:=Point[I];
      if Knuckle[I] then
      begin
        FVertexList[J+1]:=Vertex2D;
        FVertexList[J+2]:=Vertex2D;
        Inc(J,2);
      end;

      FVertexList[J+1]:=FPointList[I];
      Inc(J);
    end;

    if Interpolated then
    begin
      // Init Matrix
      SetLength(Matrix,FNoVertices+1);  // 6.01

      for i:=1 to FNoVertices do
      begin
        SetLength(Matrix[I],FNoVertices+1);  // 6.02
        for t:=0 to FNoVertices-1 do Matrix[i][t]:=0;
      end;

      FillMatrix;
      Finterpolate;

      // Release memory
      for i:=1 to FNoVertices do Matrix[I]:=nil;

      Matrix:=nil;
    end;
  end;
  FBuild:=true;
  FPhantomPoints;
end;

procedure TBSpline.FInterpolate;
var I,J,K  : Integer;
    Factor : TDataType;
    Tmp    : TVertexList;
begin
  if (FNoVertices>2) // and (FNoVertices<MaxInterpolatedVertices)
     then
  begin
    SetLength(Tmp,FNoVertices+2);

    for i:=1 to FNoVertices do
      for J:=I+1 to FNoVertices do
      begin
        factor:=Matrix[J][I]/Matrix[I][I];
        for K:=1 to FNoVertices do
            Matrix[J][K]:=Matrix[J][K]-factor*Matrix[I][K];
        FVertexList[J].x:=FVertexList[J].x-factor*FVertexList[J-1].x;
        FVertexList[J].y:=FVertexList[J].y-factor*FVertexList[J-1].y;
      end;

    Tmp[FNoVertices].x:=FVertexList[FNoVertices].x/Matrix[FNoVertices][FNoVertices];
    Tmp[FNoVertices].y:=FVertexList[FNoVertices].y/Matrix[FNoVertices][FNoVertices];

    for I:=FNoVertices-1 downto 1 do
    begin
      Tmp[I].x:=(1/Matrix[I][I])*(FVertexList[I].x-Matrix[I][I+1]*Tmp[I+1].x);
      Tmp[I].y:=(1/Matrix[I][I])*(FVertexList[I].y-Matrix[I][I+1]*Tmp[I+1].y);
    end;

    ClearVertexList;
    FVertexList:=Tmp;
  end;
end;

procedure TBSpline.AddPoint(const X,Y:Double);
var Vertex : TVertex;
begin
  if FNoPoints=FCapacity then
     SetCapacity(FCapacity+VerticesIncrement);

  Inc(FNoPoints);
  Vertex.X:=X;
  Vertex.Y:=Y;
  Point[FNoPoints]:=Vertex;
  Build:=false;
end;

procedure TBSpline.ClearVertexList;
begin
  FVertexList:=nil;
end;

procedure TBSpline.Clear;
begin
  if NumberOfVertices>0 then ClearVertexList;
  FNoPoints:=0;
  FNoVertices:=0;
  Build:=False;
  SetCapacity(0);
  FInterpolated:=False;
  FFragments:=100;
end;

procedure TBSpline.FPhantomPoints;
var I : integer;
begin
  if NumberOfVertices>1 then
  begin
    I:=0;
    FVertexList[I].X:=2*FVertexList[I+1].X-FVertexList[I+2].X;
    FVertexList[I].Y:=2*FVertexList[I+1].Y-FVertexList[I+2].Y;
    FVertexList[NumberOfVertices+1].X:=2*FVertexList[NumberOfVertices].X-FVertexList[NumberOfVertices-1].X;
    FVertexList[NumberOfVertices+1].Y:=2*FVertexList[NumberOfVertices].Y-FVertexList[NumberOfVertices-1].Y;
  end;
end;

function TBSpline.Value(const Parameter:TDataType):TVertex;
var c,S,E : integer;
    Dist  : TDataType;
    Mix   : TDataType;
    Mid   : TDataType;
begin
  result.X:=0;
  result.Y:=0;

  if FNoPoints<2 then Exit;

  if not FBuild then Rebuild;

  Mid:=(NumberOfVertices-1)*Parameter+1;
  S:=Trunc(Mid-1);
  if S<0 then S:=0;
  E:=S+3;
  if S>FNovertices+1 then S:=FNovertices+1;

  for c:=S to E do
  begin
    dist:=Abs(C-Mid);
    if dist<2 then
    begin
      if dist<1 then mix:=4/6-dist*dist+0.5*dist*dist*dist
                else mix:=(2-dist)*(2-dist)*(2-dist)/6;
      result.x:=Result.x+FVertexList[c].x*mix;
      result.y:=Result.y+FVertexList[c].y*mix;
    end;
  end;
end;

{ TSmoothingFunction }
constructor TSmoothingFunction.Create(AOwner: TComponent);
begin
  inherited;
  CanUsePeriod:=False;
  SingleSource:=True;
  FInterpolate:=True;
  FFactor:=4;
  InternalSetPeriod(1);
end;

procedure TSmoothingFunction.AddPoints(Source: TChartSeries);
var BSpline : TBSpline;
    t       : Integer;
    tmpList : TChartValueList;
begin
  BSpline:=TBSpline.Create;
  try
    with ParentSeries do
    begin
      Clear;

      if YMandatory=Source.YMandatory then  // 7.0
      begin
        NotMandatoryValueList.Order:=loAscending;
        MandatoryValueList.Order:=loNone;
        CalcVisiblePoints:=True;
      end
      else
      begin
        NotMandatoryValueList.Order:=loNone;
        MandatoryValueList.Order:=loAscending;
        CalcVisiblePoints:=False;
      end;
    end;

    if Source.Count>0 then
    begin
      tmpList:=ValueList(Source);

      With Source do
      for t:=0 to Count-1 do
      begin
        if ParentSeries.YMandatory then
           BSpline.AddPoint(XValues.Value[t],tmpList.Value[t])
        else
           BSpline.AddPoint(tmpList.Value[t],XValues.Value[t]);

        BSpline.Knuckle[t]:=False;
      end;

      BSpline.Interpolated:=Interpolate;
      BSpline.Fragments:=Source.Count*Factor;

      with BSpline do
      for t:=0 to Fragments do
          with Value(t/Fragments) do
               if ParentSeries.YMandatory then ParentSeries.AddXY(X,Y)
                                          else ParentSeries.AddXY(Y,X);
    end;
  finally
    BSpline.Free;
  end;
end;

procedure TSmoothingFunction.SetFactor(const Value: Integer);
begin
  if FFactor<>Value then
  begin
    FFactor:=Math.Max(1,Value);
    Recalculate;
  end;
end;

procedure TSmoothingFunction.SetInterpolate(const Value: Boolean);
begin
  if FInterpolate<>Value then
  begin
    FInterpolate:=Value;
    Recalculate;
  end;
end;

class function TSmoothingFunction.GetEditorClass: String;
begin
  result:='TSmoothFuncEditor';
end;

initialization
  RegisterTeeFunction( TSmoothingFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionSmooth,
                                           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
finalization
  UnRegisterTeeFunctions([TSmoothingFunction]);
end.
