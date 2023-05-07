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
/*
The column [dbo].[Donation].[Confirmed] is being dropped, data loss could occur.

The column [dbo].[Donation].[Received] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Donation])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering Table [dbo].[Donation]...';


GO
ALTER TABLE [dbo].[Donation] DROP COLUMN [Confirmed], COLUMN [Received];


GO
PRINT N'Creating Table [dbo].[ConfirmedDonations]...';


GO
CREATE TABLE [dbo].[ConfirmedDonations] (
    [Id]             INT            NOT NULL,
    [Received]       DATE           NOT NULL,
    [Confirmed]      DATE           NOT NULL,
    [ConfirmedBy]    NVARCHAR (500) NOT NULL,
    [MemberNumber]   NVARCHAR (500) NOT NULL,
    [DonationNumber] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Procedure [dbo].[spDonation_Confirmed_Delete]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Confirmed_Delete]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'Creating Procedure [dbo].[spDonation_Confirmed_Get]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Confirmed_Get]
	@MemberNumber nvarchar(500)
AS
BEGIN
	SELECT * FROM dbo.ConfirmedDonations WITH(NOLOCK) 
	WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Confirmed_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Confirmed_GetAll]
AS
BEGIN
	SELECT * FROM dbo.ConfirmedDonations WITH(NOLOCK);
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Confirmed_Insert]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Confirmed_Insert]
    @Received DATE,
    @Confirmed DATE,
    @ConfirmedBy NVARCHAR(500),
    @DonationNumber NVARCHAR(MAX), 
    @MemberNumber NVARCHAR(500)
AS
BEGIN
	INSERT INTO dbo.ConfirmedDonations (Received, Confirmed, ConfirmedBy, DonationNumber, MemberNumber)
    VALUES (@Received, @Confirmed, @ConfirmedBy, @DonationNumber, @MemberNumber)
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Confirmed_Update]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Confirmed_Update]
    @Received DATE,
    @Confirmed DATE,
    @ConfirmedBy NVARCHAR(500),
    @DonationNumber NVARCHAR(MAX), 
    @MemberNumber NVARCHAR(500)
AS
BEGIN
	UPDATE dbo.ConfirmedDonations SET 
    Received = @Received, 
    Confirmed = @Confirmed, 
    ConfirmedBy = @ConfirmedBy
    WHERE MemberNumber = @MemberNumber 
    AND DonationNumber = @DonationNumber
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Delete]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Delete]
	@MemberNumber nvarchar(50)
AS
BEGIN
	DELETE FROM dbo.Donation WITH(NOLOCK) 
	WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Get]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Get]
	@MemberNumber nvarchar(50)
AS
BEGIN
	SELECT * FROM dbo.Donation WITH(NOLOCK) 
	WHERE MemberNumber = @MemberNumber;
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spDonation_GetAll]
AS
BEGIN
	SELECT * FROM dbo.Donation WITH(NOLOCK);
END
GO
PRINT N'Creating Procedure [dbo].[spDonation_Insert]...';


GO
CREATE PROCEDURE [dbo].[spDonation_Insert]
    @Type NVARCHAR(100), 
    @Amount NVARCHAR(500), 
    @Description NVARCHAR(1000), 
    @Purpose NVARCHAR(1000), 
    @MemberNumber NVARCHAR(50)
AS
BEGIN
	INSERT INTO dbo.Donation ([Type], Amount, [Description], Purpose, MemberNumber)
    VALUES (@Type, @Amount, @Description, @Purpose, @MemberNumber)
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Delete]...';


GO
CREATE PROCEDURE [dbo].[spRequest_Delete]
	@RequestNumber NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.Request WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber;
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
PRINT N'Creating Procedure [dbo].[spRequest_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spRequest_GetAll]
AS
BEGIN
	SELECT * from dbo.Request WITH(NOLOCK);
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Insert]...';


GO
CREATE PROCEDURE [dbo].[spRequest_Insert]
    @RequestNumber NVARCHAR(100), 
    @MemberNumber NVARCHAR(50),
    @Value NVARCHAR(500),
    @Received DATE, 
    @Confirmed DATE    
AS
BEGIN
	INSERT INTO dbo.Request(RequestNumber, MemberNumber, [Value], Received, Confirmed)
    VALUES (@RequestNumber, @MemberNumber, @Value, @Received, @Confirmed)
END
GO
PRINT N'Creating Procedure [dbo].[spRequest_Update]...';


GO
CREATE PROCEDURE [dbo].[spRequest_Update]
    @RequestNumber NVARCHAR(100), 
    @MemberNumber NVARCHAR(50),
    @Value NVARCHAR(500),
    @Received DATE, 
    @Confirmed DATE    
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
PRINT N'Creating Procedure [dbo].[spRequested_Items_Delete]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Delete]
	@RequestNumber NVARCHAR(MAX),
	@Name NVARCHAR(MAX)
AS
BEGIN
	DELETE FROM dbo.RequestedItems WITH(NOLOCK) 
	WHERE RequestNumber = @RequestNumber
	AND [Name] = @Name;
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
PRINT N'Creating Procedure [dbo].[spRequested_Items_Insert]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Insert]
    @Name NVARCHAR(500),
    @Quantity DATE, 
    @Value DATE,    
    @RequestNumber NVARCHAR(100), 
    @StockNumber NVARCHAR(50)
AS
BEGIN
	INSERT INTO dbo.RequestedItems ([Name], Quantity, [Value], RequestNumber, StockNumber)
    VALUES (@Name, @Quantity, @Value, @RequestNumber, @StockNumber)
END
GO
PRINT N'Creating Procedure [dbo].[spRequested_Items_Update]...';


GO
CREATE PROCEDURE [dbo].[spRequested_Items_Update]
    @Name NVARCHAR(500),
    @Quantity DATE, 
    @Value DATE,    
    @RequestNumber NVARCHAR(100), 
    @StockNumber NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.RequestedItems SET 
    Quantity = @Quantity,
    [Value] = @Value
    WHERE RequestNumber = @RequestNumber 
    AND [Name] = @Name 
    AND StockNumber = @StockNumber
END
GO
PRINT N'Creating Procedure [dbo].[spRequestedItems_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spRequestedItems_GetAll]
AS
BEGIN
	SELECT * from dbo.RequestedItems WITH(NOLOCK);
END
GO
if not exists(select 1 from dbo.Member)
begin 
	insert into dbo.Member (Firstname, Lastname, Email, Cellphone, StreetAddress,Suburb, City, MemberNumber)
	values ('Austin', 'van der Merwe', 'aus.vd.merwe@gmail.com', '0796234424', '1 Ingonya Street', 'Baillie Park', 'Potchefstroom', 'PH00001ADM')
end
GO

GO
PRINT N'Update complete.';


GO
