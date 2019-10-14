IF OBJECT_ID('[dbo].[FR_ListaProductos]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ListaProductos]
	PRINT ('Procedimiento [dbo].[FR_ListaProductos] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListaProductos]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_ListaProductos]
(
	@pv_ListaProductos varchar(max)
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)
	DECLARE @NOMBRE_TABLA VARCHAR(100)
	SELECT	@NOMBRE_TABLA = 'TABLA' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(100), GETDATE(), 120), '-', '_'), '-', '_'), ' ', '_'), ' ', '_'), ':', '_'), ':', '_')

	select @query = ''

	if @pv_ListaProductos is not null and rtrim(ltrim(@pv_ListaProductos)) <> '' begin
		select @query = @query + '
		--CON LISTA DE PRECIO
		SELECT		DISTINCT   
					CodProd = tp.CodProd
		,			DesProd = ISNULL(tp.DesProd,'''')
		,			codgrupo = ISNULL(tp.CodGrupo,'''')
		,			codsubgr = ISNULL(tp.CodSubGr,'''')
		,			PrecioVta = pd.valorPct
		,			codumed = pd.CodUmed
		,			desumed = ISNULL(detumed.desumed,'''')
		,			CodLista = lp.CodLista
		,			Stock = [dbo].[stock2018](tp.CodProd)  
		FROM		[' + @pv_BaseDatos + '].[softland].[iw_tprod] AS tp   
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd   
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd  
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlispre] AS lp ON pd.CodLista = lp.CodLista   
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed  
		where		lp.CodLista = ''' + @pv_ListaProductos + '''
		GROUP BY	tp.CodProd,			tp.DesProd,			tp.CodGrupo,	tp.CodSubGr
		,			tp.PrecioVta,		pd.ValorPct,		pd.CodUmed,		detumed.desumed
		,			tp.codumedvta1,		tp.codumedvta2,		tp.codumed,		tp.preciovtaum1
		,			tp.preciovtaum1,	lp.CodLista
		ORDER BY	DesProd ASC
		'
	end
	else begin
		select @query = @query + '
		--SIN LISTA DE PRECIO
		SELECT		DISTINCT   
					CodProd = tp.CodProd
		,			DesProd = ISNULL(tp.DesProd,'''')
		,			codgrupo = ISNULL(tp.CodGrupo,'''')
		,			codsubgr = ISNULL(tp.CodSubGr,'''')
		,			PrecioVta = pd.valorPct
		,			codumed = pd.CodUmed
		,			desumed = ISNULL(detumed.desumed,'''')
		,			CodLista = ''''
		,			Stock = [dbo].[stock2018](tp.CodProd)  
		FROM		[' + @pv_BaseDatos + '].[softland].[iw_tprod] AS tp   
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd   
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd  
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed  
		GROUP BY	tp.CodProd,			tp.DesProd,			tp.CodGrupo,	tp.CodSubGr
		,			tp.PrecioVta,		pd.ValorPct,		pd.CodUmed,		detumed.desumed
		,			tp.codumedvta1,		tp.codumedvta2,		tp.codumed,		tp.preciovtaum1
		,			tp.preciovtaum1
		ORDER BY	DesProd ASC
		'
	end

	exec  (@query)
END  
GO

IF OBJECT_ID('[dbo].[FR_ListaProductos]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListaProductos] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListaProductos]')
END