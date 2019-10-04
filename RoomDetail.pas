unit RoomDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.ListBox, FMX.EditBox, FMX.SpinBox,
  FMX.Edit, FMX.DialogService;

type
  TRoomDetailForm = class(TForm)
    DetailList: TListBox;
    ToolBar1: TToolBar;
    Layout1: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    CancelBtn: TButton;
    SaveBtn: TButton;
    AdressLB: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    AdressEdit: TEdit;
    NumberSpin: TSpinBox;
    PriceEdit: TEdit;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    HomeRoomNumLB: TListBoxItem;
    NumRoomEdit: TEdit;
    RoomLbl: TLabel;
    Label1: TLabel;
    HomeNumEdit: TEdit;
    CityLB: TListBoxItem;
    CityEdit: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBtnClick(Sender: TObject);
    procedure NumberSpinChange(Sender: TObject);
  private
    FcorrStatus: Boolean;
    procedure SetcorrStatus(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }

    property corrStatus: Boolean read FcorrStatus write SetcorrStatus;
  end;

var
  RoomDetailForm: TRoomDetailForm;

implementation

{$R *.fmx}

uses RoomBehaviors, AppData;

procedure TRoomDetailForm.CancelBtnClick(Sender: TObject);
begin
      case corrStatus of
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
      end;
end;

procedure TRoomDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    {$IFDEF ANDROID}
        Action := TCloseAction.caFree;
    {$ENDIF}
end;

procedure TRoomDetailForm.NumberSpinChange(Sender: TObject);
begin
    corrStatus := True;
end;

procedure TRoomDetailForm.SetcorrStatus(const Value: Boolean);
begin
   FcorrStatus := Value;
end;

end.
