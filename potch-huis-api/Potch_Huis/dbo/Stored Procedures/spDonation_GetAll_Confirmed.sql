CREATE PROCEDURE [dbo].[spDonation_GetAll_Confirmed]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Confirmed DESC) AS Id, [Type], Amount, MemberNumber, DonationNumber, Received, Confirmed, ConfirmedBy
    FROM 
        dbo.Donation WITH (NOLOCK)
    WHERE 
        Confirmed != '01/01/2000'
    ORDER BY 
        Confirmed DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

END
