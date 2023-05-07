CREATE PROCEDURE [dbo].[spDonation_Get]
	@DonationNumber nvarchar(50)
AS
BEGIN
	SELECT * FROM dbo.Donation WITH(NOLOCK) 
	WHERE DonationNumber = @DonationNumber;
END
