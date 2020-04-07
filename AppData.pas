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
    RoomQueryScreen: TBlobField;
    RoomQueryAdressStr: TWideStringField;
    StateQuery: TFDQuery;
    StateQueryID: TIntegerField;
    StateQueryDescription: TStringField;
    StateDBQuery: TFDQuery;
    StateQueryScreen: TBlobField;
    ReportQuery: TFDQuery;
    ReportQueryRoom: TIntegerField;
    ReportQueryCity: TStringField;
    ReportQueryAdress: TStringField;
    ReportQueryNumHome: TIntegerField;
    ReportQueryNumApartment: TIntegerField;
    ReportQueryCountRoom: TIntegerField;
    ReportQueryScreen: TBlobField;
    ReportQueryRoomStr: TWideStringField;
    ReportQueryPriceMerge: TWideStringField;
    ReportQueryStrIncome: TWideStringField;
    ReportQueryStrExpence: TWideStringField;
    ReportQueryTotalPrice: TWideStringField;
    ReportTotalQuery: TFDQuery;
    ReportTotalQueryTotalReportPrice: TWideStringField;
    ReportDetailQuery: TFDQuery;
    ReportDetailQueryID: TIntegerField;
    ReportDetailQueryRoom: TIntegerField;
    ReportDetailQueryPhone: TStringField;
    ReportDetailQueryPrice: TFloatField;
    ReportDetailQueryPriceRoom: TFloatField;
    ReportDetailQueryTypeDoc: TIntegerField;
    ReportDetailQueryDateCorr: TWideMemoField;
    ReportDetailQueryDescription: TStringField;
    ReportDetailQueryTypeDocID: TIntegerField;
    ReportDetailQueryDateBeg: TWideStringField;
    ReportDetailQueryDateEnd: TWideStringField;
    ReportDetailQueryRoomStr: TWideStringField;
    ReportDetailQueryScreen: TBlobField;
    S: TWideStringField;
    OrderQuery: TFDQuery;
    OrderQueryID: TIntegerField;
    OrderQueryDate_Create: TWideMemoField;
    OrderQueryRoom: TIntegerField;
    OrderQueryPhone: TStringField;
    OrderQueryPrice: TFloatField;
    OrderQueryDateCorr: TWideMemoField;
    OrderQueryTypeDoc: TIntegerField;
    OrderQueryRoomStr: TWideStringField;
    OrderQueryMergeDate: TWideStringField;
    OrderQueryDateBeg: TWideStringField;
    OrderQueryDateEnd: TWideStringField;
    OrderQueryDescription: TStringField;
    OrderQueryTypeDocID: TIntegerField;
    OrderQueryCreate_Time: TWideStringField;
    OrderQueryScreen: TWideStringField;
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

uses sConsts;

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
