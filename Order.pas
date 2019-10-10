unit Order;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.DateTimeCtrls, FMX.ListBox,
  FMX.Edit, System.DateUtils,  FMX.DialogService, MaskUtils;

type
  TOrderForm = class(TForm)
    Layout: TLayout;
    ToolBar1: TToolBar;
    GridPanelLayout1: TGridPanelLayout;
    CancelBtn: TButton;
    SaveBtn: TButton;
    OrderBox: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    DateBItemBox: TListBoxItem;
    DateEItemBox: TListBoxItem;
    RoomItemBox: TListBoxItem;
    DateBOrder: TDateEdit;
    TimeBOrder: TTimeEdit;
    DateEOrder: TDateEdit;
    TimeEOrder: TTimeEdit;
    RoomLbl: TLabel;
    RoomBtn: TButton;
    PriceItemBox: TListBoxItem;
    PriceEdit: TEdit;
    PhoneItemBox: TListBoxItem;
    PhoneEdit: TEdit;
    ClearEditButton1: TClearEditButton;
    ClearEditButton2: TClearEditButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateBOrderChange(Sender: TObject);
    procedure RoomBtnClick(Sender: TObject);
    procedure PriceEditClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure PhoneEditChange(Sender: TObject);
    procedure PriceEditChange(Sender: TObject);
  private
    { Private declarations }
    FPstatusCorr: Boolean;
    FIDRoom: string;
    FPriceRoom: string;
    FDateB: string;
    FDateE: string;

    function getMinuts(): real;
    function getPrice(): real;

    procedure SetPstatusCorr(const Value: Boolean);
    procedure SetIDRoom(const Value: string);
    procedure SetPriceRoom(const Value: string);
    procedure SetDateB(const Value: string);
    procedure SetDateE(const Value: string);
    procedure CorrectRangeDate();
  public
    { Public declarations }
    property PstatusCorr: Boolean read FPstatusCorr write SetPstatusCorr default False;
    property IDRoom: string read FIDRoom write SetIDRoom;
    property PriceRoom: string read FPriceRoom write SetPriceRoom;
    property DateB: string read FDateB write SetDateB;
    property DateE: string read FDateE write SetDateE;
  end;

var
  OrderForm: TOrderForm;

implementation

{$R *.fmx}

uses sConsts, AppData, Room;

procedure TOrderForm.CancelBtnClick(Sender: TObject);
begin
      case PstatusCorr of
          True: TDialogService.MessageDialog('ѕри выходе вы потер€ете все изменени€!' + #13 + '¬ы действительно хотите выйти?', System.UITypes.TMsgDlgType.mtInformation,
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
      end;
end;

procedure TOrderForm.CorrectRangeDate;
begin
    if DateBOrder.Date > DateEOrder.Date then
        DateEOrder.Date := DateBOrder.Date;

    if TimeBOrder.Time > TimeEOrder.Time then
        TimeEOrder.Time := TimeBOrder.Time;
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

function TOrderForm.getMinuts: real;
var
   DTBeg, DTEnd: string;
   DTTotal: Int64;
begin
   try
    DTBeg := StringReplace(DateToStr(DateBOrder.Date) + TimeToStr(TimeBOrder.Time), '-', '/', [rfReplaceAll]);
    DTEnd := StringReplace(DateToStr(DateEOrder.Date) + TimeToStr(TimeEOrder.Time), '-', '/', [rfReplaceAll]);

    DateB := DateToStr(DateBOrder.Date) + ' ' + TimeToStr(TimeBOrder.Time);
    DateE := DateToStr(DateEOrder.Date) + ' ' + TimeToStr(TimeEOrder.Time);
   finally
      Result := MinutesBetween(StrToDateTime(DTBeg), StrToDateTime(DTEnd)).ToDouble;
   end;

end;

function TOrderForm.getPrice: real;
var
    minPrice: real;
begin
  if (Length(PriceRoom) > 0) and
     (getMinuts > 0) then
      Begin
         minPrice := PriceRoom.ToDouble / 60;
         Result := getMinuts * minPrice;
      End
  else
      Result := 0;
end;

procedure TOrderForm.PhoneEditChange(Sender: TObject);
begin
   PstatusCorr := True;
end;

procedure TOrderForm.PriceEditChange(Sender: TObject);
begin
      PstatusCorr := True;
end;

procedure TOrderForm.PriceEditClick(Sender: TObject);
begin
    PriceEdit.Text := FloatToStr(getPrice());
end;

procedure TOrderForm.RoomBtnClick(Sender: TObject);
var
    RoomF: TRoomForm;
begin
   RoomF := TRoomForm.Create(Application);

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

procedure TOrderForm.SetDateB(const Value: string);
begin
  FDateB := Value;
end;

procedure TOrderForm.SetDateE(const Value: string);
begin
  FDateE := Value;
end;

procedure TOrderForm.SetIDRoom(const Value: string);
begin
  FIDRoom := Value;
end;

procedure TOrderForm.SetPriceRoom(const Value: string);
begin
  FPriceRoom := Value;
end;

procedure TOrderForm.SetPstatusCorr(const Value: Boolean);
begin
   FPstatusCorr := Value;
end;

end.
