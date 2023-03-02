CREATE PROCEDURE [dbo].[spStock_Update]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(MAX), 
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(50), 
    @LastUpdated DateTime,
    @Active BIT
AS
BEGIN
	UPDATE dbo.Stock SET 
    [Name] = @Name,
    [Description] = @Description,
    Quantity = @Quantity,
    [Value] = @Value,
    LastUpdated = GETDATE(),
    Active = @Active
    WHERE [Name] = @Name;
END
