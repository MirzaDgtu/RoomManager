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

  SSQLGetRoom     = 'SELECT    O.ID, ' +                          // ��������� ������ ���� �������
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


  SSQLGetRoomFree  = 'SELECT   R.ID, ' +                          // ��������� ������ ���� �������
                    '          R.City, ' +
                    '          R.Adress, ' +
                    '         (R.Adress || '' - '' || R.NumHome || '', ��. '' || R.NumApartment || '', '' || R.CountRoom || '' - ���.'') as ''AdressStr'', ' +
                    '          R.NumHome, '  +
                    '          R.NumApartment, ' +
                    '          R.CountRoom, ' +
                    '          R.Price, ' +
                    '          I.Screen ' +
                    'FROM	 Room R ' +
                    '      LEFT JOIN ImageIcon I ON I.ID = 1 ' +
                    'WHERE R.ID  NOT IN (SELECT Distinct(O.Room) ' +
                    '                    From Orders O ' +
                    '                    WHERE Date(O.DateBeg) BETWEEN ''%s'' AND ''%s'' AND ' +
                    '                          Date(O.DateEnd) BETWEEN ''%s'' AND ''%s'') ' +
                    'GROUP By R.ID ' +
                    'ORDER BY R.City';



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
                          '        (''� '' || O.DateBeg || '' �� '' || O.DateEnd) as ''MergeDate'', '  +
                          '        O.Room,        ' +
                          '        (''�. '' || R.City || '', '' || R.Adress || '' - '' || R.NumHome || '', '' || NumApartment) as ''RoomStr'', ' +
                          '        O.Phone,       ' +
                          '        O.Price,       ' +
                          '        R.Price as ''PriceRoom'', ' +
                          '        O.DateCorr,    ' +
                          '        O.TypeDoc,     ' +
                       {   '        IfNULL(CAST((CASE O.TypeDoc WHEN  1 THEN (SELECT Screen   ' +
                          '                                                  FROM ImageIcon ' +
                          '                                                  WHERE ID = 5)  ' +
                          '                       ELSE		  	              (SELECT Screen    ' +
                          '                                                  FROM ImageIcon ' +
                          '                                                  WHERE ID = 6)  ' +
                          '              END) as Blob), 0x0)  as Screen,  ' +  }

                          '        (SELECT Screen   ' +
                          '         FROM ImageIcon ' +
                          '         WHERE ID = 5 ) as ''Screen'', ' +

                          '        T.Description,  ' +
                          '        T.ID as ''TypeDocID'', ' +
                          '        (CAST(''����� ������: '' || time(O.Date_Create) as TEXT)) as ''Create_Time'' ' +
                          'FROM Orders O          ' +
                          '     LEFT JOIN Room R On R.ID = O.Room ' +
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
  SSQLRepotrSales      = 'SELECT O.Room, ' +
                         'R.City,        ' +
                         'R.Adress,      ' +
                         'R.NumHome,     ' +
                         'R.NumApartment, ' +
                         'R.CountRoom,    ' +
                         '(R.City || '', '' ||  R.Adress || '' '' || R.NumHome || '', '' || R.NumApartment) as ''RoomStr'', ' +
                         'CAST(''�������: '' || (SELECT Sum(Price) ' +
                         '                       FROM Orders ' +
                         '                       WHERE TypeDoc = 1 AND ' +
                         '                             Room = O.Room '  +
                         '                             AND Date_Create Between ''%s'' AND ''%s'') || '', ������: '' || (SELECT Sum(Price) ' +
                         '                                                                                              FROM Orders       ' +
                         '                                                                                              WHERE TypeDoc <> 1 AND ' +
                         '                                                                                                    Room = O.Room ' +
                         '                                                                                                    AND Date_Create Between ''%s'' AND ''%s'') as TEXT) as ''PriceMerge'', ' +
                         'CAST((''�������: '' || (SELECT Sum(Price) ' +
                         '                        From Orders                       ' +
                         '                        WHERE TypeDoc = 1 AND             ' +
                         '                              Room = O.Room ' +
                         '                              AND Date_Create Between ''%s'' AND ''%s'')) as TEXT) as ''StrIncome'', ' +
                         'CAST((''������: '' || (SELECT Sum(Price) ' +
                         '                       FROM Orders                       ' +
                         '                       WHERE TypeDoc <> 1 AND            ' +
                         '                             Room = O.Room ' +
                         '                             AND Date_Create Between ''%s'' AND ''%s'')) as TEXT) as ''StrExpence'', ' +
                         'CAST(CAST((SELECT IFNULL(Sum(Price), 0.0)   ' +
                         '	         FROM Orders                      ' +
                         '	         WHERE TypeDoc = 1 AND            ' +
                         '		             Room = O.Room ' +
                         '                 AND Date_Create Between ''%s'' AND ''%s'') as FLOAT) - ' +
                         'CAST((SELECT IFNULL(Sum(Price), 0.0)        ' +
                         '	    FROM Orders                           ' +
                         '	    WHERE TypeDoc <> 1 AND                ' +
                         '		        Room = O.Room ' +
                         '            AND Date_Create Between ''%s'' AND ''%s'') as FLOAT) as TEXT) as ''TotalPrice'', ' +
                         'I.Screen                                 ' +
                         'From Orders O                            ' +
                         '   LEFT JOIN Room R ON R.ID = O.Room     ' +
                         '   LEFT JOIN ImageIcon I ON I.ID = 4     ' +
                         'WHERE O.Date_Create Between ''%s'' AND ''%s''  ' +
                         'Group By O.Room';

  SSQLGetReportTotal   = 'SELECT CAST(''�����: �������: '' || (SELECT IfNull(Sum(Price), 0.0) ' +
                         '                                     FROM Orders  ' +
                         '                                     WHERE TypeDoc = 1 AND ' +
                        // '                                   Cast(strftime(''m'', Date(DateBeg)) as INTEGER) = Cast(strftime(''m'', Date(''now'')) as INTEGER)) || ' +
                         '                                     Date(Date_Create) BETWEEN ''%s'' AND ''%s'') || ' +
                         '                       '', �������: '' || (SELECT IfNull(Sum(Price), 0.0) ' +
                         '                                   FROM Orders ' +
                         '                                 WHERE TypeDoc <> 1 AND ' +
