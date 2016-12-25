unit tableClientUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;

type

  { TTableAbnForm }

  TTableAbnForm = class(TForm)
    DelClientBtn: TButton;
    grpboxAbnListView: TGroupBox;
    ClientsListView: TListView;
    procedure DelClientBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  TableAbnForm: TTableAbnForm;
  Item : TListItem;

implementation
uses addNewChildAbnUnit, MainMenu, addNewTeacherUnit, addNewChildGrpUnit;
{$R *.lfm}

{ TTableAbnForm }

procedure TTableAbnForm.FormCreate(Sender: TObject);
var i : integer;
begin
  Left:=0;
  Top:=0;
  for i:=1 to countClients do
    begin
      Item := ClientsListView.Items.Add;
      Item.Caption := (IntToStr(ClientArray[i].idClient));
      Item.SubItems.Add(ClientArray[i].ClientName);
      Item.SubItems.Add(IntToStr(ClientArray[i].ClientAge));
      Item.SubItems.Add(ClientArray[i].ClientEmail);
      Item.SubItems.Add(ClientArray[i].ClientTelephoneNumber);
      Item.SubItems.Add(grpChildArr[i].nameGrp);
    end;
end;

procedure TTableAbnForm.DelClientBtnClick(Sender: TObject);
var i : integer;
    indexToDel : integer;
begin
  if(countClients = 0) then ShowMessage('Удаление невозможно: таблица пуста.') else
    begin
      if(ClientsListView.Selected = NIL) then
        begin
          ShowMessage('Удаление невозможно: не выбрано поле для удаления!');
        end else
        begin
          indexToDel := ClientsListView.Selected.Index;
          ClientsListView.Selected.Delete();
          for i := indexToDel+1 to countClients-1 do
            ClientArray[i] := ClientArray[i+1];
            dec(countClients);
            MainForm.restartStatClick;
        end;
    end;
end;

end.

