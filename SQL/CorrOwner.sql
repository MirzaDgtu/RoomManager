SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Корректировка владельца>
-- =============================================
CREATE PROCEDURE A_CorrOwner
@ID int = 0,
@Name varchar(100) = Null,
@Passport varchar(300) = Null,
@PassportScreen image = null,
@Phone varchar(30) = Null
AS
	if @ID <> 0
		BEGIN
			UPDATE APARTMENT..RoomOWNER
			SET Name = @Name,
				Passport = @Passport,
				PassportScreen = @PassportScreen,
				Phone = @Phone
			WHERE ID = @ID
		END
GO
