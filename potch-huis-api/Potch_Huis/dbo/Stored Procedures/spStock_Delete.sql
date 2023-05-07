CREATE PROCEDURE [dbo].[spStock_Delete]
    @StockNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.Stock WHERE StockNumber = @StockNumber;
END
