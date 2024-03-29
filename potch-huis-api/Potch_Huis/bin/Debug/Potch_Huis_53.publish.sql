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
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [Type]           NVARCHAR (MAX) NOT NULL,
    [Amount]         NVARCHAR (MAX) NOT NULL,
    [DonationNumber] NVARCHAR (MAX) NOT NULL,
    [Received]       NVARCHAR (MAX) NOT NULL,
    [MemberNumber]   NVARCHAR (50)  NOT NULL,
    [ConfirmedBy]    NVARCHAR (MAX) NOT NULL,
    [Confirmed]      NVARCHAR (MAX) NOT NULL,
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
    PRIMARY KEY CLUSTERED ([Id] ASC)
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
    [Received]      NVARCHAR (MAX) NOT NULL,
    [Confirmed]     NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[RequestedItems]...';


GO
CREATE TABLE [dbo].[RequestedItems] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [Name]                NVARCHAR (100) NOT NULL,
    [Quantity]            NVARCHAR (100) NOT NULL,
    [Value]               NVARCHAR (100) NOT NULL,
    [RequestNumber]       NVARCHAR (MAX) NOT NULL,
    [StockNumber]         NVARCHAR (MAX) NOT NULL,
    [RequestedItemNumber] NVARCHAR (MAX) NOT NULL,
    [ActualQuantity]      NVARCHAR (MAX) NOT NULL,
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
    [LastUpdated] NVARCHAR (20)  NOT NULL,
    [Active]      BIT            NOT NULL,
    [StockNumber] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Procedure [dbo].[spDonation_Delete]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Delete]
	@DonationNumber nvarchar(50)
AS
BEGIN
	DELETE FROM dbo.Donation WHERE DonationNumber = @DonationNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Get]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Get]
	@DonationNumber nvarchar(50)
AS
BEGIN
	SELECT * FROM dbo.Donation WITH(NOLOCK) 
	WHERE DonationNumber = @DonationNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Get_Member]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Get_Member]
	@MemberNumber nvarchar(50),
	@PageNumber INT,
	@Pagesize INT
AS
BEGIN
	SELECT 
		ROW_NUMBER() OVER (ORDER BY Id DESC) AS Id, [Type], Amount, Received, ConfirmedBy, MemberNumber, DonationNumber, Confirmed
	FROM 
		dbo.Donation WITH (NOLOCK)
	WHERE 
		MemberNumber = @MemberNumber
	ORDER BY 
		Id DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_GetAll_Confirmed]...';


GO
CREATE PROCEDURE [dbo].[spDonation_GetAll_Confirmed]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Confirmed DESC) AS Id, [Type], Amount, MemberNumber, DonationNumber, Received, Confirmed, ConfirmedBy
    FROM 
        dbo.Donation WITH (NOLOCK)
    WHERE 
        Confirmed != '01/01/2000'
    ORDER BY 
        Confirmed DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

END
GO
PRINT N'Creating Procedure [dbo].[spDonation_GetAll_Unconfirmed]...';


GO
CREATE PROCEDURE [dbo].[spDonation_GetAll_Unconfirmed]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Received ASC) AS Id, [Type], Amount, MemberNumber, DonationNumber, CONVERT(varchar(10), Received, 103) AS Received, CONVERT(varchar(10), Confirmed, 103) AS Confirmed, ConfirmedBy
    FROM 
        dbo.Donation WITH (NOLOCK)
    WHERE 
        Confirmed = '01/01/2000'
    ORDER BY 
        Confirmed ASC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Insert]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Insert]
@Type NVARCHAR(MAX),
@Amount NVARCHAR(MAX),
@Received NVARCHAR(MAX),
@MemberNumber NVARCHAR(50),
@ConfirmedBy NVARCHAR(MAX),
@Confirmed NVARCHAR(MAX),
@DonationNumber INT,
@Id INT = 0
AS
BEGIN
SELECT @DonationNumber = COUNT(*) + 1 FROM dbo.Donation;
	INSERT INTO dbo.Donation (Type, Amount, DonationNumber, Received, MemberNumber, ConfirmedBy, Confirmed)
    VALUES (@Type, @Amount, CONCAT('D_', @DonationNumber), @Received, @MemberNumber, @ConfirmedBy, @Confirmed);
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Update]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Update]
    @Type NVARCHAR(MAX),
    @Amount NVARCHAR(MAX),
    @DonationNumber NVARCHAR(MAX),
    @Received NVARCHAR(MAX),
    @MemberNumber NVARCHAR(50),
    @ConfirmedBy NVARCHAR(MAX),
    @Confirmed NVARCHAR(MAX),
    @Id INT = 0
