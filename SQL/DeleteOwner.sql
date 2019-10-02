SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Удаление владельца квартиры>
-- =============================================
CREATE PROCEDURE A_DeleteOwner
@ID int = 0
AS
	if @ID <> 0 
		BEGIN
			DELETE FROM APARTMENT..RoomOWNER
			WHERE ID = @ID
		END
GO
