CREATE TABLE [dbo].[RequestedItems]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] NVARCHAR(100) NOT NULL, 
    [Quantity] NVARCHAR(100) NOT NULL, 
    [Value] NVARCHAR(100) NOT NULL, 
    [RequestNumber] NVARCHAR(MAX) NOT NULL, 
    [StockNumber] NVARCHAR(MAX) NOT NULL, 
    [RequestedItemNumber] NVARCHAR(MAX) NOT NULL, 
    [ActualQuantity] NVARCHAR(MAX) NOT NULL
)
