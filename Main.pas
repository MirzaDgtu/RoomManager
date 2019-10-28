unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.ListView, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, FMX.TabControl, FMX.Ani, System.ImageList, FMX.ImgList,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.GenData, Fmx.Bind.GenData,
  Data.Bind.ObjectScope, FMX.Menus, Data.Bind.DBScope, FMX.DialogService;

type
  TMainForm = class(TForm)
    TB: TToolBar;
    Tabs: TTabControl;
    OrdersTab: TTabItem;
    ReportTab: TTabItem;
    MenuBtn: TButton;
    Shop_Layout: TLayout;
    AnimalMenu: TFloatAnimation;
    OrdersView: TListView;
    RoomBtn: TButton;
    MenuRect: TRoundRect;
    AddBtn: TButton;
    CorrBtn: TButton;
    DeleteBtn: TButton;
    RefreshBtn: TButton;
    OrdersBS: TBindSourceDB;
    OrdersBL: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    SettingBtn: TButton;
    SettingLayout: TLayout;
    SettingRect: TRoundRect;
    AnimalSetting: TFloatAnimation;
    RangeRectBtn: TRectangle;
    SettingRectBtn: TRectangle;
    StateRectBtn: TRectangle;
    ReportLV: TListView;
    Report_Layout: TLayout;
    ReportRR: TRoundRect;
    RefreshReportBtn: TButton;
    AnimalReport: TFloatAnimation;
    ReportBS: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    ToolBar1: TToolBar;
    TotalReportLbl: TLabel;
    ReportDetailBtn: TButton;
    procedure MenuBtnClick(Sender: TObject);
    procedure RoomBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrdersViewClick(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure OrdersViewItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SettingBtnClick(Sender: TObject);
    procedure CorrBtnClick(Sender: TObject);
    procedure RangeRectBtnClick(Sender: TObject);
    procedure StateRectBtnClick(Sender: TObject);
    procedure ReportLVClick(Sender: TObject);
    procedure RefreshReportBtnClick(Sender: TObject);
    procedure OrdersTabClick(Sender: TObject);
    procedure ReportTabClick(Sender: TObject);
    procedure ReportLVItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ReportDetailBtnClick(Sender: TObject);
  private
    FIdOrder: string;
    FEndDate: variant;
    FBegDate: variant;
    FIdRoomReport: string;
    { Private declarations }

    function getDate(dateValue: string): TDate;

    procedure PanelMenuView();
    procedure PanelMenuHide();
    procedure PanelSettingView();
    procedure PanelSettingHide();
    procedure PanelReportView();
    procedure PanelReportHide();

    procedure SetIdOrder(const Value: string);
    procedure SetBegDate(const Value: variant);
    procedure SetEndDate(const Value: variant);

    procedure RefreshReport(DateB, DateE: variant);
    procedure SetIdRoomReport(const Value: string);

  public
    { Public declarations }

          // Свойства документа
    property BegDate: variant read FBegDate write SetBegDate;
    property EndDate: variant read FEndDate write SetEndDate;

    property IdOrder: string read FIdOrder write SetIdOrder;

    property IdRoomReport: string read FIdRoomReport write SetIdRoomReport;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses Room, AppData, RoomBehaviors, sConsts, Order, OrderBehavior, Range, State,
  ReportDetails;

procedure TMainForm.AddBtnClick(Sender: TObject);
var
    OrderF: TOrderForm;
    OrderA: TOrderAction;
begin
   Shop_Layout.Visible := False;
   AnimalMenu.Inverse := true;
   AnimalMenu.Start;

    OrderF := TOrderForm.Create(MainForm);
    OrderA := TOrderAction.Create;

    try
       with OrderF do
        begin
           DateBOrder.Date := Now();
           DateEOrder.Date := Now();
           PstatusCorr := False;


           {$IFDEF ANDROID}
              ShowModal(
                        procedure(ModalResult: TModalResult)
                          Begin
                              if ModalResult = mrOk then
                                Begin
                                    try
                                      try
                                        OrderA.add(FormatDateTime('yyyy-mm-dd hh:MM:ss', Now),
                                                                  FormatDateTime('yyyy-mm-dd', DateBOrder.Date),
                                                                  FormatDateTime('yyyy-mm-dd', DateEOrder.Date),
                                                                  IdRoom.ToInteger,
                                                                  PhoneEdit.Text,
                                                                  PriceEdit.Text,
                                                                  IdTypeDoc.ToInteger);
                                      finally
                                           RefreshBtnClick(Self);
                                      end;
                                    except
                                        on Err: Exception do
                                          ShowMessage('Ошибка создания заявки!' + #13 + 'Сообщение: ' + Err.Message);
                                    end;
                                end;
                          end
                        );
           {$ENDIF}



           {$IFDEF MSWINDOWS}
              if ShowModal = mrOk then
                Begin
                    try
                      try
                        OrderA.add(FormatDateTime('yyyy-mm-dd hh:MM:ss', Now),
                                                  FormatDateTime('yyyy-mm-dd', DateBOrder.Date),
                                                  FormatDateTime('yyyy-mm-dd', DateEOrder.Date),
                                                  IdRoom.ToInteger,
                                                  PhoneEdit.Text,
                                                  PriceEdit.Text,
                                                  IdTypeDoc.ToInteger);
                      finally
                          RefreshBtnClick(Self);
                      end;
                    except
                        on Err: Exception do
                          ShowMessage('Ошибка создания заявки!' + #13 + 'Сообщение: ' + Err.Message);
                    end;
                End;
           {$ENDIF}
        End;
    finally
       {$IFDEF MSWINDOWS}
          FreeAndNil(OrderF);
       {$ENDIF}
    end;

end;

procedure TMainForm.CorrBtnClick(Sender: TObject);
var
    OrderF: TOrderForm;
    OrderA: TOrderAction;
begin

   PanelMenuHide();
   OrderF := TOrderForm.Create(MainForm);
   OrderA := TOrderAction.Create;

   try
     try
      if Length(Trim(IdOrder)) > 0 then
        Begin
          ModuleData.OrderDBQuery.Active := False;
          ModuleData.OrderDBQuery.SQL.Text := Format(SSQLGetOrderDetail, [IdOrder.ToInteger]);
          ModuleData.OrderDBQuery.Active := True;

          with OrderF do
            Begin
              RoomLbl.Text    := ModuleData.OrderDBQuery.FieldByName('RoomStr').AsString;
              PhoneEdit.Text  := ModuleData.OrderDBQuery.FieldByName('Phone').AsString;
              IDRoom          := ModuleData.OrderDBQuery.FieldByName('Room').AsString;
              PriceRoom       := ModuleData.OrderDBQuery.FieldByName('PriceRoom').AsString;
              DateBOrder.Date := getDate(ModuleData.OrderDBQuery.FieldByName('DateBeg').AsString);
              DateEOrder.Date := getDate(ModuleData.OrderDBQuery.FieldByName('DateEnd').AsString);
              IdTypeDoc       := ModuleData.OrderDBQuery.FieldByName('TypeDocID').AsString;
              StateEdit.Text  := ModuleData.OrderDBQuery.FieldByName('Description').AsString;
              PriceEdit.Text  := ModuleData.OrderDBQuery.FieldByName('Price').AsString;


              {$IFDEF ANDROID}
                  ShowModal  (
                                procedure(ModalResult: TModalResult)
                                  Begin
                                      if ModalResult = mrOk then
                                        Begin
                                           try
                                              OrderA.correction(FormatDateTime('yyyy-mm-dd hh:MM:ss', Now()),
                                                                FormatDateTime('yyyy-mm-dd', DateBOrder.Date),
                                                                FormatDateTime('yyyy-mm-dd', DateEOrder.Date),
                                                                IDRoom.ToInteger,
                                                                PhoneEdit.Text,
                                                                PriceEdit.Text,
                                                                IdTypeDoc.ToInteger,
                                                                IdOrder.ToInteger);
                                           finally
                                              RefreshBtnClick(Self);
                                           end;
                                        End;
                                  End
                              );
              {$ENDIF}

              {$IFDEF MSWINDOWS}
                  if ShowModal = 1 then
                    Begin
                      try
                        OrderA.correction(FormatDateTime('yyyy-mm-dd hh:MM:ss', Now()),
                                          FormatDateTime('yyyy-mm-dd', DateBOrder.Date),
                                          FormatDateTime('yyyy-mm-dd', DateEOrder.Date),
                                          IDRoom.ToInteger,
                                          PhoneEdit.Text,
                                          PriceEdit.Text,
                                          IdTypeDoc.ToInteger,
                                          IdOrder.ToInteger);
                      finally
                         RefreshBtnClick(Self);
                      end;


                    End;
              {$ENDIF}
            End;
        End;
     finally
        RefreshBtnClick(Self);
     end;
   finally
      {$IFDEF MSWINDOWS}
          FreeAndNil(OrderF);
      {$ENDIF}
      FreeAndNil(OrderA);
      RefreshBtnClick(Self);
   end;
end;

procedure TMainForm.DeleteBtnClick(Sender: TObject);
begin
      PanelMenuHide();

       try
         if Length(IdOrder) > 0 then
          Begin
           TDialogService.MessageDialog('Вы действительно хотите удалить эту заявку?', System.UITypes.TMsgDlgType.mtInformation,
                                  [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
                                   System.UITypes.TMsgDlgBtn.mbYes, 0,

                                   procedure(const AResult: TModalResult)
                                   begin
                                     case AResult of
                                      mrYES: try
                                                try
                                                  ModuleData.Connection.StartTransaction;
                                                    ModuleData.OrderDBQuery.SQL.Text := Format(SSQLDeleteOrder, [IdOrder.ToInteger]);
                                                    ModuleData.OrderDBQuery.ExecSQL;
                                                  ModuleData.Connection.Commit;
                                                finally
                                                  Self.OrdersView.BeginUpdate;
                                                    ModuleData.RoomQuery.Active := False;
                                                    ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
                                                    ModuleData.RoomQuery.Active := True;

                                                    OrdersBS.DataSet.Refresh;
                                                  Self.OrdersView.EndUpdate;
                                                end;
                                             except
                                                on Err: Exception do
                                                  Begin
                                                    ModuleData.Connection.Rollback;
                                                    Showmessage('Ошибка удаления заявки!' + #13 + 'Сообщение: ' + Err.Message);
                                                  End;
                                             end;
                                      mrNo: ;
                                     end;
                                   end);
        End;
   finally
      Self.OrdersView.BeginUpdate;
        ModuleData.RoomQuery.Active := False;
        ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
        ModuleData.RoomQuery.Active := True;

        OrdersBS.DataSet.Refresh;
      Self.OrdersView.EndUpdate;
   end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     ModuleData := TModuleData.Create(Application);
     BegDate := FormatDateTime('yyyy-mm-dd', Now());
     EndDate := FormatDateTime('yyyy-mm-dd', Now()+1);
     Tabs.ActiveTab := OrdersTab;

     with ModuleData do
      Begin
         ConnectionToLocalDB;

         OrderQuery.Active := False;
         OrderQuery.SQL.Text := Format(SSQLGetOrders, [BegDate,
                                                       EndDate]);
         OrderQuery.Active := True;
      end;
end;


function TMainForm.getDate(dateValue: string): TDate;
var
    strYear, strMonth, strDay: string;
begin
    strYear := Copy(dateValue, 0, 4);
    strMonth := Copy(dateValue, 6, 2);
    strDay  := Copy(dateValue, 9, 2);

    Result := StrToDate(strDay + '.' + strMonth + '.' + strYear);
end;


procedure TMainForm.MenuBtnClick(Sender: TObject);
begin
    PanelSettingHide();

    case Tabs.TabIndex of
      0: PanelMenuView();
      1: PanelReportView();
    end;
end;

procedure TMainForm.OrdersTabClick(Sender: TObject);
begin
    PanelMenuHide();
    PanelSettingHide();
    PanelReportHide();
end;

procedure TMainForm.OrdersViewClick(Sender: TObject);
begin
   PanelMenuHide();
   PanelSettingHide();
end;

procedure TMainForm.OrdersViewItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    IdOrder := AItem.Data['ID'].asString;
end;

procedure TMainForm.PanelMenuHide;
begin
   Shop_Layout.Visible := False;
   AnimalMenu.Inverse := true;
   AnimalMenu.Start;
end;

procedure TMainForm.PanelMenuView;
begin
    Shop_Layout.Position.Y := MainForm.Height + 20;
    Shop_Layout.Visible := True;

    AnimalMenu.Inverse := False;
    AnimalMenu.StartValue := MainForm.Height + 20;
    AnimalMenu.Start;
end;

procedure TMainForm.PanelReportHide;
begin
   Report_Layout.Visible := False;
   AnimalReport.Inverse := true;
   AnimalReport.Start;
end;

procedure TMainForm.PanelReportView;
begin
    Report_Layout.Position.Y := MainForm.Height + 20;
    Report_Layout.Visible := True;

    AnimalReport.Inverse := False;
    AnimalReport.StartValue := Self.Height + 20;
    AnimalReport.Start;
end;

procedure TMainForm.PanelSettingHide;
begin
   SettingLayout.Visible := False;
   AnimalSetting.Inverse := true;
   AnimalSetting.Start;
end;

procedure TMainForm.PanelSettingView();
begin
    SettingLayout.Position.Y := MainForm.Height + 20;
    SettingLayout.Visible := True;

    AnimalSetting.Inverse := False;
    AnimalSetting.StartValue := MainForm.Height + 20;
    AnimalSetting.Start;
end;

procedure TMainForm.RangeRectBtnClick(Sender: TObject);
var
    RangeF: TRangeForm;
begin
   RangeF := TRangeForm.Create(MainForm);
   PanelSettingHide();

   try
      RangeF.DateBPicker.Date := Now();
      RangeF.DateEndPicker.Date := Now();
      {$IFDEF ANDROID}
          RangeF.ShowModal(
                     procedure (ModalResult: TModalResult)
                      Begin
                        if ModalResult =  mrOk then
                          Begin
                            try
                              BegDate := FormatDateTime('yyyy-mm-dd', RangeF.DateBPicker.Date);
                              EndDate := FormatDateTime('yyyy-mm-dd', RangeF.DateEndPicker.Date);
                            finally
                              RefreshBtnClick(Self);
                            end;
                          end;
                      End
                   );
      {$ENDIF}

      {$IFDEF MSWINDOWS}
          if RangeF.ShowModal = 1 then
            Begin
                try
                  BegDate := FormatDateTime('yyyy-mm-dd', RangeF.DateBPicker.Date);
                  EndDate := FormatDateTime('yyyy-mm-dd', RangeF.DateEndPicker.Date);
                finally
                  RefreshBtnClick(Self);
                end;
            End;
      {$ENDIF}
   finally
       {$IFDEF MSWINDOWS}
          FreeAndNil(RangeF);
       {$ENDIF}
          RefreshBtnClick(Self);
   end;

end;

procedure TMainForm.Rectangle1Click(Sender: TObject);
var
    Room: TRoomForm;
begin
   PanelMenuHide();

   Room := TRoomForm.Create(MainForm);
    try

      {$IFDEF ANDROID}
          Room.Show();
      {$ENDIF}

      {$IFDEF MSWINDOWS}
          Room.ShowModal();
      {$ENDIF}
    finally
      {$IFDEF MSWINDOWS}
          FreeAndNil(Room);
      {$ENDIF}
    end;
end;

procedure TMainForm.RefreshBtnClick(Sender: TObject);
begin
    PanelMenuHide();

    try
       OrdersView.BeginUpdate;
         ModuleData.OrderQuery.Active := False;
         ModuleData.OrderQuery.SQL.Text := Format(SSQLGetOrders, [BegDate,
                                                                  EndDate]);
        ModuleData.OrderQuery.Active := True;

         OrdersBS.DataSet.Refresh;
    finally
       OrdersView.EndUpdate;
    end;
end;

procedure TMainForm.RefreshReport(DateB, DateE: variant);
begin
    ModuleData.ReportQuery.Active := False;
    ModuleData.ReportQuery.SQL.Text := Format(SSQLRepotrSales, [DateB,
                                                                DateE,
                                                                DateB,
                                                                DateE,
                                                                DateB,
                                                                DateE,
                                                                DateB,
                                                                DateE,
                                                                DateB,
                                                                DateE,
                                                                DateB,
                                                                DateE,
                                                                DateB,
                                                                DateE]);
    ModuleData.ReportQuery.Active := True;

    ModuleData.ReportTotalQuery.Active := False;
    ModuleData.ReportTotalQuery.SQL.Text := Format(SSQLGetReportTotal, [DateB,
                                                                        DateE,
                                                                        DateB,
                                                                        DateE,
                                                                        DateB,
                                                                        DateE,
                                                                        DateB,
                                                                        DateE]);
    ModuleData.ReportTotalQuery.Active := True;

    try
      try
        ReportLV.Items.Clear;
        ReportLV.BeginUpdate;
          ReportBS.DataSet.Refresh;
        ReportLV.EndUpdate;

        TotalReportLbl.Text := ModuleData.ReportTotalQuery.FieldByName('TotalReportPrice').AsString;
      finally
      end;
    finally
    end;
end;

procedure TMainForm.RefreshReportBtnClick(Sender: TObject);
begin
    PanelReportHide();
    RefreshReport(BegDate, EndDate);
end;

procedure TMainForm.ReportDetailBtnClick(Sender: TObject);
var
    ReportDetailsF: TReportDetailForm;
begin
  ReportDetailsF := TReportDetailForm.Create(MainForm);
  PanelReportHide();

  if Length(IdRoomReport) > 0 then
    Begin
      ModuleData.ReportDetailQuery.Active := False;
      ModuleData.ReportDetailQuery.SQL.Text := Format(SSQLGetReportDetails, [IdRoomReport.ToInteger,
                                                                             BegDate,
                                                                             EndDate]);
      ModuleData.ReportDetailQuery.Active := True;

      try
         {$IFDEF ANDROID}
            ReportDetailsF.Show();
         {$ENDIF}

         {$IFDEF MSWINDOWS}
            ReportDetailsF.ReportDetailLV.Items.Clear;
              ReportDetailsF.ReportDetailLV.BeginUpdate;
                ReportDetailsF.ReportDetailBS.DataSet.Refresh;
              ReportDetailsF.ReportDetailLV.EndUpdate;

            ReportDetailsF.ShowModal();
         {$ENDIF}
      finally
         {$IFDEF MSWINDOWS}
            FreeAndNil(ReportDetailsF);
         {$ENDIF}
      end;
    End;
end;

procedure TMainForm.ReportLVClick(Sender: TObject);
begin
    PanelReportHide();
    PanelSettingHide();
end;

procedure TMainForm.ReportLVItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    IdRoomReport := AItem.Data['Room'].AsString;
end;

procedure TMainForm.ReportTabClick(Sender: TObject);
begin
    PanelMenuHide();
    PanelSettingHide();
    PanelReportHide();
end;

procedure TMainForm.RoomBtnClick(Sender: TObject);
var
    Room: TRoomForm;
begin
   PanelMenuHide();
   Room := TRoomForm.Create(MainForm);
    try
        ModuleData.RoomQuery.Active := False;
        ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
        ModuleData.RoomQuery.Active := True;

      {$IFDEF ANDROID}
          Room.Show();
      {$ENDIF}

      {$IFDEF MSWINDOWS}
          Room.ShowModal();
      {$ENDIF}
    finally
      {$IFDEF MSWINDOWS}
          FreeAndNil(Room);
      {$ENDIF}
    end;
end;


procedure TMainForm.SetBegDate(const Value: variant);
begin
  FBegDate := Value;
end;

procedure TMainForm.SetEndDate(const Value: variant);
begin
  FEndDate := Value;
end;

procedure TMainForm.SetIdOrder(const Value: string);
begin
  FIdOrder := Value;
end;

procedure TMainForm.SetIdRoomReport(const Value: string);
begin
  FIdRoomReport := Value;
end;

procedure TMainForm.SettingBtnClick(Sender: TObject);
begin
    PanelMenuHide();
    PanelReportHide();
    PanelSettingView();
end;

procedure TMainForm.StateRectBtnClick(Sender: TObject);
var
    StatesF :TStatesForm;
begin
     StatesF  := TStatesForm.Create(MainForm);
     PanelSettingHide();

      ModuleData.StateQuery.Active := False;
      ModuleData.StateQuery.SQL.Text := SSQLGetStates;
      ModuleData.StateQuery.Active := True;

     Try
      
        {$IFDEF ANDROID}
            StatesF.Show();
        {$ENDIF}

        {$IFDEF MSWINDOWS}
            StatesF.ShowModal();
        {$ENDIF}
     Finally
        {$IFDEF MSWINDOWS}
            FreeAndNil(StatesF);
        {$ENDIF}
     End;
end;

end.
