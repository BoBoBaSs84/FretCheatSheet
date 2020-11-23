CREATE TABLE [dbo].[EnNotes] (
    [Id]   INT          IDENTITY (1, 1) NOT NULL,
    [Note] NVARCHAR (5) NULL,
    CONSTRAINT [PK__EnNotes] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK__EnNotes__Note] UNIQUE NONCLUSTERED ([Note] ASC)
);

