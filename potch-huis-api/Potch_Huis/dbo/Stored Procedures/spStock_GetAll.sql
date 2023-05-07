CREATE PROCEDURE [dbo].[spStock_GetAll]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        ROW_NUMBER() OVER (ORDER BY LastUpdated DESC) AS Id, 
        Name, 
        Description, 
        Quantity, 
        Value, 
        LastUpdated, 
        Active, 
        StockNumber
    FROM 
        dbo.Stock WITH (NOLOCK)
    ORDER BY 
        LastUpdated DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
