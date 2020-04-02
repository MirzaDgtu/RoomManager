unit Order;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.DateTimeCtrls, FMX.ListBox,
  FMX.Edit, System.DateUtils,  FMX.DialogService, MaskUtils, FMX.Ani,
  FMX.Objects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TOrderForm = class(TForm)
    Layout: TLayout;
    TB: TToolBar;
    GridPanelLayout1: TGridPanelLayout;
    CancelBtn: TButton;
    SaveBtn: TButton;
    OrderBox: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    DateBItemBox: TListBoxItem;
    DateEItemBox: TListBoxItem;
    RoomItemBox: TListBoxItem;
    DateBOrder: TDateEdit;
    DateEOrder: TDateEdit;
    RoomLbl: TLabel;
    RoomBtn: TButton;
    PriceItemBox: TListBoxItem;
    PriceEdit: TEdit;
    PhoneItemBox: TListBoxItem;
    PhoneEdit: TEdit;
    ClearEditButton1: TClearEditButton;
    ClearEditButton2: TClearEditButton;
    StateItemBox: TListBoxItem;
    StateEdit: TEdit;
    ClearEditButton3: TClearEditButton;
    StateBtn: TButton;
    StateLayout: TLayout;
    StateAnimation: TFloatAnimation;
    StateRect: TRectangle;
    StateLV: TListView;
    StateBS: TBindSourceDB;
    StateBL: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    StatesHeaderTB: TToolBar;
    BackBtn: TButton;
    RefreshBtn: TButton;
    StateHeaderLB: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateBOrderChange(Sender: TObject);
    procedure RoomBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure PhoneEditChange(Sender: TObject);
    procedure PriceEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure StateBtnClick(Sender: TObject);
    procedure StateLVItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure StateEditKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure PriceEditKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure BackBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
  private
    { Private declarations }
    FPstatusCorr: Boolean;
    FIDRoom: string;
    FPriceRoom: string;
    FIdTypeDoc: string;

    function getPrice(): real;
    function getCountDay(): integer;

    procedure PanelStateView();
    procedure PanelStateHide();
    procedure SetPstatusCorr(const Value: Boolean);
    procedure SetIDRoom(const Value: string);
    procedure SetPriceRoom(const Value: string);
    procedure CorrectRangeDate();
    procedure SetIdTypeDoc(const Value: string);
  public
    { Public declarations }
    property PstatusCorr: Boolean read FPstatusCorr write SetPstatusCorr default False;
    property IDRoom: string read FIDRoom write SetIDRoom;
    property PriceRoom: string read FPriceRoom write SetPriceRoom;
    property IdTypeDoc: string read FIdTypeDoc write SetIdTypeDoc;
  end;

var
  OrderForm: TOrderForm;

implementation

{$R *.fmx}

uses sConsts, AppData, Room;

procedure TOrderForm.BackBtnClick(Sender: TObject);
begin
    PanelStateHide();
end;

procedure TOrderForm.CancelBtnClick(Sender: TObject);
begin
  {    case PstatusCorr of
          True: TDialogService.MessageDialog('При выходе вы потеряете все изменения!' + #13 + 'Вы действительно хотите выйти?', System.UITypes.TMsgDlgType.mtInformation,
                                [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
                                 System.UITypes.TMsgDlgBtn.mbYes, 0,

                                 procedure(const AResult: TModalResult)
                                 begin
                                   case AResult of
                                      mrYES: Close();
                                      mrNo: Exit;
                                   end;
                                 end);
          False: Close();
      end; }

      Close();
end;

procedure TOrderForm.CorrectRangeDate;
begin
    if DateBOrder.Date > DateEOrder.Date then
        DateEOrder.Date := DateBOrder.Date;
end;

procedure TOrderForm.DateBOrderChange(Sender: TObject);
begin
    PstatusCorr := True;
    CorrectRangeDate();
    PriceEdit.Text := FloatToStr(getPrice());
end;

procedure TOrderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF ANDROID}
     Action := TCloseAction.caFree;
  {$ENDIF}
end;

procedure TOrderForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    if Key = vkHardwareBack then
      CancelBtnClick(Self);
end;


function TOrderForm.getCountDay: integer;
begin
   Result := DaysBetween(DateBOrder.Date, DateEOrder.Date);
end;

function TOrderForm.getPrice: real;
begin
  if (Length(PriceRoom) > 0) and
     (getCountDay > 0) then
         Result := getCountDay.ToDouble * PriceRoom.ToDouble
  else
      Result := 0;
