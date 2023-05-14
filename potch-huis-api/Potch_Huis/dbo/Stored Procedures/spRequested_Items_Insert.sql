CREATE PROCEDURE [dbo].[spRequested_Items_Insert]
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
SELECT @RequestedItemNumber = COUNT(*) + 1 FROM dbo.RequestedItems WHERE RequestNumber = @RequestNumber;
	INSERT INTO dbo.RequestedItems ([Name], Quantity, [Value], RequestNumber, StockNumber, RequestedItemNumber, ActualQuantity)
    VALUES (@Name, @Quantity, @Value, @RequestNumber, @StockNumber, CONCAT('RI_', @RequestedItemNumber), @ActualQuantity)
END
