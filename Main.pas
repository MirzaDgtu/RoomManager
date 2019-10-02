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
  Data.Bind.ObjectScope, FMX.Menus, Data.Bind.DBScope;

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
    ImageList: TImageList;
    procedure MenuBtnClick(Sender: TObject);
    procedure RoomBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrdersViewClick(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure PanelMenuHide();
  public
    { Public declarations }
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
                                      end;
                                    except
                                        on Err: Exception do
                                          ShowMessage('Ошибка создания заявки!' + #13 + 'Сообщение: ' + Err.Message);
                                    end;
                                end;
                          end;
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

                                    {   ModuleData.OrderDBQuery.SQL.Text := Format(SSQLAddOrder, [FormatDateTime('yyyy-mm-dd hh:MM:ss', Now),
                                                  DateB,
                                                  DateE,
                                                  IdRoom.ToInteger,
                                                  PhoneEdit.Text,
                                                  PriceEdit.Text,
                                                  1]);

                                                  ShowMessage(ModuleData.OrderDBQuery.SQL.Text); }
                      finally
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

end.