end;

procedure TOrderForm.PanelStateHide;
begin
   StateLayout.Visible := False;
   StateAnimation.Inverse := true;
   StateAnimation.Start;
end;

procedure TOrderForm.PanelStateView;
begin
    StateLayout.Position.Y := Self.Height + 20;
    StateLayout.Visible := True;

    StateAnimation.Inverse := False;
    StateAnimation.StartValue := Self.Height + 20;
    StateAnimation.Start;
end;

procedure TOrderForm.PhoneEditChange(Sender: TObject);
begin
   PstatusCorr := True;
end;

procedure TOrderForm.PriceEditChange(Sender: TObject);
begin
   PstatusCorr := True;
end;

procedure TOrderForm.PriceEditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if (KeyChar < '0')or( KeyChar >'9') then KeyChar:=#0;

end;

procedure TOrderForm.RefreshBtnClick(Sender: TObject);
begin
    try
       Self.StateLV.BeginUpdate;
       Self.StateBS.DataSet.Refresh;
    finally
       Self.StateLV.EndUpdate;
    end;
end;

procedure TOrderForm.RoomBtnClick(Sender: TObject);
var
    RoomF: TRoomForm;
begin
   RoomF := TRoomForm.Create(Application);

   ModuleData.RoomQuery.Active := False;
   if (StateEdit.Text = EmptyStr) or
      (StateEdit.Text = Trim('Выручка')) then
         ModuleData.RoomQuery.SQL.Text := Format(SSQLGetRoomFree, [FormatDateTime('yyyy-mm-dd', DateBOrder.Date),
                                                                   FormatDateTime('yyyy-mm-dd', DateEOrder.Date),
                                                                   FormatDateTime('yyyy-mm-dd', DateBOrder.Date),
                                                                   FormatDateTime('yyyy-mm-dd', DateEOrder.Date)])
   else
         ModuleData.RoomQuery.SQL.Text :=  SSQLGetRoom;
         ModuleData.RoomQuery.Active := True;

    try
      RoomF.IsOwner := 'OrderForm';
      {$IFDEF ANDROID}
        RoomF.ShowModal(
                          procedure(ModalResult: TModalResult)
                          Begin
                            if ModalResult = mrOK then
                              Begin
                                try
                                    RoomLbl.Text := 'г. ' + RoomF.City + ', ' + RoomF.AdressRoom + ' ' + RoomF.NumHome + ', кв. ' + RoomF.NumApartment;
                                    IDRoom := RoomF.IdRoom;
                                    PriceRoom := RoomF.PriceRoom;
                                finally
                                   DateBOrderChange(Self);
                                end;
                              End;
                          End
                        );
      {$ENDIF}

      {$IFDEF MSWINDOWS}
          if RoomF.ShowModal = mrOk then
            Begin
              try
                RoomLbl.Text :=  'г. ' + RoomF.City + ', ' + RoomF.AdressRoom + ' ' + RoomF.NumHome + ', кв. ' + RoomF.NumApartment;
                IDRoom := RoomF.IdRoom;
                PriceRoom := RoomF.PriceRoom;
              finally
                DateBOrderChange(Self);
              end;
            End;
      {$ENDIF}

    finally
        PstatusCorr := True;
        {$IFDEF MSWINDOWS}
            FreeAndNil(RoomF);
        {$ENDIF}
    end;
end;

procedure TOrderForm.SetIDRoom(const Value: string);
begin
  FIDRoom := Value;
end;

procedure TOrderForm.SetIdTypeDoc(const Value: string);
begin
  FIdTypeDoc := Value;
end;

procedure TOrderForm.SetPriceRoom(const Value: string);
begin
  FPriceRoom := Value;
end;

procedure TOrderForm.SetPstatusCorr(const Value: Boolean);
begin
   FPstatusCorr := Value;
end;

procedure TOrderForm.StateBtnClick(Sender: TObject);
begin
    ModuleData.StateQuery.Active := False;
    ModuleData.StateQuery.SQL.Text := SSQLGetStates;
    ModuleData.StateQuery.Active := True;
    PanelStateView();
end;

procedure TOrderForm.StateEditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    KeyChar := #0;
end;

procedure TOrderForm.StateLVItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    PanelStateHide();
    StateEdit.Text := AItem.Data['Description'].AsString;
    IdTypeDoc := AItem.Data['ID'].AsString;
end;

end.
