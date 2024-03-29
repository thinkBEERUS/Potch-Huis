﻿/*
Deployment script for Potch_Huis

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Potch_Huis"
:setvar DefaultFilePrefix "Potch_Huis"
:setvar DefaultDataPath "C:\Users\Admin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Admin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key 09c9fba4-726c-4019-ba7c-69b5fafec294, 6ffe5398-959e-4c4e-b927-df0d4fd073b8, 44fab115-e1cb-404c-a51f-9321b5ec3d98 is skipped, element [dbo].[Request].[StockNumber] (SqlSimpleColumn) will not be renamed to ItemNumber';


GO
PRINT N'Rename refactoring operation with key 66d1fb0e-d07c-44a3-8ba2-041d5b514fda is skipped, element [dbo].[Request].[MemberNumber] (SqlSimpleColumn) will not be renamed to Quantity';


GO
PRINT N'Creating Table [dbo].[Request]...';


GO
CREATE TABLE [dbo].[Request] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [RequestNumber] NVARCHAR (MAX) NOT NULL,
    [MemberNumber]  NVARCHAR (50)  NOT NULL,
    [Value]         NVARCHAR (MAX) NOT NULL,
    [Received]      DATE           NOT NULL,
    [Confirmed]     DATE           NOT NULL,
    PRIMARY KEY CLUSTERED ([RequestNumber] ASC)
);


GO
PRINT N'Creating Table [dbo].[RequestedItems]...';


GO
CREATE TABLE [dbo].[RequestedItems] (
    [Id]            INT            NOT NULL,
    [Name]          NCHAR (10)     NOT NULL,
    [Quantity]      NCHAR (10)     NOT NULL,
    [Value]         NCHAR (10)     NOT NULL,
    [RequestNumber] NVARCHAR (MAX) NOT NULL,
    [StockNumber]   NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Stock]...';


GO
CREATE TABLE [dbo].[Stock] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (100) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    [Quantity]    NVARCHAR (MAX) NOT NULL,
    [Value]       NVARCHAR (50)  NOT NULL,
    [LastUpdated] DATETIME       NOT NULL,
    [Active]      BIT            NOT NULL,
    [StockNumber] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([StockNumber] ASC)
);


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock]
    ADD DEFAULT 0 FOR [Active];


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Request]...';


GO
ALTER TABLE [dbo].[Request] WITH NOCHECK
    ADD FOREIGN KEY ([MemberNumber]) REFERENCES [dbo].[Member] ([MemberNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[RequestedItems]...';


GO
ALTER TABLE [dbo].[RequestedItems] WITH NOCHECK
    ADD FOREIGN KEY ([RequestNumber]) REFERENCES [dbo].[Request] ([RequestNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[RequestedItems]...';


GO
ALTER TABLE [dbo].[RequestedItems] WITH NOCHECK
    ADD FOREIGN KEY ([StockNumber]) REFERENCES [dbo].[Stock] ([StockNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Donation]...';


GO
ALTER TABLE [dbo].[Donation] WITH NOCHECK
    ADD FOREIGN KEY ([MemberNumber]) REFERENCES [dbo].[Member] ([MemberNumber]);


GO
PRINT N'Creating Procedure [dbo].[spMember_Delete]...';


GO
CREATE PROCEDURE [dbo].[spMember_Delete]
	@MemberNumber nvarchar(50)
AS
BEGIN
	DELETE FROM dbo.Member WHERE MemberNumber = @MemberNumber;
	DELETE FROM dbo.[Password] WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spMember_Get]...';


GO
CREATE PROCEDURE [dbo].[spMember_Get]
	@MemberNumber nvarchar(50)
AS
BEGIN
	SELECT * FROM dbo.Member WITH(NOLOCK) 
	WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spMember_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spMember_GetAll]
AS
BEGIN
	SELECT * FROM dbo.Member WITH(NOLOCK);
END
GO
PRINT N'Creating Procedure [dbo].[spMember_Insert]...';


GO
CREATE PROCEDURE [dbo].[spMember_Insert]
    @Firstname NVARCHAR(50), 
    @Lastname NVARCHAR(50), 
    @Email NVARCHAR(50), 
    @Cellphone NVARCHAR(20), 
    @StreetAddress NVARCHAR(50), 
    @Suburb NVARCHAR(50), 
    @City NVARCHAR(50), 
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	INSERT INTO dbo.Member (Firstname, Lastname, Email, Cellphone, StreetAddress, Suburb, City, MemberNumber)
    VALUES (@Firstname, @Lastname, @Email, @Cellphone, @StreetAddress, @Suburb, @City, @MemberNumber)
END
GO
PRINT N'Creating Procedure [dbo].[spMember_Number]...';


GO
CREATE PROCEDURE [dbo].[spMember_Number]
AS
BEGIN
	SELECT TOP 1 MemberNumber FROM dbo.Member WITH(NOLOCK) ORDER BY Id DESC;
END
GO
PRINT N'Creating Procedure [dbo].[spMember_Update]...';


GO
CREATE PROCEDURE [dbo].[spMember_Update]
    @Firstname NVARCHAR(50), 
    @Lastname NVARCHAR(50), 
    @Email NVARCHAR(50), 
    @Cellphone NVARCHAR(20), 
    @StreetAddress NVARCHAR(50), 
    @Suburb NVARCHAR(50), 
    @City NVARCHAR(50), 
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.Member SET 
    Firstname = @Firstname, 
    Lastname = @Lastname, 
    Email = @Email, 
    Cellphone = @Cellphone, 
    StreetAddress = @StreetAddress, 
    Suburb = @Suburb, 
    City = @City
    WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spPassword_Get]...';


GO
CREATE PROCEDURE [dbo].[spPassword_Get]
	@MemberNumber nvarchar(50)
AS
BEGIN
	SELECT [Hash], Salt, MemberNumber FROM dbo.[Password] WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spPassword_Insert]...';


GO
CREATE PROCEDURE [dbo].[spPassword_Insert]
    @Salt varbinary(MAX), 
    @Hash NVARCHAR(MAX), 
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	INSERT INTO dbo.[Password] (Salt, [Hash], MemberNumber)
    VALUES (@Salt, @Hash, @MemberNumber)
END
GO
PRINT N'Creating Procedure [dbo].[spPassword_Update]...';


GO
CREATE PROCEDURE [dbo].[spPassword_Update]
    @Salt varbinary(MAX),
    @Hash VARCHAR(MAX),
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.[Password] SET 
    Salt = @Salt,
    [Hash] = @Hash
    WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spStock_Delete]...';


GO
CREATE PROCEDURE [dbo].[spStock_Delete]
    @StockNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.Stock WHERE StockNumber = @StockNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spStock_Get]...';


GO
CREATE PROCEDURE [dbo].[spStock_Get]
	@Name VARCHAR(MAX)
AS
BEGIN
	DECLARE @SearchString NVARCHAR(MAX) = (SELECT '%' + @Name + '%')
	SELECT * FROM dbo.Stock WITH(NOLOCK)
	WHERE [Name] LIKE @SearchString;
END
GO
PRINT N'Creating Procedure [dbo].[spStock_GetActive]...';


GO
CREATE PROCEDURE [dbo].[spStock_GetActive]
AS
BEGIN
	SELECT * FROM dbo.Stock WITH(NOLOCK)
	WHERE Active = 1;
END
GO
PRINT N'Creating Procedure [dbo].[spStock_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spStock_GetAll]
AS
BEGIN
	SELECT * FROM dbo.Stock WITH(NOLOCK);
END
GO
PRINT N'Creating Procedure [dbo].[spStock_Insert]...';


GO
CREATE PROCEDURE [dbo].[spStock_Insert]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(MAX), 
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(50), 
    @LastUpdated DateTime,
    @Active BIT,
    @StockNumber NVARCHAR(MAX)
AS
BEGIN
	INSERT INTO dbo.Stock([Name], [Description], Quantity, [Value], LastUpdated, Active, StockNumber)
    VALUES (@Name, @Description, @Quantity, @Value, @LastUpdated, @Active, @StockNumber);
END
GO
PRINT N'Creating Procedure [dbo].[spStock_Update]...';


GO
CREATE PROCEDURE [dbo].[spStock_Update]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(MAX), 
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(50), 
    @LastUpdated DateTime,
    @Active BIT,
    @StockNumber NVARCHAR(MAX)
AS
BEGIN
	UPDATE dbo.Stock SET 
    [Name] = @Name,
    [Description] = @Description,
    Quantity = @Quantity,
    [Value] = @Value,
    LastUpdated = GETDATE(),
    Active = @Active
    WHERE StockNumber = @StockNumber;
END
GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c7377572-7288-4c33-9fc1-465eb6140a2b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c7377572-7288-4c33-9fc1-465eb6140a2b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'cb084663-e349-4dd4-9493-df8d0b96341d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('cb084663-e349-4dd4-9493-df8d0b96341d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '09c9fba4-726c-4019-ba7c-69b5fafec294')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('09c9fba4-726c-4019-ba7c-69b5fafec294')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '66d1fb0e-d07c-44a3-8ba2-041d5b514fda')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('66d1fb0e-d07c-44a3-8ba2-041d5b514fda')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6ffe5398-959e-4c4e-b927-df0d4fd073b8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6ffe5398-959e-4c4e-b927-df0d4fd073b8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '44fab115-e1cb-404c-a51f-9321b5ec3d98')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('44fab115-e1cb-404c-a51f-9321b5ec3d98')

GO

GO
if not exists(select 1 from dbo.Member)
begin 
	insert into dbo.Member (Firstname, Lastname, Email, Cellphone, StreetAddress,Suburb, City, MemberNumber)
	values ('Austin', 'van der Merwe', 'aus.vd.merwe@gmail.com', '0796234424', '1 Ingonya Street', 'Baillie Park', 'Potchefstroom', 'PH00001ADM')
end
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Request'), OBJECT_ID(N'dbo.RequestedItems'), OBJECT_ID(N'dbo.Donation'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO
