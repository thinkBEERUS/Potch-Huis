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
PRINT N'Creating Table [dbo].[RequestedItems]...';


GO
CREATE TABLE [dbo].[RequestedItems] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [Name]                NCHAR (10)     NOT NULL,
    [Quantity]            NCHAR (10)     NOT NULL,
    [Value]               NCHAR (10)     NOT NULL,
    [RequestNumber]       NVARCHAR (MAX) NOT NULL,
    [StockNumber]         NVARCHAR (MAX) NOT NULL,
    [RequestedItemNumber] NVARCHAR (MAX) NOT NULL,
    [ActualQuantity]      NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Altering Procedure [dbo].[spDonation_GetAll]...';


GO
ALTER PROCEDURE [dbo].[spDonation_GetAll]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ROW_NUMBER() OVER (ORDER BY Id DESC) AS Id, [Type], Amount, [Description], Purpose, MemberNumber, DonationNumber
    FROM 
        dbo.Donation WITH (NOLOCK)
    ORDER BY 
        Id DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
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
	INSERT INTO dbo.RequestedItems ([Name], Quantity, [Value], RequestNumber, StockNumber, RequestedItemNumber, ActualQuantity)
    VALUES (@Name, @Quantity, @Value, @RequestNumber, @StockNumber, @RequestedItemNumber, @ActualQuantity)
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
if not exists(select 1 from dbo.Member)
begin 
	insert into dbo.Member (Firstname, Lastname, Email, Cellphone, StreetAddress,Suburb, City, MemberNumber)
	values ('Austin', 'van der Merwe', 'aus.vd.merwe@gmail.com', '0796234424', '1 Ingonya Street', 'Baillie Park', 'Potchefstroom', 'PH00001ADM')
end
GO

GO
PRINT N'Update complete.';


GO