//                         '                                   Cast(strftime(''m'', Date(DateBeg)) as INTEGER) = Cast(strftime(''m'', Date(''now'')) as INTEGER)) || ' +
                         '                                        Date(Date_Create) BETWEEN ''%s'' AND ''%s'') || ' +
                         '                       '', �������: '' || ((SELECT IfNull(Sum(Price), 0.0) ' +
                         '                                            FROM Orders ' +
                         '                                            WHERE TypeDoc = 1 AND ' +
//                         '                                   Cast(strftime(''m'', Date(DateBeg)) as INTEGER) = Cast(strftime(''m'', Date(''now'')) as INTEGER)) - ' +
                         '                                                  Date(Date_Create) BETWEEN ''%s'' AND ''%s'') - ' +
                         '                                            (SELECT IfNull(Sum(Price), 0.0) ' +
                         '                                             FROM Orders ' +
                         '                                             WHERE TypeDoc <> 1 AND ' +
//                         '                                   Cast(strftime(''m'', Date(DateBeg)) as INTEGER) = Cast(strftime(''m'', Date(''now'')) as INTEGER))) AS TEXT) AS ''TotalReportPrice''';
                         '                                                   Date(Date_Create) BETWEEN ''%s'' AND ''%s'')) AS TEXT) AS  ''TotalReportPrice''';



  SSQLGetReportDetails  = ' SELECT O.ID, ' +
                          '        Date(O.Date_Create) as Date_Create, ' +
                          '        Date(O.DateBeg) as ''DateBeg'', ' +
                          '        Date(O.DateEnd) as ''DateEnd'', ' +
                          '        O.Room, ' +
                          '        (''�. '' || R.City || '', '' || R.Adress || '' - '' || R.NumHome || '', '' || NumApartment) as ''RoomStr'', ' +
                          '        O.Phone, ' +
                          '        O.Price, ' +
                          '        R.Price as ''PriceRoom'', ' +
                          '        O.TypeDoc, ' +
                          '        O.DateCorr, ' +
                          '        T.Description, ' +
                          '        T.ID as ''TypeDocID'', ' +
                          '        CAST((CASE O.TypeDoc WHEN  1 THEN (SELECT Screen  ' +
                          '                                     FROM ImageIcon      ' +
                          '                                     WHERE ID = 5)       ' +
                          '                        ELSE	        (SELECT Screen       ' +
                          '                                     FROM ImageIcon      ' +
                          '                                     WHERE ID = 6)       ' +
                          '               END) as BLOB) as Screen' +
                          '  FROM Orders O                                       ' +
                          '       LEFT JOIN TypeDoc T ON T.ID = O.TypeDoc        ' +
                          '       LEFT JOIN Room R On R.ID = O.Room              ' +
                          '  WHERE O.Room = %d AND                               ' +
                          '       Date(O.Date_Create) BETWEEN ''%s'' AND ''%s''      ' +
                          '  Order By O.TypeDoc';


implementation

end.
