CREATE PROCEDURE [dbo].[spRequested_Items_Delete]
	@RequestNumber NVARCHAR(MAX),
	@RequestedItemNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.RequestedItems 
	WHERE RequestNumber = @RequestNumber
	AND RequestedItemNumber = @RequestedItemNumber;
END
