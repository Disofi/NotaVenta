IF OBJECT_ID('[dbo].[SP_GET_Ciudad]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[SP_GET_Ciudad]
	PRINT ('Procedimiento [dbo].[SP_GET_Ciudad] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_GET_Ciudad]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[SP_GET_Ciudad]
(
	@pv_BaseDatos varchar(100)
)
AS
	declare @query varchar(max)

	select @query = ''

	select	@query = @query + '
	SELECT	CiuCod
	,		CiuDes 
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtciud] c 
	'

	exec (@query)
GO

IF OBJECT_ID('[dbo].[SP_GET_Ciudad]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[SP_GET_Ciudad] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[SP_GET_Ciudad]')
END
