CREATE PROCEDURE [dbo].[spReport_Monthly_Requests]
    @ItemName NVARCHAR(500),
    @MonthsToInclude INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        YEAR(r.Confirmed) AS Year,
        MONTH(r.Confirmed) AS Month,
        ri.[Name],
        COUNT(*) AS RequestCount
    FROM 
        dbo.Request r
        JOIN RequestedItems ri ON r.RequestNumber = ri.RequestNumber
    WHERE 
        ri.[Name] = @ItemName
        AND (
            @MonthsToInclude IS NULL 
            OR r.Confirmed >= DATEADD(month, -@MonthsToInclude, GETDATE())
        )
    GROUP BY 
        YEAR(r.Confirmed), 
        MONTH(r.Confirmed), 
        ri.[Name]
    ORDER BY 
        YEAR(r.Confirmed) ASC, 
        MONTH(r.Confirmed) ASC;
END
