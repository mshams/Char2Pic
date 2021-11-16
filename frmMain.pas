unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtDlgs, Menus, StdCtrls, jpeg, ExtCtrls, uCommands, frmAbout;

type
  TfMain = class(TForm)
    mnu: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    SaveEvoPic1: TMenuItem;
    ImportEvoPic1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Run1: TMenuItem;
    Start1: TMenuItem;
    ClearEvoPic1: TMenuItem;
    Setting1: TMenuItem;
    Normalpriority1: TMenuItem;
    Highpriority1: TMenuItem;
    N2: TMenuItem;
    Persianalphabet1: TMenuItem;
    Englishalphabet1: TMenuItem;
    Customalphabet1: TMenuItem;
    N3: TMenuItem;
    Customfont1: TMenuItem;
    About1: TMenuItem;
    SaveDlg: TSavePictureDialog;
    OpenDlg: TOpenPictureDialog;
    FontDlg: TFontDialog;
    Page: TPageControl;
    Tab1: TTabSheet;
    Tab2: TTabSheet;
    Scrl1: TScrollBox;
    Scrl2: TScrollBox;
    img: TImage;
    pb: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    N4: TMenuItem;
    Custombackgroundcolor1: TMenuItem;
    ColorDlg: TColorDialog;
    Image2x21: TMenuItem;
    Image3x31: TMenuItem;
    Customdimention1: TMenuItem;
    Image1x11: TMenuItem;
    Progress: TProgressBar;
    Scallingoption1: TMenuItem;
    Grayscale1: TMenuItem;
    Randomchars1: TMenuItem;
    RandomOrdered1: TMenuItem;
    N5: TMenuItem;
    Saveashtml1: TMenuItem;
    SavHtmDlg: TSaveDialog;
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Open1Click(Sender: TObject);
    procedure pbMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Start1Click(Sender: TObject);
    procedure SaveEvoPic1Click(Sender: TObject);
    procedure ClearEvoPic1Click(Sender: TObject);
    procedure Normalpriority1Click(Sender: TObject);
    procedure Highpriority1Click(Sender: TObject);
    procedure Persianalphabet1Click(Sender: TObject);
    procedure Englishalphabet1Click(Sender: TObject);
    procedure Customalphabet1Click(Sender: TObject);
    procedure Customfont1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ImportEvoPic1Click(Sender: TObject);
    procedure Custombackgroundcolor1Click(Sender: TObject);
    procedure Image2x21Click(Sender: TObject);
    procedure Image3x31Click(Sender: TObject);
    procedure Image1x11Click(Sender: TObject);
    procedure Customdimention1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Saveashtml1Click(Sender: TObject);
  private
    procedure SetDestSize(Source, Dest: TImage; Dimention: byte = 1);
    { Private declarations }
  public
    { Public declarations }
  end;

  TCustomOption = Record
    AlphabetEnglish: Boolean;
    AlphabetChars: WideString;
    AlphabetSize: byte;
    AlphabetFont: TFontName;
  End;

var
  fMain: TfMain;
  Option: TCustomOption;
  EvoPic: TEvoPic;
  Stopped: Boolean = false;
  BackColor: TColor = clblack;
  Dimention: byte = 1;

implementation

{$R *.dfm}
{$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$SetPEFlags IMAGE_FILE_DEBUG_STRIPPED}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

procedure TfMain.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TfMain.ClearEvoPic1Click(Sender: TObject);
begin
  EvoPic.ClearCanvas(BackColor);
end;

procedure TfMain.Customalphabet1Click(Sender: TObject);
var
  ws: WideString;
begin
  ws := InputBox('Custom alphabet', 'Please enter your alphabet characters:',
    '1234567890abcdefghijklmnopqrstuvwxyz<>/?,;:!@#$%&*-+=');

  if ws <> '' then
  begin
    if EvoPic <> nil then
      EvoPic.SetAlphabetCustom(ws);
    Option.AlphabetChars := ws;
  end;
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Custombackgroundcolor1Click(Sender: TObject);
begin
  if ColorDlg.Execute(fMain.Handle) then
    BackColor := ColorDlg.Color;
end;

procedure TfMain.Customdimention1Click(Sender: TObject);
var
  d: string;
begin
  d := InputBox('Custom dimention', 'Please enter destination dimension:', '4');

  if StrToIntDef(d, 0) <> 0 then
    Dimention := StrToInt(d);
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Customfont1Click(Sender: TObject);
begin
  if FontDlg.Execute(fMain.Handle) then
  begin
    if EvoPic <> nil then
      EvoPic.SetAlphabetFont(FontDlg.Font.Name, FontDlg.Font.Size);
    Option.AlphabetFont := FontDlg.Font.Name;
    Option.AlphabetSize := FontDlg.Font.Size;
  end;
