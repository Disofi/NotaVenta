USE [DSNotaVenta]
GO
IF OBJECT_ID('[dbo].[FR_BuscarDirecDespa]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_BuscarDirecDespa]
	PRINT ('Procedimiento [dbo].[FR_BuscarDirecDespa] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_BuscarDirecDespa]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_BuscarDirecDespa]
(
	@CodAxD varchar(10)
,	@pv_BaseDatos varchar(100)
)
as
begin
	declare @query varchar(max)

	select @query = ''

	select @query = @query + '
	select	DirDch
	,		ComDch
	,		nomdch 
	from	[' + @pv_BaseDatos + '].[Softland].cwtauxd  
	where	CodAxD = ''' + @CodAxD + ''''

	EXEC (@query)
end  
    
GO

IF OBJECT_ID('[dbo].[FR_BuscarDirecDespa]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_BuscarDirecDespa] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_BuscarDirecDespa]')
END