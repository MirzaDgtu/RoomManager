SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Добавление владельца квартиры>
-- =============================================
CREATE PROCEDURE A_AddOwner
@Name varchar(100) = Null,
@Passport varchar(300) = Null,
@PassportScreen image = null,
@Phone varchar(30) = Null
AS
	IF IsNull(@Name, '') <> ''
		BEGIN
			INSERT INTO APARTMENT..RoomOWNER (Name,
											  Passport,
											  PassportScreen,
											  Phone)

			VALUES							 (@Name,
											  @Passport,
											  @PassportScreen,
											  @Phone)
		END	
GO
