////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   frmInput.pas
//  Creator     :   Shen Min
//  Date        :   2003-04-22
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit frmInput;

interface

{$I SUIPack.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, StdCtrls, SUIEdit, SUIButton;

type
  TfrmInput = class(TForm)
    suiForm1: TsuiForm;
    lbl_prompt: TLabel;
    edt_value: TsuiEdit;
    btn1: TsuiButton;
    btn2: TsuiButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
