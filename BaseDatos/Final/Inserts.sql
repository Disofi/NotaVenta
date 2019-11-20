use DSNotaVenta
GO
SET IDENTITY_INSERT [dbo].[DS_Empresa] ON 
GO
INSERT [dbo].[DS_Empresa] ([Id], [Nombre], [BaseDatos]) 
SELECT	1, N'Asturia', N'AST' UNION ALL
SELECT	2, N'Fabrica', N'FABRICA'
GO
SET IDENTITY_INSERT [dbo].[DS_Empresa] OFF

GO

SET IDENTITY_INSERT [dbo].[DS_Parametros] ON 
GO
INSERT [dbo].[DS_Parametros] ([Id], [IdEmpresa], [MultiEmpresa], [ManejaAdministrador], [ManejaAprobador], [ListaClientesVendedor], [ListaClientesTodos], [ValidaReglasNegocio], [ManejaListaPrecios], [EditaPrecioProducto], [MuestraCondicionVentaCliente], [MuestraCondicionVentaTodos], [EditaDescuentoProducto], [MaximoDescuentoProducto], [CantidadDescuentosProducto], [MuestraStockProducto], [StockProductoEsMasivo], [StockProductoEsBodega], [StockProductoCodigoBodega], [ControlaStockProducto], [EnvioMailCliente], [EnvioMailVendedor], [EnvioMailContacto], [EnvioObligatorioAprobador], [ManejaTallaColor], [ManejaDescuentoTotalDocumento], [CantidadDescuentosTotalDocumento], [CantidadLineas], [ManejaLineaCreditoVendedor], [ManejaLineaCreditoAprobador], [ManejaCanalVenta], [CreacionNotaVentaUsuariosBloqueados], [CreacionNotaVentaUsuariosInactivos], [PermiteModificacionCondicionVenta], [AtributoSoftlandDescuentoCliente], [PermiteCrearDireccion], [CrearClienteConDV], [MuestraUnidadMedidaProducto], [DescuentoLineaDirectoSoftland], [DescuentoTotalDirectoSoftland], [CambioVendedorCliente], [AgregaCliente], [EnvioMailAprobador], [ManejaSaldo]) 
SELECT	5, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, CAST(100.00 AS Decimal(18, 2)), 2, 0, 0, 0, N'', 0, 0, 1, 0, 1, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, N'', 1, 0, 1, 1, 0, 1, 1, 1, 1 UNION ALL
SELECT	6, 2, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, CAST(10.00 AS Decimal(18, 2)), 3, 0, 1, 0, N'', 1, 1, 1, 1, 0, 0, 1, 1, 30, 0, 0, 1, 0, 0, 0, N'', 1, 0, 0, 0, 0, 1, 1, 1, 1
GO
SET IDENTITY_INSERT [dbo].[DS_Parametros] OFF

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

SET IDENTITY_INSERT [dbo].[DS_Usuarios] ON 
GO
INSERT [dbo].[DS_Usuarios] ([ID], [Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [Nombre], [ContrasenaCorreo], [Estado]) 
SELECT	1, N'adm', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 1, N'Admin', N'Disofi2019', 1 UNION ALL
SELECT	2, N'vendedor', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 2, N'Vendedor', N'Disofi2019', 1 UNION ALL
SELECT	3, N'aprobador', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 3, N'Aprobador', N'Disofi2019', 1 UNION ALL
SELECT	7, N'Jbobadilla', N'81dc9bdb52d04dc20036dbd8313ed055', N'', N'', N'palcantara@disofi.cl', 2, N'Jeannette', N'jb12345678', 1 UNION ALL
SELECT	8, N'Jmarican', N'81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, N'juanemilio07@gmail.com', 2, N'Juan Marican ', N'', 1
GO
SET IDENTITY_INSERT [dbo].[DS_Usuarios] OFF

GO

SET IDENTITY_INSERT [dbo].[Menu] ON 
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) 
SELECT	1, N'fa fa-home', N'Administracion', N'Usuario', N'Usuarios', N'Administracion', 1, 1, 1 UNION ALL
SELECT	2, N'fa fa-home', N'Administracion', N'Clientes', N'Clientes', N'Administracion', 1, 1, 2 UNION ALL
SELECT	7, N'fa fa-home', N'Realizar Venta', N'Ventas', N'MisClientes', N'Venta', 2, 1, 1 UNION ALL
SELECT	8, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 3, 1, 1 UNION ALL
SELECT	9, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 3, 1, 2 UNION ALL
SELECT	10, N'fa fa-home', N'Reporte', N'Notas de Venta Rechazadas', N'FacturasRechazadas', N'Reporte', 3, 1, 3
GO
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO

SET IDENTITY_INSERT [dbo].[DS_UsuarioEmpresa] ON
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) 
SELECT	2, 3, 1, N'0         ' UNION ALL
SELECT	3, 7, 1, N'01        ' UNION ALL
SELECT	4, 7, 2, N'01        ' UNION ALL
SELECT	5, 8, 1, N'003       ' UNION ALL
SELECT	6, 2, 1, N'999       ' UNION ALL
SELECT	7, 2, 2, N'999       '
SET IDENTITY_INSERT [dbo].[DS_UsuarioEmpresa] OFF
