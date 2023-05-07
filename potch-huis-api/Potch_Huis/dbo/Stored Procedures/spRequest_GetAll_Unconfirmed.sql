CREATE PROCEDURE [dbo].[spRequest_GetAll_Unconfirmed]
	@PageNumber INT,
	@PageSize INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ROW_NUMBER() OVER (ORDER BY Confirmed DESC) AS Id, RequestNumber, MemberNumber, Value, CONVERT(varchar(10), Received, 103) AS Received, CONVERT(varchar(10), Confirmed, 103) AS Confirmed
	FROM dbo.Request WITH (NOLOCK)
	WHERE 
        Confirmed = '01/01/2000' 
	ORDER BY Confirmed DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END
