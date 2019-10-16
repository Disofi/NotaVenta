USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[FR_ActualizarCliente]    Script Date: 16-10-2019 13:17:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ActualizarCliente]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
ALTER PROCEDURE [dbo].[FR_ActualizarCliente]  
 @CodAux VARCHAR(10),  
 @RutAux VARCHAR(20),  
 @NomAux VARCHAR(60),   
 @DirAux NCHAR(60),   
 @NomCon VARCHAR(50),  
 @FonCon NCHAR(10),  
 @Email varchar(100),
 @pv_BaseDatos varchar(100)
AS  
DECLARE @query varchar(max)
SELECT @query = ''

SELECT @query = @query + '
BEGIN  	
	 UPDATE ['+@pv_BaseDatos+'].[softland].[cwtauxi]  
	  SET  
	  RutAux = '''+@RutAux+''',
	  NomAux = '''+@NomAux+''',
	  DirAux = '''+@DirAux+''',
	  EMail = '''+@Email+'''
	  WHERE CodAux = '''+@CodAux+'''
  
	 UPDATE ['+@pv_BaseDatos+'].[softland].[cwtaxco]  
	  SET NomCon = '''+@NomCon+''',
	  FonCon = '''+@FonCon+'''

	  WHERE CodAuc = '''+@CodAux+'''

	END  
'
exec (@query)

	  SELECT	Verificador = Cast(1 as bit)
	  ,			Mensaje = 'Se actualiza cliente'
