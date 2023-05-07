CREATE PROCEDURE [dbo].[spDonation_Get_Member]
	@MemberNumber nvarchar(50),
	@PageNumber INT,
	@Pagesize INT
AS
BEGIN
	SELECT 
		ROW_NUMBER() OVER (ORDER BY Id DESC) AS Id, [Type], Amount, Received, ConfirmedBy, MemberNumber, DonationNumber, Confirmed
	FROM 
		dbo.Donation WITH (NOLOCK)
	WHERE 
		MemberNumber = @MemberNumber
	ORDER BY 
		Id DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END

