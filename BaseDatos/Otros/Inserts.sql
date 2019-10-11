﻿--select * from [dbo].[DS_UsuariosTipos]

truncate table [dbo].[DS_Usuarios] 

INSERT [dbo].[DS_Usuarios] ([Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [VenCod], [Nombre], [ContrasenaCorreo], [Estado]) 
SELECT	N'adm', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 1, N'', N'Admin', N'Disofi2019', 1 UNION ALL
SELECT	N'vendedor', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 2, N'02        ', N'Vendedor', N'Disofi2019', 1 UNION ALL
SELECT	N'aprobador', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 3, N'04        ', N'Aprobador', N'Disofi2019', 1

GO

truncate table [dbo].[Menu] 

INSERT [dbo].[Menu] ([TipoUsuario], [Clase], [PieMenu], [Titulo], [Action], [Controller], [Activo], [Orden]) 
SELECT	1, N'fa fa-home', N'Administracion', N'Usuario', N'Usuarios', N'Administracion', 1, 1 UNION ALL
SELECT	1, N'fa fa-home', N'Administracion', N'Clientes', N'Clientes', N'Administracion', 1, 2 UNION ALL
SELECT	1, N'fa fa-home', N'Administracion', N'Parametros', N'Parametros', N'Administracion', 1, 3 UNION ALL
SELECT	1, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 1, 4 UNION ALL
SELECT	1, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 1, 5 UNION ALL
SELECT	1, N'fa fa-home', N'Realizar Venta', N'Ventas', N'MisClientes', N'Venta', 1, 6  UNION ALL

SELECT	2, N'fa fa-home', N'Realizar Venta', N'Ventas', N'MisClientes', N'Venta', 1, 1 UNION ALL

SELECT	3, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 1, 1 UNION ALL
SELECT	3, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 1, 2