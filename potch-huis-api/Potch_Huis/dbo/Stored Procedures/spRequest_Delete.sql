CREATE PROCEDURE [dbo].[spRequest_Delete]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.Request WHERE RequestNumber = @RequestNumber;
END
