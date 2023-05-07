CREATE PROCEDURE [dbo].[spMember_Insert]
    @Firstname NVARCHAR(50), 
    @Lastname NVARCHAR(50), 
    @Email NVARCHAR(50), 
    @Cellphone NVARCHAR(20), 
    @StreetAddress NVARCHAR(50), 
    @Suburb NVARCHAR(50), 
    @City NVARCHAR(50), 
    @MemberNumber NVARCHAR(50),
    @Id int
AS
BEGIN
	INSERT INTO dbo.Member (Firstname, Lastname, Email, Cellphone, StreetAddress, Suburb, City, MemberNumber)
    VALUES (@Firstname, @Lastname, @Email, @Cellphone, @StreetAddress, @Suburb, @City, @MemberNumber)
END
