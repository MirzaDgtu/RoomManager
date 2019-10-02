unit Room;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.ListView, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, FMX.Ani, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Fmx.Bind.GenData, Data.Bind.ObjectScope, FMX.DialogService, System.Math;

type
  TRoomForm = class(TForm)
    ToolBar1: TToolBar;
    RoomView: TListView;
    MenuBtn: TButton;
    Menu_Layout: TLayout;
    AddBtn: TButton;
    DeleteBtn: TButton;
    RefreshBtn: TButton;
    CorrBtn: TButton;
    MenuAnimation: TFloatAnimation;
    RoundRect1: TRoundRect;
    RoomBS: TBindSourceDB;
    RoomBL: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure MenuBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure CorrBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RoomViewItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure RoomViewClick(Sender: TObject);
  private
    FAdressRoom: string;
    FPriceRoom: String;
    FIdRoom: string;
    FNumHome: string;
    FCountRoom: string;
    FCity: string;
    FNumApartment: string;
    FIsOwner: string;
    procedure SetAdressRoom(const Value: string);
    procedure SetPriceRoom(const Value: String);
    procedure SetIdRoom(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetCountRoom(const Value: string);
    procedure SetNumApartment(const Value: string);
    procedure SetNumHome(const Value: string);
    procedure SetIsOwner(const Value: string);
    { Private declarations }

  public
    { Public declarations }

    property IsOwner: string read FIsOwner write SetIsOwner;

    property  IdRoom: string read FIdRoom write SetIdRoom;
    property  City: string read FCity write SetCity;
    property  AdressRoom: string read FAdressRoom write SetAdressRoom;
    property  NumHome: string read FNumHome write SetNumHome;
    property  NumApartment: string read FNumApartment write SetNumApartment;
    property  CountRoom: string read FCountRoom write SetCountRoom;
    property  PriceRoom: String read FPriceRoom write SetPriceRoom;
  end;

var
  RoomForm: TRoomForm;

implementation

{$R *.fmx}

uses RoomDetail, RoomBehaviors, AppData, sConsts;

procedure TRoomForm.AddBtnClick(Sender: TObject);
var
    RoomD: TRoomDetailForm;
    RoomBeh: TRoomAction;
    ModuleData: TModuleData;
begin
   Menu_Layout.Visible := False;
   MenuAnimation.Inverse := true;
   MenuAnimation.Start;

   RoomD := TRoomDetailForm.Create(Application);
   RoomBeh := TRoomAction.Create;
   ModuleData := TModuleData.Create(Application);

   try
      {$IFDEF ANDROID}
        RoomD.ShowModal(
                         procedure(ModalResult: TModalResult)
                          Begin
                            if ModalResult = mrOk then
                               Begin
                                 if (RoomD.NumberSpin.Value > 0) and
                                    (Length(Trim(RoomD.AdressEdit.Text)) > 0) then
                                      Begin
                                         try
                                             RoomBeh.add(RoomD.CityEdit.Text,
                                                         RoomD.AdressEdit.Text,
                                                         RoomD.HomeNumEdit.Text.ToInteger,
                                                         RoomD.NumRoomEdit.Text.ToInteger,
                                                         RoomD.NumberSpin.Value.ToString.ToInteger,
                                                         RoomD.PriceEdit.Text);
                                         finally
                                            Self.RoomView.BeginUpdate;
                                              ModuleData.RoomQuery.Active := False;
                                              ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
                                              ModuleData.RoomQuery.Active := True;

                                              RoomBS.DataSet.Refresh;
                                            Self.RoomView.EndUpdate;
                                         end;
                                      end;
                               end;
                          end
                       );
      {$ENDIF}

      {$IFDEF MSWINDOWS}
          if RoomD.ShowModal = mrOk then
            Begin
             if (RoomD.NumberSpin.Value > 0) and
                (Length(Trim(RoomD.AdressEdit.Text)) > 0) then
                Begin
                  try
                     RoomBeh.add(RoomD.CityEdit.Text,
                                 RoomD.AdressEdit.Text,
                                 RoomD.HomeNumEdit.Text.ToInteger,
                                 RoomD.NumRoomEdit.Text.ToInteger,
                                 RoomD.NumberSpin.Value.ToString.ToInteger,
                                 RoomD.PriceEdit.Text);
                  finally
                    Self.RoomView.BeginUpdate;
                      ModuleData.RoomQuery.Active := False;
                      ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
                      ModuleData.RoomQuery.Active := True;

                      RoomBS.DataSet.Refresh;
                    Self.RoomView.EndUpdate;
                  end;
                End;
             End;
      {$ENDIF}
   finally
      {$IFDEF MSWINDOWS}
          FreeAndNil(RoomD);
      {$ENDIF}

      FreeAndNil(RoomBeh);
      ModuleData.RoomQuery.Active := False;
      ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
      ModuleData.RoomQuery.Active := True;
      RoomBS.DataSet.Refresh;
   end;
end;

procedure TRoomForm.CorrBtnClick(Sender: TObject);
var
    RoomD: TRoomDetailForm;
    RoomBeh: TRoomAction;
begin
   Menu_Layout.Visible := False;
   MenuAnimation.Inverse := true;
   MenuAnimation.Start;

   RoomD := TRoomDetailForm.Create(Application);
   RoomBeh := TRoomAction.Create;


   try
      {$IFDEF ANDROID}
        with RoomD do
          Begin
              NumberSpin.Value := NumberRoom.ToSingle;
              AdressEdit.Text := AdressRoom;
              PriceEdit.Text := PriceRoom;

              ShowModal(
                         procedure(ModalResult: TModalResult)
                          Begin
                            if ModalResult = mrOk then
                               Begin
                                 if (RoomD.NumberSpin.Value > 0) and
                                    (Length(Trim(RoomD.AdressEdit.Text)) > 0) then
                                      Begin
                                         try
                                             RoomBeh.correction(RoomD.CityEdit.Text,
                                                                RoomD.AdressEdit.Text,
                                                                RoomD.HomeNumEdit.Text.ToInteger,
                                                                RoomD.NumRoomEdit.Text.ToInteger,
                                                                RoomD.NumberSpin.Value.ToString.ToInteger,
                                                                RoomD.PriceEdit.Text,
                                                                IdRoom.ToInteger);
                                         finally
                                            Self.RoomView.BeginUpdate;
                                              ModuleData.RoomQuery.Active := False;
                                              ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
                                              ModuleData.RoomQuery.Active := True;

                                              RoomBS.DataSet.Refresh;
                                            Self.RoomView.EndUpdate;
                                         end;
                                      end;
                               end;
                          end
                       );
          end;
      {$ENDIF}

      {$IFDEF MSWINDOWS}

          with RoomD do
          Begin
              CityEdit.Text := City;
              AdressEdit.Text := AdressRoom;
              HomeNumEdit.Text := NumHome;
              NumRoomEdit.Text := NumApartment;
              NumberSpin.Value := CountRoom.ToSingle;
              PriceEdit.Text := PriceRoom;

              if ShowModal = mrOk then
              Begin
               if (RoomD.NumberSpin.Value > 0) and
                  (Length(Trim(RoomD.AdressEdit.Text)) > 0) then
                  Begin
                    try
                       RoomBeh.correction(RoomD.CityEdit.Text,
                                          RoomD.AdressEdit.Text,
                                          RoomD.HomeNumEdit.Text.ToInteger,
                                          RoomD.NumRoomEdit.Text.ToInteger,
                                          RoomD.NumberSpin.Value.ToString.ToInteger,
                                          RoomD.PriceEdit.Text,
                                          IdRoom.ToInteger);
                    finally
                    end;
                  End;
               End;
          End;
      {$ENDIF}
   finally
      {$IFDEF MSWINDOWS}
         FreeAndNil(RoomD);
      {$ENDIF}
          Self.RoomView.BeginUpdate;
            ModuleData.RoomQuery.Active := False;
            ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
            ModuleData.RoomQuery.Active := True;

            RoomBS.DataSet.Refresh;
          Self.RoomView.EndUpdate;
      FreeAndNil(RoomBeh);
   end;
end;


procedure TRoomForm.DeleteBtnClick(Sender: TObject);
begin
   Menu_Layout.Visible := False;
   MenuAnimation.Inverse := true;
   MenuAnimation.Start;

   try
       if Length(IdRoom) > 0 then
        Begin
         TDialogService.MessageDialog('Вы действительно хотите удалить эту квартиру?', System.UITypes.TMsgDlgType.mtInformation,
                                [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
                                 System.UITypes.TMsgDlgBtn.mbYes, 0,

                                 procedure(const AResult: TModalResult)
                                 begin
                                   case AResult of
                                    mrYES: try
                                              ModuleData.RoomDBQuery.SQL.Text := Format(SSQLDeleteRoom, [IdRoom.ToInteger]);
                                              ModuleData.RoomDBQuery.ExecSQL;
                                           except
                                              on Err: Exception do
                                                Showmessage('Ошибка удаления квартиры!' + #13 + 'Сообщение: ' + Err.Message);
                                           end;
                                    mrNo: ;
                                   end;
                                 end);
        End;
   finally
        Self.RoomView.BeginUpdate;
          ModuleData.RoomQuery.Active := False;
          ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
          ModuleData.RoomQuery.Active := True;

          RoomBS.DataSet.Refresh;
        Self.RoomView.EndUpdate;
   end;
end;

procedure TRoomForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    {$IFDEF ANDROID}
        Action := TCloseAction.caFree;
    {$ENDIF}
end;

procedure TRoomForm.MenuBtnClick(Sender: TObject);
begin
    Menu_Layout.Position.Y := Self.Height + 20;
    Menu_Layout.Visible := True;

    MenuAnimation.Inverse := False;
    MenuAnimation.StartValue := Self.Height + 20;
    MenuAnimation.Start;
end;

procedure TRoomForm.RefreshBtnClick(Sender: TObject);
begin
   Menu_Layout.Visible := False;
   MenuAnimation.Inverse := true;
   MenuAnimation.Start;

   try
    Self.RoomView.BeginUpdate;
      ModuleData.RoomQuery.Active := False;
      ModuleData.RoomQuery.SQL.Text := SSQLGetRoom;
      ModuleData.RoomQuery.Active := True;

      RoomBS.DataSet.Refresh;
   finally
    Self.RoomView.EndUpdate;
   end;

end;

procedure TRoomForm.RoomViewClick(Sender: TObject);
begin
   Menu_Layout.Visible := False;
   MenuAnimation.Inverse := true;
   MenuAnimation.Start;
end;

procedure TRoomForm.RoomViewItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
   IdRoom := AItem.Data['ID'].AsString;
   City   := AItem.Data['City'].AsString;
   AdressRoom := AItem.Data['Adress'].AsString;
   NumHome := AItem.Data['NumHome'].AsString;
   NumApartment := AItem.Data['NumRoom'].AsString;
   CountRoom := AItem.Data['CountRoom'].AsString;
   PriceRoom := AItem.Data['Price'].AsString;

   if IsOwner = 'OrderForm' then
     ModalResult := mrOk;
end;

procedure TRoomForm.SetAdressRoom(const Value: string);
begin
  FAdressRoom := Value;
end;

procedure TRoomForm.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TRoomForm.SetCountRoom(const Value: string);
begin
  FCountRoom := Value;
end;

procedure TRoomForm.SetIdRoom(const Value: string);
begin
  FIdRoom := Value;
end;

procedure TRoomForm.SetIsOwner(const Value: string);
begin
  FIsOwner := Value;
end;

procedure TRoomForm.SetNumApartment(const Value: string);
begin
  FNumApartment := Value;
end;

procedure TRoomForm.SetNumHome(const Value: string);
begin
  FNumHome := Value;
end;

procedure TRoomForm.SetPriceRoom(const Value: String);
begin
  FPriceRoom := Value;
end;

end.
