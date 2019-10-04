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
    RoundRect1: TRoundRect;
    AddBtn: TButton;
    CorrBtn: TButton;
    DeleteBtn: TButton;
    RefreshBtn: TButton;
    OrdersBS: TBindSourceDB;
    OrdersBL: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
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
  private
    FIdOrder: string;
    { Private declarations }
    procedure PanelMenuHide();
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


procedure TMainForm.MenuBtnClick(Sender: TObject);
begin
    Shop_Layout.Position.Y := MainForm.Height + 20;
    Shop_Layout.Visible := True;

    AnimalMenu.Inverse := False;
    AnimalMenu.StartValue := MainForm.Height + 20;
    AnimalMenu.Start;
end;

procedure TMainForm.OrdersViewClick(Sender: TObject);
begin
   PanelMenuHide();
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

end.
