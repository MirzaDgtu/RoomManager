SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<>
-- =============================================
CREATE PROCEDURE A_AddOrders
@DateB smalldatetime = Null,
@DateE smalldatetime = null,
@Room int = 0,
@Client int = 0,
@Price float = 0.0
AS

if @Room <> 0
	BEGIN
		INSERT INTO APARTMENT..ORDERS(Date_Create,
									  Date_Begin,
									  Date_End,
									  Room,
									  Client,
									  Price)

		VALUES						 (GETDATE(),
									  @DateB,
									  @DateE,
									  @Room,
									  @Client,
									  @Price)
	END
GO
