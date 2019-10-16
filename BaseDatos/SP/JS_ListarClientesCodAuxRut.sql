IF OBJECT_ID('[dbo].[JS_ListarClientesCodAuxRut]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[JS_ListarClientesCodAuxRut]
	PRINT ('Procedimiento [dbo].[JS_ListarClientesCodAuxRut] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarClientesCodAuxRut]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[JS_ListarClientesCodAuxRut]  
(
	@vchrRutAux VARCHAR(20) = ''
,	@vchrCodAux VARCHAR(10) = ''
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
	SELECT	CodAux = clientes.CodAux,
			NomAux = clientes.[NomAux],
			RutAux = clientes.[RutAux],
			DirAux = clientes.[DirAux],
			DirNum = ISNULL(clientes.[DirNum],''''),
			NomCon = contacto.[NomCon],
			FonCon = ISNULL(contacto.[FonCon],''''),
			EMail = ISNULL(clientes.EMail,''''),
			Notas = clientes.Notas
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi] clientes 
		left JOIN [' + @pv_BaseDatos + '].[softland].[cwtaxco] contacto 
			ON (clientes.CodAux = contacto.CodAuc)  
	WHERE	CodAux = ''' + @vchrCodAux + '''
	AND		RutAux = (CASE ''' + @vchrRutAux + ''' WHEN '''' THEN RutAux ELSE ''' + @vchrRutAux + ''' END)  
	'

	EXEC (@query)
END
GO

IF OBJECT_ID('[dbo].[JS_ListarClientesCodAuxRut]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[JS_ListarClientesCodAuxRut] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[JS_ListarClientesCodAuxRut]')
END
