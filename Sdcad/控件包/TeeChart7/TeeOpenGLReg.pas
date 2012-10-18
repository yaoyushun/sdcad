{********************************************}
{      TeeOpenGL Component Registration      }
{   Copyright (c) 1999-2004 by David Berneda }
{         All Rights Reserved                }
{********************************************}
unit TeeOpenGLReg;
{$I TeeDefs.inc}

interface

procedure Register;

implementation

Uses Classes,
     {$IFDEF D6}
     DesignIntf,
     DesignEditors,
     {$ELSE}
     DsgnIntf,
     {$ENDIF}
     TeeGLEditor, TeeOpenGL, TeeConst;

type TTeeOpenGLCompEditor=class(TComponentEditor)
     public
       procedure ExecuteVerb( Index : Integer ); override;
       function GetVerbCount : Integer; override;
       function GetVerb( Index : Integer ) : string; override;
     end;

{ TTeeOpenGLCompEditor }
procedure TTeeOpenGLCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index<>0 then inherited ExecuteVerb(Index)
  else
    if EditTeeOpenGL(nil,Component as TTeeOpenGL) then
       Designer.Modified;
end;

function TTeeOpenGLCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+1;
end;

function TTeeOpenGLCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;

procedure Register;
begin
  RegisterComponents(TeeMsg_TeeChartPalette,[TTeeOpenGL]);
  RegisterComponentEditor(TTeeOpenGL,TTeeOpenGLCompEditor);
end;

end.