AS
BEGIN
    UPDATE dbo.Donation
    SET [Type] = @Type, Amount = @Amount, Received = @Received,
        MemberNumber = @MemberNumber, ConfirmedBy = @ConfirmedBy, Confirmed = @Confirmed
    WHERE DonationNumber = @DonationNumber
END
GO
PRINT N'Creating Procedure [dbo].[spGlobal_GetAll_Rows]...';


GO
CREATE PROCEDURE [dbo].[spGlobal_GetAll_Rows]
  @DBname NVARCHAR(100)
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @SQL NVARCHAR(MAX);
  SET @SQL = N'SELECT COUNT(*) AS TotalRows FROM ' + QUOTENAME(@DBname);

  EXEC dbo.sp_executesql @SQL;
END
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
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Id ASC) AS Id, Firstname, Lastname, Email, Cellphone, StreetAddress, Suburb, City, MemberNumber
    FROM 
        dbo.Member WITH (NOLOCK)
    ORDER BY 
        Id ASC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
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
    @MemberNumber NVARCHAR(50),
    @Id int
AS
BEGIN
SELECT @MemberNumber = COUNT(*) + 1 FROM dbo.Member;
	INSERT INTO dbo.Member (Firstname, Lastname, Email, Cellphone, StreetAddress, Suburb, City, MemberNumber)
    VALUES (@Firstname, @Lastname, @Email, @Cellphone, @StreetAddress, @Suburb, @City, Concat('PH', @MemberNumber))
END
GO
PRINT N'Creating Procedure [dbo].[spMember_Number]...';


GO
CREATE PROCEDURE [dbo].[spMember_Number]
AS
BEGIN
	SELECT TOP 1 Id FROM dbo.Member WITH(NOLOCK) ORDER BY Id DESC;
END
GO
PRINT N'Creating Procedure [dbo].[spMember_Report_Monthly_Donations]...';


GO
CREATE PROCEDURE [dbo].[spMember_Report_Monthly_Donations]
    @MemberNumber varchar(50),
    @Year varchar(4) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Count(*) AS [DonationCount], Month(Confirmed) AS [Month], Year(Confirmed) AS [Year]
    FROM ConfirmedDonations
    WHERE MemberNumber = @MemberNumber AND (@Year IS NULL or Year(Confirmed) = @Year)
    GROUP BY Year(Confirmed), Month(Confirmed);
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
    @MemberNumber NVARCHAR(50),
    @Id int
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
PRINT N'Creating Procedure [dbo].[spReport_Monthly_Requests]...';


GO
CREATE PROCEDURE [dbo].[spReport_Monthly_Requests]
    @ItemName NVARCHAR(500),
    @MonthsToInclude INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        YEAR(r.Confirmed) AS Year,
        MONTH(r.Confirmed) AS Month,
        ri.[Name],
        COUNT(*) AS RequestCount
    FROM 
        dbo.Request r
        JOIN RequestedItems ri ON r.RequestNumber = ri.RequestNumber
    WHERE 
        ri.[Name] = @ItemName
        AND (
            @MonthsToInclude IS NULL 
            OR r.Confirmed >= DATEADD(month, -@MonthsToInclude, GETDATE())
        )
    GROUP BY 
        YEAR(r.Confirmed), 
        MONTH(r.Confirmed), 
        ri.[Name]
    ORDER BY 
        YEAR(r.Confirmed) ASC, 
        MONTH(r.Confirmed) ASC;
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Delete]...';


GO
CREATE PROCEDURE [dbo].[spRequest_Delete]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.Request WHERE RequestNumber = @RequestNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Get]...';


GO
CREATE PROCEDURE [dbo].[spRequest_Get]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	SELECT * FROM dbo.Request WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Get_Member]...';


GO
CREATE PROCEDURE [dbo].[spRequest_Get_Member]
	@MemberNumber nvarchar(50),
	@PageNumber INT,
	@Pagesize INT
AS
BEGIN
	SELECT 
		ROW_NUMBER() OVER (ORDER BY Id DESC) AS Id, RequestNumber, [Value], Received, Confirmed
	FROM 
		dbo.Request WITH (NOLOCK)
	WHERE 
		MemberNumber = @MemberNumber
	ORDER BY 
		Id DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spRequest_GetAll]
	@PageNumber INT,
	@PageSize INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ROW_NUMBER() OVER (ORDER BY Received DESC) AS Id, RequestNumber, MemberNumber, [Value], Received, Confirmed
	FROM dbo.Request WITH (NOLOCK)
	WHERE 
        Confirmed != '01/01/2000'
	ORDER BY Received DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_GetAll_Unconfirmed]...';


