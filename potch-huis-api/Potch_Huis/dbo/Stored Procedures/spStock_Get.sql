﻿CREATE PROCEDURE [dbo].[spStock_Get]
	@Name VARCHAR(MAX)
AS
BEGIN
	SELECT * FROM dbo.Stock WITH(NOLOCK)
	WHERE [Name] = @Name;
END
