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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
PRINT N'Creating Table [dbo].[Member]...';


GO
CREATE TABLE [dbo].[Member] (
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


GO
PRINT N'Creating Table [dbo].[Password]...';


GO
CREATE TABLE [dbo].[Password] (
    [Id]           INT             IDENTITY (1, 1) NOT NULL,
    [Salt]         VARBINARY (MAX) NOT NULL,
    [Hash]         NVARCHAR (MAX)  NOT NULL,
    [MemberNumber] NVARCHAR (50)   NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


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
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Donation]...';


GO
ALTER TABLE [dbo].[Donation]
    ADD FOREIGN KEY ([MemberNumber]) REFERENCES [dbo].[Member] ([MemberNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Request]...';


GO
ALTER TABLE [dbo].[Request]
    ADD FOREIGN KEY ([MemberNumber]) REFERENCES [dbo].[Member] ([MemberNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[RequestedItems]...';


GO
ALTER TABLE [dbo].[RequestedItems]
    ADD FOREIGN KEY ([RequestNumber]) REFERENCES [dbo].[Request] ([RequestNumber]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[RequestedItems]...';


GO
ALTER TABLE [dbo].[RequestedItems]
    ADD FOREIGN KEY ([StockNumber]) REFERENCES [dbo].[Stock] ([StockNumber]);


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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
