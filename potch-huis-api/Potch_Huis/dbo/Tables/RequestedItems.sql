CREATE TABLE [dbo].[RequestedItems]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] NCHAR(10) NOT NULL, 
    [Quantity] NCHAR(10) NOT NULL, 
    [Value] NCHAR(10) NOT NULL, 
    [RequestNumber] NVARCHAR(MAX) NOT NULL, 
    [StockNumber] NVARCHAR(MAX) NOT NULL, 
    [RequestedItemNumber] NVARCHAR(MAX) NOT NULL, 
    [ActualQuantity] NVARCHAR(MAX) NOT NULL
)
