unit MainMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, IniFiles, addNewManGrpUnit,
  addNewChildGrpUnit, addNewTeacherUnit, settingsUnit, tableTeacherUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    restartStat: TButton;
    StatisticGrpBox: TGroupBox;
    manGrpStatistic: TLabel;
    danceTeachers: TMenuItem;
    addNewTeacher: TMenuItem;
    deleteTeacher: TMenuItem;
    addSettings: TMenuItem;
    teachersGrpStatistic: TLabel;
    watchTeachers: TMenuItem;
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
    procedure AddNewChildAbnClick(Sender: TObject);
    procedure addNewTeacherClick(Sender: TObject);
    procedure CreateNewChildGrpClick(Sender: TObject);
    procedure CreateNewManGrClick(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure restartStatClick(Sender: TObject);
    procedure addSettingsClick(Sender: TObject);
    procedure watchTeachersClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
const
  noGrpWarning = ' нет информации.';
var
  MainForm: TMainForm;
  IniFile: TIniFile;

implementation
{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  try
    IniFile:=TIniFile.Create('settings.ini*');
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
  teachersGrpStatistic.Caption:='Преподавателей в студии: ' + IntToStr(countTeachers);
  if numChildGrp = 0 then
  begin
    childGrpStatistic.Caption:='Количество детских групп: ' + noGrpWarning;
  end;
  if numManGrp = 0 then
  begin
    manGrpStatistic.Caption:='Количество взрослых групп: ' + noGrpWarning;
  end;
  if countTeachers = 0 then
  begin
    teachersGrpStatistic.Caption:='Преподавателей в студии: ' + noGrpWarning;
  end;
end;

procedure TMainForm.addSettingsClick(Sender: TObject);
begin
  settingsForm:=TsettingsForm.Create(self);
  MainForm.InsertControl(settingsForm);
  settingsForm.Show;
end;


procedure TMainForm.watchTeachersClick(Sender: TObject);
begin
  TableTeachersForm:=TTableTeachersForm.Create(Self);
  MainForm.InsertControl(TableTeachersForm);
  TableTeachersForm.Show;
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

procedure TMainForm.AddNewChildAbnClick(Sender: TObject);
begin

end;


procedure TMainForm.CreateNewManGrClick(Sender: TObject);
begin
  addNewManGrpForm:=TaddNewManGrpForm.Create(self);
  MainForm.InsertControl(addNewManGrpForm);
  addNewManGrpForm.Show;
end;


procedure TMainForm.FormClose(Sender: TObject);
var
  simpleFile : file of TDanceTeacher;
  i : integer;
begin
  {$i-}
  AssignFile(simpleFile, 'ds.int');
  Rewrite(simpleFile);
  for i:=1 to countTeachers do
  begin
    write(simpleFile,TeacherArray[countTeachers]);
  end;
  CloseFile(simpleFile);
  if IOResult <> 0 then ShowMessage('Ошибка записи в файл.');
  {$i+}
  try
    IniFile:= TIniFile.Create('settings.ini');
    IniFile.WriteInteger('MAINFORM','MAINFORMWIDTH',MAINFORM.Width);
    IniFile.WriteInteger('MAINFORM','MAINFORMHEIGHT',MAINFORM.Height);
    IniFile.Free;
  except
    ShowMessage('Невозможно работать с файлом.');
  end;
end;

end.

