IF OBJECT_ID('[dbo].[FR_ListaTallaColorProducto]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ListaTallaColorProducto]
	PRINT ('Procedimiento [dbo].[FR_ListaTallaColorProducto] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListaTallaColorProducto]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_ListaTallaColorProducto]
(
	@pv_CodProd varchar(max)
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''
	select @query = @query + '
	SELECT		CodigoBodega = codbode
	,			CodigoProducto = codprod
	,			Talla = partida
	,			Color = pieza
	,			CantidadBodega = ISNULL(CONVERT(INT, sum(ingresos-egresos)), 0)
	FROM		[' + @pv_BaseDatos + '].[softland].IW_vsnpMovimStockTipoBod  
	where		codprod = ''' + @pv_CodProd + '''
	group by	codprod, codbode, partida, pieza
	'


	exec (@query)
END  
GO

IF OBJECT_ID('[dbo].[FR_ListaTallaColorProducto]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListaTallaColorProducto] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListaTallaColorProducto]')
END