
CREATE PROCEDURE [dbo].[FretCheatSheet] (
	@IdBassType INT
	, @IdTuningType INT
	, @IdFretType INT
	, @IdEnConcertPitch INT
	)
AS
DECLARE @FretCount INT;

SELECT @FretCount = FretCount
FROM EnBassFretTypes
WHERE Id = @IdFretType;

SELECT ebt.[Type] [BassType]
	, ebtu.[Type] [TuningType]
	, CONVERT(VARCHAR(5), ebs.String) + ' - ' + enst.Note [String]
	, ebs.IdEnNoteScale [IdNoteScaleString]
	, d.R - 1 [Fret]
	, en.Note
	, f.FrequencyHz
	, ens.Id [IdNoteScale]
FROM dbo.EnBassTypes ebt
JOIN dbo.EnBassTunings ebtu
	ON ebtu.IdEnBassTypes = ebt.Id
JOIN dbo.EnBassStrings ebs
	ON ebs.IdEnBassTuning = ebtu.Id
CROSS APPLY (
	SELECT ROW_NUMBER() OVER (ORDER BY c1.object_id) [R]
	FROM sys.columns c1
	) d
JOIN [dbo].[EnNoteScale] ens
	ON ens.Id = ebs.IdEnNoteScale + d.R - 1
JOIN [dbo].[EnNotes] en
	ON en.Id = ens.IdEnNote
JOIN [dbo].[EnNoteScale] ents
	ON ents.Id = ebs.IdEnNoteScale
JOIN [dbo].[EnNotes] enst
	ON enst.Id = ents.IdEnNote
OUTER APPLY (
	SELECT [dbo].[GetNoteFrequency](@IdEnConcertPitch, ens.Id) [FrequencyHz]
	) f
WHERE ebt.Id = @IdBassType
	AND ebtu.Id = @IdTuningType
	AND d.R - 1 BETWEEN 1 AND @FretCount
ORDER BY ebs.String DESC
	, d.R - 1 ASC;



