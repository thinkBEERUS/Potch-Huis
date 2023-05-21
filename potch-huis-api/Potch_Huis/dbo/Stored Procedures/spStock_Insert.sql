CREATE PROCEDURE [dbo].[spStock_Insert]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(MAX), 
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(50), 
    @LastUpdated NVARCHAR(MAX),
    @Active BIT,
    @StockNumber NVARCHAR(MAX),
    @Id int
AS
BEGIN
SELECT @StockNumber = COUNT(*) + 1 FROM dbo.Stock;
	INSERT INTO dbo.Stock([Name], [Description], Quantity, [Value], LastUpdated, Active, StockNumber)
    VALUES (@Name, @Description, @Quantity, @Value, @LastUpdated, @Active, CONCAT('S_', @StockNumber));
END
