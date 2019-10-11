IF OBJECT_ID('[dbo].[FR_ActualizarCliente]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ActualizarCliente]
	PRINT ('Procedimiento [dbo].[FR_ActualizarCliente] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ActualizarCliente]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_ActualizarCliente]  
 @CodAux VARCHAR(10),  
 @RutAux VARCHAR(20),  
 @NomAux VARCHAR(60),   
 @DirAux NCHAR(60),   
 @NomCon VARCHAR(50),  
 @FonCon NCHAR(10),  
 @Email varchar(100)  
AS  
BEGIN  
 UPDATE [KUPPEL].[softland].[cwtauxi]  
  SET RutAux=@RutAux, NomAux=@NomAux, DirAux=@DirAux, EMail=@Email WHERE CodAux=@CodAux  
  
 UPDATE [KUPPEL].[softland].[cwtaxco]  
  SET NomCon=@NomCon, FonCon=@FonCon WHERE CodAuc=@CodAux  

  SELECT	Verificador = Cast(1 as bit)
  ,			Mensaje = 'Se actualiza cliente' 

END  
GO

IF OBJECT_ID('[dbo].[FR_ActualizarCliente]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ActualizarCliente] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ActualizarCliente]')
END
