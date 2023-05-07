CREATE PROCEDURE [dbo].[spRequest_Update]
    @RequestNumber NVARCHAR(100), 
    @MemberNumber NVARCHAR(50),
    @Value NVARCHAR(500),
    @Received NVARCHAR(500), 
    @Confirmed NVARCHAR(500),
    @Id INT
AS
BEGIN
	UPDATE dbo.Request SET 
    MemberNumber = @MemberNumber, 
    [Value] = @Value, 
    Received = @Received, 
    Confirmed = @Confirmed
    WHERE RequestNumber = @RequestNumber
END
