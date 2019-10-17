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
		and			tp.Inventariable <> 0
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
		,			PrecioVta = tp.PrecioVta
		,			codumed = tp.CodUmed
		,			desumed = ISNULL(detumed.desumed,'''')
		,			CodLista = ''''
		,			Stock = [dbo].[stock2018](tp.CodProd)  
		FROM		[' + @pv_BaseDatos + '].[softland].[iw_tprod] AS tp   
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd   
			--LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd  
			LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tumed] AS detumed on tp.CodUmed = detumed.CodUMed  
		where		tp.Inventariable <> 0
		GROUP BY	tp.CodProd,			tp.DesProd,			tp.CodGrupo,	tp.CodSubGr
		,			tp.PrecioVta,		tp.PrecioVta,		tp.CodUmed,		detumed.desumed
		,			tp.codumedvta1,		tp.codumedvta2,		tp.codumed,		tp.preciovtaum1
		,			tp.preciovtaum1
		ORDER BY	DesProd ASC
		'
		/*
		Msg 4104, Level 16, State 1, Line 18
El identificador formado por varias partes "pd.ValorPct" no se pudo enlazar.
Msg 4104, Level 16, State 1, Line 18
El identificador formado por varias partes "pd.CodUmed" no se pudo enlazar.
Msg 4104, Level 16, State 1, Line 18
El identificador formado por varias partes "detumed.desumed" no se pudo enlazar.
Msg 4104, Level 16, State 1, Line 8
El identificador formado por varias partes "pd.valorPct" no se pudo enlazar.
Msg 4104, Level 16, State 1, Line 9
El identificador formado por varias partes "pd.CodUmed" no se pudo enlazar.
Msg 4104, Level 16, State 1, Line 10
El identificador formado por varias partes "detumed.desumed" no se pudo enlazar.
		*/
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