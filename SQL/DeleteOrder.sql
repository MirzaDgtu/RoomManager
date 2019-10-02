SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Удаление документа>
-- =============================================
CREATE PROCEDURE A_DeleteOrder
@ID int = 0
AS
	BEGIN TRANSACTION
		DELETE FROM APARTMENT..ORDERS
		WHERE ID = @ID
	COMMIT
GO
