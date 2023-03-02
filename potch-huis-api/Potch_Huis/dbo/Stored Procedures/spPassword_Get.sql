CREATE PROCEDURE [dbo].[spPassword_Get]
	@MemberNumber nvarchar(50)
AS
BEGIN
	SELECT [Hash], Salt, MemberNumber FROM dbo.[Password] WHERE MemberNumber = @MemberNumber;
END
