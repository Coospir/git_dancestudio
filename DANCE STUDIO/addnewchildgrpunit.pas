unit addNewChildGrpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

const countChildGrp = 4;

type
  { TaddNewChildGrpForm }
  TaddNewChildGrpForm = class(TForm)
    btnSaveChildGrp: TButton;
    nameChildGrpEdit: TEdit;
    procedure btnSaveChildGrpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  grpChildArr[numChildGrp].nameGrp:=nameChildGrpEdit.Text;
  close;
end;

procedure TaddNewChildGrpForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

end.

