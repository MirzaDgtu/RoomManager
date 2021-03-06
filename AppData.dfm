object ModuleData: TModuleData
  OldCreateOrder = False
  Height = 419
  Width = 361
  object Connection: TFDConnection
    Params.Strings = (
      'Database=D:\Projects\RoomManager\SQL\SQLite\RoomManagerDB.db'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = ConnectionBeforeConnect
    Left = 24
    Top = 8
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 88
    Top = 8
  end
  object SQLiteDriver: TFDPhysSQLiteDriverLink
    Left = 160
    Top = 8
  end
  object RoomDBQuery: TFDQuery
    Connection = Connection
    Left = 24
    Top = 72
  end
  object StoredProc: TFDStoredProc
    Connection = Connection
    Left = 240
    Top = 8
  end
  object RoomQuery: TFDQuery
    IndexFieldNames = 'ID;City'
    Connection = Connection
    Left = 24
    Top = 120
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object RoomQueryCity: TStringField
      FieldName = 'City'
      Size = 50
    end
    object StringField1: TStringField
      FieldName = 'Adress'
      Size = 200
    end
    object RoomQueryAdressStr: TWideStringField
      FieldName = 'AdressStr'
      Size = 50
    end
    object RoomQueryNumHome: TIntegerField
      FieldName = 'NumHome'
    end
    object RoomQueryNumApartment: TIntegerField
      FieldName = 'NumApartment'
    end
    object RoomQueryCountRoom: TIntegerField
      FieldName = 'CountRoom'
    end
    object FloatField1: TFloatField
      FieldName = 'Price'
    end
    object RoomQueryScreen: TBlobField
      FieldName = 'Screen'
    end
  end
  object OrderDBQuery: TFDQuery
    Connection = Connection
    Left = 104
    Top = 72
  end
  object StateQuery: TFDQuery
    Connection = Connection
    Left = 176
    Top = 120
    object StateQueryID: TIntegerField
      FieldName = 'ID'
    end
    object StateQueryDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object StateQueryScreen: TBlobField
      FieldName = 'Screen'
    end
  end
  object StateDBQuery: TFDQuery
    Connection = Connection
    Left = 176
    Top = 72
  end
  object ReportQuery: TFDQuery
    Connection = Connection
    Left = 256
    Top = 72
    object ReportQueryRoom: TIntegerField
      FieldName = 'Room'
    end
    object ReportQueryCity: TStringField
      FieldName = 'City'
      Size = 30
    end
    object ReportQueryAdress: TStringField
      FieldName = 'Adress'
      Size = 150
    end
    object ReportQueryNumHome: TIntegerField
      FieldName = 'NumHome'
    end
    object ReportQueryNumApartment: TIntegerField
      FieldName = 'NumApartment'
    end
    object ReportQueryCountRoom: TIntegerField
      FieldName = 'CountRoom'
    end
    object ReportQueryScreen: TBlobField
      FieldName = 'Screen'
    end
    object ReportQueryRoomStr: TWideStringField
      FieldName = 'RoomStr'
      Size = 150
    end
    object ReportQueryPriceMerge: TWideStringField
      FieldName = 'PriceMerge'
      Size = 50
    end
    object ReportQueryStrIncome: TWideStringField
      FieldName = 'StrIncome'
      Size = 50
    end
    object ReportQueryStrExpence: TWideStringField
      FieldName = 'StrExpence'
      Size = 50
    end
    object ReportQueryTotalPrice: TWideStringField
      FieldName = 'TotalPrice'
      Size = 50
    end
  end
  object ReportTotalQuery: TFDQuery
    Connection = Connection
    Left = 256
    Top = 120
    object ReportTotalQueryTotalReportPrice: TWideStringField
      FieldName = 'TotalReportPrice'
      Size = 100
    end
  end
  object ReportDetailQuery: TFDQuery
    Connection = Connection
    Left = 256
    Top = 168
    object ReportDetailQueryID: TIntegerField
      FieldName = 'ID'
    end
    object ReportDetailQueryRoom: TIntegerField
      FieldName = 'Room'
    end
    object ReportDetailQueryPhone: TStringField
      FieldName = 'Phone'
      Size = 50
    end
    object ReportDetailQueryPrice: TFloatField
      FieldName = 'Price'
    end
    object ReportDetailQueryPriceRoom: TFloatField
      FieldName = 'PriceRoom'
    end
    object ReportDetailQueryTypeDoc: TIntegerField
      FieldName = 'TypeDoc'
    end
    object ReportDetailQueryDateCorr: TWideMemoField
      FieldName = 'DateCorr'
      BlobType = ftWideMemo
      Size = 100
    end
    object ReportDetailQueryDescription: TStringField
      FieldName = 'Description'
      Size = 150
    end
    object ReportDetailQueryTypeDocID: TIntegerField
      FieldName = 'TypeDocID'
    end
    object ReportDetailQueryDateBeg: TWideStringField
      FieldName = 'DateBeg'
      Size = 50
    end
    object ReportDetailQueryDateEnd: TWideStringField
      FieldName = 'DateEnd'
      Size = 50
    end
    object ReportDetailQueryRoomStr: TWideStringField
      FieldName = 'RoomStr'
      Size = 150
    end
    object ReportDetailQueryScreen: TBlobField
      FieldName = 'Screen'
    end
    object S: TWideStringField
      FieldName = 'Date_Create'
      Size = 100
    end
  end
  object OrderQuery: TFDQuery
    Connection = Connection
    Left = 101
    Top = 120
    object OrderQueryID: TIntegerField
      FieldName = 'ID'
    end
    object OrderQueryDate_Create: TWideMemoField
      FieldName = 'Date_Create'
      BlobType = ftWideMemo
      Size = 30
    end
    object OrderQueryRoom: TIntegerField
      FieldName = 'Room'
    end
    object OrderQueryPhone: TStringField
      FieldName = 'Phone'
      Size = 30
    end
    object OrderQueryPrice: TFloatField
      FieldName = 'Price'
    end
    object OrderQueryDateCorr: TWideMemoField
      FieldName = 'DateCorr'
      BlobType = ftWideMemo
    end
    object OrderQueryTypeDoc: TIntegerField
      FieldName = 'TypeDoc'
    end
    object OrderQueryRoomStr: TWideStringField
      FieldName = 'RoomStr'
      Size = 150
    end
    object OrderQueryMergeDate: TWideStringField
      FieldName = 'MergeDate'
      Size = 50
    end
    object OrderQueryDateBeg: TWideStringField
      FieldName = 'DateBeg'
      Size = 50
    end
    object OrderQueryDateEnd: TWideStringField
      FieldName = 'DateEnd'
      Size = 50
    end
    object OrderQueryDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object OrderQueryTypeDocID: TIntegerField
      FieldName = 'TypeDocID'
    end
    object OrderQueryCreate_Time: TWideStringField
      FieldName = 'Create_Time'
      Size = 50
    end
    object OrderQueryScreen: TBlobField
      FieldName = 'Screen'
    end
  end
end
