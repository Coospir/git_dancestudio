unit addNewChildGrpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, addNewTeacherUnit;

const countChildGrp = 4;

type
  { TaddNewGrpForm }
  TaddNewGrpForm = class(TForm)
    btnSaveChildGrp: TButton;
    changeTeacherChildGrp: TComboBox;
    addTeacherForChildGrpLabel: TLabel;
    NameChildGroup: TBoundLabel;
    NameGroupChildLabeledEdit: TLabeledEdit;
    procedure btnSaveChildGrpClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

type grpChild = record
     nameGrp : string[50];
     TeacherID : integer;
end;
type
  TeacherID = class
    private
      idTeacher : integer;
    public
      procedure SetIdTeacher(ID : integer);
      function GetIdTeacher : integer;
  end;

var
  addNewGrpForm: TaddNewGrpForm;
  grpChildArr : array[1..countChildGrp] of grpChild;
  numChildGrp : integer;
implementation
uses MainMenu;

{$R *.lfm}

{ TaddNewGrpForm }
function TeacherID.GetIdTeacher : integer;
begin
  GetIdTeacher:=idTeacher;
end;

procedure TeacherID.SetIdTeacher(ID : integer);
begin
  self.idTeacher := ID;
end;

procedure TaddNewGrpForm.btnSaveChildGrpClick(Sender: TObject);
begin
  if(NameGroupChildLabeledEdit.Text = '') or (changeTeacherChildGrp.ItemIndex = -1) then
  begin
    ShowMessage('Оставлено пустое поле!');
  end else
  begin
    numChildGrp:=numChildGrp+1;
    grpChildArr[numChildGrp].nameGrp:=NameGroupChildLabeledEdit.Text;
    grpChildArr[numChildGrp].TeacherID:=(TeacherID(changeTeacherChildGrp.Items.Objects[changeTeacherChildGrp.ItemIndex])).GetIdTeacher;
    ShowMessage('Группа успешно создана!');
    MainForm.restartStatClick;
  end;
end;

procedure TaddNewGrpForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

procedure TaddNewGrpForm.FormShow(Sender: TObject);
var i : integer;
    classTeacherID: TeacherID;
  begin
  for i := 1 to countTeachers do
    begin
      classTeacherID:=TeacherID.Create;
      classTeacherID.SetIdTeacher(TeacherArray[i].idTeacher);
      changeTeacherChildGrp.AddItem(TeacherArray[i].TeacherName, classTeacherID);
    end;
end;

end.

