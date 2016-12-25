unit MainMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls, IniFiles,
  addNewChildGrpUnit, addNewTeacherUnit, settingsUnit,
  tableTeacherUnit, addNewChildAbnUnit, tableChildGrpUnit, tableClientUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    btnProgramToTray: TButton;
    addNoteBtn: TButton;
    DeleteAllNotesBtn: TButton;
    DeleteMemoNote: TButton;
    ListBoxMemo: TListBox;
    OpenCloseMemoBtn: TButton;
    CreateMemoPanel: TGroupBox;
    allAbnStatistic: TLabel;
    allAbn: TMenuItem;
    CreateNewAbn: TMenuItem;
    EditForNote: TEdit;
    OpenListAbn: TMenuItem;
    DanceStudioAbn: TMenuItem;
    StatisticGrpBox: TGroupBox;
    danceTeachers: TMenuItem;
    CreateNewTeacher: TMenuItem;
    addSettings: TMenuItem;
    teachersGrpStatistic: TLabel;
    OpenListTeachers: TMenuItem;
    allGrpStatistic: TLabel;
    MainMenuDanceStudio: TMainMenu;
    Groups: TMenuItem;
    OpenListGrp: TMenuItem;
    allGrp: TMenuItem;
    CreateNewGrp: TMenuItem;
    procedure AddNewChildAbnClick(Sender: TObject);
    procedure addNoteBtnClick(Sender: TObject);
    procedure btnProgramToTrayClick(Sender: TObject);
    procedure DeleteAllNotesBtnClick(Sender: TObject);
    procedure CreateNewAbnClick(Sender: TObject);
    procedure CreateNewTeacherClick(Sender: TObject);
    procedure allGrpClick(Sender: TObject);
    procedure CreateNewGrpClick(Sender: TObject);
    procedure CreateNewManAbnClick(Sender: TObject);
    procedure DeleteMemoNoteClick(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure addSettingsClick(Sender: TObject);
    procedure ListBoxMemoClick(Sender: TObject);
    procedure MemoNotesChange(Sender: TObject);
    procedure MemoWindowChange(Sender: TObject);
    procedure OpenListAbnClick(Sender: TObject);
    procedure OpenListGrpClick(Sender: TObject);
    procedure OpenManTableClick(Sender: TObject);
    procedure OpenListTeachersClick(Sender: TObject);
    procedure OpenCloseMemoBtnClick(Sender: TObject);
  private
    { private declarations }
  public
    procedure restartStatClick;
    { public declarations }
  end;
const
  noGrpWarning = ' нет информации';
var
  MainForm: TMainForm;
  IniFile: TIniFile;

implementation
{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainForm.restartStatClick;
  try
    IniFile:=TIniFile.Create('settings.ini');
    MainForm.Color:=IniFile.ReadInteger('COLOR','MAINFORMCOLOR',MAINFORM.COLOR);
    IniFile.ReadInteger('MAINFORM','MAINFORMWIDTH',MAINFORM.Width);
    IniFile.ReadInteger('MAINFORM','MAINFORMHEIGHT',MAINFORM.Height);
    IniFile.Free;
  except
    ShowMessage('Невозможно работать с файлом.');
  end;
end;


procedure TMainForm.restartStatClick;
begin
  allGrpStatistic.Caption:= 'Всего групп: ' + IntToStr(numChildGrp);
  teachersGrpStatistic.Caption:= 'Всего преподавателей: ' + IntToStr(countTeachers);
  allAbnStatistic.Caption:= 'Всего абонементов: ' + IntToStr(countClients);
  if numChildGrp = 0 then
  begin
    allGrpStatistic.Caption:= 'Всего групп: ' + noGrpWarning;
  end;
  if countTeachers = 0 then
  begin
    teachersGrpStatistic.Caption:= 'Всего преподавателей: ' + noGrpWarning;
  end;
  if countClients = 0 then
  begin
    allAbnStatistic.Caption:= 'Всего абонементов: ' + noGrpWarning;
  end;
end;

procedure TMainForm.addSettingsClick(Sender: TObject);
begin
  settingsForm:=TsettingsForm.Create(self);
  MainForm.InsertControl(settingsForm);
  settingsForm.Show;
end;

procedure TMainForm.ListBoxMemoClick(Sender: TObject);
begin

end;

procedure TMainForm.MemoNotesChange(Sender: TObject);
begin

end;



procedure TMainForm.MemoWindowChange(Sender: TObject);
begin

end;

procedure TMainForm.OpenListAbnClick(Sender: TObject);
begin
  TableAbnForm:=TTableAbnForm.Create(self);
  MainForm.InsertControl(TableAbnForm);
  TableAbnForm.Show;
end;

procedure TMainForm.OpenListGrpClick(Sender: TObject);
begin
  ListAllGrpForm:=TListAllGrpForm.Create(self);
  MainForm.InsertControl(ListAllGrpForm);
  ListAllGrpForm.Show;
end;

procedure TMainForm.OpenManTableClick(Sender: TObject);
begin
  if(countTeachers = 0) then
  begin
    ShowMessage('В базе данных нет преподавателей, создайте их!');
  end else
  begin

  end;
end;


procedure TMainForm.OpenListTeachersClick(Sender: TObject);
begin
  TableTeachersForm:=TTableTeachersForm.Create(Self);
  MainForm.InsertControl(TableTeachersForm);
  TableTeachersForm.Show;
end;

procedure TMainForm.OpenCloseMemoBtnClick(Sender: TObject);
begin
  if(ListBoxMemo.Visible = false) then
  begin
    ListBoxMemo.Visible:=true;
    CreateMemoPanel.Height:=280;
  end else
  begin
    ListBoxMemo.Visible:=false;
    CreateMemoPanel.Height:=151;
  end;
end;

procedure TMainForm.CreateNewGrpClick(Sender: TObject);
begin
  if(countTeachers = 0) then
  begin
    ShowMessage('В базе данных нет преподавателей, создайте их!');
  end else
  begin
    addNewGrpForm:= TaddNewGrpForm.Create(self);
    MainForm.InsertControl(addNewGrpForm);
    addNewGrpForm.Show;
  end;
end;

procedure TMainForm.CreateNewManAbnClick(Sender: TObject);
begin
  if(countTeachers = 0) then
  begin
    ShowMessage('В базе данных нет преподавателей, создайте их!');
  end else
  begin

  end;
end;

procedure TMainForm.DeleteMemoNoteClick(Sender: TObject);
begin
  if ListBoxMemo.ItemIndex > -1 then
  begin
    ListBoxMemo.Items.Delete(ListBoxMemo.ItemIndex);
  end else
  ShowMessage('Список заметок пуст.');
end;

procedure TMainForm.CreateNewTeacherClick(Sender: TObject);
begin
  addNewTeacherForm:=TaddNewTeacherForm.Create(self);
  MainForm.InsertControl(addNewTeacherForm);
  addNewTeacherForm.Show;
end;

procedure TMainForm.allGrpClick(Sender: TObject);
begin

end;

procedure TMainForm.AddNewChildAbnClick(Sender: TObject);
begin
  if(countTeachers = 0) then
  begin
    ShowMessage('В базе данных нет преподавателей, создайте их!');
  end else
  begin
    addNewAbnForm:=TaddNewAbnForm.Create(self);
    MainForm.InsertControl(addNewAbnForm);
    addNewAbnForm.Show;
  end;
end;

procedure TMainForm.addNoteBtnClick(Sender: TObject);
begin
  if(EditForNote.Text = '') then
  begin
    ShowMessage('Сначала введите текст.');
  end else
  begin
    ListBoxMemo.Visible:=true;
    ListBoxMemo.Items.Add(MainForm.EditForNote.Text);
  end;
end;

procedure TMainForm.btnProgramToTrayClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.DeleteAllNotesBtnClick(Sender: TObject);
begin
  if ListBoxMemo.Count <> 0 then
  begin
    ListBoxMemo.Clear;
  end else
  ShowMessage('Список заметок пуст.');
end;

procedure TMainForm.CreateNewAbnClick(Sender: TObject);
begin
  if(countTeachers = 0)  then
  begin
    ShowMessage('В базе данных нет ни преподавателей, ни групп - создайте их!');
  end else if(numChildGrp = 0) then
  begin
    ShowMessage('В базе данных нет групп, создайт их!');
  end else
  begin
    addNewAbnForm:=TaddNewAbnForm.Create(self);
    MainForm.InsertControl(addNewAbnForm);
    addNewAbnForm.Show;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject);
begin
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
