IF OBJECT_ID('[dbo].[FR_EliminarUsuario]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_EliminarUsuario]
	PRINT ('Procedimiento [dbo].[FR_EliminarUsuario] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_EliminarUsuario]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_EliminarUsuario]  
@Id int  
AS  
	UPDATE dbo.DS_Usuarios SET dbo.DS_Usuarios.Estado = 0   
	WHERE dbo.DS_Usuarios.ID = @Id  

	SELECT	Verificador = Cast(1 as bit)
	,		Mensaje = 'Se elimina usuario'   
GO

IF OBJECT_ID('[dbo].[FR_EliminarUsuario]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_EliminarUsuario] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_EliminarUsuario]')
END
