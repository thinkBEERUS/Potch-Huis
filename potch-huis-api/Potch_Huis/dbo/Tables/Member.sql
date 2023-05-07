CREATE TABLE [dbo].[Member]
(
	[Id] INT NOT NULL IDENTITY, 
    [Firstname] NVARCHAR(50) NOT NULL, 
    [Lastname] NVARCHAR(50) NOT NULL, 
    [Email] NVARCHAR(50) NOT NULL, 
    [Cellphone] NVARCHAR(20) NOT NULL, 
    [StreetAddress] NVARCHAR(50) NOT NULL, 
    [Suburb] NVARCHAR(50) NOT NULL, 
    [City] NVARCHAR(50) NOT NULL, 
    [MemberNumber] NVARCHAR(50) NOT NULL,
    PRIMARY KEY([Id])
)
