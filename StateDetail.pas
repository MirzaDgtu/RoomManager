unit StateDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.ListBox;

type
  TStateDetailForm = class(TForm)
    LayoutMain: TLayout;
    ToolBar1: TToolBar;
    TBGridPL: TGridPanelLayout;
    CancelBtn: TButton;
    OkBtn: TButton;
    StatesLB: TListBox;
    HeaderLB: TListBoxGroupHeader;
    StateLB: TListBoxItem;
    StateEdit: TEdit;
    ClearEditButton1: TClearEditButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StateDetailForm: TStateDetailForm;

implementation

{$R *.fmx}

procedure TStateDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    {$IFDEF ANDROID}
        Action := TCloseAction.caFree;
    {$ENDIF}
end;

end.
