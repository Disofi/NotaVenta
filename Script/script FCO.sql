alter PROCEDURE [dbo].[FR_EliminarUsuario]  
@Id int  
AS  
DECLARE @Estado int
SET @Estado	= (SELECT Estado FROM dbo.DS_Usuarios du WHERE du.ID = @Id)
IF(@Estado = 1)
BEGIN

	UPDATE dbo.DS_Usuarios SET dbo.DS_Usuarios.Estado = 0   
	WHERE dbo.DS_Usuarios.ID = @Id  

	SELECT	Verificador = Cast(1 as bit)
	,		Mensaje = 'Se Deshabilito usuario'   
END
ELSE
BEGIN
	UPDATE dbo.DS_Usuarios SET dbo.DS_Usuarios.Estado = 1   
	WHERE dbo.DS_Usuarios.ID = @Id  

	SELECT	Verificador = Cast(1 as bit)
	,		Mensaje = 'Se Habilito usuario'
END
GO



ALTER PROCEDURE [dbo].[FR_AgregarUsuario]
	@Usuario	varchar(10),
	@email	varchar(50),
	@Contrasena varchar(150),
	@tipoUsuario	varchar(50),
	@Nombre varchar (100)
 AS
DECLARE @CantVenCod int
DECLARE @IdUsuario int
SET @CantVenCod	= (SELECT count(*) AS cantidad FROM dbo.DS_Usuarios du WHERE Usuario = @Usuario AND du.Estado = 1)
if(@CantVenCod = 0)
BEGIN
	INSERT INTO [dbo].[DS_Usuarios] ([Usuario],[Contrasena],[email],[tipoUsuario],[Nombre],[Estado])
		VALUES(@Usuario,(@Contrasena), @email, @tipoUsuario, @Nombre,1)
	 
SET @IdUsuario = (SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY])	

		SELECT Verificador = cast(1 AS bit),
		Mensaje = 'Usuario Creado'
END
ELSE
SELECT	Verificador = cast(0 AS bit),
		Mensaje = 'Usuario ya Existe'
		


ALTER procedure [dbo].[DS_GET_ObtenerDatosUsuario]
@IdUsuario int
AS
	SELECT 
	id = u.ID,
	Usuario = u.Usuario,
	Nombre = u.Nombre,
	email = u.email,
	tipoId = u.tipoUsuario,
	tipoUsuario = dut.tipoUsuario
	FROM DS_Usuarios u 
	JOIN dbo.DS_UsuariosTipos dut ON u.tipoUsuario = dut.id
	JOIN dbo.DS_UsuarioEmpresa due ON due.IdUsuario = u.ID
	WHERE u.ID = @IdUsuario	