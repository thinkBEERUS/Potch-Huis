CREATE PROCEDURE [dbo].[spDonation_Insert]
@Type NVARCHAR(MAX),
@Amount NVARCHAR(MAX),
@Received NVARCHAR(MAX),
@MemberNumber NVARCHAR(50),
@ConfirmedBy NVARCHAR(MAX),
@Confirmed NVARCHAR(MAX),
@DonationNumber INT,
@Id INT = 0
AS
BEGIN
SELECT @DonationNumber = COUNT(*) + 1 FROM dbo.Donation;
	INSERT INTO dbo.Donation (Type, Amount, DonationNumber, Received, MemberNumber, ConfirmedBy, Confirmed)
    VALUES (@Type, @Amount, CONCAT('D_', @DonationNumber), @Received, @MemberNumber, @ConfirmedBy, @Confirmed);
END
