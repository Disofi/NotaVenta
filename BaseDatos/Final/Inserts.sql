use DSNotaVenta
GO



GO
SET IDENTITY_INSERT [dbo].[DS_Empresa] ON 
GO
INSERT [dbo].[DS_Empresa] ([Id], [Nombre], [BaseDatos]) 
SELECT	1, N'Elbelman', N'ECSA2015'
GO
SET IDENTITY_INSERT [dbo].[DS_Empresa] OFF
GO



GO
SET IDENTITY_INSERT [dbo].[DS_Parametros] ON 
GO
INSERT [dbo].[DS_Parametros] ([Id], [IdEmpresa], [MultiEmpresa], [ManejaAdministrador], [ManejaAprobador], [ListaClientesVendedor], [ListaClientesTodos], [ValidaReglasNegocio], [ManejaListaPrecios], [EditaPrecioProducto], [MuestraCondicionVentaCliente], [MuestraCondicionVentaTodos], [EditaDescuentoProducto], [MaximoDescuentoProducto], [CantidadDescuentosProducto], [MuestraStockProducto], [StockProductoEsMasivo], [StockProductoEsBodega], [StockProductoCodigoBodega], [ControlaStockProducto], [EnvioMailCliente], [EnvioMailVendedor], [EnvioMailContacto], [EnvioObligatorioAprobador], [ManejaTallaColor], [ManejaDescuentoTotalDocumento], [CantidadDescuentosTotalDocumento], [CantidadLineas], [ManejaLineaCreditoVendedor], [ManejaLineaCreditoAprobador], [ManejaCanalVenta], [CreacionNotaVentaUsuariosBloqueados], [CreacionNotaVentaUsuariosInactivos], [PermiteModificacionCondicionVenta], [AtributoSoftlandDescuentoCliente], [PermiteCrearDireccion], [CrearClienteConDV], [MuestraUnidadMedidaProducto], [DescuentoLineaDirectoSoftland], [DescuentoTotalDirectoSoftland], [CambioVendedorCliente], [AgregaCliente], [EnvioMailAprobador], [ManejaSaldo]) 
SELECT	1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, CAST(15.00 AS Decimal(18, 2)), 1, 1, 0, 1, N'9', 0, 0, 1, 0, 1, 0, 1, 0, 30, 1, 0, 1, 0, 0, 0, N'', 1, 1, 0, 0, 0, 1, 1, 1, 1
GO
SET IDENTITY_INSERT [dbo].[DS_Parametros] OFF
GO



GO
SET IDENTITY_INSERT [dbo].[DS_UsuariosTipos] ON 
GO
INSERT [dbo].[DS_UsuariosTipos] ([ID], [tipoUsuario], [urlInicio]) 
SELECT	1, N'Administrador', N'Parametros' UNION ALL
SELECT	2, N'Vendedor', N'Todolosclientes' UNION ALL
SELECT	3, N'Aprobador', N'Reporte'
GO
SET IDENTITY_INSERT [dbo].[DS_UsuariosTipos] OFF
GO



GO
SET IDENTITY_INSERT [dbo].[DS_Usuarios] ON 
GO
INSERT [dbo].[DS_Usuarios] ([ID], [Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [Nombre], [ContrasenaCorreo], [Estado]) 
SELECT	1, N'adm', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 1, N'Admin', N'Disofi2019', 1 UNION ALL
SELECT	2, N'vendedor', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 2, N'Vendedor', N'Disofi2019', 1 UNION ALL
SELECT	3, N'aprobador', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 3, N'Aprobador', N'Disofi2019', 1
GO
SET IDENTITY_INSERT [dbo].[DS_Usuarios] OFF
GO



GO
SET IDENTITY_INSERT [dbo].[Menu] ON 
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) 
SELECT  1, N'fa fa-home', N'Administracion', N'Usuario', N'Usuarios', N'Administracion', 1, 1, 1 UNION ALL
SELECT  2, N'fa fa-home', N'Administracion', N'Clientes', N'Clientes', N'Administracion', 1, 1, 2 UNION ALL
SELECT  7, N'fa fa-home', N'Realizar Venta', N'Ventas', N'MisClientes', N'Venta', 2, 1, 1 UNION ALL
SELECT  8, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 3, 1, 1 UNION ALL
SELECT  9, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 3, 1, 2 UNION ALL
SELECT  10, N'fa fa-home', N'Reporte', N'Notas de Venta Rechazadas', N'FacturasRechazadas', N'Reporte', 3, 1, 3 UNION ALL
SELECT  11, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 2, 1, 1 UNION ALL
SELECT  12, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 2, 1, 2 UNION ALL
SELECT  13, N'fa fa-home', N'Reporte', N'Notas de Venta Rechazadas', N'FacturasRechazadas', N'Reporte', 2, 1, 3
GO

GO
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO



GO
SET IDENTITY_INSERT [dbo].[DS_UsuarioEmpresa] ON 
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) 
SELECT	1, 2, 1, N'01        '
GO
SET IDENTITY_INSERT [dbo].[DS_UsuarioEmpresa] OFF
GO