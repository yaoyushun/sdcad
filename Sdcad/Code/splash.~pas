unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg;

type
  TSplashForm = class(TForm)
    Timer1: TTimer;
    imgBackGround: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure imgBackGroundClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashForm: TSplashForm;
  m_Bitmap: TBitmap;
implementation

{$R *.dfm}

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  m_Bitmap:= TBitmap.Create;
  m_Bitmap.Width := imgBackGround.Picture.Width;
  m_Bitmap.Height := imgBackGround.Picture.Height;
  m_Bitmap.PixelFormat := pf24bit;
  m_Bitmap.Canvas.Draw(0,0,imgBackGround.Picture.Graphic);
  self.Brush.Bitmap := m_Bitmap;
end;

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

procedure TSplashForm.imgBackGroundClick(Sender: TObject);
begin
  timer1.Enabled := false;
end;

procedure TSplashForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  m_Bitmap.Free;
end;

end.
