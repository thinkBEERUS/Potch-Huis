CREATE PROCEDURE [dbo].[spRequest_Insert]
    @RequestNumber NVARCHAR(100) OUTPUT, 
    @MemberNumber NVARCHAR(50),
    @Value NVARCHAR(500),
    @Received NVARCHAR(500), 
    @Confirmed NVARCHAR(500)
AS
BEGIN
    SELECT @RequestNumber = COUNT(*) + 1 FROM dbo.Request;
    INSERT INTO dbo.Request(RequestNumber, MemberNumber, [Value], Received, Confirmed)
    VALUES (CONCAT('R_', @RequestNumber), @MemberNumber, @Value, @Received, @Confirmed)
END
