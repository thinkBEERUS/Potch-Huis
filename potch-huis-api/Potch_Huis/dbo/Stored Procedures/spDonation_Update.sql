CREATE PROCEDURE [dbo].[spDonation_Update]
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
    UPDATE dbo.Donation
    SET [Type] = @Type, Amount = @Amount, Received = @Received,
        MemberNumber = @MemberNumber, ConfirmedBy = @ConfirmedBy, Confirmed = @Confirmed
    WHERE DonationNumber = @DonationNumber
END
