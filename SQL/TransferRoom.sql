SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Перевод квартиры в(из) резерв(а)>
-- =============================================
CREATE PROCEDURE A_TransferRoom
@ID int = 0,
@Reserve bit = 1
AS

	if @ID <> 0
		BEGIN
			UPDATE APARTMENT..ROOM
			SET Reserve = @Reserve
			WHERE ID = @ID
		END
GO
