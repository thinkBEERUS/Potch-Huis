CREATE PROCEDURE [dbo].[spRequest_GetAll]
	@PageNumber INT,
	@PageSize INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ROW_NUMBER() OVER (ORDER BY Received DESC) AS Id, RequestNumber, MemberNumber, [Value], Received, Confirmed
	FROM dbo.Request WITH (NOLOCK)
	WHERE 
        Confirmed != '01/01/2000'
	ORDER BY Received DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END