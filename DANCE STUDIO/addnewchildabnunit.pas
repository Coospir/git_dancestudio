unit addNewChildAbnUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, MaskEdit;

type

  { TaddNewAbnForm }

  TaddNewAbnForm = class(TForm)
    ageNewClient: TEdit;
    ageNewClientLabel: TLabel;
    saveInfoNewClientBtn: TButton;
    grpNewClientLabel: TLabel;
    grpNewClient: TComboBox;
    emailNewClient: TLabeledEdit;
    emailNewClientLabel: TBoundLabel;
    telNumberNewClientLabel: TLabel;
    telNumberNewClient: TMaskEdit;
    nameNewClient: TLabeledEdit;
    nameNewClientLabel: TBoundLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure saveInfoNewClientBtnClick(Sender: TObject);
    procedure grpNewClientChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
const maxCountClients = 5;
type
  TNewClient = record
      idClient : integer;
      ClientName : string[100];
      ClientAge : integer;
      ClientEmail : string[100];
      ClientTelephoneNumber : string[20];
  end;
var
  addNewAbnForm: TaddNewAbnForm;
  countClients : integer;
  ClientArray : array[1..maxCountClients] of TNewClient;

implementation
uses MainMenu, addNewChildGrpUnit;

{$R *.lfm}

{ TaddNewAbnForm }

procedure idMakerForClient();
var
    max_num: integer;
    i: byte;
begin
    max_num := 1;
    for i := 1 to countClients-1 do
        if ClientArray[i].idClient >= max_num then begin
            max_num := ClientArray[i].idClient;
	    max_num := max_num + 1;
        end;
    ClientArray[countClients].idClient:= max_num;
end;

procedure TaddNewAbnForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

procedure TaddNewAbnForm.FormShow(Sender: TObject);
var i : integer;
     classTeacherID: TeacherID;
  begin
  for i := 1 to numChildGrp do
    begin
      classTeacherID:=TeacherID.Create;
      classTeacherID.SetIdTeacher(grpChildArr[i].TeacherID);
      grpNewClient.AddItem(grpChildArr[i].nameGrp, classTeacherID);
    end;
end;

procedure TaddNewAbnForm.saveInfoNewClientBtnClick(Sender: TObject);
begin
  try
    if (nameNewClient.Text = '') or (ageNewClient.Text = '')  or (emailNewClient.Text = '') or (telNumberNewClient.Text = '') or (grpNewClient.ItemIndex = -1) then
    begin
      ShowMessage('Оставлено пустое поле!');
    end else if(countClients >= maxCountClients) then ShowMessage('Достигнуто максимальное количество записей "Абонементы"!') else
      if(StrToInt(ageNewClient.Text) < 3) then ShowMessage('Возраст клиента слишком мал!') else
    begin
    ClientArray[countClients+1].ClientName:=nameNewClient.Text;
    ClientArray[countClients+1].ClientAge:=StrToInt(ageNewClient.Text);
    ClientArray[countClients+1].ClientEmail:=emailNewClient.Text;
    ClientArray[countClients+1].ClientTelephoneNumber:=telNumberNewClient.Text;
    (TeacherID(grpNewClient.Items.Objects[grpNewClient.ItemIndex])).GetIdTeacher;
    ShowMessage('Данные успешно сохранены!');
    countClients:=countClients+1;
    idMakerForClient();
    MainForm.restartStatClick;
    end;
  except
    on EConvertError do ShowMessage('Заполнены не все поля!');
  end;
end;

procedure TaddNewAbnForm.grpNewClientChange(Sender: TObject);
begin

end;

end.

