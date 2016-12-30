program DanceStudio;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainMenu, addNewChildGrpUnit, settingsUnit, addNewTeacherUnit,
  tableTeacherUnit, lazcontrols, printer4lazarus, addNewChildAbnUnit,
  tableChildGrpUnit, tableClientUnit;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TaddNewGrpForm, addNewGrpForm);
  Application.CreateForm(TsettingsForm, settingsForm);
  Application.CreateForm(TaddNewTeacherForm, addNewTeacherForm);
  Application.CreateForm(TTableTeachersForm, TableTeachersForm);
  Application.CreateForm(TaddNewAbnForm, addNewAbnForm);
  Application.CreateForm(TListAllGrpForm, ListAllGrpForm);
  Application.CreateForm(TTableAbnForm, TableAbnForm);
  Application.Run;
end.

