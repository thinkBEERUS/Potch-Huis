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
The column [dbo].[Donation].[DonationNumber] on table [dbo].[Donation] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Donation])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Starting rebuilding table [dbo].[ConfirmedDonations]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ConfirmedDonations] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [Received]       DATE           NOT NULL,
    [Confirmed]      DATE           NOT NULL,
    [ConfirmedBy]    NVARCHAR (500) NOT NULL,
    [MemberNumber]   NVARCHAR (500) NOT NULL,
    [DonationNumber] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ConfirmedDonations])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_ConfirmedDonations] ON;
        INSERT INTO [dbo].[tmp_ms_xx_ConfirmedDonations] ([Id], [Received], [Confirmed], [ConfirmedBy], [MemberNumber], [DonationNumber])
        SELECT   [Id],
                 [Received],
                 [Confirmed],
                 [ConfirmedBy],
                 [MemberNumber],
                 [DonationNumber]
        FROM     [dbo].[ConfirmedDonations]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_ConfirmedDonations] OFF;
    END

DROP TABLE [dbo].[ConfirmedDonations];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ConfirmedDonations]', N'ConfirmedDonations';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Altering Table [dbo].[Donation]...';


GO
ALTER TABLE [dbo].[Donation]
    ADD [DonationNumber] NVARCHAR (MAX) NOT NULL;


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Confirmed_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Confirmed_Delete]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Confirmed_Get]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Confirmed_Get]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Confirmed_GetAll]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Confirmed_GetAll]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Confirmed_Insert]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Confirmed_Insert]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Confirmed_Update]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Confirmed_Update]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Delete]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Get]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Get]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_GetAll]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_GetAll]';


GO
PRINT N'Refreshing Procedure [dbo].[spDonation_Insert]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spDonation_Insert]';


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
