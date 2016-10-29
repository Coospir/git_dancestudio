unit settingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, IniFiles;

type

  { TsettingsForm }

  TsettingsForm = class(TForm)
    ColorButton1: TColorButton;
    newColorFormSettings: TLabel;
    procedure ColorButton1ColorChanged(Sender: TObject);
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

  procedure TsettingsForm.ColorButton1ColorChanged(Sender: TObject);
    var IniFile:TIniFile;
  begin
    try
      MainForm.Color:=ColorButton1.ButtonColor;
      IniFile:= TIniFile.Create('D:\settings.ini');
      IniFile.WriteInteger('COLOR','MAINFORMCOLOR',COLORBUTTON1.BUTTONCOLOR);
      IniFile.Free;
      Close;
    except
      ShowMessage('Невозможно работать с файлом.');
    end;
  end;




end.

