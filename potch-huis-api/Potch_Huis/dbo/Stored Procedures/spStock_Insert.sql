CREATE PROCEDURE [dbo].[spStock_Insert]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(MAX), 
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(50), 
    @LastUpdated DateTime,
    @Active BIT,
    @StockNumber NVARCHAR(MAX),
    @Id int
AS
BEGIN
	INSERT INTO dbo.Stock([Name], [Description], Quantity, [Value], LastUpdated, Active, StockNumber)
    VALUES (@Name, @Description, @Quantity, @Value, @LastUpdated, @Active, @StockNumber);
END
