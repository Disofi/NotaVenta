IF OBJECT_ID('[dbo].[FR_ListarContactos]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ListarContactos]
	PRINT ('Procedimiento [dbo].[FR_ListarContactos] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarContactos]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
  
CREATE procedure [dbo].[FR_ListarContactos]  
	@CodAuc varchar(10)  
,	@NomCon varchar(30)
,	@pv_BaseDatos varchar(100)  
as  
BEGIN  
	declare @query varchar(max)

	select @query = ''
	
	select @query = @query + '
	SELECT	ven.CodAuc as CodAux
	,		ven.NomCon       
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi] dir 
		INNER JOIN [' + @pv_BaseDatos + '].[softland].[cwtaxco] ven 
			ON ven.CodAuc = dir.CodAux   
	WHERE	CodAuc = ''' + @CodAuc + '''
	'

	EXEC (@query)
END
GO

IF OBJECT_ID('[dbo].[FR_ListarContactos]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListarContactos] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListarContactos]')
END
