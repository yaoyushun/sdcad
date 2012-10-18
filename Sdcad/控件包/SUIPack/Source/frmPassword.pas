////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   frmPassword.pas
//  Creator     :   Shen Min
//  Date        :   2003-03-31
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit frmPassword;

interface

{$I SUIPack.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, StdCtrls, SUIEdit, SUIButton;

type
  TfrmPass = class(TForm)
    suiForm1: TsuiForm;
    edt1: TsuiEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt2: TsuiEdit;
    btn1: TsuiButton;
    btn2: TsuiButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPass: TfrmPass;

implementation

{$R *.dfm}

end.
