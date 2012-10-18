{**********************************************}
{   TeeChart PageNum Tool                      }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeePageNumTool;
{$I TeeDefs.inc}

// This unit implements a Chart Tool example:

{
   TPageNumTool

      This tool derives from Annotation tool.
      It is used to display the current chart page number.

      The Chart MaxPointsPerPage property should be bigger than zero,
      to divide a chart in pages.

      Can be useful both for screen and print / print preview.

      This tool is automatically used by the Chart Editor dialog at
      "Paging" tab, when this unit is used in your application.
}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, TeCanvas, TeEngine, Chart, TeeTools;

type
  TPageNumTool=class(TAnnotationTool)
  private
    Function GetFormat:String;
    function IsFormatStored: Boolean;
  protected
    Function GetText:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
  published
    property Format:String read GetFormat write SetText stored IsFormatStored;
  end;

implementation

Uses SysUtils, TeeConst, TeeProcs, TeeProCo;

{ TPageNumTool }
Constructor TPageNumTool.Create(AOwner: TComponent);
begin
  inherited;
  Format:=TeeMsg_PageOfPages;
end;

Function TPageNumTool.GetText:String;
begin
  result:= SysUtils.Format( Format,
            [TCustomChart(ParentChart).Page,TCustomChart(ParentChart).NumPages]);
end;

class function TPageNumTool.Description: String;
begin
  result:=TeeMsg_PageNumber;
end;

function TPageNumTool.IsFormatStored: Boolean;
begin
  result:=Format<>TeeMsg_PageOfPages;
end;

function TPageNumTool.GetFormat: String;
begin
  result:=Text;
end;

initialization
  RegisterTeeTools([TPageNumTool]);
  TeePageNumToolClass:=TPageNumTool;
finalization
  TeePageNumToolClass:=nil;
  UnRegisterTeeTools([TPageNumTool]);
end.
