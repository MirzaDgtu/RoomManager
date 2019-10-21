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

  SSQLGetRoom     = 'SELECT    O.ID, ' +
                    '          O.City, ' +
                    '          O.Adress, ' +
                    '          PrintF(''%s - %d, кв. %d, %d - ком.'', O.Adress, O.NumHome, O.NumApartment, O.CountRoom) as ''AdressStr'', ' +
                    '          O.NumHome, '  +
                    '          O.NumApartment, ' +
                    '          O.CountRoom, ' +
                    '          O.Price, ' +
                    '          I.Screen ' +
                    'FROM	 Room O ' +
                    '      LEFT JOIN ImageIcon I ON I.ID = 1 ' +
                    'ORDER BY O.City';



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
                  '  SET DateBeg	=	''%s'', '      +
                  '      DateEnd	=	''%s'', '      +
                  '      Room =	%d,         '      +
                  '      Phone	= ''%s'',   '      +
                  '      Price	= ''%s'',   '      +
                  '      DateCorr = ''%s'', '      +
                  '      TypeDoc	= %d      '      +
                  'WHERE ID = %d        ';                                                // Корректировка заказа


  SSQLDeleteOrder = 'DELETE FROM Orders ' +                                                // Удаление заказва
                    'WHERE ID = %d';

  SSQLGetOrderDetail    = 'SELECT   O.ID, ' +
                          '         O.Date_Create, ' +
                          '         date(O.DateBeg) as ''DateBeg'',     ' +
                          '         date(O.DateEnd) as ''DateEnd'',     ' +
                          '         O.Room,        ' +
                          '        (''г. '' || R.City || '', '' || R.Adress || '' - '' || R.NumHome || '', '' || NumApartment) as ''RoomStr'', ' +
                          '         O.Phone,       ' +
                          '         O.Price,       ' +
                          '         R.Price as ''PriceRoom'', ' +
                          '         O.DateCorr,    ' +
                          '         O.TypeDoc,     ' +
                          '         T.Description,  ' +
                          '         T.ID as ''TypeDocID'' ' +
                          'FROM Orders O           ' +
                          '     LEFT JOIN Room R ON R.ID = O.Room ' +
                          '     LEFT JOIN TypeDoc T ON T.ID = O.TypeDoc ' +
                          'WHERE O.ID = %d';                                              // Получение детализации по заказу


  SSQLGetOrders         = 'SELECT  O.ID, ' +
                          '        O.Date_Create, ' +
                          'date(O.DateBeg) as ''DateBeg'', ' +
                          'date(O.DateEnd) as ''DateEnd'', ' +
                         // '        O.DateBeg,     ' +
                        //  '        O.DateEnd,     ' +
                          '        (''С '' || O.DateBeg || '' по '' || O.DateEnd) as ''MergeDate'', '  +
                          '        O.Room,        ' +
                          '        printf(''г. '' || R.City || '', '' || R.Adress || '' - '' || R.NumHome || '', '' || NumApartment) as ''RoomStr'', ' +
                          '        O.Phone,       ' +
                          '        O.Price,       ' +
                          '        R.Price as ''PriceRoom'', ' +
                          '        O.DateCorr,    ' +
                          '        O.TypeDoc,     ' +
                          '        I.Screen,      ' +
                          '        T.Description,  ' +
                          '        T.ID as ''TypeDocID'' ' +
                          'FROM Orders O          ' +
                          '     LEFT JOIN Room R On R.ID = O.Room' +
                          '     LEFT JOIN ImageIcon I ON I.ID = 2 ' +
                          '     LEFT JOIN TypeDoc T ON T.ID = O.TypeDoc ' +
                          'WHERE DATE(Date_Create) Between ''%s'' and ''%s''';                                     // Получение реестра заказов




  SSQLGetStates         = 'SELECT T.ID, ' +
                          '       T.Description, ' +
                          '       I.Screen ' +
                          'FROM TypeDoc T ' +
                          '     LEFT JOIN ImageIcon I ON I.ID = 3';                                              // Получение списка статей для документа

  SSQLAddState          = 'INSERT INTO TypeDoc(Description) ' +                                                  // Добавление новой статьи документа
                          'VALUES	 (''%s'')';

  SSQLCorrState         = 'UPDATE TypeDoc ' +                                                                    // Корректировка статьи документа
                          'SET Description = ''%s'' ' +
                          'WHERE ID = %d';

  SSQLDeleteState       = 'DELETE FROM TypeDoc ' +                                                               // Удаление статьи документа
                          'WHERE ID = %d';

          // Отчет
  SSQLRepotrSales      = 'SELECT O.Room, ' +                                                                    // Получение отчета по сдаче квартир
                         '       R.City, ' +
                         '       R.Adress, ' +
                         '       R.NumHome, ' +
                         '       R.NumApartment, ' +
                         '       R.CountRoom, ' +
                         '      (R.City || '', '' ||  R.Adress || '' '' || R.NumHome || '', '' || R.NumApartment) as ''RoomStr'', ' +
                         '	    CAST((SELECT Sum(Price) ' +
                         '       FROM Orders        ' +
                         '       WHERE TypeDoc = 1 AND Room = O.Room) as Text)	as ''PriceIncome'', ' +
                         '	    CAST((SELECT Sum(Price) ' +
                         '       FROM Orders       ' +
                         '       WHERE TypeDoc <> 1 AND Room = O.Room) as Text)	as ''PriceExpend'', ' +
                         '		  (''Выручка: '' || (SELECT Sum(Price) ' +
                         '                    FROM Orders ' +
                         '                    WHERE TypeDoc = 1 AND Room = O.Room) || '', Расход: '' || (SELECT Sum(Price) ' +
                         '                                                                             FROM Orders ' +
                         '                                                                             WHERE TypeDoc <> 1 AND Room = O.Room)) as ''PriceMerge'', ' +
                         '        CAST(((SELECT Sum(Price) ' +
                         '          FROM Orders ' +
                         '          WHERE TypeDoc = 1 AND Room = O.Room) - ' +
                         '         (SELECT Sum(Price) ' +
                         '          FROM Orders ' +
                         '          WHERE TypeDoc <> 1 AND Room = O.Room)) as Text)	as ''TotalPrice'',	' +
                         '          I.Screen ' +
                         'From Orders O ' +
                         '   LEFT JOIN Room R ON R.ID = O.Room ' +
                         ' 	 LEFT JOIN ImageIcon I ON I.ID = 4 ' +
                         'WHERE O.Date_Create BETWEEN ''%s'' AND ''%s'' ' +
                         'Group By O.Room';




implementation

end.
