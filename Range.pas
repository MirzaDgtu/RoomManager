unit Range;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.DateTimeCtrls, FMX.ListBox,
  FMX.Layouts;

type
  TRangeForm = class(TForm)
    RangeLayout: TLayout;
    RangeLB: TListBox;
    HeaderLB: TListBoxGroupHeader;
    DatebLB: TListBoxItem;
    DateELB: TListBoxItem;
    DateBPicker: TDateEdit;
    DateEndPicker: TDateEdit;
    TB: TToolBar;
    TbLB: TListBoxItem;
    GridPanelLayout1: TGridPanelLayout;
    CancelBtn: TButton;
    SaveBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBtnClick(Sender: TObject);
    procedure DateBPickerChange(Sender: TObject);
  private
    { Private declarations }
    procedure CorrectRangeDate();
  public
    { Public declarations }
  end;

var
  RangeForm: TRangeForm;

implementation

{$R *.fmx}

procedure TRangeForm.CancelBtnClick(Sender: TObject);
begin
    Close();
end;

procedure TRangeForm.CorrectRangeDate;
begin
    if DateBPicker.Date > DateEndPicker.Date then
      DateEndPicker.Date := DateBPicker.Date;

end;

procedure TRangeForm.DateBPickerChange(Sender: TObject);
begin
       CorrectRangeDate();
end;

procedure TRangeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF ANDROID}
      Action := TCloseAction.caFree;
  {$ENDIF}
end;

end.
