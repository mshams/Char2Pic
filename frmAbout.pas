unit frmAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Image1: TImage;
    Image2: TImage;
    Comments: TLabel;
    LinkLabel1: TLinkLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure Image2DblClick(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}
{$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$SetPEFlags IMAGE_FILE_DEBUG_STRIPPED}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

procedure TAboutBox.Image2DblClick(Sender: TObject);
begin
  Image1.Visible := not Image1.Visible;
  Image2.Visible := not Image1.Visible;
end;

procedure TAboutBox.LinkLabel1LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  winexec('cmd.exe /c start http://www.mshams.ir', SW_Hide);
end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  AboutBox.Close;
end;

end.
