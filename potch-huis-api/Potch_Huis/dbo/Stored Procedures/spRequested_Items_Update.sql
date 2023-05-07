CREATE PROCEDURE [dbo].[spRequested_Items_Update]
    @Name NVARCHAR(500),
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(MAX),    
    @RequestNumber NVARCHAR(100), 
    @StockNumber NVARCHAR(50),
    @RequestedItemNumber NVARCHAR(MAX),
    @ActualQuantity NVARCHAR(MAX),
    @Id INT
AS
BEGIN
	UPDATE dbo.RequestedItems SET 
    Quantity = @Quantity,
    [Value] = @Value,
    [Name] = @Name, 
    StockNumber = @StockNumber,
    ActualQuantity = @ActualQuantity
    WHERE RequestNumber = @RequestNumber 
    AND RequestedItemNumber = @RequestedItemNumber    
END
