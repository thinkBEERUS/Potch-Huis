CREATE PROCEDURE [dbo].[spRequested_Item_Get]
	@RequestNumber NVARCHAR(MAX),
	@RequestedItem VARCHAR(MAX)
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber
	AND RequestedItemNumber = @RequestedItem;
END

