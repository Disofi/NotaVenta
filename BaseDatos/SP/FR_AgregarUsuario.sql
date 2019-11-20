USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarUsuario]    Script Date: 16-10-2019 13:21:06 ******/
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
	@Nombre varchar (100),
	@BaseDatos int
 AS
DECLARE @CantVenCod int
DECLARE @IdUsuario int
SET @CantVenCod	= (SELECT count(*) AS cantidad FROM dbo.DS_UsuarioEmpresa due JOIN dbo.DS_Usuarios du ON due.IdUsuario=du.ID WHERE due.VenCod = @venCod AND du.Estado = 1)
if(@CantVenCod = 0)
BEGIN
	INSERT INTO [dbo].[DS_Usuarios] ([Usuario],[Contrasena],[email],[tipoUsuario],[Nombre],[Estado])
		VALUES(@Usuario,(@Contrasena), @email, @tipoUsuario, @Nombre,1)
	 
SET @IdUsuario = (SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY])	

	INSERT dbo.DS_UsuarioEmpresa
	(
	    --Id - column value is auto-generated
	    IdUsuario,
	    IdEmpresa,
	    VenCod
	)
	VALUES
	(
	    -- Id - int
	    @IdUsuario, -- IdUsuario - int
	    @BaseDatos, -- IdEmpresa - int
	    @venCod -- VenCod - nchar
	)

		SELECT Verificador = cast(1 AS bit),
		Mensaje = 'Usuario Creado'
END
ELSE
SELECT	Verificador = cast(0 AS bit),
		Mensaje = 'Usuario ya Existe'