unit MainMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, Menus, StdCtrls, IniFiles, addNewManGrpUnit, addNewChildGrpUnit, addNewTeacherUnit, settingsUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    manGrpStatistic: TLabel;
    danceTeachers: TMenuItem;
    addNewTeacher: TMenuItem;
    deleteTeacher: TMenuItem;
    addSettings: TMenuItem;
    watchTeachers: TMenuItem;
    restartStat: TButton;
    childGrpStatistic: TLabel;
    MainMenu1: TMainMenu;
    Groups: TMenuItem;
    OpenChildTable: TMenuItem;
    OpenManTable: TMenuItem;
    childGrp: TMenuItem;
    manGrp: TMenuItem;
    CreateNewChildGrp: TMenuItem;
    DeleteChildGrp: TMenuItem;
    AddNewChildAbn: TMenuItem;
    CreateNewManGr: TMenuItem;
    CreateNewManGrp: TMenuItem;
    DeleteManGrp: TMenuItem;
    procedure addNewTeacherClick(Sender: TObject);
    procedure CreateNewChildGrpClick(Sender: TObject);
    procedure CreateNewManGrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure restartStatClick(Sender: TObject);
    procedure addSettingsClick(Sender: TObject);
    procedure watchDanceDirectionClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
  IniFile: TIniFile;

implementation
{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  try
    IniFile:=TIniFile.Create('D:\settings.ini');
    MainForm.Color:=IniFile.ReadInteger('COLOR','MAINFORMCOLOR',MAINFORM.COLOR);
    IniFile.ReadInteger('MAINFORM','MAINFORMWIDTH',MAINFORM.Width);
    IniFile.ReadInteger('MAINFORM','MAINFORMHEIGHT',MAINFORM.Height);
    IniFile.Free;
  except
    ShowMessage('Невозможно работать с файлом.');
  end;
end;

procedure TMainForm.restartStatClick(Sender: TObject);
begin
  childGrpStatistic.Caption:='Количество детских групп: ' + IntToStr(numChildGrp);
  manGrpStatistic.Caption:='Количество взрослых групп: ' + IntToStr(numManGrp);
end;

procedure TMainForm.addSettingsClick(Sender: TObject);
begin
  settingsForm:=TsettingsForm.Create(self);
  MainForm.InsertControl(settingsForm);
  settingsForm.Show;
end;

procedure TMainForm.watchDanceDirectionClick(Sender: TObject);
begin

end;

procedure TMainForm.CreateNewChildGrpClick(Sender: TObject);
begin
  addNewChildGrpForm:= TaddNewChildGrpForm.Create(self);
  MainForm.InsertControl(addNewChildGrpForm);
  addNewChildGrpForm.Show;
end;

procedure TMainForm.addNewTeacherClick(Sender: TObject);
begin
  addNewTeacherForm:=TaddNewTeacherForm.Create(self);
  MainForm.InsertControl(addNewTeacherForm);
  addNewTeacherForm.Show;
end;




procedure TMainForm.CreateNewManGrClick(Sender: TObject);
begin
  addNewManGrpForm:=TaddNewManGrpForm.Create(self);
  MainForm.InsertControl(addNewManGrpForm);
  addNewManGrpForm.Show;
end;


procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  try
    IniFile:= TIniFile.Create('D:\settings.ini');
    IniFile.WriteInteger('MAINFORM','MAINFORMWIDTH',MAINFORM.Width);
    IniFile.WriteInteger('MAINFORM','MAINFORMHEIGHT',MAINFORM.Height);
    IniFile.Free;
  except
    ShowMessage('Невозможно работать с файлом.');
  end;
end;

end.

