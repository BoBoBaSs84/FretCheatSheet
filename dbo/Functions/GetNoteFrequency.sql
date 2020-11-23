
CREATE FUNCTION [dbo].[GetNoteFrequency] (
	@IdEnConcertPitch INT
	, @IdEnNoteScale INT
	)
RETURNS FLOAT

BEGIN
	DECLARE @Constant FLOAT = POWER(CONVERT(FLOAT, 2), 1 / CONVERT(FLOAT, 12));
	DECLARE @Frequency FLOAT;

	SELECT @Frequency = ecp.PitchInHz * POWER(@Constant, ens.StepNote)
	FROM [dbo].[EnConcertPitch] ecp
	OUTER APPLY [dbo].[EnNoteScale] ens
	WHERE ecp.Id = @IdEnConcertPitch
		AND ens.Id = @IdEnNoteScale;

	RETURN @Frequency;
END

