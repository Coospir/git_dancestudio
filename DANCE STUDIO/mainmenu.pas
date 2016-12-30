unit MainMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls, IniFiles,
  addNewChildGrpUnit, addNewTeacherUnit, settingsUnit, XMLRead, XMLWrite,
  DOM, tableTeacherUnit, addNewChildAbnUnit, tableChildGrpUnit, tableClientUnit;

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
var i: integer;
    PassNode : TDOMNode;
    Document : TXMLDocument;
    sIdTeacher,sNameTeacher,sAgeTeacher, sSerialPassTeacher, sNumberPassTeacher, sEmailTeacher, sTelephoneTeacher, sDanceDirectionTeacher : string;
    Element : TDOMNode;
    s: string;
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
  countTeachers:=0;
  readXMLFile(Document,'danceStudio.xml');
  Element:=Document.FirstChild.FirstChild;
  i := 0;
  try
    try
      repeat
        s:=Element.NodeName;
        sIdTeacher:=Element.Attributes.GetNamedItem('Teacher_ID').NodeValue;
        sNameTeacher:=Element.Attributes.GetNamedItem('Teacher_Name').NodeValue;
        sAgeTeacher:=Element.Attributes.GetNamedItem('Teacher_Age').NodeValue;
        sSerialPassTeacher:=Element.Attributes.GetNamedItem('Teacher_SerialPassport').NodeValue;
        sNumberPassTeacher:=Element.Attributes.GetNamedItem('Teacher_NumberPassport').NodeValue;
        sEmailTeacher:=Element.Attributes.GetNamedItem('Teacher_Email').NodeValue;
        sTelephoneTeacher:=Element.Attributes.GetNamedItem('Teacher_TelephoneNumber').NodeValue;
        sDanceDirectionTeacher:=Element.Attributes.GetNamedItem('Style').NodeValue;
           i:=i+1;
        if(sDanceDirectionTeacher = 'Хип-Хоп') then TeacherArray[i].DanceDirection:=HipHop else
          if(sDanceDirectionTeacher = 'Крамп') then TeacherArray[i].DanceDirection:=Krump else
            if(sDanceDirectionTeacher = 'Джазз-Фанк') then TeacherArray[i].DanceDirection:=JFunk else
              if(sDanceDirectionTeacher = 'Брейкданс') then TeacherArray[i].DanceDirection:=Break else
                if(sDanceDirectionTeacher = 'Импровизация') then TeacherArray[i].DanceDirection:=Improvis else
                  if(sDanceDirectionTeacher = 'Лэдис Хип-Хоп') then TeacherArray[i].DanceDirection:=LadyHop else
                    if(sDanceDirectionTeacher = 'Стрип-Пластика') then TeacherArray[i].DanceDirection:=Plastic else
                      if(sDanceDirectionTeacher = 'Контемпорари') then TeacherArray[i].DanceDirection:=Contemp else
                        if(sDanceDirectionTeacher = 'Бальные танцы') then TeacherArray[i].DanceDirection:=BalDance else
                          if(sDanceDirectionTeacher = 'Восточные танцы') then TeacherArray[i].DanceDirection:=VostokDance;

                          Element:=Element.NextSibling;
                          TeacherArray[i].idTeacher:=StrToInt(sIdTeacher);
                          TeacherArray[i].TeacherName:=sNameTeacher;
                          TeacherArray[i].TeacherAge:=StrToInt(sAgeTeacher);
                          TeacherArray[i].SerialPassport:=sSerialPassTeacher;
                          TeacherArray[i].NumberPassport:=StrToInt(sNumberPassTeacher);
                          TeacherArray[i].TeacherEmail:=sEmailTeacher;
                          TeacherArray[i].TelephoneNumber:=sTelephoneTeacher;
                          countTeachers:=countTeachers+1;
                        until Element = NIL;
                      except
                        ShowMessage('Ошибка чтения XML - файла!');
                      end;
                      finally
                      Document.Free;
                    end;
                      MainForm.restartStatClick;
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
var RootNode, ElementNode, ItemNode, TextNode, PassNode : TDOMNode;
    Document : TXMLDocument;
    i : integer;
  begin
    if countTeachers <> 0 then
  begin
    Document:=TXMLDocument.Create;
    with Document do
    begin
      ElementNode:=Document.CreateElement('Element');
      for i:= 1 to countTeachers do
        begin
          ItemNode:=Document.CreateElement('Teacher_Information');
          TDOMElement(ItemNode).SetAttribute('Teacher_ID', IntToStr(TeacherArray[i].idTeacher));
          TDOMElement(ItemNode).SetAttribute('Teacher_Name', TeacherArray[i].TeacherName);
          TDOMElement(ItemNode).SetAttribute('Teacher_Age', IntToStr(TeacherArray[i].TeacherAge));
          TDOMElement(ItemNode).SetAttribute('Teacher_SerialPassport', TeacherArray[i].SerialPassport);
          TDOMElement(ItemNode).SetAttribute('Teacher_NumberPassport', IntToStr(TeacherArray[i].NumberPassport));
          TDOMElement(ItemNode).SetAttribute('Teacher_Email', TeacherArray[i].TeacherEmail);
          TDOMElement(ItemNode).SetAttribute('Teacher_TelephoneNumber', TeacherArray[i].TelephoneNumber);
          case TeacherArray[i].DanceDirection of
               HipHop: TDOMElement(ItemNode).SetAttribute('Style','HipHop');
               Krump: TDOMElement(ItemNode).SetAttribute('Style','Krump');
               JFunk: TDOMElement(ItemNode).SetAttribute('Style','JazzFunk');
               Break: TDOMElement(ItemNode).SetAttribute('Style','Breakdance');
               Improvis: TDOMElement(ItemNode).SetAttribute('Style','Improvisation');
               LadyHop: TDOMElement(ItemNode).SetAttribute('Style','LadyHop');
               Plastic: TDOMElement(ItemNode).SetAttribute('Style','PlasticDance');
               Contemp: TDOMElement(ItemNode).SetAttribute('Style','Contemporary');
               BalDance: TDOMElement(ItemNode).SetAttribute('Style','BalDance');
               VostokDance: TDOMElement(ItemNode).SetAttribute('Style','VostokDance');
               SportAcro: TDOMElement(ItemNode).SetAttribute('Style','SportAcrobatics');
          end;
          ElementNode.AppendChild(ItemNode);
        end;
    end;
    Document.AppendChild(ElementNode);
    writeXMLFile(Document, 'danceStudio.xml');
    ShowMessage('Данные автоматически сохранены!');
  end else ShowMessage('Не удалось сохранить данные!');
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
