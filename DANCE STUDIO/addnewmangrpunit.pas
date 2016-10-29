unit addNewManGrpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

const
  countManGrp = 4;
type
  { TaddNewManGrpForm }
  TaddNewManGrpForm = class(TForm)
    btnSaveManGrp: TButton;
    NameGroupManLabeledEdit: TLabeledEdit;
    NameManGroup: TBoundLabel;
    procedure btnSaveManGrpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

type grpMan = record
     nameGrp : string[20];
end;

var
  addNewManGrpForm: TaddNewManGrpForm;
  grpManArr : array[1..countManGrp] of grpMan;
  numManGrp : integer;
implementation

{$R *.lfm}

{ TaddNewManGrpForm }

procedure TaddNewManGrpForm.btnSaveManGrpClick(Sender: TObject);
begin
  numManGrp:=numManGrp+1;
  grpManArr[numManGrp].nameGrp:=NameGroupManLabeledEdit.Text;
  close;
end;

procedure TaddNewManGrpForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

end.

