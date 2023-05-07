CREATE TABLE [dbo].[Request]
(
	[Id] INT NOT NULL IDENTITY, 
    [RequestNumber] NVARCHAR(MAX) NOT NULL, 
    [MemberNumber] NVARCHAR(50) NOT NULL, 
    [Value] NVARCHAR(MAX) NOT NULL,
    [Received] NVARCHAR(MAX) NOT NULL, 
    [Confirmed] NVARCHAR(MAX) NOT NULL , 
    PRIMARY KEY ([Id])
)
