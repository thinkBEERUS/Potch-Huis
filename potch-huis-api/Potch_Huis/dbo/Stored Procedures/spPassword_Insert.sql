CREATE PROCEDURE [dbo].[spPassword_Insert]
    @Salt varbinary(MAX), 
    @Hash NVARCHAR(MAX), 
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	INSERT INTO dbo.[Password] (Salt, [Hash], MemberNumber)
    VALUES (@Salt, @Hash, @MemberNumber)
END
