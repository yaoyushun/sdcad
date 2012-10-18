////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   frmConvert.pas
//  Creator     :   Shen Min
//  Date        :   2003-02-26
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit frmConvert;

interface

{$I SUIPack.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmConv = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cb_theme: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConv: TfrmConv;

implementation

{$R *.dfm}

end.
