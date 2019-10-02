SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<pmp>
-- Create date: <2019-09-20>
-- Description:	<>
-- =============================================
CREATE PROCEDURE A_AddTypeDoc
@Name varchar(10) = Null,
@Description varchar(100) = Null 
AS

if IsNull(@Name,'') <> ''
	BEGIN
		INSERT INTO TYPE_DOC (Name,
							  Description)

		VALUES				 (@Name,
							  @Description)
	END
GO
