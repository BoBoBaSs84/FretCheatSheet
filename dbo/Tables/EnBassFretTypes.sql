CREATE TABLE [dbo].[EnBassFretTypes] (
    [Id]        INT IDENTITY (1, 1) NOT NULL,
    [FretCount] INT NULL,
    CONSTRAINT [PK__EnBassFretTypes] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK__EnBassFretTypes__FretCount] UNIQUE NONCLUSTERED ([FretCount] ASC)
);

