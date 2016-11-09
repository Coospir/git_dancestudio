unit tableTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ExtendedNotebook, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ActnList, ComCtrls, addNewTeacherUnit;

type

  { TTableTeachersForm }

  TTableTeachersForm = class(TForm)
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  TableTeachersForm: TTableTeachersForm;
  Item : TListItem;
implementation

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
      Item := ListView1.Items.Add;
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

procedure TTableTeachersForm.ListBox1Click(Sender: TObject);
begin

end;

procedure TTableTeachersForm.ListBox1SelectionChange(Sender: TObject;
  User: boolean);
begin
  ShowMessage('Проверка!');
end;


end.

