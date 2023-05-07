CREATE PROCEDURE [dbo].[spDonation_Insert]
    @Type NVARCHAR(MAX),
    @Amount NVARCHAR(MAX),
    @DonationNumber NVARCHAR(MAX),
    @Received NVARCHAR(MAX),
    @MemberNumber NVARCHAR(50),
    @ConfirmedBy NVARCHAR(MAX),
    @Confirmed NVARCHAR(MAX),
    @Id INT = 0
AS
BEGIN
	INSERT INTO dbo.Donation (Type, Amount, DonationNumber, Received, MemberNumber, ConfirmedBy, Confirmed)
    VALUES (@Type, @Amount, @DonationNumber, @Received, @MemberNumber, @ConfirmedBy, @Confirmed);
END
