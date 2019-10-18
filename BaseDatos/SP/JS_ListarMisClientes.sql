USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes]    Script Date: 18-10-2019 12:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarMisClientes]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
ALTER PROCEDURE [dbo].[JS_ListarMisClientes]
	@cod nchar(10)
,	@ID int
,	@pv_BaseDatos varchar(100)
AS
BEGIN
	declare @query nvarchar(max)
	
	select	@query = ''

	select	@query = @query + '
	SELECT top 10	c.CodAux
	,		c.NomAux
	,		c.DirAux
	,		c.DirNum
	,		FonAux1 = 
			CASE	WHEN c.FonAux1 IS NOT NULL 
						THEN c.FonAux1 
					WHEN c.FonAux2 IS NOT NULL 
						THEN c.FonAux2 
						ELSE c.FonAux3 
			END
	,		C.Notas
	,		DeudaVencida = 
			(
				SELECT	isnull(convert (numeric,( (sum(sub_a.DEBE)) - (sum(sub_a.HABER)))), 0)
				from	[' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a
				where	sub_a.CODAUX = c.CodAux
				and		(
							select	isnull(min(MovFv), '''')
							from	[' + @pv_BaseDatos + '].[softland].[cwmovim] sub_cwom
							where	sub_cwom.MovNumDocRef = sub_a.MOVNUMDOCREF and ttdcod= ''FV''
						) < getdate()
				and		MONTH
						(
							(
								select	isnull(min(MovFv), '''')
								from	[' + @pv_BaseDatos + '].[softland].[cwmovim] sub_cwom
								where	sub_cwom.MovNumDocRef = sub_a.MOVNUMDOCREF and ttdcod= ''FV''
							)
						) < getdate()
			)
	,		Deuda = 
			(
				SELECT	isnull(convert (numeric,( (sum(sub_a.DEBE)) - (sum(sub_a.HABER)))), 0)
				FROM	[' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a
				where	sub_a.CODAUX = c.CodAux
			)
	,		Credito = 
			CASE	WHEN	(
								(Select CONVERT(numeric(18,2),vcl.MtoCre)
								From [' + @pv_BaseDatos + '].softland.cwtcvcl as vcl INNER JOIN [' + @pv_BaseDatos + '].softland.CWDocSaldos as doc on
								 vcl.CodAux = c.CodAux and doc.CodAux= vcl.CodAux 
								Group by vcl.MtoCre ) - 
								(SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  [' + @pv_BaseDatos + '].softland.CWDocSaldos
								where CODAUX= c.CodAux)
							) < 0 
						then ''$0''
						ELSE FORMAT((Select CONVERT(numeric(18,2),vcl.MtoCre)
								From [' + @pv_BaseDatos + '].softland.cwtcvcl as vcl INNER JOIN [' + @pv_BaseDatos + '].softland.CWDocSaldos as doc on
								 vcl.CodAux = c.CodAux and doc.CodAux= vcl.CodAux 
								Group by vcl.MtoCre ) - 
								(SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  [' + @pv_BaseDatos + '].softland.CWDocSaldos
								where CODAUX= c.CodAux),''$0'')  
			END
	FROM	[' + @pv_BaseDatos + '].softland.[cwtauxven] A 
		INNER JOIN [' + @pv_BaseDatos + '].softland.cwtauxi C 
			ON (c.CodAux = a.CodAux) 
		INNER JOIN [' + @pv_BaseDatos + '].softland.cwtvend B 
			ON (b.VenCod = a.VenCod) 
		INNER JOIN [dbo].[DS_UsuarioEmpresa] D 
			ON (b.VenCod collate Modern_Spanish_CI_AS = d.VenCod) 
		LEFT JOIN [' + @pv_BaseDatos + '].softland.cwtcvcl as vcl 
			ON vcl.CodAux = A.CodAux
	WHERE	D.VenCod = ' + @cod + '
	and		D.ID = ' + CONVERT(VARCHAR(20), @ID ) + '
	AND		C.Bloqueado	<> ''S''
	'

	EXEC (@query)
END

