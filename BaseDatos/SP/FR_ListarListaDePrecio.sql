IF OBJECT_ID('[dbo].[FR_ListarListaDePrecio]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ListarListaDePrecio]
	PRINT ('Procedimiento [dbo].[FR_ListarListaDePrecio] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarListaDePrecio]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_ListarListaDePrecio]  
(
	@CodAux varchar(15)  
,	@pv_BaseDatos varchar(100)
)
as  
BEGIN
	declare @query varchar(max)

	select @query = ''

	select @query = @query + '
	DECLARE @contar  int  
  
	SET @contar =	(
						SELECT	count(*)  
						FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi] cliente 
									INNER JOIN [' + @pv_BaseDatos + '].[softland].cwtcvcl condicion 
										on cliente.CodAux = condicion.CodAux 
									INNER JOIN [' + @pv_BaseDatos + '].[softland].iw_tlispre lista 
										on condicion.codlista = lista.CodLista  
						WHERE	condicion.codlista !='''' 
						AND		condicion.codlista IS NOT NULL 
						AND		cliente.CodAux = ''' + @CodAux + '''
					)  
	IF(@contar = 0)	BEGIN  
		Select	Codlista = CodLista
		,		DesLista = DesLista
		from	[' + @pv_BaseDatos + '].[softland].iw_tlispre 
		where	codlista = ''LPW''  
	END
	ELSE BEGIN
		Select	Codlista = condicion.codlista
		,		DesLista = lista.DesLista
		,		CodAux = condicion.codaux   
		FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi] cliente 
			INNER JOIN [' + @pv_BaseDatos + '].[softland].cwtcvcl condicion 
				on cliente.CodAux = condicion.CodAux 
			INNER JOIN [' + @pv_BaseDatos + '].[softland].iw_tlispre lista 
				on condicion.codlista = lista.CodLista
		WHERE	condicion.codlista != ''''
		AND		condicion.codlista IS NOT NULL 
		AND		cliente.CodAux = ''' + @CodAux + '''
	END
	'

	EXEC (@query)
END
GO

IF OBJECT_ID('[dbo].[FR_ListarListaDePrecio]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListarListaDePrecio] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListarListaDePrecio]')
END
