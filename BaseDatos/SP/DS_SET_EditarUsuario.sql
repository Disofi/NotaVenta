USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[DS_SET_EditarUsuario]    Script Date: 16-10-2019 13:18:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DS_SET_EditarUsuario]
@IdUsuario int,
@Usuario varchar (100),
@Nombre varchar (100),
@Password varchar (max),
@Email varchar (150),
@TipoUsuario int,
@VendCod varchar (15)
AS
DECLARE @Existe int
SET @Existe	= (SELECT count(*) FROM dbo.DS_Usuarios du WHERE du.VenCod = @VendCod)
IF(@Existe = 0)
BEGIN
UPDATE dbo.DS_Usuarios
SET
    --ID - column value is auto-generated
    dbo.DS_Usuarios.Usuario = @Usuario, -- varchar
    dbo.DS_Usuarios.Contrasena = @Password, -- varchar
    dbo.DS_Usuarios.Cliente = '', -- varchar
    dbo.DS_Usuarios.CCosto = '', -- varchar
    dbo.DS_Usuarios.email = @Email, -- varchar
    dbo.DS_Usuarios.tipoUsuario = @TipoUsuario, -- int
    dbo.DS_Usuarios.VenCod = @VendCod, -- nchar
    dbo.DS_Usuarios.Nombre = @Nombre, -- varchar
    dbo.DS_Usuarios.ContrasenaCorreo = '', -- varchar
    dbo.DS_Usuarios.Estado = 1 -- int
	WHERE dbo.DS_Usuarios.ID = @IdUsuario

	SELECT Verificador = cast(1 as bit),
	Mensaje = 'Usuario Modificado'
END
ELSE
BEGIN
SELECT Verificador = cast(0 AS bit),
Mensaje = 'Codigo de Vendedor Ya Existe'
END