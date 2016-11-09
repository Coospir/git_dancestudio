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

{$R *.lfm}

{ TaddNewChildGrpForm }

procedure TaddNewChildGrpForm.btnSaveChildGrpClick(Sender: TObject);
begin
  numChildGrp:=numChildGrp+1;
  grpChildArr[numChildGrp].nameGrp:=NameGroupChildLabeledEdit.Text;
  close;
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
begin
  changeTeacherChildGrp.AddItem(TeacherArray[countTeachers].TeacherName, NIL);
end;

end.

