SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Добавление новых квартир>
-- =============================================
CREATE PROCEDURE A_AddRoom
@Col int = 0,
@Adress varchar(200) = Null,
@Owner int = 0,
@Price float = 0.0
AS

	INSERT INTO APARTMENT..ROOM (Col,
								 Adress,
								 Owner,
								 Price)

	VALUES						(@Col,
								 @Adress,
								 @Owner,
								 @Price)
GO
