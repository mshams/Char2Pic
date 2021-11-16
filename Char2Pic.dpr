program Char2Pic;

uses
  Forms,
  frmMain in 'frmMain.pas' {fMain},
  uCommands in 'uCommands.pas',
  frmAbout in 'frmAbout.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Char2Pic';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
