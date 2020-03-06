unit ReportDetails;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView, FMX.Layouts, FMX.Ani,
  FMX.Objects, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TReportDetailForm = class(TForm)
    FormLayout: TLayout;
    ReportDetailLV: TListView;
    SettingTB: TToolBar;
    MenuBtn: TButton;
    Menu_Layout: TLayout;
    MenuRR: TRoundRect;
    AnimalMenu: TFloatAnimation;
    RefreshBtn: TButton;
    ReportDetailBS: TBindSourceDB;
    ReportDetailBL: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ReportHeaderTB: TToolBar;
    HomeBtn: TButton;
    RefreshPBtn: TButton;
    HeaderLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RefreshBtnClick(Sender: TObject);
    procedure MenuBtnClick(Sender: TObject);
    procedure HomeBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure PanelMenuView();
    procedure PanelMenuHide();
  public
    { Public declarations }
  end;

var
  ReportDetailForm: TReportDetailForm;

implementation

{$R *.fmx}

uses AppData;

{ TReportDetailForm }

procedure TReportDetailForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      {$IFDEF ANDROID}
          Action := TCloseAction.caFree;
      {$ENDIF}
end;

procedure TReportDetailForm.HomeBtnClick(Sender: TObject);
begin
  Close();
end;

procedure TReportDetailForm.MenuBtnClick(Sender: TObject);
begin
    PanelMenuView();
end;

procedure TReportDetailForm.PanelMenuHide;
begin
   Menu_Layout.Visible := False;
   AnimalMenu.Inverse := true;
   AnimalMenu.Start;
end;

procedure TReportDetailForm.PanelMenuView;
begin
    Menu_Layout.Position.Y := Self.Height + 20;
    Menu_Layout.Visible := True;

    AnimalMenu.Inverse := False;
    AnimalMenu.StartValue := Self.Height + 20;
    AnimalMenu.Start;
end;

procedure TReportDetailForm.RefreshBtnClick(Sender: TObject);
begin
  PanelMenuHide();
    try
      ReportDetailLV.Items.Clear;
      ReportDetailLV.BeginUpdate;
      ReportDetailBS.DataSet.Refresh;
      ReportDetailLV.EndUpdate;
    finally
    end;
end;

end.
