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
                    '          O.NumHome, '  +
                    '          O.NumApartment, ' +
                    '          O.CountRoom, ' +
                    '          O.Price, ' +
                    '          I.Screen ' +
                    'FROM	 Room O' +
                    '      LEFT JOIN ImageIcon I ON I.ID = 1 ' +
                    'ORDER BY CountRoom';



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
                  '  SET Date_Create = ''%s'', ' +
                  '    DateBeg	=	''%s'', '      +
                  '    DateEnd	=	''%s'', '      +
                  '    Room =	%d, '              +
                  '    Phone	= ''%s'', '        +
                  '    Price	= ''%s'', '        +
                  '    DateCorr = ''%s'', '      +
                  '    TypeDoc	= %d    '        +
                  'WHERE ID = %d        ';                                                // ������������� ������


  SSQLDeleteOrder = 'DELETE FROM Order ' +                                                // �������� �������
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
                          'WHERE O.ID = %d';                                              // ��������� ����������� �� ������


  SSQLGetOrders         = 'SELECT  O.ID, ' +
                          '        O.Date_Create, ' +
                          '        O.DateBeg,     ' +
                          '        O.DateEnd,     ' +
                          '        O.Room,        ' +
                          '        printf(''%s - %d, %d'', R.Adress, R.NumHome, NumApartment) as ''RoomStr'', ' +
                          '        O.Phone,       ' +
                          '        O.Price,       ' +
                          '        O.DateCorr,    ' +
                          '        O.TypeDoc,     ' +
                          '        I.Screen       ' +
                          'FROM Orders O          ' +
                          'LEFT JOIN Room R On R.ID = O.Room' +
                          '     LEFT JOIN ImageIcon I ON I.ID = 2 ';
                        //  'WHERE DATE(O.DateBeg) = DATE(''%s'')';                                     // ��������� ������� �������
implementation

end.
