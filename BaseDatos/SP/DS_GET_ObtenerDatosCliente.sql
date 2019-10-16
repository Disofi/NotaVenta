USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosUsuario]    Script Date: 16-10-2019 13:27:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[DS_GET_ObtenerDatosUsuario]
@IdUsuario int,
@pv_BaseDatos varchar (100)
AS
DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '
	SELECT 
	id = u.ID,
	Usuario = u.Usuario,
	Nombre = u.Nombre,
	email = u.email,
	tipoId = u.tipoUsuario,
	VenCod = due.VenCod,
	tipoUsuario = dut.tipoUsuario,
	VenDes = c.VenDes
	FROM DS_Usuarios u 
	JOIN dbo.DS_UsuariosTipos dut ON u.tipoUsuario = dut.id
	JOIN dbo.DS_UsuarioEmpresa due ON due.IdUsuario = u.ID
	JOIN ['+@pv_BaseDatos+'].softland.cwtvend c ON c.VenCod COLLATE Modern_Spanish_CI_AS = due.VenCod
	WHERE u.ID = ' + CONVERT(VARCHAR(20), @IdUsuario) + '
'

EXEC (@query)
