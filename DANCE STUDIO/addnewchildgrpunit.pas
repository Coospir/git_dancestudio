unit addNewChildGrpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, addNewTeacherUnit;

const countChildGrp = 4;

type
  { TaddNewChildGrpForm }
  TaddNewChildGrpForm = class(TForm)
    btnSaveChildGrp: TButton;
    changeTeacherChildGrp: TComboBox;
    addTeacherForGrpLabel: TLabel;
    NameChildGroup: TBoundLabel;
    NameGroupChildLabeledEdit: TLabeledEdit;
    procedure btnSaveChildGrpClick(Sender: TObject);
    procedure changeTeacherChildGrpChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

type grpChild = record
     nameGrp : string[20];

end;


var
  addNewChildGrpForm: TaddNewChildGrpForm;
  grpChildArr : array[1..countChildGrp] of grpChild;
  numChildGrp : integer;
implementation
uses MainMenu;

{$R *.lfm}

{ TaddNewChildGrpForm }

procedure TaddNewChildGrpForm.btnSaveChildGrpClick(Sender: TObject);
begin
  //if(TeacherArray[countTeachers].TeacherName = '') then
  //      begin
  //        ShowMessage('Невозможно сохранить данные: список преподавателей пуст!');
  //      end else
        begin
          numChildGrp:=numChildGrp+1;
          grpChildArr[numChildGrp].nameGrp:=NameGroupChildLabeledEdit.Text;
          MainForm.restartStatClick;
          close;
        end;
end;

procedure TaddNewChildGrpForm.changeTeacherChildGrpChange(Sender: TObject);

begin
end;


procedure TaddNewChildGrpForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

procedure TaddNewChildGrpForm.FormShow(Sender: TObject);
var i : integer;
  begin
  for i := 1 to countTeachers do
    begin
      changeTeacherChildGrp.AddItem(TeacherArray[i].TeacherName, NIL);
    end;
end;

end.

