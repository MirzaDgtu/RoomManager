SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Корректировка документа снятия кваритиры>
-- =============================================
CREATE PROCEDURE A_CorrOrder
@ID int = 0,
@DateB smalldatetime = Null,
@DateE smalldatetime = null,
@Room int = 0,
@Client int = 0,
@Price float = 0.0
AS
	if @ID <> 0
		BEGIN TRANSACTION
			UPDATE APARTMENT..ORDERS
			SET Date_Begin = @DateB,
				Date_End = @DateE,
				Date_Corr = GETDATE(),
				Client = @Client,
				Price = @Price
			WHERE ID = @ID
		COMMIT
GO
