IF OBJECT_ID('[dbo].[FR_ListarCondicionesDeVenta]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ListarCondicionesDeVenta]
	PRINT ('Procedimiento [dbo].[FR_ListarCondicionesDeVenta] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarCondicionesDeVenta]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[FR_ListarCondicionesDeVenta]
(
	@CodAux varchar(15) 
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''

	-- ==========================================================================================  
	-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
	-- ==========================================================================================  
	select @query = @query + '

	declare @contar  int  
	set @contar =	(  
						select	contar = count(ven.CveDes) 
						from	[' + @pv_BaseDatos + '].[softland].[cwtauxi] cliente   
							inner join [' + @pv_BaseDatos + '].[softland].cwtcvcl condicion 
								on cliente.CodAux = condicion.CodAux  
							inner join [' + @pv_BaseDatos + '].[softland].cwtconv ven 
								on condicion.ConVta = ven.CveCod  
						where	condicion.ConVta != ''''
						and		condicion.ConVta is NOT null   
						and		cliente.CodAux = ''' + @CodAux + '''
					)
	
	if(@contar = 0) BEGIN  
		select	cvecod as ConVta
		,		CveDes 
		from	[' + @pv_BaseDatos + '].[softland].cwtconv   
		where	cvecod = ''005''
	END
	ELSE BEGIN  
		select	ven.CveDes
		,		condicion.ConVta
		,		cliente.CodAux 
		from	[' + @pv_BaseDatos + '].[softland].[cwtauxi] cliente   
			INNER JOIN [' + @pv_BaseDatos + '].[softland].cwtcvcl condicion 
				ON cliente.CodAux = condicion.CodAux  
			INNER JOIN [' + @pv_BaseDatos + '].[softland].cwtconv ven 
				ON condicion.ConVta = ven.CveCod  
		WHERE	condicion.ConVta != ''''
		AND		condicion.ConVta is NOT null   
		AND		cliente.CodAux = ''' + @CodAux + '''
	END
	'
	EXEC (@query)
end  
GO

IF OBJECT_ID('[dbo].[FR_ListarCondicionesDeVenta]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListarCondicionesDeVenta] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListarCondicionesDeVenta]')
END
