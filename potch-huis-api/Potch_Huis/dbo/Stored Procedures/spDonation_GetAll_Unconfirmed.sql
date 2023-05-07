CREATE PROCEDURE [dbo].[spDonation_GetAll_Unconfirmed]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Received ASC) AS Id, [Type], Amount, MemberNumber, DonationNumber, CONVERT(varchar(10), Received, 103) AS Received, CONVERT(varchar(10), Confirmed, 103) AS Confirmed, ConfirmedBy
    FROM 
        dbo.Donation WITH (NOLOCK)
    WHERE 
        Confirmed = '01/01/2000'
    ORDER BY 
        Confirmed ASC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

END

