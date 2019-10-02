CREATE TABLE ROOM(ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
				  Col int Default(0),
				  Adress Varchar(200) Null,
				  Owner int Default(0),
				  Price float,
				  Reserve bit DEFAULT (1))



CREATE TABLE RoomOWNER (ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
						Name varchar(100),
						Passport VARCHAR(300),
						Phone varchar(30),
						PassportScreen image)

CREATE TABLE STOREPRICE (ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
						 Room int Not Null,
						 Date_Create smalldatetime Null,
						 Price float)

CREATE TABLE TYPE_DOC(ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
					  Name varchar(10) Not NUll,
					  Description varchar(100) Null)


CREATE TABLE ORDERS(ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
					Date_Create smalldatetime Null,
					Date_Begin smalldatetime Null,
					Date_End smalldatetime Null,
					Room int Default(0),
					Client int Null,
					Price float,
					Date_Corr smalldatetime Null)

CREATE TABLE CLIENT (ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
					 Family varchar(50) Null,
					 Name varchar(30) Null,
					 Patronymic varchar(60) Null,
					 Document varchar(150) Null,
					 Document_Number varchar(30) Null,
					 DocImage IMAGE,
					 Phone1 varchar(30) Null,
					 Phone2 varchar(30) Null,
					 Adress varchar(200) Null)

