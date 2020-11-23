CREATE TABLE [dbo].[EnBassTypes] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [Strings] INT NULL,
    [Type]    AS  (CONVERT([nvarchar](2),[Strings])+'-String'),
    CONSTRAINT [PK__EnBassTypes] PRIMARY KEY CLUSTERED ([Id] ASC)
);

