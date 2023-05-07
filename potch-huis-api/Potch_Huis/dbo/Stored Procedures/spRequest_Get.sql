CREATE PROCEDURE [dbo].[spRequest_Get]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	SELECT * FROM dbo.Request WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber;
END
