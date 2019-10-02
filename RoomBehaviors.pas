unit RoomBehaviors;

interface

uses System.SysUtils, FMX.Forms;

type
    TRoomAction = class
      private

      public
        function add(city, adress: string; numHome, numApartment, countRoom: integer; price: string): Boolean;
        function correction(city, adress: string; numHome, numApartment, countRoom: integer; price: string; id: integer): Boolean;
        function delete(numRoom: integer): Boolean;
    end;


implementation

{ RoomAction }

uses AppData, sConsts;


function TRoomAction.add(city, adress: string; numHome, numApartment,
  countRoom: integer; price: string): Boolean;
begin
   try
      try
        if ModuleData.ConnectionToLocalDB then
          begin
            ModuleData.Connection.StartTransaction;
                ModuleData.RoomDBQuery.SQL.Text := Format(SSQLAddRoom,   [city,
                                                                          adress,
                                                                          numHome,
                                                                          numApartment,
                                                                          countRoom,
                                                                          price]);
                ModuleData.RoomDBQuery.ExecSQL;
            ModuleData.Connection.Commit;
          End;
      finally
        Result := True;
      end;
   except
      Result := False;
   end;
end;

function TRoomAction.correction(city, adress: string; numHome, numApartment,
  countRoom: integer; price: string; id: integer): Boolean;
begin
    try
      try
        if ModuleData.ConnectionToLocalDB then
          Begin
            ModuleData.Connection.StartTransaction;
              ModuleData.RoomDBQuery.SQL.Text := Format(SSQLCorrRoom,    [city,
                                                                          adress,
                                                                          numHome,
                                                                          numApartment,
                                                                          countRoom,
                                                                          price,
                                                                          id]);
              ModuleData.RoomDBQuery.ExecSQL;
            ModuleData.Connection.Commit;
          End;
      finally
        Result := True;
      end;
    except
      Result := False;
    end;
end;

function  TRoomAction.delete(numRoom: integer): Boolean;
begin
    try
        try
            if ModuleData.ConnectionToLocalDB then
              Begin
                ModuleData.Connection.StartTransaction;
                  ModuleData.RoomDBQuery.SQL.Text := Format(SSQLDeleteRoom, [numRoom]);
                  ModuleData.RoomDBQuery.ExecSQL;
                ModuleData.Connection.Commit;
              End;
        finally
           Result := True;
        end;
    except
       Result := False;
    end;
end;

end.
