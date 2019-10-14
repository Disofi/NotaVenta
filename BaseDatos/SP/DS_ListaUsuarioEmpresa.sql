IF OBJECT_ID('[dbo].[DS_ListaUsuarioEmpresa]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[DS_ListaUsuarioEmpresa]
	PRINT ('Procedimiento [dbo].[DS_ListaUsuarioEmpresa] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[DS_ListaUsuarioEmpresa]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[DS_ListaUsuarioEmpresa]
(
	@pi_IdUsuario INT
)
AS  
BEGIN
	SELECT	IdUsuario = a.IdUsuario
	,		IdEmpresa = a.IdEmpresa
	,		NombreEmpresa = b.Nombre
	,		BaseDatos = b.BaseDatos
	FROM	DS_UsuarioEmpresa a
		INNER JOIN DS_Empresa b
			on a.IdEmpresa = b.Id
	WHERE	a.IdUsuario = @pi_IdUsuario
END  
GO

IF OBJECT_ID('[dbo].[DS_ListaUsuarioEmpresa]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[DS_ListaUsuarioEmpresa] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[DS_ListaUsuarioEmpresa]')
END
