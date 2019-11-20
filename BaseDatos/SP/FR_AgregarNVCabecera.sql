IF OBJECT_ID('[dbo].[FR_AgregarNVCabecera]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_AgregarNVCabecera]
	PRINT ('Procedimiento [dbo].[FR_AgregarNVCabecera] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_AgregarNVCabecera]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_AgregarNVCabecera]
(
	/*--------------------------- CAMPOS DISOFI ---------------------------*/
	@pv_EstadoNP [varchar](1) NULL = 'P'
,	@pv_BaseDatos [varchar](100)
,	@pb_InsertaDisofi BIT
,	@pb_InsertaSoftland BIT
,	@pi_IdNotaVenta INT = null
	/*--------------------------- CAMPOS SOFTLAND ---------------------------*/
,	@pi_NVNumero [int] NULL
,	@pd_nvFem [datetime] NULL = NULL
,	@pv_nvEstado [varchar](1) NULL = NULL
,	@pi_nvEstFact [int] NULL = NULL
,	@pi_nvEstDesp [int] NULL = NULL
,	@pi_nvEstRese [int] NULL = NULL
,	@pi_nvEstConc [int] NULL = NULL
,	@pi_CotNum [int] NULL = NULL
,	@pv_NumOC [varchar](12) NULL
,	@pd_nvFeEnt [datetime] NULL = NULL
,	@pv_CodAux [varchar](10) NULL = NULL
,	@pv_VenCod [varchar](4) NULL = NULL
,	@pv_CodMon [varchar](2) NULL = NULL
,	@pv_CodLista [varchar](3) NULL = NULL
,	@pt_nvObser [text] NULL = NULL
,	@pv_nvCanalNV [varchar](3) NULL = NULL
,	@pv_CveCod [varchar](3) NULL = NULL
,	@pv_NomCon [varchar](30) NULL = NULL
,	@pv_CodiCC [varchar](8) NULL = NULL
,	@pv_CodBode [varchar](10) NULL = NULL
,	@pf_nvSubTotal [float] NULL = NULL
,	@pf_nvPorcDesc01 [float] NULL = NULL
,	@pf_nvDescto01 [float] NULL = NULL
,	@pf_nvPorcDesc02 [float] NULL = NULL
,	@pf_nvDescto02 [float] NULL = NULL
,	@pf_nvPorcDesc03 [float] NULL = NULL
,	@pf_nvDescto03 [float] NULL = NULL
,	@pf_nvPorcDesc04 [float] NULL = NULL
,	@pf_nvDescto04 [float] NULL = NULL
,	@pf_nvPorcDesc05 [float] NULL = NULL
,	@pf_nvDescto05 [float] NULL = NULL
,	@pf_nvMonto [float] NULL = NULL
,	@pd_nvFeAprob [datetime] NULL = NULL
,	@pi_NumGuiaRes [int] NULL = NULL
,	@pf_nvPorcFlete [float] NULL = NULL
,	@pf_nvValflete [float] NULL = NULL
,	@pf_nvPorcEmb [float] NULL = NULL
,	@pf_nvValEmb [float] NULL = NULL
,	@pf_nvEquiv [float] NULL = NULL
,	@pf_nvNetoExento [float] NULL = NULL
,	@pf_nvNetoAfecto [float] NULL = NULL
,	@pf_nvTotalDesc [float] NULL = NULL
,	@pv_ConcAuto [varchar](1) NULL = NULL
,	@pv_CodLugarDesp [varchar](30) NULL = NULL
,	@pv_SolicitadoPor [varchar](30) NULL = NULL
,	@pv_DespachadoPor [varchar](30) NULL = NULL
,	@pv_Patente [varchar](9) NULL = NULL
,	@pv_RetiradoPor [varchar](30) NULL = NULL
,	@pv_CheckeoPorAlarmaVtas [varchar](1) NULL = NULL
,	@pi_EnMantencion [int] NULL = NULL
,	@pv_Usuario [varchar](8) NULL = NULL
,	@pv_UsuarioGeneraDocto [varchar](8) NULL = NULL
,	@pd_FechaHoraCreacion [datetime] NULL = NULL
,	@pv_Sistema [varchar](2) NULL = NULL
,	@pv_ConcManual [varchar](1) NULL = NULL
,	@pv_RutSolicitante [varchar](20) NULL = NULL
,	@pv_proceso [varchar](50) NULL = NULL
,	@pf_TotalBoleta [float] NULL = NULL
,	@pi_NumReq [int] NULL
,	@pv_CodVenWeb [varchar](50) NULL = NULL
,	@pv_CodBodeWms [varchar](10) NULL = NULL
,	@pv_CodLugarDocto [varchar](30) NULL = NULL
,	@pv_RutTransportista [varchar](20) NULL = NULL
,	@pv_Cod_Distrib [varchar](10) NULL = NULL
,	@pv_Nom_Distrib [varchar](60) NULL = NULL
,	@pi_MarcaWG [int] NULL = NULL
)
AS
BEGIN
	DECLARE	@VerificadorDisofi BIT
	DECLARE	@MensajeDisofi VARCHAR(MAX)

	DECLARE	@VerificadorSoftland BIT
	DECLARE	@MensajeSoftland VARCHAR(MAX)

	SELECT	@VerificadorDisofi = 0
	,		@MensajeDisofi = 'No se ejecuto la insercion en disofi'
	,		@VerificadorSoftland = 0
	,		@MensajeDisofi = 'No se ejecuto la insercion en disofi'

	IF @pb_InsertaDisofi = 1 BEGIN
		INSERT INTO [dbo].[DS_NotasVenta]
		(
			EstadoNP
		,	NVNumero
		,	nvFem
		,	nvEstado
		,	nvEstFact
		,	nvEstDesp
		,	nvEstRese
		,	nvEstConc
		,	CotNum
		,	NumOC
		,	nvFeEnt
		,	CodAux
		,	VenCod
		,	CodMon
		,	CodLista
		,	nvObser
		,	nvCanalNV
		,	CveCod
		,	NomCon
		,	CodiCC
		,	CodBode
		,	nvSubTotal
		,	nvPorcDesc01
		,	nvDescto01
		,	nvPorcDesc02
		,	nvDescto02
		,	nvPorcDesc03
		,	nvDescto03
		,	nvPorcDesc04
		,	nvDescto04
		,	nvPorcDesc05
		,	nvDescto05
		,	nvMonto
		,	nvFeAprob
		,	NumGuiaRes
		,	nvPorcFlete
		,	nvValflete
		,	nvPorcEmb
		,	nvValEmb
		,	nvEquiv
		,	nvNetoExento
		,	nvNetoAfecto
		,	nvTotalDesc
		,	ConcAuto
		,	CodLugarDesp
		,	SolicitadoPor
		,	DespachadoPor
		,	Patente
		,	RetiradoPor
		,	CheckeoPorAlarmaVtas
		,	EnMantencion
		,	Usuario
		,	UsuarioGeneraDocto
		,	FechaHoraCreacion
		,	Sistema
		,	ConcManual
		,	RutSolicitante
		,	proceso
		,	TotalBoleta
		,	NumReq
		,	CodVenWeb
		,	CodBodeWms
		,	CodLugarDocto
		,	RutTransportista
		,	Cod_Distrib
		,	Nom_Distrib
		,	MarcaWG
		)
		VALUES
		(
			@pv_EstadoNP
		,	@pi_NVNumero
		,	@pd_nvFem
		,	@pv_nvEstado
		,	@pi_nvEstFact
		,	@pi_nvEstDesp
		,	@pi_nvEstRese
		,	@pi_nvEstConc
		,	@pi_CotNum
		,	@pv_NumOC
		,	@pd_nvFeEnt
		,	@pv_CodAux
		,	@pv_VenCod
		,	@pv_CodMon
		,	@pv_CodLista
		,	@pt_nvObser
		,	@pv_nvCanalNV
		,	@pv_CveCod
		,	@pv_NomCon
		,	@pv_CodiCC
		,	@pv_CodBode
		,	@pf_nvSubTotal
		,	@pf_nvPorcDesc01
		,	@pf_nvDescto01
		,	@pf_nvPorcDesc02
		,	@pf_nvDescto02
		,	@pf_nvPorcDesc03
		,	@pf_nvDescto03
		,	@pf_nvPorcDesc04
		,	@pf_nvDescto04
		,	@pf_nvPorcDesc05
		,	@pf_nvDescto05
		,	@pf_nvMonto
		,	@pd_nvFeAprob
		,	@pi_NumGuiaRes
		,	@pf_nvPorcFlete
		,	@pf_nvValflete
		,	@pf_nvPorcEmb
		,	@pf_nvValEmb
		,	@pf_nvEquiv
		,	@pf_nvNetoExento
		,	@pf_nvNetoAfecto
		,	@pf_nvTotalDesc
		,	@pv_ConcAuto
		,	@pv_CodLugarDesp
		,	@pv_SolicitadoPor
		,	@pv_DespachadoPor
		,	@pv_Patente
		,	@pv_RetiradoPor
		,	@pv_CheckeoPorAlarmaVtas
		,	@pi_EnMantencion
		,	@pv_Usuario
		,	@pv_UsuarioGeneraDocto
		,	@pd_FechaHoraCreacion
		,	@pv_Sistema
		,	@pv_ConcManual
		,	@pv_RutSolicitante
		,	@pv_proceso
		,	@pf_TotalBoleta
		,	@pi_NumReq
		,	@pv_CodVenWeb
		,	@pv_CodBodeWms
		,	@pv_CodLugarDocto
		,	@pv_RutTransportista
		,	@pv_Cod_Distrib
		,	@pv_Nom_Distrib
		,	@pi_MarcaWG
		)

		SELECT	@pi_IdNotaVenta = @@identity
		
		SELECT	@VerificadorDisofi = 1
		,		@MensajeDisofi = 'Se agrego en disofi satisfactoriamente'
	END
	IF @pb_InsertaSoftland = 1 BEGIN
		EXEC [FR_AgregarNVCabeceraSoftland]
			@pi_IdNotaVenta = @pi_IdNotaVenta
		,	@pv_BaseDatos = @pv_BaseDatos
		,	@pb_Verificador = @VerificadorSoftland out
		,	@pv_Mensaje = @MensajeSoftland out
		,	@pi_NVNumero = @pi_NVNumero out

		UPDATE	[dbo].[DS_NotasVenta]
		SET		NVNumero = @pi_NVNumero
		WHERE	Id = @pi_IdNotaVenta
	END

	SELECT	IdNotaVenta = @pi_IdNotaVenta
	,		NVNumero = @pi_NVNumero
	,		VerificadorDisofi = @VerificadorDisofi
	,		MensajeDisofi = @MensajeDisofi
	,		VerificadorSoftland = @VerificadorSoftland
	,		MensajeSoftland = @MensajeSoftland
END
GO

IF OBJECT_ID('[dbo].[FR_AgregarNVCabecera]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_AgregarNVCabecera] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_AgregarNVCabecera]')
END
GO