unit sConsts;

interface

resourcestring

  // ��������
  SSQLAddRoom = 'INSERT INTO Room (City, ' +
                '                  Adress, ' +
                '                  NumHome, ' +
                '                  NumApartment, ' +
                '                  CountRoom, ' +
                '                  Price) ' +
                'VALUES 		(''%s'', ''%s'', %d, %d, %d, ''%s'')';		      // ���������� ����� ��������

  SSQLCorrRoom  = 'UPDATE Room ' +
                  '    SET City = ''%s'', ' +
                  '        Adress = ''%s'', ' +
                  '        NumHome = %d, '    +
                  '        NumApartment = %d, ' +
                  '        CountRoom = %d,  '   +
                  '        Price = ''%s''  '    +
                  'WHERE ID = %d ';                               // ������������� ���������� ��������



  SSQLDeleteRoom  = 'DELETE FROM ROOM ' +
                    'WHERE ID = %d';

  SSQLGetRoom     = 'SELECT    O.ID, ' +
                    '          O.City, ' +
                    '          O.Adress, ' +
                    '          PrintF(''%s - %d, ��. %d, %d - ���.'', O.Adress, O.NumHome, O.NumApartment, O.CountRoom) as ''AdressStr'', ' +
                    '          O.NumHome, '  +
                    '          O.NumApartment, ' +
                    '          O.CountRoom, ' +
                    '          O.Price, ' +
                    '          I.Screen ' +
                    'FROM	 Room O ' +
                    '      LEFT JOIN ImageIcon I ON I.ID = 1 ' +
                    'ORDER BY O.City';



  // ������
  SSQLAddOrder = 'INSERT INTO Orders (Date_Create,  ' +
                 '                   DateBeg,      ' +
                 '                   DateEnd,      ' +
                 '                   Room,         ' +
                 '                   Phone,        ' +
                 '                   Price,        ' +
                 '                   TypeDoc)      ' +
                 'VALUES				(''%s'', ''%s'', ''%s'', %d, ''%s'', ''%s'', %d)';        // �������� ������ ������

  SSQLCorrOrder = 'UPDATE Orders ' +
                  '  SET DateBeg	=	''%s'', '      +
                  '      DateEnd	=	''%s'', '      +
                  '      Room =	%d,         '      +
                  '      Phone	= ''%s'',   '      +
                  '      Price	= ''%s'',   '      +
                  '      DateCorr = ''%s'', '      +
                  '      TypeDoc	= %d      '      +
                  'WHERE ID = %d        ';                                                // ������������� ������


  SSQLDeleteOrder = 'DELETE FROM Orders ' +                                                // �������� �������
                    'WHERE ID = %d';

  SSQLGetOrderDetail    = 'SELECT   O.ID, ' +
                          '         O.Date_Create, ' +
                          '         date(O.DateBeg) as ''DateBeg'',     ' +
                          '         date(O.DateEnd) as ''DateEnd'',     ' +
                          '         O.Room,        ' +
                          '        (''�. '' || R.City || '', '' || R.Adress || '' - '' || R.NumHome || '', '' || NumApartment) as ''RoomStr'', ' +
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
                          'WHERE O.ID = %d';                                              // ��������� ����������� �� ������


  SSQLGetOrders         = 'SELECT  O.ID, ' +
                          '        O.Date_Create, ' +
                          'date(O.DateBeg) as ''DateBeg'', ' +
                          'date(O.DateEnd) as ''DateEnd'', ' +
                         // '        O.DateBeg,     ' +
                        //  '        O.DateEnd,     ' +
                          '        (''� '' || O.DateBeg || '' �� '' || O.DateEnd) as ''MergeDate'', '  +
                          '        O.Room,        ' +
                          '        printf(''�. '' || R.City || '', '' || R.Adress || '' - '' || R.NumHome || '', '' || NumApartment) as ''RoomStr'', ' +
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
                          'WHERE DATE(Date_Create) Between ''%s'' and ''%s''';                                     // ��������� ������� �������




  SSQLGetStates         = 'SELECT T.ID, ' +
                          '       T.Description, ' +
                          '       I.Screen ' +
                          'FROM TypeDoc T ' +
                          '     LEFT JOIN ImageIcon I ON I.ID = 3';                                              // ��������� ������ ������ ��� ���������

  SSQLAddState          = 'INSERT INTO TypeDoc(Description) ' +                                                  // ���������� ����� ������ ���������
                          'VALUES	 (''%s'')';

  SSQLCorrState         = 'UPDATE TypeDoc ' +                                                                    // ������������� ������ ���������
                          'SET Description = ''%s'' ' +
                          'WHERE ID = %d';

  SSQLDeleteState       = 'DELETE FROM TypeDoc ' +                                                               // �������� ������ ���������
                          'WHERE ID = %d';

          // �����
  SSQLRepotrSales      = 'SELECT O.Room, ' +                                                                    // ��������� ������ �� ����� �������
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
                         '		  (''�������: '' || (SELECT Sum(Price) ' +
                         '                    FROM Orders ' +
                         '                    WHERE TypeDoc = 1 AND Room = O.Room) || '', ������: '' || (SELECT Sum(Price) ' +
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
