SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Перевод старой цены в архив>
-- =============================================
CREATE PROCEDURE A_AddStorePrice
	@Room int = 0,
	@Price float = 0.0
AS

if @Room <> 0
	BEGIN
		INSERT INTO APARTMENT..STOREPRICE(Room,
										  Date_Create,
										  Price)

		VALUES							 (@Room,
										  GETDATE(),
										  @Price)
	END
GO
