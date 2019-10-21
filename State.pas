unit State;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Ani, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.DialogService;

type
  TStatesForm = class(TForm)
    Layout: TLayout;
    StateTB: TToolBar;
    MenuBtn: TButton;
    StatesLV: TListView;
    State_Layout: TLayout;
    MenuRR: TRoundRect;
    AddBtn: TButton;
    CorrBtn: TButton;
    DeleteBtn: TButton;
    RefreshBtn: TButton;
    StateAnimation: TFloatAnimation;
    StateBS: TBindSourceDB;
    StateBL: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure MenuBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddBtnClick(Sender: TObject);
    procedure CorrBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure StatesLVItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    FIdState: string;
    FDescription: string;
    { Private declarations }
    procedure StatePanelView();
    procedure StatePanelHide();
    procedure SetIdState(const Value: string);
    procedure SetDescription(const Value: string);
    procedure RefreshStatesLV();
  public
    { Public declarations }
    property IdState: string read FIdState write SetIdState;
    property Description: string read FDescription write SetDescription;
  end;

var
  StatesForm: TStatesForm;

implementation

{$R *.fmx}

uses AppData, sConsts, Main, StatesBehavior, StateDetail;

{ TStatesForm }

procedure TStatesForm.AddBtnClick(Sender: TObject);
var
    StateA: TStatesAction;
    StateD: TStateDetailForm;
begin
    StateA := TStatesAction.Create;
    StateD := TStateDetailForm.Create(Application);
    StatePanelHide();

    try
        try
           {$IFDEF ANDROID}
                      StateD.ShowModal(
                         procedure(ModalResult: TModalResult)
                          Begin
                            if ModalResult = mrOk then
                               Begin
                                    if Length(Trim(StateD.StateEdit.Text)) > 0 then
                                       Begin
                                         try
                                             StateA.add(StateD.StateEdit.Text);
                                         finally
                                            RefreshStatesLV();
                                         end;
                                       End;
                               end;
                          end
                       );
           {$ENDIF}

           {$IFDEF MSWINDOWS}
              if StateD.ShowModal = mrOk then
                Begin
                      if Length(Trim(StateD.StateEdit.Text)) > 0 then
                         Begin
                           try
                               StateA.add(StateD.StateEdit.Text);
                           finally
                              RefreshStatesLV();
                           end;
                         End;
                End;
           {$ENDIF}
        finally
        end;
    finally
         {$IFDEF MSWINDOWS}
            FreeAndNil(StateD);
         {$ENDIF}
            FreeAndNil(StateA);
    end;
end;

procedure TStatesForm.CorrBtnClick(Sender: TObject);
var
    StateA: TStatesAction;
    StateD: TStateDetailForm;
begin
    StateA := TStatesAction.Create;
    StateD := TStateDetailForm.Create(Application);
    StatePanelHide();

    try
       StateD.StateEdit.Text := Description;

        try
           {$IFDEF ANDROID}
                StateD.ShowModal(
                                  procedure (ModalResult: TModalResult)
                                    Begin
                                      if ModalResult = mrOk then
                                         Begin
                                              if Length(Trim(StateD.StateEdit.Text)) > 0 then
                                                 Begin
                                                   try
                                                       StateA.correction(IdState.ToInteger,
                                                                         StateD.StateEdit.Text);
                                                   finally
                                                      RefreshStatesLV();
                                                   end;
                                                 End;
                                         end;
                                    end
                                );
           {$ENDIF}

           {$IFDEF MSWINDOWS}
               if StateD.ShowModal = mrOk then
                  Begin
                    if Length(Trim(StateD.StateEdit.Text)) > 0 then
                       Begin
                         try
                             StateA.correction(IdState.ToInteger,
                                               StateD.StateEdit.Text);
                         finally
                            RefreshStatesLV();
                         end;
                       End;
                  End;
           {$ENDIF}
        finally
        end;
    finally
         {$IFDEF MSWINDOWS}
            FreeAndNil(StateD);
         {$ENDIF}
            FreeAndNil(StateA);
    end;
end;

procedure TStatesForm.DeleteBtnClick(Sender: TObject);
begin
    StatePanelHide();

    try
      try
       if Length(IdState) > 0 then
          Begin
                  TDialogService.MessageDialog('Вы действительно хотите удалить эту статью?', System.UITypes.TMsgDlgType.mtInformation,
                                  [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
                                   System.UITypes.TMsgDlgBtn.mbYes, 0,

                                   procedure(const AResult: TModalResult)
                                   begin
                                     case AResult of
                                      mrYES: try
                                                try
                                                    ModuleData.StateDBQuery.SQL.Text := Format(SSQLDeleteState, [IdState.ToInteger]);
                                                    ModuleData.StateDBQuery.ExecSQL;
                                                finally
                                                    RefreshStatesLV();
                                                end;
                                             except
                                                on Err: Exception do
                                                  Showmessage('Ошибка удаления статьи!' + #13 + 'Сообщение: ' + Err.Message);
                                             end;
                                      mrNo: Exit;
                                     end;
                                   end);
          End;
      finally
      end;
    finally
    end;
end;

procedure TStatesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF ANDROID}
      Action := TCloseAction.caFree;
  {$ENDIF}
end;

procedure TStatesForm.MenuBtnClick(Sender: TObject);
begin
    StatePanelView();
end;

procedure TStatesForm.RefreshBtnClick(Sender: TObject);
begin
    StatePanelHide();
end;

procedure TStatesForm.RefreshStatesLV;
begin
    StatePanelHide();

    try
       StatesLV.BeginUpdate;
         ModuleData.StateQuery.Active := False;
         ModuleData.StateQuery.SQL.Text := SSQLGetStates;
         ModuleData.StateQuery.Active := True;

         StateBS.DataSet.Refresh;
    finally
       StatesLV.EndUpdate;
    end;
end;

procedure TStatesForm.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TStatesForm.SetIdState(const Value: string);
begin
  FIdState := Value;
end;

procedure TStatesForm.StatePanelHide;
begin
   State_Layout.Visible := False;
   StateAnimation.Inverse := true;
   StateAnimation.Start;
end;

procedure TStatesForm.StatePanelView;
begin
    State_Layout.Position.Y := Self.Height + 20;
    State_Layout.Visible := True;

    StateAnimation.Inverse := False;
    StateAnimation.StartValue := Self.Height + 20;
    StateAnimation.Start;
end;

procedure TStatesForm.StatesLVItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    IdState := AItem.Data['ID'].AsString;
    Description := AItem.Data['Description'].AsString;
end;

end.
