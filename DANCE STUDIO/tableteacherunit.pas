unit tableTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, addNewTeacherUnit;

type

  { TTableTeachersForm }

  TTableTeachersForm = class(TForm)
    ListBox1: TListBox;
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

implementation

{$R *.lfm}

{ TTableTeachersForm }

procedure TTableTeachersForm.FormCreate(Sender: TObject);
var
  myStringList: TStringList;
  i: integer;
begin
  Left:=0;
  Top:=0;
  for i:=1 to countTeachers do
    begin
      myStringList:=TStringList.Create;
      myStringList.Add(TeacherArray[countTeachers].TeacherName);
      myStringList.Add(TeacherArray[countTeachers].TeacherAge);
      myStringList.Add(TeacherArray[countTeachers].TeacherEmail);
      //myStringList.Add(TeacherArray[countTeachers].DanceDirection);
      ListBox1.Items.Assign(myStringList);
      //myStringList.Free;
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

