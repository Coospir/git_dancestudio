unit tableTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ComCtrls, addNewTeacherUnit;

type

  { TTableTeachersForm }

  TTableTeachersForm = class(TForm)
    delTeacher: TButton;
    TeacherListView: TListView;
    procedure delTeacherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TeacherListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TeacherListViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TeacherListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { private declarations }
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
      Item.Caption :=(TeacherArray[i].TeacherName);
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
    TeacherListView.Selected.Delete;
    countTeachers:=countTeachers-1;
    numChildGrp:=numChildGrp-1;
    MainForm.restartStatClick;
  end else if(countTeachers = 0) then ShowMessage('Нечего удалять!') else
    if(TeacherListView.Selected.Selected = false) then
    ShowMessage('Не выбран пункт для удаления!');
end;

procedure TTableTeachersForm.TeacherListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin

end;




end.

