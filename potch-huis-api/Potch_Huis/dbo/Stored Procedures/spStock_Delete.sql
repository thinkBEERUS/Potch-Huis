CREATE PROCEDURE [dbo].[spStock_Delete]
	@Name nvarchar(100)
AS
BEGIN
	DELETE FROM dbo.Stock WHERE [Name] = @Name;
END
