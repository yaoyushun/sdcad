{******************************************}
{   TDraw3D component                      }
{ Copyright (c) 1995-2004 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeDraw3D;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     {$IFDEF CLX}
     Types,
     {$ENDIF}
     Classes, TeeProcs;

type
  TDraw3DPaintEvent=procedure(Sender:TObject; Const ARect:TRect) of object;

  TDraw3D=class(TCustomTeePanelExtended)
  private
    FOnPaint : TDraw3DPaintEvent;
  protected
    Procedure InternalDraw(Const UserRectangle:TRect); override;
  published
    { TCustomTeePanelExtended properties }
    property BackImage;
    property BackImageMode;
    property Border;
    property BorderRound;
    property Gradient;
    property OnAfterDraw;

    { TCustomTeePanel properties }
    property BufferedDisplay default True;
    property MarginLeft;
    property MarginTop;
    property MarginRight;
    property MarginBottom;
    property MarginUnits;
    property Monochrome;
    property PrintProportional;
    property PrintResolution;
    property Shadow;
    property View3D;
    property View3DOptions;
    property OnPaint:TDraw3DPaintEvent read FOnPaint write FOnPaint;

    { TPanel properties }
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;

    {$IFDEF CLX}
    property Bitmap;
    {$ENDIF}

    property BorderWidth;
    property Color;
    {$IFNDEF CLX}
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property Locked;
    {$ENDIF}

    { TPanel events }
    property OnClick;
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDrag;
    {$IFNDEF CLX}
    property OnCanResize;
    {$ENDIF}
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}

    {$IFDEF K3}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
  end;

implementation

{ TDraw3D }
Procedure TDraw3D.InternalDraw(Const UserRectangle:TRect);
var Old : Boolean;
    tmp : TRect;
    OldRect : TRect;
begin
  Old:=AutoRepaint;
  AutoRepaint:=False;

  tmp:=UserRectangle;

  if not InternalCanvas.SupportsFullRotation then
     PanelPaint(tmp);

  RecalcWidthHeight;
  Width3D:=100;
  InternalCanvas.Projection(Width3D,ChartBounds,ChartRect);

  InternalCanvas.Projection(Width3D,ChartBounds,ChartRect);

  if InternalCanvas.SupportsFullRotation then
  begin
    OldRect:=ChartRect;
    ChartRect:=tmp;
    PanelPaint(UserRectangle);  // 7.0
    ChartRect:=OldRect;
  end;

  Canvas.ResetState;
  if Assigned(FOnPaint) then FOnPaint(Self,UserRectangle);
  if Zoom.Active then DrawZoomRectangle;
  Canvas.ResetState;
  if Assigned(FOnAfterDraw) then FOnAfterDraw(Self);
  AutoRepaint:=Old;
end;

end.
