CREATE TABLE [dbo].[EnBassTunings] (
    [Id]            INT       IDENTITY (1, 1) NOT NULL,
    [IdEnBassTypes] INT       NULL,
    [Type]          [sysname] NOT NULL,
    CONSTRAINT [PK__EnBassTunings] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK__EnBassTunings_EnBassTypes] FOREIGN KEY ([IdEnBassTypes]) REFERENCES [dbo].[EnBassTypes] ([Id])
);

