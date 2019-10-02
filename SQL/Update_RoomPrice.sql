SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<При обновлении цены на квартиру, старая цена переносится в >
-- =============================================
CREATE TRIGGER Update_RoomPrice 
   ON  ROOM 
   INSTEAD OF UPDATE
AS 

DECLARE @OldPrice float, @NewPrice float, @ID int
	SELECT @NewPrice = Price,
		   @ID = ID
	FROM inserted WITH (NOLOCK)

	SET @OldPrice = (SELECT R.Price
					 FROM APARTMENT..Room R WITH (NOLOCK)
					 WHERE R.ID = @ID)


	if @OldPrice != @NewPrice
		BEGIN
			EXEC A_AddStorePrice @ID, @NewPrice
		END				 
GO
