IF OBJECT_ID('[dbo].[FR_ModificarParametrosUsuarios]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ModificarParametrosUsuarios]
	PRINT ('Procedimiento [dbo].[FR_ModificarParametrosUsuarios] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ModificarParametrosUsuarios]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_ModificarParametrosUsuarios]  
(
	@pi_IdEmpresa INT
,	@pb_MultiEmpresa BIT
,	@pb_ManejaAdministrador BIT
,	@pb_ManejaAprobador BIT
,	@pb_ListaClientesVendedor BIT
,	@pb_ListaClientesTodos BIT
,	@pb_ValidaReglasNegocio BIT
,	@pb_ManejaListaPrecios BIT
,	@pb_EditaPrecioProducto BIT
,	@pb_MuestraCondicionVentaCliente BIT
,	@pb_MuestraCondicionVentaTodos BIT
,	@pb_EditaDescuentoProducto BIT
,	@pd_MaximoDescuentoProducto DECIMAL(18, 2)
,	@pb_CantidadDescuentosProducto INT
,	@pb_MuestraStockProducto BIT
,	@pb_StockProductoEsMasivo BIT
,	@pb_StockProductoEsBodega BIT
,	@pv_StockProductoCodigoBodega VARCHAR(1000)
,	@pb_ControlaStockProducto BIT
,	@pb_EnvioMailCliente BIT
,	@pb_EnvioMailVendedor BIT
,	@pb_EnvioMailContacto BIT
,	@pb_EnvioObligatorioAprobador BIT 
,	@pb_ManejaTallaColor BIT 
,	@pb_ManejaDescuentoTotalDocumento BIT 
,	@pi_CantidadDescuentosTotalDocumento INT
,	@pi_CantidadLineas INT
,	@pb_ManejaLineaCredito BIT 
,	@pb_ManejaCanalVenta BIT 
,	@pb_CreacionNotaVentaUsuariosBloqueados BIT 
,	@pb_CreacionNotaVentaUsuariosInactivos BIT 
,	@pb_PermiteModificacionCondicionVenta BIT 
,	@pv_AtributoSoftlandDescuentoCliente VARCHAR(1000)
,	@pb_PermiteCrearDireccion BIT 
,	@pb_CrearClienteConDV BIT 
,	@pb_MuestraUnidadMedidaProducto BIT 
,	@pb_DescuentoLineaDirectoSoftland BIT 
,	@pb_DescuentoTotalDirectoSoftland BIT 
)
as  
begin
	UPDATE	[dbo].[DS_Parametros]  
	SET		MultiEmpresa = @pb_MultiEmpresa
	,		ManejaAdministrador = @pb_ManejaAdministrador
	,		ManejaAprobador = @pb_ManejaAprobador
	,		ListaClientesVendedor = @pb_ListaClientesVendedor
	,		ListaClientesTodos = @pb_ListaClientesTodos
	,		ValidaReglasNegocio = @pb_ValidaReglasNegocio
	,		ManejaListaPrecios = @pb_ManejaListaPrecios
	,		EditaPrecioProducto = @pb_EditaPrecioProducto
	,		MuestraCondicionVentaCliente = @pb_MuestraCondicionVentaCliente
	,		MuestraCondicionVentaTodos = @pb_MuestraCondicionVentaTodos
	,		EditaDescuentoProducto = @pb_EditaDescuentoProducto
	,		MaximoDescuentoProducto = @pd_MaximoDescuentoProducto
	,		CantidadDescuentosProducto = @pb_CantidadDescuentosProducto
	,		MuestraStockProducto = @pb_MuestraStockProducto
	,		StockProductoEsMasivo = @pb_StockProductoEsMasivo
	,		StockProductoEsBodega = @pb_StockProductoEsBodega
	,		StockProductoCodigoBodega = @pv_StockProductoCodigoBodega
	,		ControlaStockProducto = @pb_ControlaStockProducto
	,		EnvioMailCliente = @pb_EnvioMailCliente
	,		EnvioMailVendedor = @pb_EnvioMailVendedor
	,		EnvioMailContacto = @pb_EnvioMailContacto
	,		EnvioObligatorioAprobador = @pb_EnvioObligatorioAprobador
	,		ManejaTallaColor = @pb_ManejaTallaColor
	,		ManejaDescuentoTotalDocumento = @pb_ManejaDescuentoTotalDocumento
	,		CantidadDescuentosTotalDocumento = @pi_CantidadDescuentosTotalDocumento
	,		CantidadLineas = @pi_CantidadLineas
	,		ManejaLineaCredito = @pb_ManejaLineaCredito
	,		ManejaCanalVenta = @pb_ManejaCanalVenta
	,		CreacionNotaVentaUsuariosBloqueados = @pb_CreacionNotaVentaUsuariosBloqueados
	,		CreacionNotaVentaUsuariosInactivos = @pb_CreacionNotaVentaUsuariosInactivos
	,		PermiteModificacionCondicionVenta = @pb_PermiteModificacionCondicionVenta
	,		AtributoSoftlandDescuentoCliente = @pv_AtributoSoftlandDescuentoCliente
	,		PermiteCrearDireccion = @pb_PermiteCrearDireccion
	,		CrearClienteConDV = @pb_CrearClienteConDV
	,		MuestraUnidadMedidaProducto = @pb_MuestraUnidadMedidaProducto
	,		DescuentoLineaDirectoSoftland = @pb_DescuentoLineaDirectoSoftland
	,		DescuentoTotalDirectoSoftland = @pb_DescuentoTotalDirectoSoftland
	WHERE	IdEmpresa = @pi_IdEmpresa
	
	SELECT	Verificador = CAST(1 as bit)
	,		Mensaje = 'Parametros Actualizados satisfactoriamente'
end
GO

IF OBJECT_ID('[dbo].[FR_ModificarParametrosUsuarios]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ModificarParametrosUsuarios] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ModificarParametrosUsuarios]')
END