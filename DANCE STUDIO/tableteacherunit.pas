unit tableTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ComCtrls, addNewTeacherUnit, XMLRead, XMLWrite, DOM;

type

  { TTableTeachersForm }

  TTableTeachersForm = class(TForm)
    readFromXmlFile: TButton;
    saveToXmlFile: TButton;
    delTeacher: TButton;
    TeacherListView: TListView;
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
    XMLfile: TXMLDocument;
  public
    { public declarations }
  end;

var
  TableTeachersForm: TTableTeachersForm;
  Item : TListItem;
implementation
uses MainMenu, addNewChildGrpUnit;

{$R *.lfm}

{ TTableTeachersForm }

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
  Doc: TXMLDocument;
  Child: TDOMNode;
  j: Integer;
begin
  try
    ReadXMLFile(Doc, 'dance_studio.xml');
    //TListView.Clear;
    Child := Doc.DocumentElement.FirstChild;
    while Assigned(Child) do
    begin
      Item.SubItems.Add(Child.NodeName + ' ' + Child.Attributes.Item[0].NodeValue);
      with Child.ChildNodes do
      try
        for j:=1 to countTeachers do
    begin

      end;
      finally
        Free;
      end;
      Child := Child.NextSibling;
    end;
  finally
    Doc.Free;
  end;
end;

procedure TTableTeachersForm.saveToXmlFileClick(Sender: TObject);
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
    ShowMessage('Записано в файл: '+ 'dance_studio.xml');
    writeXMLFile(Document, 'dance_studio.xml');
    XMLfile.Free;
  end
  else ShowMessage('Пустая таблица!');
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
begin
  if(countTeachers <> 0) then
  begin
    if(TeacherListView.Selected = NIL) then
      begin
        ShowMessage('Не выбран пункт для удаления!');
      end else
      if(TeacherListView.Column[0].Caption = IntToStr(TeacherArray[countTeachers].idTeacher)) then
      begin
        TeacherListView.Selected.Delete;
        countTeachers:=countTeachers-1;
        numChildGrp:=numChildGrp-1;
        MainForm.restartStatClick;
      end;
  end else if(countTeachers = 0) then ShowMessage('Нечего удалять!') else
end;

procedure TTableTeachersForm.TeacherListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin

end;




end.

