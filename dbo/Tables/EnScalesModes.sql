CREATE TABLE [dbo].[EnScalesModes] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [Mode]          NVARCHAR (50) NULL,
    [Type]          NVARCHAR (50) NULL,
    [HalfToneSteps] DECIMAL (11)  NULL,
    CONSTRAINT [PK__EnScalesModes] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK__EnScalesModes__HalfToneSteps] UNIQUE NONCLUSTERED ([HalfToneSteps] ASC)
);

