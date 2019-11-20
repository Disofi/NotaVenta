IF OBJECT_ID('[dbo].[FR_BuscarParametrosUsuarios]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_BuscarParametrosUsuarios]
	PRINT ('Procedimiento [dbo].[FR_BuscarParametrosUsuarios] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_BuscarParametrosUsuarios]					*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
  
CREATE procedure [dbo].[FR_BuscarParametrosUsuarios]
(
	@pi_idEmpresa INT
)
AS
BEGIN  
	SELECT	* 
	FROM	[dbo].[DS_Parametros]
	where	IdEmpresa = @pi_idEmpresa  
END  
GO

IF OBJECT_ID('[dbo].[FR_BuscarParametrosUsuarios]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_BuscarParametrosUsuarios] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_BuscarParametrosUsuarios]')
END