GO
CREATE PROCEDURE [dbo].[spRequest_GetAll_Unconfirmed]
	@PageNumber INT,
	@PageSize INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ROW_NUMBER() OVER (ORDER BY Confirmed DESC) AS Id, RequestNumber, MemberNumber, Value, CONVERT(varchar(10), Received, 103) AS Received, CONVERT(varchar(10), Confirmed, 103) AS Confirmed
	FROM dbo.Request WITH (NOLOCK)
	WHERE 
        Confirmed = '01/01/2000' 
	ORDER BY Confirmed DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Insert]...';


GO
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
GO
PRINT N'Creating Procedure [dbo].[spRequest_Update]...';


GO
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
GO
PRINT N'Creating Procedure [dbo].[spRequested_Item_Get]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Item_Get]
	@RequestNumber NVARCHAR(MAX),
	@RequestedItem VARCHAR(MAX)
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber
	AND RequestedItemNumber = @RequestedItem;
END
GO
PRINT N'Creating Procedure [dbo].[spRequested_Items_Delete]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Delete]
	@RequestNumber NVARCHAR(MAX),
	@RequestedItemNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.RequestedItems 
	WHERE RequestNumber = @RequestNumber
	AND RequestedItemNumber = @RequestedItemNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spRequested_Items_Get]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Get]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spRequested_Items_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_GetAll]
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK);
END
GO
PRINT N'Creating Procedure [dbo].[spRequested_Items_Insert]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Insert]
    @Name NVARCHAR(500),
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(MAX),    
    @RequestNumber NVARCHAR(100), 
    @StockNumber NVARCHAR(50),
    @RequestedItemNumber NVARCHAR(MAX),
    @ActualQuantity NVARCHAR(MAX),
    @Id INT
AS
BEGIN
SELECT @RequestedItemNumber = COUNT(*) + 1 FROM dbo.RequestedItems WHERE RequestNumber = @RequestNumber;
	INSERT INTO dbo.RequestedItems ([Name], Quantity, [Value], RequestNumber, StockNumber, RequestedItemNumber, ActualQuantity)
    VALUES (@Name, @Quantity, @Value, @RequestNumber, @StockNumber, CONCAT('RI_', @RequestedItemNumber), @ActualQuantity)
END
GO
PRINT N'Creating Procedure [dbo].[spRequested_Items_Update]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Update]
    @Name NVARCHAR(500),
    @Quantity NVARCHAR(MAX), 
    @Value NVARCHAR(MAX),    
    @RequestNumber NVARCHAR(100), 
    @StockNumber NVARCHAR(50),
    @RequestedItemNumber NVARCHAR(MAX),
    @ActualQuantity NVARCHAR(MAX),
    @Id INT
AS
BEGIN
	UPDATE dbo.RequestedItems SET 
    Quantity = @Quantity,
    [Value] = @Value,
    [Name] = @Name, 
    StockNumber = @StockNumber,
    ActualQuantity = @ActualQuantity
    WHERE RequestNumber = @RequestNumber 
    AND RequestedItemNumber = @RequestedItemNumber    
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
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        ROW_NUMBER() OVER (ORDER BY LastUpdated DESC) AS Id, 
        Name, 
        Description, 
        Quantity, 
        Value, 
        LastUpdated, 
        Active, 
        StockNumber
    FROM 
        dbo.Stock WITH (NOLOCK)
    ORDER BY 
        LastUpdated DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
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
    @StockNumber NVARCHAR(MAX),
    @Id int
AS
BEGIN
SELECT @StockNumber = COUNT(*) + 1 FROM dbo.Stock;
	INSERT INTO dbo.Stock([Name], [Description], Quantity, [Value], LastUpdated, Active, StockNumber)
    VALUES (@Name, @Description, @Quantity, @Value, @LastUpdated, @Active, CONCAT('S_', @StockNumber));
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
    @StockNumber NVARCHAR(MAX),
    @Id INT
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
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '31099bf8-dfe8-405b-ba66-a3efe40eb471')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('31099bf8-dfe8-405b-ba66-a3efe40eb471')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '74e83254-2b31-467c-b66f-a7ae1ce4a803')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('74e83254-2b31-467c-b66f-a7ae1ce4a803')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'aae4b304-f867-42c7-b165-b80b986b095c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('aae4b304-f867-42c7-b165-b80b986b095c')

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
