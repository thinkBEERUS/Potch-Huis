CREATE PROCEDURE [dbo].[spStock_GetActive]
AS
BEGIN
	SELECT * FROM dbo.Stock WITH(NOLOCK)
	WHERE Active = 1;
END
