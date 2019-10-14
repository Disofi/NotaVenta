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
)
AS  
BEGIN  
	if @pv_ListaProductos is not null and rtrim(ltrim(@pv_ListaProductos)) <> '' begin
		--CON LISTA DE PRECIO
		SELECT		DISTINCT   
					CodProd = tp.CodProd
		,			DesProd = ISNULL(tp.DesProd,'')
		,			codgrupo = ISNULL(tp.CodGrupo,'')
		,			codsubgr = ISNULL(tp.CodSubGr,'')
		,			PrecioVta = pd.valorPct
		,			codumed = pd.CodUmed
		,			desumed = ISNULL(detumed.desumed,'')
		,			CodLista = lp.CodLista
		,			Stock = [dbo].[stock2018]('AB0001')  
		FROM		[KUPPEL].[softland].[iw_tprod] AS tp   
			LEFT JOIN [KUPPEL].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd   
			LEFT JOIN [KUPPEL].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd  
			LEFT JOIN [KUPPEL].[softland].[iw_tlispre] AS lp ON pd.CodLista = lp.CodLista   
			LEFT JOIN [KUPPEL].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed  
		where		lp.CodLista = @pv_ListaProductos
		GROUP BY	tp.CodProd,			tp.DesProd,			tp.CodGrupo,	tp.CodSubGr
		,			tp.PrecioVta,		pd.ValorPct,		pd.CodUmed,		detumed.desumed
		,			tp.codumedvta1,		tp.codumedvta2,		tp.codumed,		tp.preciovtaum1
		,			tp.preciovtaum1,	lp.CodLista
		ORDER BY	DesProd ASC
	end
	else begin
		--SIN LISTA DE PRECIO
		SELECT		DISTINCT   
					CodProd = tp.CodProd
		,			DesProd = ISNULL(tp.DesProd,'')
		,			codgrupo = ISNULL(tp.CodGrupo,'')
		,			codsubgr = ISNULL(tp.CodSubGr,'')
		,			PrecioVta = pd.valorPct
		,			codumed = pd.CodUmed
		,			desumed = ISNULL(detumed.desumed,'')
		,			CodLista = ''
		,			Stock = [DSTexsa_NV].[dbo].[stock2018](tp.CodProd)  
		FROM		[KUPPEL].[softland].[iw_tprod] AS tp   
			LEFT JOIN [KUPPEL].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd   
			LEFT JOIN [KUPPEL].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd  
			LEFT JOIN [KUPPEL].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed  
		GROUP BY	tp.CodProd,			tp.DesProd,			tp.CodGrupo,	tp.CodSubGr
		,			tp.PrecioVta,		pd.ValorPct,		pd.CodUmed,		detumed.desumed
		,			tp.codumedvta1,		tp.codumedvta2,		tp.codumed,		tp.preciovtaum1
		,			tp.preciovtaum1
		ORDER BY	DesProd ASC
	end
END  
GO

IF OBJECT_ID('[dbo].[FR_ListaProductos]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ListaProductos] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ListaProductos]')
END
