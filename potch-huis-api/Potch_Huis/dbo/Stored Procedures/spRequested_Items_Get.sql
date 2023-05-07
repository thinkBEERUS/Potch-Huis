CREATE PROCEDURE [dbo].[spRequested_Items_Get]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber;
END
