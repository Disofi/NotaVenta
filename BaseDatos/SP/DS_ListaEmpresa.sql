IF OBJECT_ID('[dbo].[DS_ListaEmpresa]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[DS_ListaEmpresa]
	PRINT ('Procedimiento [dbo].[DS_ListaEmpresa] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[DS_ListaEmpresa]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[DS_ListaEmpresa]
AS  
BEGIN
	SELECT	IdEmpresa = a.Id
	,		NombreEmpresa = a.Nombre
	,		BaseDatos = a.BaseDatos
	FROM	DS_Empresa a
END  
GO

IF OBJECT_ID('[dbo].[DS_ListaEmpresa]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[DS_ListaEmpresa] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[DS_ListaEmpresa]')
END
