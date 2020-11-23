CREATE TABLE [dbo].[EnConcertPitch] (
    [Id]        INT        IDENTITY (1, 1) NOT NULL,
    [PitchInHz] FLOAT (53) NULL,
    CONSTRAINT [PK__ConcertPitch] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK__EnConcertPitch__PitchInHz] UNIQUE NONCLUSTERED ([PitchInHz] ASC)
);

