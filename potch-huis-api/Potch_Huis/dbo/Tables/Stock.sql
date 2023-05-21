CREATE TABLE [dbo].[Stock]
(
	[Id] INT NOT NULL IDENTITY, 
    [Name] NVARCHAR(100) NOT NULL, 
    [Description] NVARCHAR(MAX) NOT NULL, 
    [Quantity] NVARCHAR(MAX) NOT NULL, 
    [Value] NVARCHAR(50) NOT NULL, 
    [LastUpdated] NVARCHAR(20) NOT NULL, 
    [Active] BIT NOT NULL, 
    [StockNumber] NVARCHAR(MAX) NOT NULL,
    PRIMARY KEY([Id])
)
