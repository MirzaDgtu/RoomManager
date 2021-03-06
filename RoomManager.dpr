program RoomManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {MainForm},
  sConsts in 'sConsts.pas',
  AppData in 'AppData.pas' {ModuleData: TDataModule},
  Room in 'Room.pas' {RoomForm},
  RoomDetail in 'RoomDetail.pas' {RoomDetailForm},
  RoomBehaviors in 'RoomBehaviors.pas',
  Order in 'Order.pas' {OrderForm},
  OrderBehavior in 'OrderBehavior.pas',
  Range in 'Range.pas' {RangeForm},
  StatesBehavior in 'StatesBehavior.pas',
  State in 'State.pas' {StatesForm},
  StateDetail in 'StateDetail.pas' {StateDetailForm},
  ReportDetails in 'ReportDetails.pas' {ReportDetailForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
