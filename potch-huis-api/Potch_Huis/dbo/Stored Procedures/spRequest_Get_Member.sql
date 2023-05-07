CREATE PROCEDURE [dbo].[spRequest_Get_Member]
	@MemberNumber nvarchar(50),
	@PageNumber INT,
	@Pagesize INT
AS
BEGIN
	SELECT 
		ROW_NUMBER() OVER (ORDER BY Id DESC) AS Id, RequestNumber, [Value], Received, Confirmed
	FROM 
		dbo.Request WITH (NOLOCK)
	WHERE 
		MemberNumber = @MemberNumber
	ORDER BY 
		Id DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END


