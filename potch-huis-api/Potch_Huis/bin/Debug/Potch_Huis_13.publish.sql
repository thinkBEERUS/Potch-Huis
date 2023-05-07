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
PRINT N'Rename refactoring operation with key 09c9fba4-726c-4019-ba7c-69b5fafec294 is skipped, element [dbo].[Request].[StockNumber] (SqlSimpleColumn) will not be renamed to Items';


GO
PRINT N'Rename refactoring operation with key 66d1fb0e-d07c-44a3-8ba2-041d5b514fda is skipped, element [dbo].[Request].[MemberNumber] (SqlSimpleColumn) will not be renamed to Quantity';


GO
PRINT N'Starting rebuilding table [dbo].[Stock]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Stock] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (100) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    [Quantity]    NVARCHAR (MAX) NOT NULL,
    [Value]       NVARCHAR (50)  NOT NULL,
    [LastUpdated] DATETIME       NOT NULL,
    [Active]      BIT            DEFAULT 0 NOT NULL,
    [StockNumber] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([StockNumber] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Stock])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Stock] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Stock] ([StockNumber], [Id], [Name], [Description], [Quantity], [Value], [LastUpdated], [Active])
        SELECT   [StockNumber],
                 [Id],
                 [Name],
                 [Description],
                 [Quantity],
                 [Value],
                 [LastUpdated],
                 [Active]
        FROM     [dbo].[Stock]
        ORDER BY [StockNumber] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Stock] OFF;
    END

DROP TABLE [dbo].[Stock];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Stock]', N'Stock';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Member]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Member] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [Firstname]     NVARCHAR (50) NOT NULL,
    [Lastname]      NVARCHAR (50) NOT NULL,
    [Email]         NVARCHAR (50) NOT NULL,
    [Cellphone]     NVARCHAR (20) NOT NULL,
    [StreetAddress] NVARCHAR (50) NOT NULL,
    [Suburb]        NVARCHAR (50) NOT NULL,
    [City]          NVARCHAR (50) NOT NULL,
    [MemberNumber]  NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([MemberNumber] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Member])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Member] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Member] ([MemberNumber], [Id], [Firstname], [Lastname], [Email], [Cellphone], [StreetAddress], [Suburb], [City])
        SELECT   [MemberNumber],
                 [Id],
                 [Firstname],
                 [Lastname],
                 [Email],
                 [Cellphone],
                 [StreetAddress],
                 [Suburb],
                 [City]
        FROM     [dbo].[Member]
        ORDER BY [MemberNumber] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Member] OFF;
    END

DROP TABLE [dbo].[Member];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Member]', N'Member';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating Table [dbo].[Donation]...';


GO
CREATE TABLE [dbo].[Donation] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Type]         NVARCHAR (MAX) NOT NULL,
    [Amount]       NVARCHAR (MAX) NOT NULL,
    [Description]  NVARCHAR (MAX) NOT NULL,
    [Received]     DATE           NOT NULL,
    [Confirmed]    DATE           NOT NULL,
    [Purpose]      NVARCHAR (MAX) NOT NULL,
    [MemberNumber] NVARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Request]...';


GO
CREATE TABLE [dbo].[Request] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Items]        NVARCHAR (MAX) NOT NULL,
    [Quantity]     NVARCHAR (MAX) NOT NULL,
    [Value]        NVARCHAR (MAX) NOT NULL,
    [StockNumber]  NVARCHAR (MAX) NOT NULL,
    [MemberNumber] NVARCHAR (50)  NOT NULL,
    [Received]     DATE           NOT NULL,
    [Confirmed]    DATE           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Donation]...';


GO
ALTER TABLE [dbo].[Donation] WITH NOCHECK
    ADD FOREIGN KEY ([MemberNumber]) REFERENCES [dbo].[Member] ([MemberNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Request]...';


GO
ALTER TABLE [dbo].[Request] WITH NOCHECK
    ADD FOREIGN KEY ([StockNumber]) REFERENCES [dbo].[Stock] ([StockNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Request]...';


GO
ALTER TABLE [dbo].[Request] WITH NOCHECK
    ADD FOREIGN KEY ([MemberNumber]) REFERENCES [dbo].[Member] ([MemberNumber]);


GO
PRINT N'Refreshing Procedure [dbo].[spStock_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spStock_Delete]';


GO
PRINT N'Refreshing Procedure [dbo].[spStock_Get]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spStock_Get]';


GO
PRINT N'Refreshing Procedure [dbo].[spStock_GetActive]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spStock_GetActive]';


GO
PRINT N'Refreshing Procedure [dbo].[spStock_GetAll]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spStock_GetAll]';


GO
PRINT N'Refreshing Procedure [dbo].[spStock_Insert]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spStock_Insert]';


GO
PRINT N'Refreshing Procedure [dbo].[spStock_Update]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spStock_Update]';


GO
PRINT N'Refreshing Procedure [dbo].[spMember_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spMember_Delete]';


GO
PRINT N'Refreshing Procedure [dbo].[spMember_Get]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spMember_Get]';


GO
PRINT N'Refreshing Procedure [dbo].[spMember_GetAll]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spMember_GetAll]';


GO
PRINT N'Refreshing Procedure [dbo].[spMember_Insert]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spMember_Insert]';


GO
PRINT N'Refreshing Procedure [dbo].[spMember_Number]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spMember_Number]';


GO
PRINT N'Refreshing Procedure [dbo].[spMember_Update]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spMember_Update]';


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '09c9fba4-726c-4019-ba7c-69b5fafec294')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('09c9fba4-726c-4019-ba7c-69b5fafec294')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '66d1fb0e-d07c-44a3-8ba2-041d5b514fda')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('66d1fb0e-d07c-44a3-8ba2-041d5b514fda')

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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Donation'), OBJECT_ID(N'dbo.Request'))
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
