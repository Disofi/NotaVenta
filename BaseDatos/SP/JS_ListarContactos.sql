IF OBJECT_ID('[dbo].[JS_ListarContactos]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[JS_ListarContactos]
	PRINT ('Procedimiento [dbo].[JS_ListarContactos] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarContactos]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[JS_ListarContactos]
(
	@vchrCodAux VARCHAR(50) = ''
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''

	-- ==========================================================================================  
	-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
	-- ==========================================================================================  
	select @query = @query + '
	SELECT	CodAux = contacto.CodAuc
	,		NomCon = contacto.[NomCon]
	,		FonCon = ISNULL(contacto.[FonCon],'''')
	,		EMail = ISNULL(contacto.EMail,'''')  
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtaxco] contacto  
	WHERE	contacto.CodAuc = ''' + @vchrCodAux + '''
	'

	exec (@query)
end  
GO

IF OBJECT_ID('[dbo].[JS_ListarContactos]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[JS_ListarContactos] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[JS_ListarContactos]')
END