end;

procedure TfMain.Englishalphabet1Click(Sender: TObject);
begin
  if EvoPic <> nil then
    EvoPic.SetAlphabet(false);
  Option.AlphabetEnglish := false;
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Exit1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfMain.Highpriority1Click(Sender: TObject);
begin
  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Image1x11Click(Sender: TObject);
begin
  Dimention := 1;
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Image2x21Click(Sender: TObject);
begin
  Dimention := 2;
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Image3x31Click(Sender: TObject);
begin
  Dimention := 3;
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  p: TColor;
begin
  p := (Sender as TImage).Canvas.Pixels[X, Y];
  lbl1.Caption := Format('R:%.3d G:%.3d B:%.3d ', [GetRValue(p), GetGValue(p), GetBValue(p)])
    + ColorToString(p);
end;

procedure TfMain.ImportEvoPic1Click(Sender: TObject);
var
  m: TImage;
begin
  if OpenDlg.Execute then
    with OpenDlg do
    begin
      // To draw any format of pictures, as a bitmap canvas
      m := TImage.Create(fMain);
      try
        m.Picture.LoadFromFile(FileName);
        pb.Canvas.StretchDraw(pb.Canvas.ClipRect, m.Picture.Graphic);
      finally
        m.Free;
      end;
    end;
end;

procedure TfMain.Normalpriority1Click(Sender: TObject);
begin
  SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS);
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Open1Click(Sender: TObject);
var
  m: TImage;
begin
  if OpenDlg.Execute then
    with OpenDlg do
    begin
      // To draw any format of pictures, as a bitmap canvas
      m := TImage.Create(fMain);
      try
        m.AutoSize := true;
        m.Picture.LoadFromFile(FileName);
        img.Picture := nil;

        img.Width := m.Width;
        img.Height := m.Height;
        img.Repaint;

        img.Canvas.Draw(0, 0, m.Picture.Graphic);

      finally
        m.Free;
        Run1.Enabled := true;
        ImportEvoPic1.Enabled := true;
      end;
    end;
  SetDestSize(img, pb, Dimention);
end;

procedure TfMain.pbMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  p: TColor;
begin
  p := (Sender as TImage).Canvas.Pixels[X, Y];
  lbl2.Caption := Format('R:%.3d G:%.3d B:%.3d ', [GetRValue(p), GetGValue(p), GetBValue(p)])
    + ColorToString(p);
end;

procedure TfMain.Persianalphabet1Click(Sender: TObject);
begin
  if EvoPic <> nil then
    EvoPic.SetAlphabet(true);
  Option.AlphabetEnglish := true;
  TMenuItem(Sender).Checked := true;
end;

procedure TfMain.Saveashtml1Click(Sender: TObject);
begin
  if EvoPic <> nil then
    if SavHtmDlg.Execute then
      EvoPic.SaveHtml(SavHtmDlg.FileName);

end;

procedure TfMain.SaveEvoPic1Click(Sender: TObject);
var
  j: TJPEGImage;
begin
  if SaveDlg.Execute then
  begin

    if ExtractFileExt(SaveDlg.FileName) = '.bmp' then
    begin
      pb.Picture.Bitmap.SaveToFile(SaveDlg.FileName);
    end
    else
    begin
      j := TJPEGImage.Create;
      try
        j.Assign(pb.Picture.Bitmap);
        j.SaveToFile(SaveDlg.FileName);
      finally
        j.Free;
      end;
    end;

  end;

end;

procedure TfMain.SetDestSize(Source, Dest: TImage; Dimention: byte);
begin
  Dest.Picture := nil;
  Dest.Width := Source.Width * Dimention;
  Dest.Height := Source.Height * Dimention;
end;

procedure TfMain.Start1Click(Sender: TObject);
begin
  // Set output size
  SetDestSize(img, pb, Dimention);

  // Create class
  if EvoPic <> nil then
    EvoPic.Free;

  try
    EvoPic := TEvoPic.Create(fMain, img.Canvas, pb.Canvas);
    if Option.AlphabetFont <> '' then
      EvoPic.SetAlphabetFont(Option.AlphabetFont, Option.AlphabetSize);
    if Customalphabet1.Checked then
      EvoPic.SetAlphabetCustom(Option.AlphabetChars)
    else
      EvoPic.SetAlphabet(not Option.AlphabetEnglish);

    EvoPic.ClearCanvas(BackColor);
  Except
    EvoPic.Free;
  end;

  // Run
  EvoPic.FillWithChar(Grayscale1.Checked, Randomchars1.Checked, RandomOrdered1.Checked);
end;

end.
