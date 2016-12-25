unit tableChildGrpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls;

type

  { TListAllGrpForm }

  TListAllGrpForm = class(TForm)
    AllGrpListView: TListView;
    DelGrpBtn: TButton;
    procedure DelGrpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ListAllGrpForm: TListAllGrpForm;
  Item : TListItem;
implementation
uses addNewChildGrpUnit, addNewTeacherUnit, MainMenu;
{$R *.lfm}

{ TListAllGrpForm }

procedure TListAllGrpForm.DelGrpBtnClick(Sender: TObject);
var i : integer;
    indexToDel : integer;
begin
  if(numChildGrp = 0) then ShowMessage('Удаление невозможно: таблица пуста.') else
    begin
      if(AllGrpListView.Selected = NIL) then
        begin
          ShowMessage('Удаление невозможно: не выбрано поле для удаления!');
        end else
        begin
          indexToDel := AllGrpListView.Selected.Index;
          AllGrpListView.Selected.Delete();
          for i := indexToDel+1 to numChildGrp-1 do
          //Вот здеся смещение влево
            grpChildArr[i] := grpChildArr[i+1];
            dec(numChildGrp);
            MainForm.restartStatClick;
        end;
    end;
end;

procedure TListAllGrpForm.FormCreate(Sender: TObject);
var i, j : integer;
begin
  Left:=0;
  Top:=0;
  for j:= 1 to numChildGrp do
  begin
    Item:=AllGrpListView.Items.Add;
    for i:=1 to countTeachers do
    begin
      if(grpChildArr[j].TeacherID = TeacherArray[i].idTeacher) then
      begin
        Item.Caption:=grpChildArr[j].nameGrp;
        Item.SubItems.Add(TeacherArray[i].TeacherName);
      end;
    end;
  end;

end;


end.

