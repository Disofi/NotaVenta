USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[RRA_ActualizaEstadoNW]    Script Date: 04-11-2019 8:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[RRA_ActualizaEstadoNW]
 @nvId    varchar(30),
 @pv_BaseDatos varchar (100)
as
begin
	
	declare @obser varchar(200)
	DECLARE @query varchar (max)
	
	set @obser = (select nvObser from dbo.DS_NotasVenta where dbo.DS_NotasVenta.Id = @nvId )

	update dbo.DS_NotasVenta  set EstadoNP = 'A',nvEstado = 'A', nvObser = 'N. Int: '+@nvId+' Obs: '+@obser  where dbo.DS_NotasVenta.Id = @nvId

	--exec dbo.insertaNVSoftland @nvId,@pv_BaseDatos
	
	declare @ultimaNvNumero nvarchar(100) ;
	DECLARE @query1 nvarchar(max);
	SELECT @query1 = N'SELECT @ultimaNvOUT =  max([NVNumero]) + 1  FROM ' + @pv_BaseDatos + '.[softland].[nw_nventa] 
						if (@ultimaNvOUT is null)
						set @ultimaNvOUT = 1';
	DECLARE @ParmDefinition nvarchar(500);  
	SET @ParmDefinition = N'@ultimaNvOUT int OUTPUT';  	
	EXEC sp_executesql @query1, @ParmDefinition, @ultimaNvOUT=@ultimaNvNumero OUTPUT;   

	DECLARE @IdDetalleNotaVenta int
	DECLARE	@VerificadorSoftland BIT
	DECLARE	@MensajeSoftland VARCHAR(MAX)
	
	
	
	EXEC [FR_AgregarNVCabeceraSoftland]
			@pi_IdNotaVenta = @nvId
		,	@pv_BaseDatos = @pv_BaseDatos
		,	@pb_Verificador = @VerificadorSoftland out
		,	@pv_Mensaje = @MensajeSoftland out
		,	@pi_NVNumero = @ultimaNvNumero out
	

	DECLARE CursorNVD CURSOR FOR SELECT	id FROM dbo.DS_NotasVentaDetalle dnvd where idnotaventa = @nvId
	OPEN CursorNVD
	FETCH NEXT FROM CursorNVD INTO @IdDetalleNotaVenta	
	WHILE @@fetch_status = 0
	BEGIN
	EXEC [FR_AgregarNVDetalleSoftland]
			@pi_IdNotaVenta = @nvId
		,	@pv_BaseDatos = @pv_BaseDatos
		,	@pi_IdDetalleNotaVenta = @IdDetalleNotaVenta
		,	@pb_Verificador = @VerificadorSoftland out
		,	@pv_Mensaje = @MensajeSoftland out
		,	@pi_NVNumero = @ultimaNvNumero out	
		FETCH NEXT FROM CursorNVD INTO @IdDetalleNotaVenta	
	END
	CLOSE cursorNVD
	DEALLOCATE CursorNVD	
	
	set @obser = (select nvObser from dbo.DS_NotasVenta where dbo.DS_NotasVenta.Id = @nvId)

	UPDATE dbo.DS_NotasVenta set RutSolicitante = @ultimaNvNumero, nvObser = ' NV: '+@ultimaNvNumero+' Obs: '+@obser  where dbo.DS_NotasVenta.Id = @nvId

	SELECT convert(int,@ultimaNvNumero) 'NVNumero'
END
