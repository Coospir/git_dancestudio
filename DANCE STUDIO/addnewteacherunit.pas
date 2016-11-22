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
    danceDirectionNewTeacherLabel: TLabel;
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
      idTeacher : integer;
      TeacherName : string[100];
      TeacherAge : integer;
      SerialPassport : string[6];
      NumberPassport : integer;
      TeacherEmail : string[100];
      TelephoneNumber : string[20];
      DanceDirection : TDanceDirection;
  end;
type
  cTeacherArray = array[1..maxCountTeachers] of TDanceTeacher;

var
  addNewTeacherForm: TaddNewTeacherForm;
  countTeachers : integer;

  TeacherArray : array[1..maxCountTeachers] of TDanceTeacher;
  copyTeacherArray : cTeacherArray;

implementation
uses MainMenu;
{$R *.lfm}
{ TaddNewTeacherForm }

procedure idMakerForTeacher();
var
    max_num: integer;
    i: byte;
begin
    max_num := 1;
//  max_num := TeacherArray[1].idTeacher;

    for i := 1 to countTeachers-1 do
        if TeacherArray[i].idTeacher >= max_num then begin
            max_num := TeacherArray[i].idTeacher;
	    max_num := max_num + 1;
        end;
    TeacherArray[countTeachers].idTeacher:= max_num;
end;


procedure TaddNewTeacherForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

procedure TaddNewTeacherForm.saveInfoNewTeacherBtnClick(Sender: TObject);
var cpTeacherArray : cTeacherArray;
begin
  try
    if (nameNewTeacher.Text = '') or (ageNewTeacher.Text = '') or(passSerialNewTeacher.Text = '') or (passNumberNewTeacher.Text = '') or (emailNewTeacher.Text = '') or (telNumberNewTeacher.Text = '') then
    begin
      ShowMessage('Оставлено пустое поле!');
    end else if(countTeachers >= maxCountTeachers) then ShowMessage('Достигнуто максимальное количество записей "Преподаватели"!') else
      if(ageNewTeacher.Text < '18') then ShowMessage('Возраст преподавателя слишком мал!') else
    begin
    TeacherArray[countTeachers+1].TeacherName:=nameNewTeacher.Text;
    TeacherArray[countTeachers+1].TeacherAge:=StrToInt(ageNewTeacher.Text);
    TeacherArray[countTeachers+1].SerialPassport:=passSerialNewTeacher.Text;
    TeacherArray[countTeachers+1].NumberPassport:=StrToInt(passNumberNewTeacher.Text);
    TeacherArray[countTeachers+1].TeacherEmail:=emailNewTeacher.Text;
    TeacherArray[countTeachers+1].TelephoneNumber:=telNumberNewTeacher.Text;
    case danceDirectionNewTeacher.ItemIndex of
      0:TeacherArray[countTeachers+1].DanceDirection:=HipHop;
      1:TeacherArray[countTeachers+1].DanceDirection:=Krump;
      2:TeacherArray[countTeachers+1].DanceDirection:=JFunk;
      3:TeacherArray[countTeachers+1].DanceDirection:=Break;
      4:TeacherArray[countTeachers+1].DanceDirection:=Improvis;
      5:TeacherArray[countTeachers+1].DanceDirection:=LadyHop;
      6:TeacherArray[countTeachers+1].DanceDirection:=Plastic;
      7:TeacherArray[countTeachers+1].DanceDirection:=Contemp;
      8:TeacherArray[countTeachers+1].DanceDirection:=BalDance;
      9:TeacherArray[countTeachers+1].DanceDirection:=VostokDance;
      10:TeacherArray[countTeachers+1].DanceDirection:=SportAcro;
    end;
      ShowMessage('Данные успешно сохранены!');
      countTeachers:=countTeachers+1;
      idMakerForTeacher();
      MainForm.restartStatClick;
    end;
  except
    on EConvertError do ShowMessage('Заполнены не все поля!');
  end;
  cpTeacherArray := TeacherArray;
end;

end.

