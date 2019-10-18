IF OBJECT_ID('[dbo].[FR_ObtenerCredito]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ObtenerCredito]
	PRINT ('Procedimiento [dbo].[FR_ObtenerCredito] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ObtenerCredito]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_ObtenerCredito]
	@pv_CodAux varchar(15)
,	@pv_BaseDatos varchar(100)
as
BEGIN
	DECLARE @query varchar(max)
	
	select	@query = ''

	select	@query = @query + '
	IF EXISTS (select codaux from [' + @pv_BaseDatos + '].[softland].[CWDocSaldos] where CodAux = ''' + @pv_CodAux + ''') BEGIN
 		SELECT
			CONVERT(numeric(18,2),vcl.MtoCre) as Credito,
			CONVERT(NUMERIC(18,2),SUM(doc.DEBE)) as Debe,
			CONVERT(numeric(18,2),SUM(doc.HABER)) as Haber
		FROM
			[' + @pv_BaseDatos + '].softland.cwtcvcl as vcl INNER JOIN [' + @pv_BaseDatos + '].softland.CWDocSaldos as doc on vcl.CodAux = ''' + @pv_CodAux + ''' and doc.CodAux= vcl.CodAux 
		GROUP by
			vcl.MtoCre
	END
	ELSE BEGIN
		SELECT
			CONVERT(numeric(18,2),MtoCre) as Credito,
			Debe = CONVERT(numeric(18,2),0),
			Haber = CONVERT(numeric(18,2),0)
		FROM
			[' + @pv_BaseDatos + '].softland.cwtcvcl where CodAux = ''' + @pv_CodAux + '''	
	END
	'

	exec (@query)
END
GO

IF OBJECT_ID('[dbo].[FR_ObtenerCredito]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ObtenerCredito] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ObtenerCredito]')
END