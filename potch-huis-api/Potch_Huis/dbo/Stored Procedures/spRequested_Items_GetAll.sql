CREATE PROCEDURE [dbo].[spRequested_Items_GetAll]
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK);
END
