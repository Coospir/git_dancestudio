unit addNewTeacherUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, MaskEdit, Buttons;

type

  { TaddNewTeacherForm }

  TaddNewTeacherForm = class(TForm)
    ageNewTeacher: TEdit;
    saveInfoNewTeacherBtn: TButton;
    danceDirectionNewTeacher: TComboBox;
    SerialNumberPassLabel: TLabel;
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
    procedure saveInfoNewTeacherBtnClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
const maxCountTeachers = 5;
type
  TDanceDirection = (HipHop, Krump, JFunk, Break, Improvis, LadyHop, Plastic, Contemp, BalDance, VostokDance, SportAcro);
type
  TDanceTeacher = record
      TeacherName : string[30];
      TeacherAge : string[2];
      SerialPassport : string[6];
      NumberPassport : string[6];
      TeacherEmail : string[50];
      TelephoneNumber : string[11];
      DanceDirection : TDanceDirection;
  end;

var
  addNewTeacherForm: TaddNewTeacherForm;
  countTeachers : integer;
  TeacherArray : array[1..maxCountTeachers] of TDanceTeacher;

implementation

{$R *.lfm}


{ TaddNewTeacherForm }

procedure TaddNewTeacherForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

procedure TaddNewTeacherForm.saveInfoNewTeacherBtnClick(Sender: TObject);
begin
  try
    countTeachers:=countTeachers+1;
    TeacherArray[countTeachers].TeacherName:=nameNewTeacher.Text;
    TeacherArray[countTeachers].TeacherAge:=ageNewTeacher.Text;
    TeacherArray[countTeachers].SerialPassport:=passSerialNewTeacher.Text;
    TeacherArray[countTeachers].NumberPassport:=passNumberNewTeacher.Text;
    TeacherArray[countTeachers].TeacherEmail:=emailNewTeacher.Text;
    TeacherArray[countTeachers].TelephoneNumber:=telNumberNewTeacher.Text;
    case danceDirectionNewTeacher.ItemIndex of
      0:TeacherArray[countTeachers].DanceDirection:=HipHop;
      1:TeacherArray[countTeachers].DanceDirection:=Krump;
      2:TeacherArray[countTeachers].DanceDirection:=JFunk;
      3:TeacherArray[countTeachers].DanceDirection:=Break;
      4:TeacherArray[countTeachers].DanceDirection:=Improvis;
      5:TeacherArray[countTeachers].DanceDirection:=LadyHop;
      6:TeacherArray[countTeachers].DanceDirection:=Plastic;
      7:TeacherArray[countTeachers].DanceDirection:=Contemp;
      8:TeacherArray[countTeachers].DanceDirection:=BalDance;
      9:TeacherArray[countTeachers].DanceDirection:=VostokDance;
      10:TeacherArray[countTeachers].DanceDirection:=SportAcro;
    end;
      ShowMessage('Данные успешно сохранены!');
  except
    on EConvertError do ShowMessage('Заполнены не все поля!');
  end;
  Close;
end;

end.

