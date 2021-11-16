unit uCommands;

interface

uses graphics, windows, sysutils, math, classes, extctrls, WideStrings, strutils;

type
  TEvoPic = class(TObject)
  private
    { private declarations }

    EvoDest: TCanvas;
    EvoSource: TCanvas;

    EvoWidth, EvoHeight, SourceWidth, SourceHeight: integer;

    alphabet: WideString;
    alphSort: WideString;
    alphabetFont: TFontName;
    alphabetSize: byte;
    alphabetCount: byte;
    TxtW, TxtH: integer;

    htmlColor: array of array of TColor;
    htmlChr: array of array of Char;
    htmW, htmH: integer;

    { private functions }
    Procedure SetFontRect;
    Function GetColor(x, y: integer; GrayImage: Boolean): TColor;
    function RGB2Gray(rgbColor: TColor): TColor;

  protected
    { protected declarations }

  public
    { public declarations }
    Procedure ClearCanvas(const CleanColor: TColor); overload;

    procedure SetAlphabet(English: Boolean);
    procedure SetAlphabetCustom(charsets: WideString);
    procedure SetAlphabetFont(Fontname: TFontName; size: byte);
    procedure SaveHtml(F: TFileName);

    Procedure FillWithChar(GrayImage, RndChar, RndMan: Boolean);

    constructor Create(AOwner: TComponent; Source, Dest: TCanvas);
    destructor Destroy; override;
  end;

implementation

uses frmmain;

Procedure TEvoPic.ClearCanvas(const CleanColor: TColor);
begin
  with EvoDest do
  begin
    Brush.Color := CleanColor;
    pen.Color := CleanColor;
    pen.Mode := pmCopy;
    Rectangle(ClipRect);
    pen.Style := psSolid;
  end;
end;

constructor TEvoPic.Create(AOwner: TComponent; Source, Dest: TCanvas);
begin
  inherited Create;
  EvoDest := Dest;
  EvoSource := Source;

  // ClearCanvas(clblack); 
  SetAlphabet(true);
  SetAlphabetFont('Courier New', 8);

  // set rect informations 
  EvoWidth := Dest.ClipRect.Right - Dest.ClipRect.Left;
  EvoHeight := Dest.ClipRect.Bottom - Dest.ClipRect.Top;
  SourceWidth := Source.ClipRect.Right - Source.ClipRect.Left;
  SourceHeight := Source.ClipRect.Bottom - Source.ClipRect.Top;

end;

destructor TEvoPic.Destroy;
begin
  inherited;
end;

procedure TEvoPic.FillWithChar(GrayImage, RndChar, RndMan: Boolean);
var
  I, j, x, y: integer;
  c: Char;
begin
  SetFontRect;
  fMain.Progress.Position := 0;
  fMain.Progress.Max := (EvoHeight div TxtH + 1) * (EvoWidth div TxtW + 1);

  htmW := EvoWidth div TxtW;
  htmH := EvoHeight div TxtH;
  SetLength(htmlColor, htmW + 1, htmH + 1);
  SetLength(htmlChr, htmW + 1, htmH + 1);

  // Divide dest Rect to selected font Rect 
  for I := 0 to EvoHeight div TxtH do
    for j := 0 to EvoWidth div TxtW do
    begin
      // Set x,y positio of outtext 
      x := TxtW * j;
      y := TxtH * I;

      // Set random char from alphabet 
      if RndChar then
      begin
        if RndMan then
          c := alphSort[length(alphSort) - GetRValue(RGB2Gray(EvoDest.Font.Color)) *
            (length(alphSort) - 1) div 255]
        else
          c := alphabet[randomRange(1, alphabetCount + 1)];
      end
      else
        c := alphabet[1 + (I * TxtH + j) mod (alphabetCount)];

      EvoDest.Font.Color := GetColor(x * SourceWidth div EvoWidth,
        y * SourceHeight div EvoHeight, GrayImage);

      htmlColor[j, I] := ColorToRGB(EvoDest.Font.Color);
      htmlChr[j, I] := c;

      // EvoDest.Font.Color:=clblack; 

      EvoDest.TextOut(x, y, c);

      fMain.Progress.StepIt;
    end;

end;

