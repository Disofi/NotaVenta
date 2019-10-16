IF OBJECT_ID('[dbo].[SP_GET_Comuna]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[SP_GET_Comuna]
	PRINT ('Procedimiento [dbo].[SP_GET_Comuna] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_GET_Comuna]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[SP_GET_Comuna]
(
	@pv_BaseDatos varchar(100)
)
AS
	declare @query varchar(max)

	select @query = ''

	select	@query = @query + '
	SELECT	ComCod
	,		ComDes 
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtcomu] c 
	'

	exec (@query)
GO

IF OBJECT_ID('[dbo].[SP_GET_Comuna]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[SP_GET_Comuna] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[SP_GET_Comuna]')
END
