﻿CREATE PROCEDURE [dbo].[spGlobal_GetAll_Rows]
  @DBname NVARCHAR(100)
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @SQL NVARCHAR(MAX);
  SET @SQL = N'SELECT COUNT(*) AS TotalRows FROM ' + QUOTENAME(@DBname);

  EXEC dbo.sp_executesql @SQL;
END