unit tableTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, PrintersDlgs, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ActnList, ComCtrls, Buttons, addNewTeacherUnit, XMLRead, XMLWrite,
  DOM, Printers, Windows;

type

  { TTableTeachersForm }

  TTableTeachersForm = class(TForm)
    addLineBtn: TButton;
    Button1: TButton;
    changeLineBtn: TButton;
    grpboxTeacherListView: TGroupBox;
    pageControlTeacher: TPageControl;
    PrintDialog1: TPrintDialog;
    readFromXmlFile: TButton;
    saveToXmlFile: TButton;
    delTeacher: TButton;
    btnForListView: TTabSheet;
    btnForFunctions: TTabSheet;
    TeacherListView: TListView;
    procedure addLineBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
const
  TOTAL_PAGES = 2;   // Сколько страниц печатать
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
  s: string;
begin
  readXMLFile(Document,'dance_studio.xml');
  Element:=Document.FirstChild.FirstChild;
  i := 1;
  //sIdTeacher:=IntToStr(TeacherArray[i].idTeacher);
  //      sNameTeacher:=TeacherArray[i].TeacherName;
  //      sAgeTeacher:=IntToStr(TeacherArray[i].TeacherAge);
  //      sSerialPassTeacher:=TeacherArray[i].SerialPassport;
  //      sNumberPassTeacher:=IntToStr(TeacherArray[i].NumberPassport);
  //      sEmailTeacher:=TeacherArray[i].TeacherEmail;
  //      sTelephoneTeacher:=TeacherArray[i].TelephoneNumber;
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
       // if(sDanceDirectionTeacher =
        i:=i+1;
        Element:=Element.NextSibling;

        Item := TeacherListView.Items.Add;
        Item.Caption :=sIdTeacher;
        Item.SubItems.Add(sNameTeacher);
        Item.SubItems.Add(sAgeTeacher);
        Item.SubItems.Add(sSerialPassTeacher);
        Item.SubItems.Add(sNumberPassTeacher);
        Item.SubItems.Add(sEmailTeacher);
        Item.SubItems.Add(sTelephoneTeacher);
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
      TeacherArray[i].idTeacher:=StrToInt(sIdTeacher);
      TeacherArray[i].TeacherName:=sNameTeacher;
      TeacherArray[i].TeacherAge:=StrToInt(sAgeTeacher);
      TeacherArray[i].SerialPassport:=sSerialPassTeacher;
      TeacherArray[i].NumberPassport:=StrToInt(sNumberPassTeacher);
      TeacherArray[i].TeacherEmail:=sEmailTeacher;
      TeacherArray[i].TelephoneNumber:=sTelephoneTeacher;
      i:=i+1;
      countTeachers:=countTeachers+1;
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

