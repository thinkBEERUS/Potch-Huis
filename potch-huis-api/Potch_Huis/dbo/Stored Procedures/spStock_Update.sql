CREATE PROCEDURE [dbo].[spStock_Update]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(MAX), 
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(50), 
    @LastUpdated NVARCHAR(MAX),
    @Active BIT,
    @StockNumber NVARCHAR(MAX),
    @Id INT
AS
BEGIN
	UPDATE dbo.Stock SET 
    [Name] = @Name,
    [Description] = @Description,
    Quantity = @Quantity,
    [Value] = @Value,
    LastUpdated = GETDATE(),
    Active = @Active
    WHERE StockNumber = @StockNumber;
END
