IF OBJECT_ID('[dbo].[FR_AgregarNVDetalle]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_AgregarNVDetalle]
	PRINT ('Procedimiento [dbo].[FR_AgregarNVDetalle] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_AgregarNVDetalle]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_AgregarNVDetalle]
(
	/*--------------------------- CAMPOS DISOFI ---------------------------*/
	@pv_BaseDatos [varchar](100)
,	@pb_InsertaDisofi BIT
,	@pb_InsertaSoftland BIT
,	@pi_IdNotaVenta INT
	/*--------------------------- CAMPOS SOFTLAND ---------------------------*/
,	@pi_NVNumero int NULL
,	@pf_nvLinea float NULL
,	@pf_nvCorrela float NULL = NULL
,	@pd_nvFecCompr datetime NULL = NULL
,	@pv_CodProd varchar(20) NULL = NULL
,	@pf_nvCant float NULL = NULL
,	@pf_nvPrecio float NULL = NULL
,	@pf_nvEquiv float NULL = NULL
,	@pf_nvSubTotal float NULL = NULL
,	@pf_nvDPorcDesc01 float NULL = NULL
,	@pf_nvDDescto01 float NULL = NULL
,	@pf_nvDPorcDesc02 float NULL = NULL
,	@pf_nvDDescto02 float NULL = NULL
,	@pf_nvDPorcDesc03 float NULL = NULL
,	@pf_nvDDescto03 float NULL = NULL
,	@pf_nvDPorcDesc04 float NULL = NULL
,	@pf_nvDDescto04 float NULL = NULL
,	@pf_nvDPorcDesc05 float NULL = NULL
,	@pf_nvDDescto05 float NULL = NULL
,	@pf_nvTotDesc float NULL = NULL
,	@pf_nvTotLinea float NULL = NULL
,	@pf_nvCantDesp float NULL = NULL
,	@pf_nvCantProd float NULL = NULL
,	@pf_nvCantFact float NULL = NULL
,	@pf_nvCantDevuelto float NULL = NULL
,	@pf_nvCantNC float NULL = NULL
,	@pf_nvCantBoleta float NULL = NULL
,	@pf_nvCantOC float NULL = NULL
,	@pt_DetProd text NULL = NULL
,	@pv_CheckeoMovporAlarmaVtas varchar(1) NULL = NULL
,	@pv_KIT varchar(20) NULL = NULL
,	@pi_CodPromocion int NULL = NULL
,	@pv_CodUMed varchar(6) NULL = NULL
,	@pf_CantUVta float NULL = NULL
,	@pv_Partida varchar(20) NULL = NULL
,	@pv_Pieza varchar(20) NULL = NULL
,	@pd_FechaVencto datetime NULL = NULL
,	@pf_CantidadKit float NULL
,	@pi_MarcaWG int NULL = NULL
,	@pf_PorcIncidenciaKit float NULL
)
AS
BEGIN
	DECLARE	@IdDetalleNotaVenta INT
	DECLARE	@VerificadorDisofi BIT
	DECLARE	@MensajeDisofi VARCHAR(MAX)

	DECLARE	@VerificadorSoftland BIT
	DECLARE	@MensajeSoftland VARCHAR(MAX)

	SELECT	@VerificadorDisofi = 0
	,		@MensajeDisofi = 'No se ejecuto la insercion en disofi'
	,		@VerificadorSoftland = 0
	,		@MensajeDisofi = 'No se ejecuto la insercion en disofi'

	IF @pb_InsertaDisofi = 1 BEGIN
		INSERT INTO [dbo].[DS_NotasVentaDetalle]
		(
			IdNotaVenta
		,	NVNumero
		,	nvLinea
		,	nvCorrela
		,	nvFecCompr
		,	CodProd
		,	nvCant
		,	nvPrecio
		,	nvEquiv
		,	nvSubTotal
		,	nvDPorcDesc01
		,	nvDDescto01
		,	nvDPorcDesc02
		,	nvDDescto02
		,	nvDPorcDesc03
		,	nvDDescto03
		,	nvDPorcDesc04
		,	nvDDescto04
		,	nvDPorcDesc05
		,	nvDDescto05
		,	nvTotDesc
		,	nvTotLinea
		,	nvCantDesp
		,	nvCantProd
		,	nvCantFact
		,	nvCantDevuelto
		,	nvCantNC
		,	nvCantBoleta
		,	nvCantOC
		,	DetProd
		,	CheckeoMovporAlarmaVtas
		,	KIT
		,	CodPromocion
		,	CodUMed
		,	CantUVta
		,	Partida
		,	Pieza
		,	FechaVencto
		,	CantidadKit
		,	MarcaWG
		,	PorcIncidenciaKit
		)
		VALUES
		(
			@pi_IdNotaVenta
		,	@pi_NVNumero
		,	@pf_nvLinea
		,	@pf_nvCorrela
		,	@pd_nvFecCompr
		,	@pv_CodProd
		,	@pf_nvCant
		,	@pf_nvPrecio
		,	@pf_nvEquiv
		,	@pf_nvSubTotal
		,	@pf_nvDPorcDesc01
		,	@pf_nvDDescto01
		,	@pf_nvDPorcDesc02
		,	@pf_nvDDescto02
		,	@pf_nvDPorcDesc03
		,	@pf_nvDDescto03
		,	@pf_nvDPorcDesc04
		,	@pf_nvDDescto04
		,	@pf_nvDPorcDesc05
		,	@pf_nvDDescto05
		,	@pf_nvTotDesc
		,	@pf_nvTotLinea
		,	@pf_nvCantDesp
		,	@pf_nvCantProd
		,	@pf_nvCantFact
		,	@pf_nvCantDevuelto
		,	@pf_nvCantNC
		,	@pf_nvCantBoleta
		,	@pf_nvCantOC
		,	@pt_DetProd
		,	@pv_CheckeoMovporAlarmaVtas
		,	@pv_KIT
		,	@pi_CodPromocion
		,	@pv_CodUMed
		,	@pf_CantUVta
		,	@pv_Partida
		,	@pv_Pieza
		,	@pd_FechaVencto
		,	@pf_CantidadKit
		,	@pi_MarcaWG
		,	@pf_PorcIncidenciaKit
		)

		SELECT	@IdDetalleNotaVenta = @@identity
		
		SELECT	@VerificadorDisofi = 1
		,		@MensajeDisofi = 'Se agrego en disofi satisfactoriamente'
	END
	IF @pb_InsertaSoftland = 1 BEGIN
		EXEC [FR_AgregarNVDetalleSoftland]
			@pi_IdNotaVenta = @pi_IdNotaVenta
		,	@pv_BaseDatos = @pv_BaseDatos
		,	@pi_IdDetalleNotaVenta = @IdDetalleNotaVenta
		,	@pb_Verificador = @VerificadorSoftland out
		,	@pv_Mensaje = @MensajeSoftland out
		,	@pi_NVNumero = @pi_NVNumero out
	END

	SELECT	IdNotaVenta = @pi_IdNotaVenta
	,		IdDetalleNotaVenta = @IdDetalleNotaVenta
	,		NVNumero = @pi_NVNumero
	,		VerificadorDisofi = @VerificadorDisofi
	,		MensajeDisofi = @MensajeDisofi
	,		VerificadorSoftland = @VerificadorSoftland
	,		MensajeSoftland = @MensajeSoftland
END
GO

IF OBJECT_ID('[dbo].[FR_AgregarNVDetalle]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_AgregarNVDetalle] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_AgregarNVDetalle]')
END
GO