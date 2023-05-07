CREATE PROCEDURE [dbo].[spMember_GetAll]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Id ASC) AS Id, Firstname, Lastname, Email, Cellphone, StreetAddress, Suburb, City, MemberNumber
    FROM 
        dbo.Member WITH (NOLOCK)
    ORDER BY 
        Id ASC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
