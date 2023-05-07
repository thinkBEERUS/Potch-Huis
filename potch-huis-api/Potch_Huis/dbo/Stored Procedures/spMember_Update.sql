CREATE PROCEDURE [dbo].[spMember_Update]
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
	UPDATE dbo.Member SET 
    Firstname = @Firstname, 
    Lastname = @Lastname, 
    Email = @Email, 
    Cellphone = @Cellphone, 
    StreetAddress = @StreetAddress, 
    Suburb = @Suburb, 
    City = @City
    WHERE MemberNumber = @MemberNumber;
END
