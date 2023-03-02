CREATE PROCEDURE [dbo].[spPassword_Update]
    @Salt varbinary(MAX),
    @Hash VARCHAR(MAX),
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.[Password] SET 
    Salt = @Salt,
    [Hash] = @Hash
    WHERE MemberNumber = @MemberNumber;
END
