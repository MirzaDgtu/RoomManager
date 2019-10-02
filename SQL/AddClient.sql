SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		pmp
-- Create date: 2019-09-20
-- Description:	Добавление клиента
-- =============================================
CREATE PROCEDURE A_AddClient 	
	@Family varchar(50) = null, 
	@Name varchar(30) = Null,
	@Patronymic varchar(60) = Null,
	@Document varchar(150) = Null,
	@Document_Number varchar(30) = Null,
	@DocImage Image = Null,
	@Phone1 varchar(30) = Null,
	@Phone2 varchar(30) = Null,
	@Adress varchar(200) = Null
AS
	INSERT INTO APARTMENT..CLIENT (Family,
								   Name,
								   Patronymic,
								   Document,
								   Document_Number,
								   DocImage,
								   Phone1,
								   Phone2,
								   Adress)

	VALUES						  (@Family,
								   @Name,
								   @Patronymic,
								   @Document,
								   @Document_Number,
								   @DocImage,
								   @Phone1,
								   @Phone2,
								   @Adress)		
GO
