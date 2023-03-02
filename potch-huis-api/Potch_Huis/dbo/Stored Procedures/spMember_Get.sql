CREATE PROCEDURE [dbo].[spMember_Get]
	@MemberNumber nvarchar(50)
AS
BEGIN
	SELECT * FROM dbo.Member WITH(NOLOCK) 
	WHERE MemberNumber = @MemberNumber;
END
