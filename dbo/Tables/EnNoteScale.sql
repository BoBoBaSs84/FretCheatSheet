CREATE TABLE [dbo].[EnNoteScale] (
    [Id]       INT IDENTITY (1, 1) NOT NULL,
    [Scale]    INT NULL,
    [IdEnNote] INT NULL,
    [StepNote] INT NULL,
    CONSTRAINT [PK__EnNoteScale] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK__EnNoteScale_EnNotes] FOREIGN KEY ([IdEnNote]) REFERENCES [dbo].[EnNotes] ([Id]),
    CONSTRAINT [UK__EnNoteScale__Scale_IdEnNotes] UNIQUE NONCLUSTERED ([Scale] ASC, [IdEnNote] ASC)
);

