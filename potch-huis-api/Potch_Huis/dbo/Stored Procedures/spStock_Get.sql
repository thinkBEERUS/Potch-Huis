CREATE PROCEDURE [dbo].[spStock_Get]
	@Name VARCHAR(MAX)
AS
BEGIN
	DECLARE @SearchString NVARCHAR(MAX) = (SELECT '%' + @Name + '%')
	SELECT * FROM dbo.Stock WITH(NOLOCK)
	WHERE [Name] LIKE @SearchString;
END
