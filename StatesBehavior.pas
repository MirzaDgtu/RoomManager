unit StatesBehavior;

interface

uses System.SysUtils;
type
  TStatesAction = class
    public
      procedure add(name: string);
      procedure correction(id: integer; name: string);
      procedure delete(id: integer);
  end;

implementation

{ StatesAction }

uses AppData, sConsts;

procedure TStatesAction.add(name: string);
begin
    try
       ModuleData.Connection.StartTransaction;
        ModuleData.StateDBQuery.SQL.Text := Format(SSQLAddState, [name]);
        ModuleData.StateDBQuery.ExecSQL;
       ModuleData.Connection.Commit
    finally
    end;
end;

procedure TStatesAction.correction(id: integer; name: string);
begin
    try
       ModuleData.Connection.StartTransaction;
        ModuleData.StateDBQuery.SQL.Text := Format(SSQLCorrState, [name,
                                                                   id]);
        ModuleData.StateDBQuery.ExecSQL;
       ModuleData.Connection.Commit
    finally
    end;
end;

procedure TStatesAction.delete(id: integer);
begin
    try
       ModuleData.Connection.StartTransaction;
        ModuleData.StateDBQuery.SQL.Text := Format(SSQLDeleteState, [id]);
        ModuleData.StateDBQuery.ExecSQL;
       ModuleData.Connection.Commit
    finally
    end;
end;

end.
