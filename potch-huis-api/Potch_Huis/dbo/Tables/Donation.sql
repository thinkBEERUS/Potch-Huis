CREATE TABLE [dbo].[Donation]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Type] NVARCHAR(MAX) NOT NULL, 
    [Amount] NVARCHAR(MAX) NOT NULL, 
    [DonationNumber] NVARCHAR(MAX) NOT NULL,
    [Received] NVARCHAR(MAX) NOT NULL, 
    [MemberNumber] NVARCHAR(50) NOT NULL, 
    [ConfirmedBy] NVARCHAR(MAX) NOT NULL, 
    [Confirmed] NVARCHAR(MAX) NOT NULL
)
