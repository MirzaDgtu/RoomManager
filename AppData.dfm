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
  end
  object OrderDBQuery: TFDQuery
    Connection = Connection
    Left = 104
    Top = 72
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
    object OrderQueryDateBeg: TWideMemoField
      FieldName = 'DateBeg'
      BlobType = ftWideMemo
      Size = 30
    end
    object OrderQueryDateEnd: TWideMemoField
      FieldName = 'DateEnd'
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
    object OrderQueryCorrDate: TWideMemoField
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
  end
end
