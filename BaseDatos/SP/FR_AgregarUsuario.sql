USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarUsuario]    Script Date: 14-10-2019 16:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FR_AgregarUsuario]
	@Usuario	varchar(10),
	@email	varchar(50),
	@Contrasena varchar(150),
	@tipoUsuario	varchar(50),
	@venCod NCHAR(10),
	@Nombre varchar (100)

 AS
DECLARE @CantVenCod int
SET @CantVenCod	= (SELECT count(*) AS cantidad FROM dbo.DS_Usuarios du WHERE du.VenCod = @venCod AND du.Estado = 1)
if(@CantVenCod = 0)
BEGIN
	INSERT INTO [dbo].[DS_Usuarios] ([Usuario],[Contrasena],[email],[tipoUsuario],[venCod],[Nombre])
		VALUES(@Usuario,(@Contrasena), @email, @tipoUsuario, @venCod, @Nombre)

		SELECT Verificador = cast(1 AS bit),
		Mensaje = 'Usuario Creado'
END
ELSE
SELECT	Verificador = cast(0 AS bit),
		Mensaje = 'Usuario ya Existe'