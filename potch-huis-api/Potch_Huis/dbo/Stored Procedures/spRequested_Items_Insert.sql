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
	INSERT INTO dbo.RequestedItems ([Name], Quantity, [Value], RequestNumber, StockNumber, RequestedItemNumber, ActualQuantity)
    VALUES (@Name, @Quantity, @Value, @RequestNumber, @StockNumber, @RequestedItemNumber, @ActualQuantity)
END
