CREATE PROCEDURE [dbo].[spDonation_Delete]
	@DonationNumber nvarchar(50)
AS
BEGIN
	DELETE FROM dbo.Donation WHERE DonationNumber = @DonationNumber;
END
