unit addNewTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, MaskEdit;

type

  { TaddNewTeacherForm }

  TaddNewTeacherForm = class(TForm)
    ageNewTeacher: TEdit;
    saveInfoNewTeacherBtn: TButton;
    danceDirectionNewTeacher: TComboBox;
    Label1: TLabel;
    passSerialNewTeacher: TEdit;
    passNumberNewTeacher: TEdit;
    emailNewTeacher: TLabeledEdit;
    emailNewTeacherLabel: TBoundLabel;
    ageNewTeacherLabel: TLabel;
    telNumberNewTeacherLabel: TLabel;
    telNumberNewTeacher: TMaskEdit;
    nameNewTeacher: TLabeledEdit;
    nameNewTeacherLabel: TBoundLabel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  addNewTeacherForm: TaddNewTeacherForm;

implementation

{$R *.lfm}
{ TaddNewTeacherForm }

procedure TaddNewTeacherForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

end.

