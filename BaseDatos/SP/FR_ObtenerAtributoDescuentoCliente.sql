IF OBJECT_ID('[dbo].[FR_ObtenerAtributoDescuentoCliente]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_ObtenerAtributoDescuentoCliente]
	PRINT ('Procedimiento [dbo].[FR_ObtenerAtributoDescuentoCliente] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ObtenerAtributoDescuentoCliente]			*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_ObtenerAtributoDescuentoCliente]
(
	@pv_CodAux VARCHAR(100)
,	@pv_textoAtributo varchar(100)
,	@pv_BaseDatos varchar(100)
)
AS
	declare @query nvarchar(max)

	select @query = ''

	select @query = ' 
		DECLARE @ValorAtributo FLOAT
		DECLARE @CODAUX VARCHAR(200)
		DECLARE @RUTAUX VARCHAR(200)

		SELECT	TOP 1 
				@CODAUX = ''' + @pv_CodAux + '''
		,		@RUTAUX = RutAux
		FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi]
		where	codaux = ''' + @pv_CodAux + '''

		select	@ValorAtributo = convert(int, atv.Valor)
		from	[' + @pv_BaseDatos + '].[softland].[CWTAuxiTTAtr] atc
			left join [' + @pv_BaseDatos + '].[softland].[CWTAuxiTVAtrV] atv 
				on atc.CodTat = atv.CodTat 
		where	atv.codigo = @CODAUX
		and		atc.NombreTipo = ''' + @pv_textoAtributo + '''

		if @ValorAtributo is null begin
			select	aux.RutAux
			,		atv.codigo
			,		atv.Valor 
			from	softland.CWTAuxiTTAtr atc
				left join softland.CWTAuxiTVAtrV atv 
					on atc.CodTat = atv.CodTat 
				left join softland.cwtauxi aux 
					on aux.CodAux = atv.Codigo
			where	atc.NombreTipo = ''' + @pv_textoAtributo + '''
			and		aux.RutAux = @RUTAUX
		end

		select ValorAtributo = @ValorAtributo 
	'
	
	begin try
		select	ValorAtributo = 15
		--EXEC (@query)
	end try
	begin catch
		select	ValorAtributo = 0
	end catch
GO

IF OBJECT_ID('[dbo].[FR_ObtenerAtributoDescuentoCliente]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_ObtenerAtributoDescuentoCliente] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_ObtenerAtributoDescuentoCliente]')
END
GO