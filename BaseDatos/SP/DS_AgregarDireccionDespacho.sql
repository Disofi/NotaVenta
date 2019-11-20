USE [DSNotaVenta]
GO
IF OBJECT_ID('[dbo].[DS_AgregarDireccionDespacho]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[DS_AgregarDireccionDespacho]
	PRINT ('Procedimiento [dbo].[DS_AgregarDireccionDespacho] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[DS_AgregarDireccionDespacho]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[DS_AgregarDireccionDespacho]
(
	@pv_CodAux varchar(500)
,	@pv_DirDch varchar(500)
,	@pv_ComDch varchar(500)
,	@pv_NomDch varchar(500)
,	@pv_CiuDch varchar(500)
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''

	select @query = @query + '
	IF NOT EXISTS (SELECT TOP 1 1 FROM [' + @pv_BaseDatos + '].[softland].[cwtauxd] WHERE CodAxD = ''' + @pv_CodAux + ''' AND NomDch = ''' + @pv_NomDch + ''') BEGIN
		INSERT INTO [' + @pv_BaseDatos + '].[softland].[cwtauxd]
		(
			CodAxD
		,	DirDch
		,	ComDch
		,	NomDch
		,	CiuDch
		)
		VALUES
		(
			''' + @pv_CodAux + '''
		,	''' + @pv_DirDch + '''
		,	''' + @pv_ComDch + '''
		,	''' + @pv_NomDch + '''
		,	''' + @pv_CiuDch + '''
		)

		SELECT	Verificador = Cast(1 as bit)
		,		Mensaje = ''Se agrega direccion de despacho satisfactoriamente''
	END
	ELSE BEGIN
		SELECT	Verificador = Cast(0 as bit)
		,		Mensaje = ''Direccion ingresada ya existe''
	END
	'

	EXEC (@query)
END  
GO

IF OBJECT_ID('[dbo].[DS_AgregarDireccionDespacho]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[DS_AgregarDireccionDespacho] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[DS_AgregarDireccionDespacho]')
END