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
	declare @nombre_tabla_temporal_clientes nvarchar(max)
	declare @nombre_tabla_temporal_gmovi nvarchar(max)
	
	select	@query = ''
	select	@nombre_tabla_temporal_clientes = 'tablaclientestemp'
	select	@nombre_tabla_temporal_gmovi = 'tablagmovitemp'

	select	@query = @query + '
	if object_id(''' + @nombre_tabla_temporal_clientes + ''') is not null begin
		drop table ' + @nombre_tabla_temporal_clientes + '
	end
	
	if object_id(''' + @nombre_tabla_temporal_gmovi + ''') is not null begin
		drop table ' + @nombre_tabla_temporal_gmovi + '
	end

	SELECT	c.CodAux
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
	,		DeudaVencida = cast(null as float)
	,		Deuda = cast(null as float)
	,		Credito = cast(null as float)
	INTO	' + @nombre_tabla_temporal_clientes + '
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

	
	select	sub_cwom.MovNumDocRef
	,		MovFv = isnull(min(MovFv), '''')
	,		AntesFecha = case when isnull(min(sub_cwom.MovFv), '''') < getdate() then 1 else 0 end
	,		AntesMes = case when MONTH(isnull(min(sub_cwom.MovFv), '''')) < getdate() then 1 else 0 end
	,		Vencido = case when convert(datetime, convert(varchar(8), isnull(min(sub_cwom.MovFv), ''20501231''), 112)) < convert(datetime, convert(varchar(8), getdate(), 112)) then 1 else 0 end
	into	' + @nombre_tabla_temporal_gmovi + '
	from	[transporte].[softland].[cwmovim] sub_cwom
	where	ttdcod= ''FV''
	group by sub_cwom.MovNumDocRef
	

	select	codaux
	,		case when Vencido = 1 then sum(DEBE - HABER) else 0 end
	from	(
				SELECT	codaux = sub_a.codaux
				,		DEBE = isnull(sub_a.DEBE, 0)
				,		HABER = isnull(sub_a.HABER, 0)
				,		MovNumDocRef = sub_a.MovNumDocRef
				,		sub_b.Vencido
				from	[' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a
					inner join ' + @nombre_tabla_temporal_gmovi + ' sub_b
						on sub_a.MovNumDocRef = sub_b.MovNumDocRef
				WHERE	sub_a.CodAux in (select sub_sub_a.codaux from ' + @nombre_tabla_temporal_clientes + ' sub_sub_a)
			) a
	group by codaux, MovNumDocRef, Vencido

	--SELECT * FROM ' + @nombre_tabla_temporal_gmovi + '








	declare @codaux varchar(30)

	IF CURSOR_STATUS(''global'',''cursor_filas'')>=-1 BEGIN
	 DEALLOCATE cursor_filas
	END

	declare cursor_filas cursor for
		select	CodAux
		from	' + @nombre_tabla_temporal_clientes + '

	open cursor_filas 

	fetch next from cursor_filas 
	into @codaux

	while @@fetch_status = 0 begin

		fetch next from cursor_filas 
		into @codaux
	end

	close cursor_filas 
	deallocate cursor_filas 


	--select	*
	--from	' + @nombre_tabla_temporal_clientes + '
	
	if object_id(''' + @nombre_tabla_temporal_clientes + ''') is not null begin
		drop table ' + @nombre_tabla_temporal_clientes + '
	end
	
	if object_id(''' + @nombre_tabla_temporal_gmovi + ''') is not null begin
		drop table ' + @nombre_tabla_temporal_gmovi + '
	end
	'

	exec (@query)
END

GO

EXEC [dbo].[JS_ListarMisClientes]
								@cod = '15'
,								@ID = 2
,								@pv_BaseDatos = 'TRANSPORTE'
