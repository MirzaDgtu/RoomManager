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
    ToolBar1: TToolBar;
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
  private
    FIdOrder: string;
    { Private declarations }

    function getDate(dateValue: string): TDate;
    function getTime(timeValue: string): TTime;

    procedure PanelMenuView();
    procedure PanelMenuHide();
    procedure PanelSettingView();
    procedure PanelSettingHide();
    procedure SetIdOrder(const Value: string);
  public
    { Public declarations }
    property IdOrder: string read FIdOrder write SetIdOrder;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses Room, AppData, RoomBehaviors, sConsts, Order, OrderBehavior;

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
           TimeBOrder.Time := Now();
           TimeEOrder.Time := Now();
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
                                                                  DateB,
                                                                  DateE,
                                                                  IdRoom.ToInteger,
                                                                  PhoneEdit.Text,
                                                                  PriceEdit.Text,
                                                                  1);
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
                                                  DateB,
                                                  DateE,
                                                  IdRoom.ToInteger,
                                                  PhoneEdit.Text,
                                                  PriceEdit.Text,
                                                  1);
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
begin

   PanelMenuHide();
   OrderF := TOrderForm.Create(MainForm);

   try
     try
      if Length(Trim(IdOrder)) > 0 then
        Begin
          ModuleData.OrderDBQuery.Active := False;
          ModuleData.OrderDBQuery.SQL.Text := Format(SSQLGetOrderDetail, [IdOrder.ToInteger]);
          ModuleData.OrderDBQuery.Active := True;

          with OrderF do
            Begin
              DateBOrder.Date := getDate(ModuleData.OrderDBQuery.FieldByName('DateBeg').AsString);
              DateEOrder.Date := getDate(ModuleData.OrderDBQuery.FieldByName('DateEnd').AsString);
              TimeBOrder.Time := getTime(ModuleData.OrderDBQuery.FieldByName('DateBeg').AsString);
              TimeEOrder.Time := getTime(ModuleData.OrderDBQuery.FieldByName('DateEnd').AsString);
              RoomLbl.Text    := ModuleData.OrderDBQuery.FieldByName('RoomStr').AsString;
              PhoneEdit.Text  := ModuleData.OrderDBQuery.FieldByName('Phone').AsString;
              PriceEdit.Text  := ModuleData.OrderDBQuery.FieldByName('Price').AsString;
              IDRoom          := ModuleData.OrderDBQuery.FieldByName('Room').AsString;
              PriceRoom       := ModuleData.OrderDBQuery.FieldByName('PriceRoom').AsString;

              ShowModal();
            End;
        End;

     finally

     end;
   finally
      FreeAndNil(OrderF);
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

     with ModuleData do
      Begin
         ConnectionToLocalDB;

         RoomQuery.Active := False;
         RoomQuery.SQL.Text := SSQLGetRoom;
         RoomQuery.Active := True;

         OrderQuery.Active := False;
         OrderQuery.SQL.Text := SSQLGetOrders;
         OrderQuery.Active := True;
      end;
end;


function TMainForm.getDate(dateValue: string): TDate;
var
    strYear, strMonth, strDay: string;
begin
    strYear := Copy(dateValue, 7, 4);
    strMonth := Copy(dateValue, 4, 2);
    strDay  := Copy(dateValue, 1, 2);

    Result := StrToDate(strDay + '.' + strMonth + '.' + strYear);
end;

function TMainForm.getTime(timeValue: string): TTime;
var
    strHour, strMinute: string;
begin
    strHour := Copy(timeValue, 12, 2);
    strMinute := Copy(timeValue, 15, 2);

    Result := StrToTime(strHour + ':' + strMinute);
end;

procedure TMainForm.MenuBtnClick(Sender: TObject);
begin
    PanelSettingHide();
    PanelMenuView();
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
         ModuleData.OrderQuery.SQL.Text := SSQLGetOrders;
         ModuleData.OrderQuery.Active := True;

         OrdersBS.DataSet.Refresh;
    finally
       OrdersView.EndUpdate;
    end;
end;

procedure TMainForm.RoomBtnClick(Sender: TObject);
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

procedure TMainForm.SetIdOrder(const Value: string);
begin
  FIdOrder := Value;
end;

procedure TMainForm.SettingBtnClick(Sender: TObject);
begin
    PanelMenuHide();
    PanelSettingView();
end;

end.
