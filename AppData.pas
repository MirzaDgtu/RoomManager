unit AppData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.UI, FireDAC.Comp.DataSet,  System.IOUtils;


type
  TModuleData = class(TDataModule)
    Connection: TFDConnection;
    WaitCursor: TFDGUIxWaitCursor;
    SQLiteDriver: TFDPhysSQLiteDriverLink;
    RoomDBQuery: TFDQuery;
    StoredProc: TFDStoredProc;
    RoomQuery: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    RoomQueryNumHome: TIntegerField;
    RoomQueryNumApartment: TIntegerField;
    RoomQueryCountRoom: TIntegerField;
    RoomQueryCity: TStringField;
    OrderDBQuery: TFDQuery;
    OrderQuery: TFDQuery;
    OrderQueryID: TIntegerField;
    OrderQueryDate_Create: TWideMemoField;
    OrderQueryRoom: TIntegerField;
    OrderQueryPhone: TStringField;
    OrderQueryPrice: TFloatField;
    OrderQueryTypeDoc: TIntegerField;
    OrderQueryCorrDate: TWideMemoField;
    OrderQueryRoomStr: TWideStringField;
    RoomQueryScreen: TBlobField;
    OrderQueryScreen: TBlobField;
    RoomQueryAdressStr: TWideStringField;
    OrderQueryMergeDate: TWideStringField;
    StateQuery: TFDQuery;
    StateQueryID: TIntegerField;
    StateQueryScreen: TBlobField;
    StateQueryName: TStringField;
    StateQueryDescription: TStringField;
    OrderQueryDateBeg: TWideStringField;
    OrderQueryDateEnd: TWideStringField;
    OrderQueryDescription: TStringField;
    OrderQueryTypeDocID: TIntegerField;
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ConnectionToLocalDB: Boolean;
  end;

var
  ModuleData: TModuleData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TModuleData }

procedure TModuleData.ConnectionBeforeConnect(Sender: TObject);
begin
    {$IFDEF ANDROID}
        Connection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'RoomManagerDB.db');
    {$ENDIF}

    {$IFDEF MSWINDOWS}
        Connection.Params.Values['DataBase'] := ExtractFilePath(ParamStr(0)) + 'RoomManagerDB.db';
    {$ENDIF}
end;

function TModuleData.ConnectionToLocalDB: Boolean;
begin
    try
       Connection.Connected := True;
    except
    end;

    Result := Connection.Connected;
end;

end.
