IF OBJECT_ID('[dbo].[SP_GET_LOGIN]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[SP_GET_LOGIN]
	PRINT ('Procedimiento [dbo].[SP_GET_LOGIN] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_GET_LOGIN]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[SP_GET_LOGIN]  
	@Nombre varchar(15),       
	@Contrasena varchar(50)       
as 
begin
	set nocount on       
	
	select	u.Id
	,		u.Usuario
	,		u.TipoUsuario
	from	DS_Usuarios u       
	where	u.Usuario = @Nombre 
	and		u.Contrasena = @Contrasena 
	AND		u.Estado = 1  
	
	set nocount OFF       
end  
GO
GO

IF OBJECT_ID('[dbo].[SP_GET_LOGIN]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[SP_GET_LOGIN] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[SP_GET_LOGIN]')
END
