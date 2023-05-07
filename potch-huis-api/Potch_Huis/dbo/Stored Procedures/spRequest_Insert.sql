CREATE PROCEDURE [dbo].[spRequest_Insert]
    @RequestNumber NVARCHAR(100), 
    @MemberNumber NVARCHAR(50),
    @Value NVARCHAR(500),
    @Received NVARCHAR(500), 
    @Confirmed NVARCHAR(500),
    @Id INT
AS
BEGIN
	INSERT INTO dbo.Request(RequestNumber, MemberNumber, [Value], Received, Confirmed)
    VALUES (@RequestNumber, @MemberNumber, @Value, @Received, @Confirmed)
END
