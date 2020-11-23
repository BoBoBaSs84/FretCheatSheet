
CREATE FUNCTION [dbo].[GetNotesWithinScale] (@IdEnNote INT, @IdEnEnScalesMode INT)
RETURNS @ResultsTable TABLE (
	[IdEnNoteScale] INT
	, [Scale] INT
	, [Note] NVARCHAR(5)
	, [StepNote] INT
	)

BEGIN
	DECLARE @StepNextNote TABLE (
		[Id] INT
		, StepNextNote INT
		);

	WITH cte ([Id], [HalfToneSteps], [Lengh])
	AS (
		SELECT 1
			, CONVERT(NVARCHAR(11), [HalfToneSteps])
			, LEN(HalfToneSteps)
		FROM [dbo].[EnScalesModes]
		WHERE Id = @IdEnEnScalesMode
		
		UNION ALL
		
		SELECT c.Id + 1
			, CONVERT(NVARCHAR(11), c.[HalfToneSteps])
			, LEN(c.HalfToneSteps)
		FROM cte c
		WHERE Id < c.Lengh
		)
	INSERT INTO @StepNextNote ([Id], [StepNextNote])
	SELECT c1.Id
		, CONVERT(INT, SUBSTRING(c1.HalfToneSteps, c1.Id, 1))
	FROM cte c1
	ORDER BY c1.Id ASC;

	DECLARE @IdStepMin INT
		, @IdStepMAX INT

	SELECT @IdStepMIN = MIN(Id)
		, @IdStepMAX = MAX(Id)
	FROM @StepNextNote;

	WITH cte ([IdRootNote], [IdNextNote], [IdStep], [StepNextNote])
	AS (
		SELECT ent.Id
			, snn.StepNextNote + ent.Id
			, snn.Id
			, snn.StepNextNote
		FROM @StepNextNote snn
		OUTER APPLY (
			SELECT ens.Id, en.Id [IdNote]
			FROM [dbo].[EnNoteScale] ens
			JOIN [dbo].[EnNotes] en 
				ON en.Id = ens.IdEnNote
			WHERE en.Id = @IdEnNote
			) ent
		WHERE snn.Id = @IdStepMin
		
		UNION ALL
		
		SELECT c.IdRootNote
			, snn.StepNextNote + c.IdNextNote
			, snn.Id
			, snn.StepNextNote
		FROM cte c
		JOIN @StepNextNote snn
			ON snn.Id = c.IdStep + @IdStepMin
		WHERE snn.Id <= @IdStepMAX
		)
	INSERT INTO @ResultsTable ([IdEnNoteScale], [Scale], [Note], [StepNote])
	SELECT ens.Id
		, ens.Scale
		, en.Note
		, ens.StepNote
	FROM [dbo].[EnNoteScale] ens
	JOIN [dbo].[EnNotes] en 
		ON en.Id = ens.IdEnNote
	WHERE en.Id IN (
		SELECT DISTINCT ens.IdEnNote
		FROM [dbo].[EnNoteScale] ens
		JOIN cte c
			ON c.IdRootNote = ens.Id
				OR c.IdNextNote = ens.Id
		)
	ORDER BY ens.Id ASC;

	RETURN
END

