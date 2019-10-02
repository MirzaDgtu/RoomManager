unit sConsts;

interface

resourcestring

  // Квартиры
  SSQLAddRoom = 'INSERT INTO Room (City, ' +
                '                  Adress, ' +
                '                  NumHome, ' +
                '                  NumApartment, ' +
                '                  CountRoom, ' +
                '                  Price) ' +
                'VALUES 		(''%s'', ''%s'', %d, %d, %d, ''%s'')';		      // Добавление новой квартиры

  SSQLCorrRoom  = 'UPDATE Room ' +
                  '    SET City = ''%s'', ' +
                  '        Adress = ''%s'', ' +
                  '        NumHome = %d, '    +
                  '        NumApartment = %d, ' +
                  '        CountRoom = %d,  '   +
                  '        Price = ''%s''  '    +
                  'WHERE ID = %d ';                               // Корректировка параметров квартиры



  SSQLDeleteRoom  = 'DELETE FROM ROOM ' +
                    'WHERE ID = %d';

  SSQLGetRoom     = 'SELECT    ID, ' +
                    '          City, ' +
                    '          Adress, ' +
                    '          NumHome, '  +
                    '          NumApartment, ' +
                    '          CountRoom, ' +
                    '          Price ' +
                    'FROM	 Room ' +
                    'ORDER BY CountRoom';



  // Заказы
  SSQLAddOrder = 'INSERT INTO Orders (Date_Create,  ' +
                 '                   DateBeg,      ' +
                 '                   DateEnd,      ' +
                 '                   Room,         ' +
                 '                   Phone,        ' +
                 '                   Price,        ' +
                 '                   TypeDoc)      ' +
                 'VALUES				(''%s'', ''%s'', ''%s'', %d, ''%s'', ''%s'', %d)';        // Создание нового заказа


  SSQLCorrOrder = 'UPDATE Orders ' +
                  '  SET Date_Create = ''%s'', ' +
                  '    DateBeg	=	''%s'', '      +
                  '    DateEnd	=	''%s'', '      +
                  '    Room =	%d, '              +
                  '    Phone	= ''%s'', '        +
                  '    Price	= ''%s'', '        +
                  '    DateCorr = ''%s'', '      +
                  '    TypeDoc	= %d    '        +
                  'WHERE ID = %d        ';                                                // Корректировка заказа


  SSQLDeleteOrder = 'DELETE FROM Order ' +                                                // Удаление заказва
                    'WHERE ID = %d';

  SSQLGetOrderDetail    = 'SELECT   O.ID, ' +
                          '         O.Date_Create, ' +
                          '         O.DateBeg,     ' +
                          '         O.DateEnd,     ' +
                          '         O.Room,        ' +
                          '         O.Phone,       ' +
                          '         O.Price,       ' +
                          '         O.DateCorr,    ' +
                          '         O.TypeDoc      ' +
                          'FROM Orders O            ' +
                          'WHERE O.ID = %d';                                              // Получение детализации по заказу


  SSQLGetOrders         = 'SELECT  O.ID, ' +
                          '        O.Date_Create, ' +
                          '        O.DateBeg,     ' +
                          '        O.DateEnd,     ' +
                          '        O.Room,        ' +
                          '        printf(''%s - %d, %d'', R.Adress, R.NumHome, NumApartment) as ''RoomStr'', ' +
                          '        O.Phone,       ' +
                          '        O.Price,       ' +
                          '        O.DateCorr,    ' +
                          '        O.TypeDoc      ' +
                          'FROM Orders O          ' +
                          'LEFT JOIN Room R On R.ID = O.Room';
                        //  'WHERE DATE(O.DateBeg) = DATE(''%s'')';                                     // Получение реестра заказов
implementation

end.
