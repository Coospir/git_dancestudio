unit settingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, IniFiles;

type

  { TsettingsForm }

  TsettingsForm = class(TForm)
    ColorButton: TColorButton;
    newColorFormSettings: TLabel;
    procedure ColorButtonColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
   { procedure saveSettingsClick(Sender: TObject);    }
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  settingsForm: TsettingsForm;

implementation
uses MainMenu;

{$R *.lfm}

{ TsettingsForm }

procedure TsettingsForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

  procedure TsettingsForm.ColorButtonColorChanged(Sender: TObject);
    var IniFile:TIniFile;
  begin
    try
      MainForm.Color:=ColorButton.ButtonColor;
      IniFile:= TIniFile.Create('settings.ini');
      IniFile.WriteInteger('COLOR','MAINFORMCOLOR',ColorButton.BUTTONCOLOR);
      IniFile.Free;
      Close;
    except
      ShowMessage('Невозможно работать с файлом.');
    end;
  end;




end.

