SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<Корректировка клиента>
-- =============================================
CREATE PROCEDURE A_CorrClient 
	@ID int = 0,	
	@Family varchar(50) = null, 
	@Name varchar(30) = Null,
	@Patronymic varchar(60) = Null,
	@Document varchar(150) = Null,
	@Document_Number varchar(30) = Null,
	@DocImage Image = Null,
	@Phone1 varchar(30) = Null,
	@Phone2 varchar(30) = Null,
	@Adress varchar(200) = Null
AS
	if @ID <> 0
		BEGIN
			UPDATE APARTMENT..CLIENT
			SET Family = @Family,
				Name = @Name,
				Patronymic = @Patronymic,
				Document = @Document,
				Document_Number = @Document_Number,
				DocImage = @DocImage,
				Phone1 = @Phone1,
				Phone2 = @Phone2,
				Adress = @Adress
			WHERE ID = @ID
		END
GO
