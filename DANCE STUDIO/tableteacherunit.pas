unit tableTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, ComCtrls, Buttons, addNewTeacherUnit, XMLRead, XMLWrite, DOM;

type

  { TTableTeachersForm }

  TTableTeachersForm = class(TForm)
    addLineBtn: TButton;
    changeLineBtn: TButton;
    grpboxTeacherListView: TGroupBox;
    pageControlTeacher: TPageControl;
    readFromXmlFile: TButton;
    saveToXmlFile: TButton;
    delTeacher: TButton;
    btnForListView: TTabSheet;
    btnForFunctions: TTabSheet;
    TeacherListView: TListView;
    procedure addLineBtnClick(Sender: TObject);
    procedure delTeacherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure readFromXmlFileClick(Sender: TObject);
    procedure saveToXmlFileClick(Sender: TObject);
    procedure TeacherListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TeacherListViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TeacherListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { private declarations }

  public
    XMLfile: TXMLDocument;
    { public declarations }
  end;

type
    TMyThread = class(TThread)
    private
      cpTeacherArray : cTeacherArray;
      procedure successSaveXML();
      procedure errorSaveXML();
    public
      constructor Create(var copyTeacherArray : cTeacherArray);
    protected
      procedure Execute; override;
    end;

var
  TableTeachersForm: TTableTeachersForm;
  Item : TListItem;
  MyThread : TMyThread;

implementation
uses MainMenu, addNewChildGrpUnit;

{$R *.lfm}

{ TTableTeachersForm }

procedure TMyThread.successSaveXML;
begin
  ShowMessage('Записано в файл: ' + 'dance_studio.xml');
end;

procedure TMyThread.errorSaveXML;
begin
  ShowMessage('Пустая таблица!');
end;

constructor TMyThread.Create(var copyTeacherArray : cTeacherArray);
begin
  copyTeacherArray := TeacherArray;
end;

procedure TMyThread.Execute();
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
          ItemNode:=Document.CreateElement('Teacher');
          TDOMElement(ItemNode).SetAttribute('F.I.O.', TeacherArray[i].TeacherName);
          TDOMElement(ItemNode).SetAttribute('Age', IntToStr(TeacherArray[i].TeacherAge));
          TDOMElement(ItemNode).SetAttribute('SerialPassport', TeacherArray[i].SerialPassport);
          TDOMElement(ItemNode).SetAttribute('NumberPassport', IntToStr(TeacherArray[i].NumberPassport));
          TDOMElement(ItemNode).SetAttribute('Email', TeacherArray[i].TeacherEmail);
          TDOMElement(ItemNode).SetAttribute('TelephoneNumber', TeacherArray[i].TelephoneNumber);
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
    writeXMLFile(Document, 'dance_studio.xml');
    Synchronize(@successSaveXML);
  end else Synchronize(@errorSaveXML);
end;

procedure TTableTeachersForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Left:=0;
  Top:=0;
  for i:=1 to countTeachers do
    begin
      Item := TeacherListView.Items.Add;
      Item.Caption := (IntToStr(TeacherArray[i].idTeacher));
      Item.SubItems.Add(TeacherArray[i].TeacherName);
      Item.SubItems.Add(IntToStr(TeacherArray[i].TeacherAge));
      Item.SubItems.Add(TeacherArray[i].SerialPassport);
      Item.SubItems.Add(IntToStr(TeacherArray[i].NumberPassport));
      Item.SubItems.Add(TeacherArray[i].TeacherEmail);
      Item.SubItems.Add(TeacherArray[i].TelephoneNumber);
        case TeacherArray[i].DanceDirection of
          HipHop: Item.SubItems.Add('Хип-Хоп');
          Krump: Item.SubItems.Add('Крамп');
          JFunk: Item.SubItems.Add('Джазз-Фанк');
          Break: Item.SubItems.Add('Брейкданс');
          Improvis: Item.SubItems.Add('Импровизация');
          LadyHop: Item.SubItems.Add('Лэдис Хип-Хоп');
          Plastic: Item.SubItems.Add('Стрип-Пластика');
          Contemp: Item.SubItems.Add('Контемпорари');
          BalDance: Item.SubItems.Add('Бальные танцы');
          VostokDance: Item.SubItems.Add('Восточные танцы');
          SportAcro: Item.SubItems.Add('Спортивная акроботика');
        end;
    end;
