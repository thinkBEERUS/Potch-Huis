CREATE PROCEDURE [dbo].[spMember_Delete]
	@MemberNumber nvarchar(50)
AS
BEGIN
	DELETE FROM dbo.Member WHERE MemberNumber = @MemberNumber;
	DELETE FROM dbo.[Password] WHERE MemberNumber = @MemberNumber;
END
