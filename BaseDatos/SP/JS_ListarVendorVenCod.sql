IF OBJECT_ID('[dbo].[JS_ListarVendorVenCod]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[JS_ListarVendorVenCod]
	PRINT ('Procedimiento [dbo].[JS_ListarVendorVenCod] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarVendorVenCod]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[JS_ListarVendorVenCod]
(
	@VenCod VARCHAR(10)  
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
	SELECT	du.Nombre
	,		du.VenCod
	,		du.email
	FROM	dbo.DS_Usuarios du  
	WHERE	du.VenCod = ''' + @VenCod + '''
	'

	exec (@query)
end  
GO

IF OBJECT_ID('[dbo].[JS_ListarVendorVenCod]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[JS_ListarVendorVenCod] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[JS_ListarVendorVenCod]')
END
