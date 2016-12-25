unit settingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, IniFiles;

type

  { TsettingsForm }

  TsettingsForm = class(TForm)
    GreenTheme: TButton;
    DarkRedTheme: TButton;
    TealTheme: TButton;
    newColorFormSettings: TLabel;
    procedure GreenThemeClick(Sender: TObject);
    procedure DarkRedThemeClick(Sender: TObject);
    procedure TealThemeClick(Sender: TObject);
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


procedure TsettingsForm.GreenThemeClick(Sender: TObject);
  var IniFile:TIniFile;
    begin
      try
        MainForm.Color:=TColor($0042C380);
        IniFile:= TIniFile.Create('settings.ini');
        IniFile.WriteInteger('COLOR','MAINFORMCOLOR', $0042C380);
        IniFile.Free;
        Close;
      except
        ShowMessage('Невозможно работать с файлом.');
      end;
end;

procedure TsettingsForm.DarkRedThemeClick(Sender: TObject);
  var IniFile:TIniFile;
      begin
        try
          MainForm.Color:=TColor(clMaroon);
          IniFile:= TIniFile.Create('settings.ini');
          IniFile.WriteInteger('COLOR','MAINFORMCOLOR', clMaroon);
          IniFile.Free;
          Close;
        except
          ShowMessage('Невозможно работать с файлом.');
        end;

end;

procedure TsettingsForm.TealThemeClick(Sender: TObject);
  var IniFile:TIniFile;
      begin
        try
          MainForm.Color:=TColor(clTeal);
          IniFile:= TIniFile.Create('settings.ini');
          IniFile.WriteInteger('COLOR','MAINFORMCOLOR', clTeal);
          IniFile.Free;
          Close;
        except
          ShowMessage('Невозможно работать с файлом.');
        end;
end;




end.

