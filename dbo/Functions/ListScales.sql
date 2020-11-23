
CREATE FUNCTION [dbo].[ListScales] ()
RETURNS @ResultsTable TABLE (
	[RootNote] NVARCHAR(5)
	, [ModeType] NVARCHAR(103)
	, [A] BIT
	, [A#/Bb] BIT
	, [B] BIT
	, [C] BIT
	, [C#/Db] BIT
	, [D] BIT
	, [D#/Eb] BIT
	, [E] BIT
	, [F] BIT
	, [F#/Gb] BIT
	, [G] BIT
	, [G#/Ab] BIT
	)

BEGIN
	INSERT INTO @ResultsTable (RootNote, ModeType, A, [A#/Bb], B, C, [C#/Db], D, [D#/Eb], E, F, [F#/Gb], G, [G#/Ab])
	SELECT pvt.RootNote
		, pvt.ModeType
		, CONVERT(BIT, ISNULL(pvt.[A], 0))
		, CONVERT(BIT, ISNULL(pvt.[A#/Bb], 0))
		, CONVERT(BIT, ISNULL(pvt.[B], 0))
		, CONVERT(BIT, ISNULL(pvt.[C], 0))
		, CONVERT(BIT, ISNULL(pvt.[C#/Db], 0))
		, CONVERT(BIT, ISNULL(pvt.[D], 0))
		, CONVERT(BIT, ISNULL(pvt.[D#/Eb], 0))
		, CONVERT(BIT, ISNULL(pvt.[E], 0))
		, CONVERT(BIT, ISNULL(pvt.[F], 0))
		, CONVERT(BIT, ISNULL(pvt.[F#/Gb], 0))
		, CONVERT(BIT, ISNULL(pvt.[G], 0))
		, CONVERT(BIT, ISNULL(pvt.[G#/Ab], 0))
	FROM (
		SELECT en.Note [RootNote]
			, esm.Mode + ' - ' + esm.[Type] [ModeType]
			, nws.Note
			, nws.[Exists]
		FROM [dbo].[EnNoteScale] ens
		JOIN [dbo].[EnNotes] en 
			ON en.Id = ens.IdEnNote
		OUTER APPLY EnScalesModes esm
		OUTER APPLY (
			SELECT DISTINCT Note
				, 1 [Exists]
			FROM [dbo].[GetNotesWithinScale](en.Id, esm.Id)
			) nws
		) d
	PIVOT(MAX(d.[Exists]) FOR d.Note IN (A, [A#/Bb], B, C, [C#/Db], D, [D#/Eb], E, F, [F#/Gb], G, [G#/Ab])) pvt
	ORDER BY pvt.RootNote ASC
		, pvt.ModeType ASC;

	RETURN
END

