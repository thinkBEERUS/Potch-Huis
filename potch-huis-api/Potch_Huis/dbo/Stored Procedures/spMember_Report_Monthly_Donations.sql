CREATE PROCEDURE [dbo].[spMember_Report_Monthly_Donations]
    @MemberNumber varchar(50),
    @Year varchar(4) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Count(*) AS [DonationCount], Month(Confirmed) AS [Month], Year(Confirmed) AS [Year]
    FROM ConfirmedDonations
    WHERE MemberNumber = @MemberNumber AND (@Year IS NULL or Year(Confirmed) = @Year)
    GROUP BY Year(Confirmed), Month(Confirmed);
END