end;



procedure TTableTeachersForm.readFromXmlFileClick(Sender: TObject);
var
  PassNode : TDOMNode;
  Document : TXMLDocument;
  sIdTeacher,sNameTeacher,sAgeTeacher, sSerialPassTeacher, sNumberPassTeacher, sEmailTeacher, sTelephoneTeacher, sDanceDirectionTeacher : string;
  i : integer;
  Element : TDOMNode;
begin
  readXMLFile(Document,'dance_studio.xml');
  Element:=Document.FirstChild.FirstChild;
  i := 1;
  try
    try
      repeat
        sIdTeacher:=Element.Attributes.GetNamedItem('TeacherId').NodeValue;
        sNameTeacher:=Element.Attributes.GetNamedItem('TeacherName').NodeValue;
        sAgeTeacher:=Element.Attributes.GetNamedItem('TeacherAge').NodeValue;
        sSerialPassTeacher:=Element.Attributes.GetNamedItem('TeacherSerialPass').NodeValue;
        sNumberPassTeacher:=Element.Attributes.GetNamedItem('TeacherNumberPass').NodeValue;
        sEmailTeacher:=Element.Attributes.GetNamedItem('TeacherEmail').NodeValue;
        sTelephoneTeacher:=Element.Attributes.GetNamedItem('TeacherTelephone').NodeValue;
        //sDanceDirectionTeacher:=Element.Attributes.GetNamedItem('TeacherEmail').NodeValue);
        TeacherArray[i].idTeacher:=StrToInt(sIdTeacher);
        i:=i+1;
        Element:=Element.NextSibling;
      until Element = NIL;
    except
      ShowMessage('Ошибка чтения XML - файла!');
    end;
  finally
    Document.Free;
  end;
end;

procedure TTableTeachersForm.saveToXmlFileClick(Sender: TObject);
begin
  copyTeacherArray := TeacherArray;
  MyThread := TMyThread.Create(TeacherArray);
  MyThread.Execute;
end;

procedure TTableTeachersForm.TeacherListViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
  var DropItem,CurrentItem:TListItem; i,n:integer;
begin
  if Sender = Source then
    with TListView(Sender) do begin
      DropItem:= GetItemAt(X, Y);
        if DropItem<>nil then
          begin
          CurrentItem:=TListItem.Create(Items);
          CurrentItem.Assign(Selected);
          Selected.Delete;
          n:=DropItem.Index;
          AddItem('',nil);
        for I :=items.Count-1  downto DropItem.Index+1 do begin
           items.Item[i].Assign(items.Item[i-1]);
        end;
    Items.Item[n].Assign(CurrentItem);
    end;
    end;
end;

procedure TTableTeachersForm.TeacherListViewDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  with Sender as TListView do
    Accept := (Sender = TeacherListView) and (GetItemAt(X, Y) <> Selected);
end;


procedure TTableTeachersForm.delTeacherClick(Sender: TObject);
var i : integer;
    indexToDel : integer;
begin
  if(countTeachers = 0) then ShowMessage('Удаление невозможно: таблица пуста.') else
    begin
      if(TeacherListView.Selected = NIL) then
        begin
          ShowMessage('Удаление невозможно: не выбрано поле для удаления!');
        end else
        begin
          indexToDel := TeacherListView.Selected.Index;
          TeacherListView.Selected.Delete();
          for i := indexToDel+1 to countTeachers-1 do
          //Вот здеся смещение влево
            TeacherArray[i] := TeacherArray[i+1];
            dec(countTeachers);
            MainForm.restartStatClick;
        end;
    end;
end;

procedure TTableTeachersForm.addLineBtnClick(Sender: TObject);
begin
  addNewTeacherForm:=TaddNewTeacherForm.Create(self);
  TableTeachersForm.InsertControl(addNewTeacherForm);
  addNewTeacherForm.Show;
end;





procedure TTableTeachersForm.TeacherListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin

end;




end.