//function Scale(Value: longint; Size: integer): longint;
//begin
// if SIze > 100 then
//  Size := 100
// else if Size < 0 then
//  Size := 0;
//
// if Size = 0 then
//  Result := Value
// else
//  Result := Value + MulDiv(Value, Size, 100);
//end;
//
//procedure PrintListView(intro:String; lwToSave:TListView);
//var
// LinesHeight, LineShift, WordWidth, ListViewWordWidth, LineWidth, CellWidth: Longint;
// iTop, iLeft, i, row:Integer;
// TextRect: TRect;
//begin
// with TPrintDialog.Create(nil) do
//  begin
//    Options := [poWarning];
//  if not Execute then
//    exit;
//   Free;
//  end;
// Printer.Title := intro;
// Printer.BeginDoc;
// Printer.Canvas.Font.Assign(lwToSave.Font);
// LinesHeight := Scale(Printer.Canvas.TextHeight('M'), 20);
// LineShift := (LinesHeight-Printer.Canvas.TextHeight('M')) div 2;
// WordWidth := Printer.Canvas.TextWidth('0');
// ListViewWordWidth := lwToSave.Canvas.TextWidth('0');
//
// iTop:=LinesHeight*2;
// LineWidth:=0;
//
// // Print Header
// Printer.Canvas.Font.Style:=[fsBold];
// iLeft := WordWidth*5;
// Printer.Canvas.MoveTo(iLeft, iTop);
// Printer.Canvas.LineTo(iLeft, iTop+LinesHeight);
// for i := 0 to lwToSave.Columns.Count - 1 do
//  begin
//   Printer.Canvas.TextOut(iLeft+LineShift, iTop+LineShift, lwToSave.Columns[i].Caption);
//
//   CellWidth:=LineShift*2+lwToSave.Columns[i].Width*WordWidth div ListViewWordWidth;
//   LineWidth:=LineWidth+CellWidth;
//   iLeft := iLeft+CellWidth;
//
//   Printer.Canvas.MoveTo(iLeft, iTop);
//   Printer.Canvas.LineTo(iLeft, iTop+LinesHeight);
//  end;
//
// iLeft := WordWidth*5;
// Printer.Canvas.MoveTo(iLeft, iTop);
// Printer.Canvas.LineTo(iLeft+LineWidth, iTop);
// Printer.Canvas.MoveTo(iLeft, iTop+LinesHeight);
// Printer.Canvas.LineTo(iLeft+LineWidth, iTop+LinesHeight);
//
// // Print rows
// Printer.Canvas.Font.Style:=[];
// for row := 0 to lwToSave.Items.Count - 1 do
//  begin
//   iTop:=iTop+LinesHeight;
//
//   // new page
//   if iTop>Printer.PageHeight-LinesHeight*3 then
//    begin
//     iTop:=LinesHeight*2;
//     Printer.NewPage;
//    end;
//
//
//   Printer.Canvas.MoveTo(iLeft, iTop);
//   Printer.Canvas.LineTo(iLeft, iTop+LinesHeight);
//   for i := 0 to lwToSave.Columns.Count - 1 do
//    begin
//     CellWidth:=LineShift*2+lwToSave.Columns[i].Width*WordWidth div ListViewWordWidth;
//     //TextRect:=Rect((iLeft+LineShift), (iTop+LineShift), (iLeft+LineShift+CellWidth), (iTop+LineShift+LinesHeight));
//     if i=0 then
//      Intro:=lwToSave.Items[row].Caption
//     else
//      Intro:=lwToSave.Items[row].SubItems[i-1];
//     Printer.Canvas.TextRect(TextRect,1 ,1,Intro);
//
//     iLeft := iLeft+CellWidth;
//
//     Printer.Canvas.MoveTo(iLeft, iTop);
//     Printer.Canvas.LineTo(iLeft, iTop+LinesHeight);
//    end;
//
//   iLeft := WordWidth*5;
//   Printer.Canvas.MoveTo(iLeft, iTop);
//   Printer.Canvas.LineTo(iLeft+LineWidth, iTop);
//   Printer.Canvas.MoveTo(iLeft, iTop+LinesHeight);
//   Printer.Canvas.LineTo(iLeft+LineWidth, iTop+LinesHeight);
//  end;
// Printer.EndDoc;
//end;

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

procedure TTableTeachersForm.Button1Click(Sender: TObject);
var
  printDialog    : TPrintDialog;
  page, startPage, endPage : Integer;
begin
  // Создание диалога выбора принтера
  printDialog := TPrintDialog.Create(TableTeachersForm);
  // Создание диалога выбора принтера
  printDialog := TPrintDialog.Create(TableTeachersForm);

  // Установка опций диалога печати
  printDialog.MinPage := 1;
  printDialog.MaxPage := TOTAL_PAGES;
  printDialog.ToPage  := TOTAL_PAGES;
  printDialog.Options := [poPageNums];

  // Если пользователь выбрал принтер (или значение по умолчанию), то печатаем!
  if printDialog.Execute then
  begin
    // Используйте функцию Printer, чтобы получить доступ к глобальному объекту TPrinter.
    // Set to landscape orientation
    Printer.Orientation := poLandscape;

    // Установите заголовок printjob - как оно появляется в менеджере задания по выводу на печать
    Printer.Title := 'Printing...';

    // Устанавливаем число копий для печати каждой страницы
    Printer.Copies := printDialog.Copies;

    // Начало печати
    Printer.BeginDoc;

    // Пользователь выбрал диапазон страниц?
    if printDialog.PrintRange = prPageNums then
    begin
      startPage := printDialog.FromPage;
      endPage   := printDialog.ToPage;
    end
    else // Все страницы
    begin
      startPage := 1;
      endPage   := TOTAL_PAGES;
    end;

    // Установка номера начальной страницы
    page := startPage;

    // Продолжаем печатать пока всё OK
    while (not Printer.Aborted) and Printer.Printing do
    begin
      // Пишем номер страницы
      Printer.Canvas.Font.Color := clBlue;
      Printer.Canvas.TextOut(40,  20, 'Page number = '+IntToStr(page));

      // Увеличиваем номер страницы
      Inc(page);

      // Теперь начинаем новую страницу - если она не последняя
      if (page <= endpage) and (not printer.aborted)
      then Printer.NewPage;
    end;

    // Конец печати
    Printer.EndDoc;
  end;
end;

procedure TTableTeachersForm.TeacherListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin

end;

end.
