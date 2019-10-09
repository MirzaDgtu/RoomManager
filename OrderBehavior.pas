unit OrderBehavior;

interface

uses System.SysUtils;

type
    TOrderAction  = class
      private
      public
        function add(createDate, dateBeg, dateEnd: string; room: integer; phone, price: string; typeDoc: integer): Boolean;
        function correction(dateCorr, dateBeg, dateEnd: string; room: integer; phone, price: string; typeDoc, IdOrder: integer): Boolean;
        function delete(IdOrder: integer): Boolean;
    end;

implementation

uses AppData, sConsts;

{ TOrderAction }

function TOrderAction.add(createDate, dateBeg, dateEnd: string; room: integer;
  phone, price: string; typeDoc: integer): Boolean;
begin
    if ModuleData.ConnectionToLocalDB then
      Begin
        try
            if ModuleData.ConnectionToLocalDB then
              Begin
                 ModuleData.OrderDBQuery.SQL.Text := Format(SSQLAddOrder, [createDate,
                                                                           dateBeg,
                                                                           dateEnd,
                                                                           room,
                                                                           phone,
                                                                           price,
                                                                           typeDoc]);
                 ModuleData.OrderDBQuery.ExecSQL;
              End;
        finally
            Result := True;
        end;
      End
    else
        Result := False;
end;


function TOrderAction.correction(dateCorr, dateBeg, dateEnd: string;
  room: integer; phone, price: string; typeDoc, IdOrder: integer): Boolean;
begin
    if ModuleData.ConnectionToLocalDB then
      Begin
        try
            if ModuleData.ConnectionToLocalDB then
              Begin
                ModuleData.OrderDBQuery.Sql.Text := Format(SSQLCorrOrder, [dateBeg,
                                                                           dateEnd,
                                                                           room,
                                                                           phone,
                                                                           price,
                                                                           dateCorr,
                                                                           typeDoc,
                                                                           IdOrder]);
                ModuleData.OrderDBQuery.ExecSQL;
              End;
        finally
            Result := True;
        end;
      End
    else
        Result := False;
end;

function TOrderAction.delete(IdOrder: integer): Boolean;
begin
    if ModuleData.ConnectionToLocalDB then
      Begin
        try
            if ModuleData.ConnectionToLocalDB then
              Begin
                ModuleData.OrderDBQuery.Sql.Text := Format(SSQLDeleteOrder, [IdOrder]);
                ModuleData.OrderDBQuery.ExecSQL;
              End;
        finally
            Result := True;
        end;
      End
    else
        Result := False;
end;

end.
