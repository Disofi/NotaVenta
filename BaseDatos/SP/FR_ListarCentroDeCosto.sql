IF OBJECT_ID('[dbo].[FR_ListarCentroDeCosto]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ListarCentroDeCosto]
	PRINT ('Procedimiento [dbo].[FR_ListarCentroDeCosto] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarCentroDeCosto]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_ListarCentroDeCosto]
(
	@pv_BaseDatos VARCHAR(100)
)
AS
BEGIN
	declare @query varchar(max)

	select @query = ''

	-- ==========================================================================================  
	-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
	-- ==========================================================================================  
	select @query = @query + '
		select	* 
		from	[' + @pv_BaseDatos + '].[softland].[cwtccos] 
		where	activo = ''S'' 
		and		DescCC != '''' --and CodiCC = 002  
	'

	exec (@query)
end  
GO

IF OBJECT_ID('[dbo].[FR_ListarCentroDeCosto]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListarCentroDeCosto] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListarCentroDeCosto]')
END
