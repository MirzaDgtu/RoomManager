USE [APARTMENT]
GO
/****** Object:  StoredProcedure [dbo].[A_CorrRoom]    Script Date: 20.09.2019 11:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Корреткировка квартиры>
-- =============================================
CREATE PROCEDURE [dbo].[A_CorrRoom]
@ID int = 0,
@Col int = 0,
@Adress varchar(200) = Null,
@Owner int = 0,
@Price float = 0.0,
@Reserve bit = 1
AS
  if @ID <> 0	
	BEGIN
		UPDATE APARTMENT..ROOM
		SET Col = @Col,
			Adress = @Adress,
			Owner = @Owner,
			Price = @Price,
			Reserve = @Reserve
		WHERE ID = @ID
	END