function TEvoPic.GetColor(x, y: integer; GrayImage: Boolean): TColor;
var
  RSum, GSum, BSum, sum: longint;
  I, j, mx, my: integer;
  p: TColor;
begin
  RSum := 0;
  GSum := 0;
  BSum := 0;

  mx := x + TxtW - 1;
  my := y + TxtH - 1;

  if mx > SourceWidth then
    mx := SourceWidth;

  if my > SourceHeight then
    my := SourceHeight;

  for I := x to mx do
    for j := y to my do
    begin
      p := EvoSource.Pixels[I, j];
      RSum := RSum + GetRValue(p);
      GSum := GSum + GetGValue(p);
      BSum := BSum + GetBValue(p);
    end;

  sum := (mx - x + 1) * (my - y + 1);
  RSum := RSum div sum;
  GSum := GSum div sum;
  BSum := BSum div sum;

  if GrayImage then
    result := RGB2Gray(rgb(RSum, GSum, BSum))
  else
    result := rgb(RSum, GSum, BSum);
end;

function TEvoPic.RGB2Gray(rgbColor: TColor): TColor;
var
  Gray: TColor;
begin
  Gray := (GetRValue(rgbColor) + GetGValue(rgbColor) + GetBValue(rgbColor)) div 3;
  result := rgb(Gray, Gray, Gray)
end;

procedure TEvoPic.SaveHtml(F: TFileName);
var
  s: TWideStrings;
  txt: string;
  I, j, k: integer;
begin
  s := TWideStringList.Create;
  try
    s.Add('<html><head><meta http-equiv=Content-Type content="text/html">');
    s.Add('<style><!--  /* Style Definitions */  p.fmt, li.fmt, div.fmt{margin:0cm;');
    s.Add(format('margin-bottom:-3pt;font-size:%d.0pt;', [alphabetSize]));
    s.Add('font-family:"Courier New";} --></style></head>');
    s.Add(format('<body bgcolor=#%x>', [backcolor]));

    // for all rows in html array 
    for I := 0 to htmH - 1 do
    begin
      // new row 
      s.Add('<p class=fmt><b>');
      // s.Add(''); 

      // start from first color in each row 
      j := 0;
      while j < htmW do
      begin

        k := j;
        txt := IfThen(htmlChr[k, I] <> ' ', htmlChr[k, I], '&nbsp;');

        while (k < htmW) and (htmlColor[k, I] = htmlColor[k + 1, I]) do
        begin
          k := k + 1;
          txt := txt + IfThen(htmlChr[k, I] <> ' ', htmlChr[k, I], '&nbsp;');
        end;

        s.Strings[s.Count - 1] := s.Strings[s.Count - 1] + format
          ('<span style="color:#%x">%s</span>', [htmlColor[j, I], txt]);

        j := k + 1;
      end;

      // end of row 
      s.Add('</b></p>');
    end;

    s.Add('</body></html>');
  finally
    s.SaveToFile(F);
    s.Free;
  end;
end;

procedure TEvoPic.SetAlphabet(English: Boolean);
begin
  if English then
  begin
    alphabet := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    alphSort := '#HWMABX@$DQ0ZJ%x237zvcri+=;:~-,. ';
    // s := '#HWQAqBDRgKUXdpEMOhmGPbkFNV0w8JTYZ@$&nx4uyIL569\CS2fjae1lso%3t/7zvcri|=+~;-:,.`'; 
  end
  else
  begin
    alphabet := 'ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیءؤآأ';
    alphSort := 'ظطگکشقغفعچجؤوهء ';
  end;

  alphabetCount := length(alphabet);
end;

procedure TEvoPic.SetAlphabetCustom(charsets: WideString);
begin
  alphabet := charsets;
  alphabetCount := length(alphabet);
end;

procedure TEvoPic.SetAlphabetFont(Fontname: TFontName; size: byte);
begin
  if Fontname <> '' then
    alphabetFont := Fontname;
  alphabetSize := size;
end;

procedure TEvoPic.SetFontRect;
begin
  with EvoDest do
  begin
    Font.Name := alphabetFont;
    Font.size := alphabetSize;
    Font.Style := [fsbold];
    Brush.Color := clNone;
    Brush.Style := bsClear;
    TxtW := TextWidth('W');
    TxtH := TextHeight('J') * 3 div 4;
  end;
end;

end.
