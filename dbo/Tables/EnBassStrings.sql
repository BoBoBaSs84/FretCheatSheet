CREATE TABLE [dbo].[EnBassStrings] (
    [Id]             INT IDENTITY (1, 1) NOT NULL,
    [IdEnBassTuning] INT NULL,
    [IdEnNoteScale]  INT NULL,
    [String]         INT NULL,
    CONSTRAINT [PK__EnBassStrings] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK__EnBassStrings_EnBassTunings] FOREIGN KEY ([IdEnBassTuning]) REFERENCES [dbo].[EnBassTunings] ([Id]),
    CONSTRAINT [FK__EnBassStrings_EnNoteScale] FOREIGN KEY ([IdEnNoteScale]) REFERENCES [dbo].[EnNoteScale] ([Id])
);

