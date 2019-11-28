USE [DSNotaVenta]
GO
/****** Object:  Table [dbo].[DS_Empresa]    Script Date: 19-11-2019 14:45:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Empresa](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[BaseDatos] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_NotasVenta]    Script Date: 19-11-2019 14:45:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_NotasVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EstadoNP] [varchar](1) NULL,
	[NVNumero] [int] NOT NULL,
	[nvFem] [datetime] NULL,
	[nvEstado] [varchar](1) NULL,
	[nvEstFact] [int] NULL,
	[nvEstDesp] [int] NULL,
	[nvEstRese] [int] NULL,
	[nvEstConc] [int] NULL,
	[CotNum] [int] NULL,
	[NumOC] [varchar](12) NOT NULL,
	[nvFeEnt] [datetime] NULL,
	[CodAux] [varchar](10) NULL,
	[VenCod] [varchar](4) NULL,
	[CodMon] [varchar](2) NULL,
	[CodLista] [varchar](3) NULL,
	[nvObser] [text] NULL,
	[nvCanalNV] [varchar](3) NULL,
	[CveCod] [varchar](3) NULL,
	[NomCon] [varchar](30) NULL,
	[CodiCC] [varchar](8) NULL,
	[CodBode] [varchar](10) NULL,
	[nvSubTotal] [float] NULL,
	[nvPorcDesc01] [float] NULL,
	[nvDescto01] [float] NULL,
	[nvPorcDesc02] [float] NULL,
	[nvDescto02] [float] NULL,
	[nvPorcDesc03] [float] NULL,
	[nvDescto03] [float] NULL,
	[nvPorcDesc04] [float] NULL,
	[nvDescto04] [float] NULL,
	[nvPorcDesc05] [float] NULL,
	[nvDescto05] [float] NULL,
	[nvMonto] [float] NULL,
	[nvFeAprob] [datetime] NULL,
	[NumGuiaRes] [int] NULL,
	[nvPorcFlete] [float] NULL,
	[nvValflete] [float] NULL,
	[nvPorcEmb] [float] NULL,
	[nvValEmb] [float] NULL,
	[nvEquiv] [float] NULL,
	[nvNetoExento] [float] NULL,
	[nvNetoAfecto] [float] NULL,
	[nvTotalDesc] [float] NULL,
	[ConcAuto] [varchar](1) NULL,
	[CodLugarDesp] [varchar](30) NULL,
	[SolicitadoPor] [varchar](30) NULL,
	[DespachadoPor] [varchar](30) NULL,
	[Patente] [varchar](9) NULL,
	[RetiradoPor] [varchar](30) NULL,
	[CheckeoPorAlarmaVtas] [varchar](1) NULL,
	[EnMantencion] [int] NULL,
	[Usuario] [varchar](8) NULL,
	[UsuarioGeneraDocto] [varchar](8) NULL,
	[FechaHoraCreacion] [datetime] NULL,
	[Sistema] [varchar](2) NULL,
	[ConcManual] [varchar](1) NULL,
	[RutSolicitante] [varchar](20) NULL,
	[proceso] [varchar](50) NULL,
	[TotalBoleta] [float] NULL,
	[NumReq] [int] NOT NULL,
	[CodVenWeb] [varchar](50) NULL,
	[CodBodeWms] [varchar](10) NULL,
	[CodLugarDocto] [varchar](30) NULL,
	[RutTransportista] [varchar](20) NULL,
	[Cod_Distrib] [varchar](10) NULL,
	[Nom_Distrib] [varchar](60) NULL,
	[MarcaWG] [int] NULL,
	[ErrorAprobador] [bit] NULL,
	[ErrorAprobadorMensaje] varchar(max) NULL,
 CONSTRAINT [DS_NotasVenta_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_NotasVentaDetalle]    Script Date: 19-11-2019 14:45:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_NotasVentaDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdNotaVenta] [int] NULL,
	[NVNumero] [int] NOT NULL,
	[nvLinea] [float] NOT NULL,
	[nvCorrela] [float] NULL,
	[nvFecCompr] [datetime] NULL,
	[CodProd] [varchar](20) NULL,
	[nvCant] [float] NULL,
	[nvPrecio] [float] NULL,
	[nvEquiv] [float] NULL,
	[nvSubTotal] [float] NULL,
	[nvDPorcDesc01] [float] NULL,
	[nvDDescto01] [float] NULL,
	[nvDPorcDesc02] [float] NULL,
	[nvDDescto02] [float] NULL,
	[nvDPorcDesc03] [float] NULL,
	[nvDDescto03] [float] NULL,
	[nvDPorcDesc04] [float] NULL,
	[nvDDescto04] [float] NULL,
	[nvDPorcDesc05] [float] NULL,
	[nvDDescto05] [float] NULL,
	[nvTotDesc] [float] NULL,
	[nvTotLinea] [float] NULL,
	[nvCantDesp] [float] NULL,
	[nvCantProd] [float] NULL,
	[nvCantFact] [float] NULL,
	[nvCantDevuelto] [float] NULL,
	[nvCantNC] [float] NULL,
	[nvCantBoleta] [float] NULL,
	[nvCantOC] [float] NULL,
	[DetProd] [text] NULL,
	[CheckeoMovporAlarmaVtas] [varchar](1) NULL,
	[KIT] [varchar](20) NULL,
	[CodPromocion] [int] NULL,
	[CodUMed] [varchar](6) NULL,
	[CantUVta] [float] NULL,
	[Partida] [varchar](20) NULL,
	[Pieza] [varchar](20) NULL,
	[FechaVencto] [datetime] NULL,
	[CantidadKit] [float] NOT NULL,
	[MarcaWG] [int] NULL,
	[PorcIncidenciaKit] [float] NOT NULL,
 CONSTRAINT [DS_NotasVentaDetalle_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_Parametros]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Parametros](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NULL,
	[MultiEmpresa] [bit] NULL,
	[ManejaAdministrador] [bit] NULL,
	[ManejaAprobador] [bit] NULL,
	[ListaClientesVendedor] [bit] NULL,
	[ListaClientesTodos] [bit] NULL,
	[ValidaReglasNegocio] [bit] NULL,
	[ManejaListaPrecios] [bit] NULL,
	[EditaPrecioProducto] [bit] NULL,
	[MuestraCondicionVentaCliente] [bit] NULL,
	[MuestraCondicionVentaTodos] [bit] NULL,
	[EditaDescuentoProducto] [bit] NULL,
	[MaximoDescuentoProducto] [decimal](18, 2) NULL,
	[CantidadDescuentosProducto] [int] NULL,
	[MuestraStockProducto] [bit] NULL,
	[StockProductoEsMasivo] [bit] NULL,
	[StockProductoEsBodega] [bit] NULL,
	[StockProductoCodigoBodega] [varchar](1000) NULL,
	[ControlaStockProducto] [bit] NULL,
	[EnvioMailCliente] [bit] NULL,
	[EnvioMailVendedor] [bit] NULL,
	[EnvioMailContacto] [bit] NULL,
	[EnvioObligatorioAprobador] [bit] NULL,
	[ManejaTallaColor] [bit] NULL,
	[ManejaDescuentoTotalDocumento] [bit] NULL,
	[CantidadDescuentosTotalDocumento] [int] NULL,
	[CantidadLineas] [int] NULL,
	[ManejaLineaCreditoVendedor] [bit] NULL,
	[ManejaLineaCreditoAprobador] [bit] NULL,
	[ManejaCanalVenta] [bit] NULL,
	[CreacionNotaVentaUsuariosBloqueados] [bit] NULL,
	[CreacionNotaVentaUsuariosInactivos] [bit] NULL,
	[PermiteModificacionCondicionVenta] [bit] NULL,
	[AtributoSoftlandDescuentoCliente] [varchar](1000) NULL,
	[PermiteCrearDireccion] [bit] NULL,
	[CrearClienteConDV] [bit] NULL,
	[MuestraUnidadMedidaProducto] [bit] NULL,
	[DescuentoLineaDirectoSoftland] [bit] NULL,
	[DescuentoTotalDirectoSoftland] [bit] NULL,
	[CambioVendedorCliente] [bit] NULL,
	[AgregaCliente] [bit] NULL,
	[EnvioMailAprobador] [bit] NULL,
	[ManejaSaldo] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_UsuarioEmpresa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_UsuarioEmpresa](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[IdEmpresa] [int] NULL,
	[VenCod] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_Usuarios]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Usuarios](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](10) NOT NULL,
	[Contrasena] [varchar](max) NULL,
	[Cliente] [varchar](50) NULL,
	[CCosto] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[tipoUsuario] [int] NULL,
	[Nombre] [varchar](150) NULL,
	[ContrasenaCorreo] [varchar](100) NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_UsuariosTipos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_UsuariosTipos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[tipoUsuario] [varchar](20) NOT NULL,
	[urlInicio] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[Id_Menu] [int] IDENTITY(1,1) NOT NULL,
	[Clase] [varchar](150) NULL,
	[PieMenu] [varchar](150) NULL,
	[Titulo] [varchar](150) NULL,
	[Action] [varchar](150) NULL,
	[Controller] [varchar](150) NULL,
	[TipoUsuario] [int] NULL,
	[Activo] [int] NULL,
	[Orden] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id_Menu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tabla]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tabla](
	[CodAux] [varchar](10) NOT NULL,
	[NomAux] [varchar](60) NULL,
	[DirAux] [varchar](60) NULL,
	[DirNum] [varchar](10) NULL,
	[FonAux1] [varchar](15) NULL,
	[Notas] [text] NULL,
	[DeudaVencida] [float] NULL,
	[Deuda] [float] NULL,
	[Credito] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TABLA2019_10_14_11_39_59]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA2019_10_14_11_39_59](
	[CodProd] [varchar](20) NOT NULL,
	[Cantidad] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DS_Parametros] ADD  DEFAULT ((0)) FOR [CambioVendedorCliente]
GO
/****** Object:  StoredProcedure [dbo].[DS_AddCliente]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_AddCliente]
@CodAux varchar (15),
@NomAux varchar(60),
@RutAux varchar (20),
@FonAux1 varchar (15),
@Email varchar (250),
@GirAux varchar (3),
@DirAux varchar (250),
@pv_BaseDatos varchar (100),
@EmailDte varchar (150),
@VenCod varchar (25)
AS
	DECLARE @query varchar (max)
	SELECT @query = ''
	SELECT @query = '

	DECLARE @existe int 

	SET @existe = (SELECT count(*) FROM ['+@pv_BaseDatos+'].softland.cwtauxi where CodAux = '''+@CodAux+''')
	if(@existe = 0)
	BEGIN
	INSERT INTO ['+@pv_BaseDatos+'].softland.cwtauxi (Codaux,NomAux,RutAux,ActAux,GirAux,FonAux1,ClaCli,ClaPro,ClaEmp,ClaSoc,ClaDis,ClaOtr,Bloqueado,Email,eMailDTE) values
	('''+@CodAux+''','''+@NomAux+''','''+@RutAux+''',''S'','''+@GirAux+''','''+@FonAux1+''',''S'',''N'',''N'',''N'',''N'',''N'',''N'','''+@Email+''','''+@EmailDte+''');
	
	INSERT INTO ['+@pv_BaseDatos+'].softland.cwtauxd (CodAxD,NomDch,DirDch) VALUES
	('''+@CodAux+''','''+@DirAux+''','''+@DirAux+''');
	
	INSERT INTO ['+@pv_BaseDatos+'].softland.cwtauxven (CodAux,VenCod,Usuario) values
	('''+@CodAux+''','''+@VenCod+''','''+@NomAux+''')

		SELECT Verificador = cast(1 AS bit),
		Mensaje = ''Cliente Creado''
	END
	else
	BEGIN
		SELECT Verificador = cast(0 AS bit),
		Mensaje = ''Cliente ya Existe''
	END
	'
	EXEC (@query)
	
	
	

		





GO
/****** Object:  StoredProcedure [dbo].[DS_AgregarCorreoCli]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_AgregarCorreoCli]
@CodAux varchar (50),
@Email varchar (150),
@pv_BaseDatos varchar (100)
AS
DECLARE @query varchar(max)
SELECT @query = ''
SELECT @query = @query + '
UPDATE '+@pv_BaseDatos+'.softland.cwtauxi
SET
   cwtauxi.EMail = '''+@Email+'''
   where cwtauxi.CodAux = '''+@CodAux	+'''

   SELECT 1
'
exec (@query)
GO
/****** Object:  StoredProcedure [dbo].[DS_AgregarDireccionDespacho]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[DS_AgregarDireccionDespacho]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[DS_AgregarDireccionDespacho]
(
	@pv_CodAux varchar(500)
,	@pv_DirDch varchar(500)
,	@pv_ComDch varchar(500)
,	@pv_NomDch varchar(500)
,	@pv_CiuDch varchar(500)
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''

	select @query = @query + '
	IF NOT EXISTS (SELECT TOP 1 1 FROM [' + @pv_BaseDatos + '].[softland].[cwtauxd] WHERE CodAxD = ''' + @pv_CodAux + ''' AND NomDch = ''' + @pv_NomDch + ''') BEGIN
		INSERT INTO [' + @pv_BaseDatos + '].[softland].[cwtauxd]
		(
			CodAxD
		,	DirDch
		,	ComDch
		,	NomDch
		,	CiuDch
		)
		VALUES
		(
			''' + @pv_CodAux + '''
		,	''' + @pv_DirDch + '''
		,	''' + @pv_ComDch + '''
		,	''' + @pv_NomDch + '''
		,	''' + @pv_CiuDch + '''
		)

		SELECT	Verificador = Cast(1 as bit)
		,		Mensaje = ''Se agrega direccion de despacho satisfactoriamente''
	END
	ELSE BEGIN
		SELECT	Verificador = Cast(0 as bit)
		,		Mensaje = ''Direccion ingresada ya existe''
	END
	'

	EXEC (@query)
END  
GO
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosCliente]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_GET_ObtenerDatosCliente]
@CodAux varchar (50),
@pv_BaseDatos varchar (100)
as
declare @query varchar (max)

select @query = ''

select @query = @query + '
	select 
	EMail = clientes.EMail,
	CodAux = clientes.CodAux,
	NomAux = clientes.[NomAux],
	RutAux = clientes.[RutAux],
	DirAux = clientes.[DirAux] ,
	DirNum = clientes.[DirNum], 
	NomCon = contacto.[NomCon] , 
	FonCon = contacto.[FonCon]
	from ['+@pv_BaseDatos+'].[softland].[cwtauxi] clientes
	inner join ['+@pv_BaseDatos+'].[softland].[cwtaxco] contacto on clientes.CodAux = contacto.CodAuc 
	WHERE clientes.CodAux = '''+@CodAux+'''
'
exec (@query)
GO
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosUsuario]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DS_GET_ObtenerDatosUsuario]
@IdUsuario int
AS
	SELECT 
	id = u.ID,
	Usuario = u.Usuario,
	Nombre = u.Nombre,
	email = u.email,
	tipoId = u.tipoUsuario,
	tipoUsuario = dut.tipoUsuario
	FROM DS_Usuarios u 
	LEFT JOIN dbo.DS_UsuariosTipos dut ON u.tipoUsuario = dut.id
	LEFT JOIN dbo.DS_UsuarioEmpresa due ON due.IdUsuario = u.ID
	WHERE u.ID = @IdUsuario	
GO
/****** Object:  StoredProcedure [dbo].[DS_GetAprobador]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_GetAprobador]
@IdAprobador int
as
SELECT 
Email = email, 
Contrasena = ContrasenaCorreo 
FROM dbo.DS_Usuarios du
WHERE ID = @IdAprobador
GO
/****** Object:  StoredProcedure [dbo].[DS_GetAprobadorNP]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_GetAprobadorNP]
AS
SELECT * FROM dbo.DS_Usuarios du	WHERE du.tipoUsuario = 3
GO
/****** Object:  StoredProcedure [dbo].[DS_GetCab]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_GetCab]
@nvId int
AS
SELECT CodAux, VenCod, NVNumero FROM dbo.DS_NotasVenta dnv WHERE dnv.Id = @nvId
GO
/****** Object:  StoredProcedure [dbo].[DS_ListaEmpresa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[DS_ListaEmpresa]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[DS_ListaEmpresa]
AS  
BEGIN
	SELECT	IdEmpresa = a.Id
	,		NombreEmpresa = a.Nombre
	,		BaseDatos = a.BaseDatos
	FROM	DS_Empresa a
END  
GO
/****** Object:  StoredProcedure [dbo].[DS_ListarPefiles]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_ListarPefiles]
AS
SELECT dut.ID, dut.tipoUsuario AS TipoUsuario FROM dbo.DS_UsuariosTipos dut
GO
/****** Object:  StoredProcedure [dbo].[DS_ListaUsuarioEmpresa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[DS_ListaUsuarioEmpresa]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[DS_ListaUsuarioEmpresa]
(
	@pi_IdUsuario INT
)
AS  
BEGIN
	SELECT	IdUsuario = a.IdUsuario
	,		IdEmpresa = a.IdEmpresa
	,		NombreEmpresa = b.Nombre
	,		BaseDatos = b.BaseDatos
	,		VenCod = a.VenCod	
	,		tipoUsuario = du.tipoUsuario
	FROM	DS_UsuarioEmpresa a
		INNER JOIN DS_Empresa b
			on a.IdEmpresa = b.Id
			JOIN dbo.DS_Usuarios du ON a.IdUsuario = du.Id
	WHERE	a.IdUsuario = @pi_IdUsuario
END  
GO
/****** Object:  StoredProcedure [dbo].[DS_ObtenerSaldo]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext ds_obtenersaldo

create PROCEDURE [dbo].[DS_ObtenerSaldo]  
@RutAux varchar (20),  
@CodAux varchar (50),  
@pv_BaseDatos varchar (100)  
AS  
BEGIN  
DECLARE @query varchar (max)  
SELECT @query = ''  
SELECT @query = '
SELECT mov.pccodi, mov.pcdesc, mov.codaux, mov.RutAux, mov.nomaux, mov.fechaemi, mov.fechaven, desdoc, mov.movnumdocref, mov.Saldo,    mov.DesArn ,    mov.AreaCod ,    
mov.PCAUXI, mov.PCCDOC, mov.coddoc, mov.VendCod, mov.Vendedor, mov.FecEmi , mov.Debe, mov.Haber, mov.movtipdocref, mov.movfv
FROM
(select cwpctas.pccodi, cwpctas.pcdesc, cwtauxi.codaux, cwtauxi.RutAux, cwtauxi.nomaux, min(cwmovim.movfe) as fechaemi, 
''                                                    '' as fechaven, cwttdoc.desdoc, cwmovim.movnumdocref, cwmovim.movtipdocref,min(cwmovim.MovFv) as MovFv,
sum(cwmovim.movdebe - cwmovim.movhaber) as Saldo, min(cwmovim.MovDebe) as Debe, min(cwmovim.MovHaber) as Haber, cwmovim.AreaCod, cwTAren.DesArn , cwpctas.PCAUXI, cwpctas.PCCDOC,  
cwttdoc.coddoc, 
''    '' As Cpbano ,  ''    '' as VendCod,''                                                                                           '' as Vendedor,
''                                                    '' as FecEmi  
FROM [' + @pv_BaseDatos + '].softland.cwcpbte 
inner join [' + @pv_BaseDatos + '].softland.cwmovim on cwcpbte.cpbano = cwmovim.cpbano and cwcpbte.cpbnum = cwmovim.cpbnum 
inner join [' + @pv_BaseDatos + '].softland.cwtauxi on cwtauxi.codaux = cwmovim.codaux 
inner join [' + @pv_BaseDatos + '].softland.cwpctas on cwmovim.pctcod = cwpctas.pccodi 
left join [' + @pv_BaseDatos + '].softland.cwttdoc on cwmovim.movtipdocref = cwttdoc.coddoc 
left join [' + @pv_BaseDatos + '].softland.cwtaren on cwmovim.AreaCod = cwTAren.CodArn 
WHERE
	(((cwcpbte.cpbNum <> ''00000000'')  
or (cwcpbte.cpbano = (select min(cpbano) from [' + @pv_BaseDatos + '].softland.cwcpbte) AND cwcpbte.cpbNum = ''00000000'' ))) 
and (cwcpbte.cpbest = ''V'') 
			and cwmovim.codaux = ''' + @CodAux + '''
and (CWCpbte.CpbFec <= convert(datetime,CONVERT(varchar, CURRENT_TIMESTAMP),102)) 
Group By cwpctas.pccodi , cwpctas.pcdesc, cwtauxi.codaux, cwtauxi.RutAux, cwmovim.movnumdocref, cwtauxi.nomaux, 
cwttdoc.desdoc, cwmovim.AreaCod, cwTAren.DesArn, cwpctas.PCAUXI, cwpctas.PCCDOC,  cwttdoc.coddoc , cwmovim.movtipdocref
Having (Sum((cwmovim.movdebe - cwmovim.movhaber)) <> 0) 
) as mov
'
exec(@query)  
END  
go
/****** Object:  StoredProcedure [dbo].[DS_DocumentosSaldados]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext DS_DocumentosSaldados

create PROCEDURE [dbo].[DS_DocumentosSaldados]  
@RutAux varchar (20),  
@CodAux varchar (50),  
@pv_BaseDatos varchar (100),
@cantidadDocumentos int = 1  
AS  
BEGIN  
DECLARE @query varchar (max)  
SELECT @query = ''  
SELECT @query = '
  
--Este sería el query. Saludos
select	a.areacod
,		a.pcdesc
,		a.codaux
,		a.nomaux
,		b.ttdcod
,		b.numdoc
,		b.movfe as fechaemi --fecha emision
,		b.movfv --fecha vencimiento
,		a.movtipdocref
,		a.movnumdocref
,		b.movdebe
,		b.movhaber
,		a.Saldo
,		b.movglosa
,		DiasVen = (DATEDIFF(day,a.MovFv,CURRENT_TIMESTAMP))
from	(
			SELECT top ' + convert(varchar(20), @cantidadDocumentos) + ' mov.pccodi, mov.pcdesc, mov.codaux, mov.RutAux, mov.nomaux, mov.fechaemi, mov.fechaven, desdoc, mov.movnumdocref, mov.Saldo,    mov.DesArn ,    mov.AreaCod ,    
			mov.PCAUXI, mov.PCCDOC, mov.coddoc, mov.VendCod, mov.Vendedor, mov.FecEmi , mov.Debe, mov.Haber, mov.movtipdocref, mov.MovFv
			FROM
			(select cwpctas.pccodi, cwpctas.pcdesc, cwtauxi.codaux, cwtauxi.RutAux, cwtauxi.nomaux, min(cwmovim.movfe) as fechaemi, 
			''                                                    '' as fechaven, cwttdoc.desdoc, cwmovim.movnumdocref, cwmovim.movtipdocref,min(cwmovim.MovFv) as MovFv,
			sum(cwmovim.movdebe - cwmovim.movhaber) as Saldo, min(cwmovim.MovDebe) as Debe, min(cwmovim.MovHaber) as Haber, cwmovim.AreaCod, cwTAren.DesArn , cwpctas.PCAUXI, cwpctas.PCCDOC,  
			cwttdoc.coddoc, 
			''    '' As Cpbano ,  ''    '' as VendCod,''                                                                                           '' as Vendedor,
			''                                                    '' as FecEmi  
			FROM [' + @pv_BaseDatos + '].softland.cwcpbte 
			inner join [' + @pv_BaseDatos + '].softland.cwmovim on cwcpbte.cpbano = cwmovim.cpbano and cwcpbte.cpbnum = cwmovim.cpbnum 
			inner join [' + @pv_BaseDatos + '].softland.cwtauxi on cwtauxi.codaux = cwmovim.codaux 
			inner join [' + @pv_BaseDatos + '].softland.cwpctas on cwmovim.pctcod = cwpctas.pccodi 
			left join [' + @pv_BaseDatos + '].softland.cwttdoc on cwmovim.movtipdocref = cwttdoc.coddoc 
			left join [' + @pv_BaseDatos + '].softland.cwtaren on cwmovim.AreaCod = cwTAren.CodArn 
			WHERE

			 (((cwcpbte.cpbNum <> ''00000000'')  
			or (cwcpbte.cpbano = (select min(cpbano) from [' + @pv_BaseDatos + '].softland.cwcpbte) AND cwcpbte.cpbNum = ''00000000'' ))) 


			and (cwcpbte.cpbest = ''V'') 

						and cwmovim.codaux = ''' + @CodAux + '''
			and (CWCpbte.CpbFec <= convert(datetime,CONVERT(varchar, CURRENT_TIMESTAMP),102)) 
			Group By cwpctas.pccodi , cwpctas.pcdesc, cwtauxi.codaux, cwtauxi.RutAux, cwmovim.movnumdocref, cwtauxi.nomaux, 
			cwttdoc.desdoc, cwmovim.AreaCod, cwTAren.DesArn, cwpctas.PCAUXI, cwpctas.PCCDOC,  cwttdoc.coddoc , cwmovim.movtipdocref
			Having (Sum((cwmovim.movdebe - cwmovim.movhaber)) = 0) 
			) as mov
			order by mov.fechaemi desc
		) a
	left join [' + @pv_BaseDatos + '].softland.cwmovim b
		on a.movnumdocref = b.movnumdocref 
		and a.movtipdocref = b.movtipdocref 
		and a.codaux = b.codaux 
	left join [' + @pv_BaseDatos + '].softland.cwcpbte c
		on b.CpbNum=c.CpbNum and b.CpbAno=c.CpbAno
and a.pccodi = b.pctcod
where	(((c.cpbNum <> ''00000000'')  
or		(c.cpbano = (select min(cpbano) from [' + @pv_BaseDatos + '].softland.cwcpbte) AND c.cpbNum = ''00000000'' )))
			--select * from [' + @pv_BaseDatos + '].softland.cwttdoc where rtrim(ltrim(coddoc)) = ''00''
			--select * from [' + @pv_BaseDatos + '].softland.cwttdoc where rtrim(ltrim(coddoc)) = ''00''
'  
exec(@query)  
END  
go
/****** Object:  StoredProcedure [dbo].[DS_ObtenerSaldoDetalle]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext DS_ObtenerSaldoDetalle

create PROCEDURE [dbo].[DS_ObtenerSaldoDetalle]  
@RutAux varchar (20),  
@CodAux varchar (50),  
@pv_BaseDatos varchar (100)  
AS  
BEGIN  
DECLARE @query varchar (max)  
SELECT @query = ''  
SELECT @query = '  
  
--Este sería el query. Saludos
select	a.areacod
,		a.pcdesc
,		a.codaux
,		a.nomaux
,		b.ttdcod
,		b.numdoc
,		b.movfe as fechaemi --fecha emision
,		b.movfv --fecha vencimiento
,		a.movtipdocref
,		a.movnumdocref
,		b.movdebe
,		b.movhaber
,		a.Saldo
,		b.movglosa
,		DiasVen = (DATEDIFF(day,a.MovFv,CURRENT_TIMESTAMP))
from	(
			SELECT mov.pccodi, mov.pcdesc, mov.codaux, mov.RutAux, mov.nomaux, mov.fechaemi, mov.fechaven, desdoc, mov.movnumdocref, mov.Saldo,    mov.DesArn ,    mov.AreaCod ,    
			mov.PCAUXI, mov.PCCDOC, mov.coddoc, mov.VendCod, mov.Vendedor, mov.FecEmi , mov.Debe, mov.Haber, mov.movtipdocref, mov.MovFv
			FROM
			(select cwpctas.pccodi, cwpctas.pcdesc, cwtauxi.codaux, cwtauxi.RutAux, cwtauxi.nomaux, min(cwmovim.movfe) as fechaemi, 
			''                                                    '' as fechaven, cwttdoc.desdoc, cwmovim.movnumdocref, cwmovim.movtipdocref,min(cwmovim.MovFv) as MovFv,
			sum(cwmovim.movdebe - cwmovim.movhaber) as Saldo, min(cwmovim.MovDebe) as Debe, min(cwmovim.MovHaber) as Haber, cwmovim.AreaCod, cwTAren.DesArn , cwpctas.PCAUXI, cwpctas.PCCDOC,  
			cwttdoc.coddoc, 
			''    '' As Cpbano ,  ''    '' as VendCod,''                                                                                           '' as Vendedor,
			''                                                    '' as FecEmi  
			FROM [' + @pv_BaseDatos + '].softland.cwcpbte 
			inner join [' + @pv_BaseDatos + '].softland.cwmovim on cwcpbte.cpbano = cwmovim.cpbano and cwcpbte.cpbnum = cwmovim.cpbnum 
			inner join [' + @pv_BaseDatos + '].softland.cwtauxi on cwtauxi.codaux = cwmovim.codaux 
			inner join [' + @pv_BaseDatos + '].softland.cwpctas on cwmovim.pctcod = cwpctas.pccodi 
			left join [' + @pv_BaseDatos + '].softland.cwttdoc on cwmovim.movtipdocref = cwttdoc.coddoc 
			left join [' + @pv_BaseDatos + '].softland.cwtaren on cwmovim.AreaCod = cwTAren.CodArn 
			WHERE

			 (((cwcpbte.cpbNum <> ''00000000'')  
			or (cwcpbte.cpbano = (select min(cpbano) from [' + @pv_BaseDatos + '].softland.cwcpbte) AND cwcpbte.cpbNum = ''00000000'' ))) 


			and (cwcpbte.cpbest = ''V'') 

						and cwmovim.codaux = ''' + @CodAux + '''
			and (CWCpbte.CpbFec <= convert(datetime,CONVERT(varchar, CURRENT_TIMESTAMP),102)) 
			Group By cwpctas.pccodi , cwpctas.pcdesc, cwtauxi.codaux, cwtauxi.RutAux, cwmovim.movnumdocref, cwtauxi.nomaux, 
			cwttdoc.desdoc, cwmovim.AreaCod, cwTAren.DesArn, cwpctas.PCAUXI, cwpctas.PCCDOC,  cwttdoc.coddoc , cwmovim.movtipdocref
			Having (Sum((cwmovim.movdebe - cwmovim.movhaber)) <> 0) 
			) as mov
		) a
	left join [' + @pv_BaseDatos + '].softland.cwmovim b
		on a.movnumdocref = b.movnumdocref 
		and a.movtipdocref = b.movtipdocref 
		and a.codaux = b.codaux 
	left join [' + @pv_BaseDatos + '].softland.cwcpbte c
		on b.CpbNum=c.CpbNum and b.CpbAno=c.CpbAno
and a.pccodi = b.pctcod
where	(((c.cpbNum <> ''00000000'')  
or		(c.cpbano = (select min(cpbano) from [' + @pv_BaseDatos + '].softland.cwcpbte) AND c.cpbNum = ''00000000'' )))
			--select * from [' + @pv_BaseDatos + '].softland.cwttdoc where rtrim(ltrim(coddoc)) = ''00''
			--select * from [' + @pv_BaseDatos + '].softland.cwttdoc where rtrim(ltrim(coddoc)) = ''00''
'  
exec(@query)  
END  
go
/****** Object:  StoredProcedure [dbo].[Ds_RechazarNP]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ds_RechazarNP]
@nvId int
AS
UPDATE dbo.DS_NotasVenta
SET
    dbo.DS_NotasVenta.EstadoNP	= 'R',dbo.DS_NotasVenta.nvEstado = 'R', dbo.DS_NotasVenta.nvObser = 'Rechazada' WHERE dbo.DS_NotasVenta.Id = @nvId
GO
/****** Object:  StoredProcedure [dbo].[DS_SET_ActualizaCorreo]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_SET_ActualizaCorreo]
@VendCod varchar(50),
@Email varchar(100),
@Contrasena varchar(50),
@pv_BaseDatos varchar(100)
AS
UPDATE dbo.DS_Usuarios SET    
dbo.DS_Usuarios.email = @Email,
dbo.DS_Usuarios.ContrasenaCorreo = @Contrasena	
WHERE dbo.DS_Usuarios.Id in (select sub_a.idUsuario from ds_usuarioEmpresa sub_a inner join ds_empresa sub_b on sub_a.idempresa = sub_b.id where sub_b.basedatos = @pv_BaseDatos and sub_a.VenCod = @VendCod)
SELECT 1

GO
/****** Object:  StoredProcedure [dbo].[DS_SET_EditarUsuario]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_SET_EditarUsuario]
@IdUsuario int,
@Usuario varchar (100),
@Nombre varchar (100),
@Password varchar (max),
@Email varchar (150),
@TipoUsuario int
AS
BEGIN
UPDATE dbo.DS_Usuarios
SET
    dbo.DS_Usuarios.Usuario = @Usuario,
    dbo.DS_Usuarios.Contrasena = @Password,
    dbo.DS_Usuarios.Cliente = '',
    dbo.DS_Usuarios.CCosto = '',
    dbo.DS_Usuarios.email = @Email,
    dbo.DS_Usuarios.tipoUsuario = @TipoUsuario,
    dbo.DS_Usuarios.Nombre = @Nombre,
    dbo.DS_Usuarios.Estado = 1
	WHERE dbo.DS_Usuarios.ID = @IdUsuario

	SELECT Verificador = cast(1 as bit),
	Mensaje = 'Usuario Modificado'
END
GO
/****** Object:  StoredProcedure [dbo].[FR_ActualizaClienteVendedorSoftland]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ActualizaClienteVendedorSoftland]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_ActualizaClienteVendedorSoftland]
(
	/*--------------------------- CAMPOS DISOFI ---------------------------*/
	@pv_BaseDatos [varchar](100)
,	@pi_IdNotaVenta INT = null
)
AS
BEGIN
	declare @query nvarchar(max)
	
	declare @lv_codaux varchar(100)
	declare @lv_vendedor varchar(100)

	IF (select top 1 a.CambioVendedorCliente from ds_parametros a inner join ds_empresa b on a.idEmpresa = b.id where b.basedatos = @pv_BaseDatos) = 1 BEGIN

		select	@lv_codaux  = codaux 
		,		@lv_vendedor = vencod
		from	[dbo].[ds_notasventa] 
		where	id = @pi_IdNotaVenta

		SELECT @query = ''

		SELECT @query = @query + '
		--select vencod, ''' + @lv_vendedor + ''', * from [' + @pv_BaseDatos + '].[softland].[cwtauxven] a where codaux = ''' + convert(varchar(100), @lv_codaux) + '''
		update	[' + @pv_BaseDatos + '].[softland].[cwtauxven]
		set		vencod = ''' + @lv_vendedor + '''
		where	codaux = ''' + convert(varchar(100), @lv_codaux) + '''
		'

		exec (@query)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[FR_ActualizarCliente]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ActualizarCliente]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_ActualizarCliente]  
 @CodAux VARCHAR(10),  
 @RutAux VARCHAR(20),  
 @NomAux VARCHAR(60),   
 @DirAux NCHAR(60),   
 @NomCon VARCHAR(50),  
 @FonCon NCHAR(10),  
 @Email varchar(100),
 @pv_BaseDatos varchar(100)
AS  
DECLARE @query varchar(max)
SELECT @query = ''

SELECT @query = @query + '
BEGIN  	
	 UPDATE ['+@pv_BaseDatos+'].[softland].[cwtauxi]  
	  SET  
	  RutAux = '''+@RutAux+''',
	  NomAux = '''+@NomAux+''',
	  DirAux = '''+@DirAux+''',
	  EMail = '''+@Email+'''
	  WHERE CodAux = '''+@CodAux+'''
  
	 UPDATE ['+@pv_BaseDatos+'].[softland].[cwtaxco]  
	  SET NomCon = '''+@NomCon+''',
	  FonCon = '''+@FonCon+'''

	  WHERE CodAuc = '''+@CodAux+'''

	END  
'
exec (@query)

	  SELECT	Verificador = Cast(1 as bit)
	  ,			Mensaje = 'Se actualiza cliente'
GO
/****** Object:  StoredProcedure [dbo].[FR_ActualizarUsuario]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ActualizarUsuario]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_ActualizarUsuario]  
 @id INT,  
 @usuario VARCHAR(10),  
 @email VARCHAR(50),  
 @tipoUsuario VARCHAR(50),  
 @venCod NCHAR(10)  
AS  
BEGIN  
 UPDATE [DSTexsa_NV].[dbo].[DS_Usuarios]  
  SET Usuario=@usuario, email=@email, tipoUsuario=@tipoUsuario, VenCod=@venCod WHERE ID=@id

  SELECT	Verificador = Cast(1 as bit)
  ,			Mensaje = 'Se actualiza usuario'   
END  
GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarContactos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_AgregarContactos]
 @CodAux	varchar(10),
 @NomCon	varchar(30)

as
begin
	insert into [KUPPEL].softland.cwtaxco 
	([CodAuc],[NomCon])
	values 
	(@CodAux, @NomCon)

end

GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabecera]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FR_AgregarNVCabecera]
(
	/*--------------------------- CAMPOS DISOFI ---------------------------*/
	@pv_EstadoNP [varchar](1) = 'P'
,	@pv_BaseDatos [varchar](100)
,	@pb_InsertaDisofi BIT
,	@pb_InsertaSoftland BIT
,	@pi_IdNotaVenta INT = null
	/*--------------------------- CAMPOS SOFTLAND ---------------------------*/
,	@pi_NVNumero [int]
,	@pd_nvFem [datetime] = NULL
,	@pv_nvEstado [varchar](1) = NULL
,	@pi_nvEstFact [int] = NULL
,	@pi_nvEstDesp [int] = NULL
,	@pi_nvEstRese [int] = NULL
,	@pi_nvEstConc [int] = NULL
,	@pi_CotNum [int] = NULL
,	@pv_NumOC [varchar](12)
,	@pd_nvFeEnt [datetime] = NULL
,	@pv_CodAux [varchar](10) = NULL
,	@pv_VenCod [varchar](4) = NULL
,	@pv_CodMon [varchar](2) = NULL
,	@pv_CodLista [varchar](3) = NULL
,	@pt_nvObser [text] = NULL
,	@pv_nvCanalNV [varchar](3) = NULL
,	@pv_CveCod [varchar](3) = NULL
,	@pv_NomCon [varchar](30) = NULL
,	@pv_CodiCC [varchar](8) = NULL
,	@pv_CodBode [varchar](10) = NULL
,	@pf_nvSubTotal [float] = NULL
,	@pf_nvPorcDesc01 [float] = NULL
,	@pf_nvDescto01 [float] = NULL
,	@pf_nvPorcDesc02 [float] = NULL
,	@pf_nvDescto02 [float] = NULL
,	@pf_nvPorcDesc03 [float] = NULL
,	@pf_nvDescto03 [float] = NULL
,	@pf_nvPorcDesc04 [float] = NULL
,	@pf_nvDescto04 [float] = NULL
,	@pf_nvPorcDesc05 [float] = NULL
,	@pf_nvDescto05 [float] = NULL
,	@pf_nvMonto [float] = NULL
,	@pd_nvFeAprob [datetime] = NULL
,	@pi_NumGuiaRes [int] = NULL
,	@pf_nvPorcFlete [float] = NULL
,	@pf_nvValflete [float] = NULL
,	@pf_nvPorcEmb [float] = NULL
,	@pf_nvValEmb [float] = NULL
,	@pf_nvEquiv [float] = NULL
,	@pf_nvNetoExento [float] = NULL
,	@pf_nvNetoAfecto [float] = NULL
,	@pf_nvTotalDesc [float] = NULL
,	@pv_ConcAuto [varchar](1) = NULL
,	@pv_CodLugarDesp [varchar](30) = NULL
,	@pv_SolicitadoPor [varchar](30) = NULL
,	@pv_DespachadoPor [varchar](30) = NULL
,	@pv_Patente [varchar](9) = NULL
,	@pv_RetiradoPor [varchar](30) = NULL
,	@pv_CheckeoPorAlarmaVtas [varchar](1) = NULL
,	@pi_EnMantencion [int] = NULL
,	@pv_Usuario [varchar](8) = NULL
,	@pv_UsuarioGeneraDocto [varchar](8) = NULL
,	@pd_FechaHoraCreacion [datetime] = NULL
,	@pv_Sistema [varchar](2) = NULL
,	@pv_ConcManual [varchar](1) = NULL
,	@pv_RutSolicitante [varchar](20) = NULL
,	@pv_proceso [varchar](50) = NULL
,	@pf_TotalBoleta [float] = NULL
,	@pi_NumReq [int]
,	@pv_CodVenWeb [varchar](50) = NULL
,	@pv_CodBodeWms [varchar](10) = NULL
,	@pv_CodLugarDocto [varchar](30) = NULL
,	@pv_RutTransportista [varchar](20) = NULL
,	@pv_Cod_Distrib [varchar](10) = NULL
,	@pv_Nom_Distrib [varchar](60) = NULL
,	@pi_MarcaWG [int] = NULL
,	@pb_ErrorAprobador [bit] = NULL
,	@pv_ErrorAprobadorMensaje varchar(max) = NULL
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
		,	ErrorAprobador
		,	ErrorAprobadorMensaje
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
		,	@pb_ErrorAprobador
		,	@pv_ErrorAprobadorMensaje
		)

		SELECT	@pi_IdNotaVenta = @@identity
		
		SELECT	@VerificadorDisofi = 1
		,		@MensajeDisofi = 'Se agrego en disofi satisfactoriamente'

		UPDATE	[dbo].[DS_NotasVenta]
		set		nvObser = ('N. Int: ' + convert(varchar(20), @pi_IdNotaVenta) + ' Obs: ' + convert(varchar(max), nvObser))
		where	Id = @pi_IdNotaVenta
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabeceraSoftland]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FR_AgregarNVCabeceraSoftland]
(
	@pi_IdNotaVenta INT
,	@pv_BaseDatos varchar(100)
,	@pb_Verificador BIT OUTPUT
,	@pv_Mensaje VARCHAR(max) OUTPUT
,	@pi_NVNumero INT OUTPUT
)
AS
	declare	@lb_Verificador BIT
	,		@lv_Mensaje VARCHAR(max)

	declare @query nvarchar(max)

	select	@pb_Verificador = cast(1 as bit)
	,		@pv_Mensaje = 'Nota Venta Agregado Satisfactoriamente'

	select @query = ''
	select @query = '
	begin try
	DECLARE @NOMBRE_COLUMNA VARCHAR(MAX)
	DECLARE @QUERY_FINAL VARCHAR(MAX)
	DECLARE @QUERY_INSERT VARCHAR(MAX)
	DECLARE @QUERY_SELECT VARCHAR(MAX)
	DECLARE @QUERY_UPDATE VARCHAR(MAX)
	DECLARE @QUERY_INSERT_COLUMNAS VARCHAR(MAX)
	DECLARE @QUERY_SELECT_COLUMNAS VARCHAR(MAX)
	
	SELECT	@QUERY_FINAL = ''''
	SELECT	@QUERY_INSERT = ''''
	SELECT	@QUERY_SELECT = ''''
	SELECT	@QUERY_UPDATE = ''''
	SELECT	@QUERY_INSERT_COLUMNAS = ''''
	SELECT	@QUERY_SELECT_COLUMNAS = ''''

	SELECT	@NVNumero = (SELECT ISNULL((MAX(sub_a.NVNumero) + 1), 0) FROM [' + @pv_BaseDatos + '].[softland].[nw_nventa] sub_a)
	IF CURSOR_STATUS(''global'',''CURSOR_COLUMNAS'') >= -1 BEGIN
		DEALLOCATE CURSOR_COLUMNAS
	END

	DECLARE CURSOR_COLUMNAS CURSOR FOR
		SELECT	COLUMN_NAME
		FROM	[' + @pv_BaseDatos + '].INFORMATION_SCHEMA.COLUMNS
		WHERE	TABLE_NAME = ''nw_nventa''

	OPEN CURSOR_COLUMNAS

	FETCH NEXT FROM CURSOR_COLUMNAS
	INTO @NOMBRE_COLUMNA

	WHILE @@FETCH_STATUS = 0 BEGIN
		SELECT	@QUERY_INSERT_COLUMNAS = @QUERY_INSERT_COLUMNAS + 
''		['' + @NOMBRE_COLUMNA + '']
,''
		IF (@NOMBRE_COLUMNA IN (' + '''NVNumero''' + ')) BEGIN
			SELECT	@QUERY_SELECT_COLUMNAS = @QUERY_SELECT_COLUMNAS + 
''		'''''' + CONVERT(VARCHAR(20), @NVNumero) + ''''''
,''
		END
		ELSE BEGIN
		SELECT	@QUERY_SELECT_COLUMNAS = @QUERY_SELECT_COLUMNAS + 
''		['' + @NOMBRE_COLUMNA + '']
,''
		END

		FETCH NEXT FROM CURSOR_COLUMNAS
		INTO @NOMBRE_COLUMNA
	END
	
	SELECT	@QUERY_INSERT_COLUMNAS = SUBSTRING(@QUERY_INSERT_COLUMNAS, 1, LEN(@QUERY_INSERT_COLUMNAS) - 3)
	SELECT	@QUERY_SELECT_COLUMNAS = SUBSTRING(@QUERY_SELECT_COLUMNAS, 1, LEN(@QUERY_SELECT_COLUMNAS) - 3)

	SELECT	@QUERY_INSERT = ''
INSERT INTO [' + @pv_BaseDatos + '].[softland].[nw_nventa]
(
'' + @QUERY_INSERT_COLUMNAS + ''
)''
	SELECT	@QUERY_SELECT = ''
SELECT	
'' + @QUERY_SELECT_COLUMNAS + ''
FROM	[dbo].[DS_NotasVenta] 
WHERE	Id = ' + CONVERT(VARCHAR(20), @pi_IdNotaVenta) + '''

	SELECT	@QUERY_UPDATE = ''
	UPDATE	[dbo].[DS_NotasVenta] 
	SET		NVNumero = '''''' + CONVERT(VARCHAR(100), @NVNumero) + ''''''
	WHERE	Id = ' + CONVERT(VARCHAR(20), @pi_IdNotaVenta) + '
	
	UPDATE	[dbo].[DS_NotasVentaDetalle] 
	SET		NVNumero = '''''' + CONVERT(VARCHAR(100), @NVNumero) + ''''''
	WHERE	IdNotaVenta = ' + CONVERT(VARCHAR(20), @pi_IdNotaVenta) + '
	''

	
	SELECT	@QUERY_FINAL = @QUERY_INSERT + @QUERY_SELECT + @QUERY_UPDATE

	EXEC (@QUERY_FINAL)

	CLOSE CURSOR_COLUMNAS
	DEALLOCATE CURSOR_COLUMNAS

	end try
	begin catch
		select	@lb_Verificador = cast(0 as bit)
		,		@lv_Mensaje = error_message()
	end catch
	'
	
	EXEC sp_executesql	@query
	,					N'@NVNumero INT OUTPUT, @lv_Mensaje VARCHAR(max) OUTPUT, @lb_Verificador BIT OUTPUT',
	@pi_NVNumero OUTPUT, @lv_Mensaje OUTPUT, @lb_Verificador OUTPUT

	select	@pv_Mensaje = case when @lv_Mensaje is null then @pv_Mensaje else @lv_Mensaje end
	,		@pb_Verificador = case when @lb_Verificador is null then @pb_Verificador else @lb_Verificador end
	EXEC [dbo].[FR_ActualizaClienteVendedorSoftland]
				@pv_BaseDatos = @pv_BaseDatos
	,			@pi_IdNotaVenta = @pi_IdNotaVenta

GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalle]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
,	@pi_NVNumero int
,	@pf_nvLinea float
,	@pf_nvCorrela float = NULL
,	@pd_nvFecCompr datetime = NULL
,	@pv_CodProd varchar(20) = NULL
,	@pf_nvCant float = NULL
,	@pf_nvPrecio float = NULL
,	@pf_nvEquiv float = NULL
,	@pf_nvSubTotal float = NULL
,	@pf_nvDPorcDesc01 float = NULL
,	@pf_nvDDescto01 float = NULL
,	@pf_nvDPorcDesc02 float = NULL
,	@pf_nvDDescto02 float = NULL
,	@pf_nvDPorcDesc03 float = NULL
,	@pf_nvDDescto03 float = NULL
,	@pf_nvDPorcDesc04 float = NULL
,	@pf_nvDDescto04 float = NULL
,	@pf_nvDPorcDesc05 float = NULL
,	@pf_nvDDescto05 float = NULL
,	@pf_nvTotDesc float = NULL
,	@pf_nvTotLinea float = NULL
,	@pf_nvCantDesp float = NULL
,	@pf_nvCantProd float = NULL
,	@pf_nvCantFact float = NULL
,	@pf_nvCantDevuelto float = NULL
,	@pf_nvCantNC float = NULL
,	@pf_nvCantBoleta float = NULL
,	@pf_nvCantOC float = NULL
,	@pt_DetProd text = NULL
,	@pv_CheckeoMovporAlarmaVtas varchar(1) = NULL
,	@pv_KIT varchar(20) = NULL
,	@pi_CodPromocion int = NULL
,	@pv_CodUMed varchar(6) = NULL
,	@pf_CantUVta float = NULL
,	@pv_Partida varchar(20) = NULL
,	@pv_Pieza varchar(20) = NULL
,	@pd_FechaVencto datetime = NULL
,	@pf_CantidadKit float
,	@pi_MarcaWG int = NULL
,	@pf_PorcIncidenciaKit float
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalleSoftland]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_AgregarNVDetalleSoftland]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_AgregarNVDetalleSoftland]
(
	@pi_IdNotaVenta INT
,	@pi_IdDetalleNotaVenta INT
,	@pv_BaseDatos varchar(100)
,	@pb_Verificador BIT OUTPUT
,	@pv_Mensaje VARCHAR(max) OUTPUT
,	@pi_NVNumero INT OUTPUT
)
AS
	declare @query nvarchar(max)

	select @query = ''

	select @query = '
	DECLARE @NOMBRE_COLUMNA VARCHAR(MAX)
	DECLARE @QUERY_FINAL VARCHAR(MAX)
	DECLARE @QUERY_INSERT VARCHAR(MAX)
	DECLARE @QUERY_SELECT VARCHAR(MAX)
	DECLARE @QUERY_INSERT_COLUMNAS VARCHAR(MAX)
	DECLARE @QUERY_SELECT_COLUMNAS VARCHAR(MAX)
	
	SELECT	@QUERY_FINAL = ''''
	SELECT	@QUERY_INSERT = ''''
	SELECT	@QUERY_SELECT = ''''
	SELECT	@QUERY_INSERT_COLUMNAS = ''''
	SELECT	@QUERY_SELECT_COLUMNAS = ''''
	
	IF CURSOR_STATUS(''global'',''CURSOR_COLUMNAS'') >= -1 BEGIN
		DEALLOCATE CURSOR_COLUMNAS
	END

	DECLARE CURSOR_COLUMNAS CURSOR FOR
		SELECT	COLUMN_NAME
		FROM	[' + @pv_BaseDatos + '].INFORMATION_SCHEMA.COLUMNS
		WHERE	TABLE_NAME = ''nw_detnv''

	OPEN CURSOR_COLUMNAS

	FETCH NEXT FROM CURSOR_COLUMNAS
	INTO @NOMBRE_COLUMNA

	WHILE @@FETCH_STATUS = 0 BEGIN
		SELECT	@QUERY_INSERT_COLUMNAS = @QUERY_INSERT_COLUMNAS + 
''		['' + @NOMBRE_COLUMNA + '']
,''

		SELECT	@QUERY_SELECT_COLUMNAS = @QUERY_SELECT_COLUMNAS + 
''		['' + @NOMBRE_COLUMNA + '']
,''

		FETCH NEXT FROM CURSOR_COLUMNAS
		INTO @NOMBRE_COLUMNA
	END
	
	SELECT	@QUERY_INSERT_COLUMNAS = SUBSTRING(@QUERY_INSERT_COLUMNAS, 1, LEN(@QUERY_INSERT_COLUMNAS) - 3)
	SELECT	@QUERY_SELECT_COLUMNAS = SUBSTRING(@QUERY_SELECT_COLUMNAS, 1, LEN(@QUERY_SELECT_COLUMNAS) - 3)

	SELECT	@QUERY_INSERT = ''
INSERT INTO [' + @pv_BaseDatos + '].[softland].[nw_detnv]
(
'' + @QUERY_INSERT_COLUMNAS + ''
)''
	SELECT	@QUERY_SELECT = ''
SELECT	
'' + @QUERY_SELECT_COLUMNAS + ''
FROM	[dbo].[DS_NotasVentaDetalle] 
WHERE	IdNotaVenta = ' + CONVERT(VARCHAR(20), @pi_IdNotaVenta) + '
AND		Id = ' + CONVERT(VARCHAR(20), @pi_IdDetalleNotaVenta) + '''

	SELECT	@QUERY_FINAL = @QUERY_INSERT + @QUERY_SELECT

	EXEC (@QUERY_FINAL)

	CLOSE CURSOR_COLUMNAS
	DEALLOCATE CURSOR_COLUMNAS
	'

	select	@pb_Verificador = cast(1 as bit)
	,		@pv_Mensaje = 'Nota Venta Agregado Satisfactoriamente'

	EXEC sp_executesql	@query
	,					N'@NVNumero INT OUTPUT',
	@pi_NVNumero OUTPUT;
GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarUsuario]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_AgregarUsuario]
	@Usuario	varchar(10),
	@email	varchar(50),
	@Contrasena varchar(150),
	@tipoUsuario	varchar(50),
	@Nombre varchar (100)
 AS
DECLARE @CantVenCod int
DECLARE @IdUsuario int
SET @CantVenCod	= (SELECT count(*) AS cantidad FROM dbo.DS_Usuarios du WHERE Usuario = @Usuario AND du.Estado = 1)
if(@CantVenCod = 0)
BEGIN
	INSERT INTO [dbo].[DS_Usuarios] ([Usuario],[Contrasena],[email],[tipoUsuario],[Nombre],[Estado])
		VALUES(@Usuario,(@Contrasena), @email, @tipoUsuario, @Nombre,1)
	 
SET @IdUsuario = (SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY])	

		SELECT Verificador = cast(1 AS bit),
		Mensaje = 'Usuario Creado'
END
ELSE
SELECT	Verificador = cast(0 AS bit),
		Mensaje = 'Usuario ya Existe'
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarClientes]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarClientes]
 @RutAux	varchar(30),
	@CodAux	varchar(150)
as
begin
	select 
	clientes.EMail,
	clientes.CodAux,
	clientes.[NomAux],
	clientes.[RutAux],
	clientes.[DirAux] ,
	clientes.[DirNum], 
	contacto.[NomCon] , 
	contacto.[FonCon]
    from [KUPPEL].[softland].[cwtauxi] clientes
	inner join [KUPPEL].[softland].[cwtaxco] contacto on clientes.CodAux = contacto.CodAuc 
	where RutAux = @RutAux AND
		CodAux = @CodAux

	--where clientes.RutAux ='76.387.390-0' and contacto.[NomCon] like '%jorge naza%'
end

GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarDirecDespa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_BuscarDirecDespa]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_BuscarDirecDespa]
(
	@CodAxD varchar(10)
,	@pv_BaseDatos varchar(100)
)
as
begin
	declare @query varchar(max)

	select @query = ''

	select @query = @query + '
	select	DirDch
	,		ComDch
	,		NomDch 
	from	[' + @pv_BaseDatos + '].[Softland].cwtauxd  
	where	CodAxD = ''' + @CodAxD + ''''

	EXEC (@query)
end  
    
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVCabecera]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarNVCabecera] 
	@nvId   INT,
	@pv_BaseDatos varchar(100)
AS
DECLARE @query varchar (max)
SELECT @query = ''
SELECT @query = @query + '
BEGIN
	SELECT
		nv.NVNumero,
		vend.VenCod,
		vend.Usuario,
		conven.CveCod,
		conven.CveDes,
		convert(datetime, nv.nvFem,103) ''nvFem'',
		convert(datetime, nv.nvFeEnt,103) ''nvFeEnt'',
		lista.CodLista,
		lista.DesLista,
		cliente.CodAux,
		cliente.NomAux,
		nv.NomCon,
		cc.CodiCC,
		cc.DescCC,
		nv.nvObser,
		nv.nvSubTotal,
		nv.TotalBoleta,
		nv.ErrorAprobador,
		nv.ErrorAprobadorMensaje
	FROM
		[dbo].[DS_NotasVenta] nv INNER JOIN
		['+@pv_BaseDatos+'].[softland].[cwtauxi] cliente ON (cliente.CodAux collate Modern_Spanish_CI_AS = nv.CodAux) LEFT JOIN
		['+@pv_BaseDatos+'].[softland].cwtvend vend ON (vend.VenCod collate Modern_Spanish_CI_AS = nv.VenCod) LEFT JOIN
		['+@pv_BaseDatos+'].[softland].cwtconv conven ON (conven.CveCod collate Modern_Spanish_CI_AS = nv.CveCod) LEFT JOIN
		['+@pv_BaseDatos+'].[softland].iw_tlispre lista ON (lista.CodLista collate Modern_Spanish_CI_AS = nv.CodLista) LEFT JOIN
		['+@pv_BaseDatos+'].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = nv.CodiCC)
	WHERE
		nv.Id = '+convert(varchar(100),@nvId)+'
END
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVDetalle]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarNVDetalle]
 @nvId   int,
 @pv_BaseDatos varchar(100)
AS
DECLARE @query varchar (max)

SELECT @query = ''
SELECT @query = @query + '
begin
select 
a.nvLinea,
a.CodProd, 
tp.DesProd, 
a.nvCant, 
a.CodUMed, 
a.nvPrecio, 
a.nvSubTotal,
ROUND(a.nvDPorcDesc01,0) as nvDPorcDesc01, 
ROUND(a.nvDPorcDesc02,0) as nvDPorcDesc02, 
ROUND(a.nvDPorcDesc03,0) as nvDPorcDesc03, 
ROUND(a.nvDPorcDesc04,0) as nvDPorcDesc04, 
ROUND(a.nvDPorcDesc05,0) as nvDPorcDesc05, 
a.nvTotLinea,
Stock = (select  Sum (CASE WHEN TipoBod = ''D'' THEN Ingresos - Egresos ELSE 0 END)  * 1 AS StockDisponible     
FROM  ['+@pv_BaseDatos+'].[softland].[IW_vsnpMovimStockTipoBod] WITH (INDEX(IW_GMOVI_BodPro)) 
WHERE   Fecha <= '+CONVERT(varchar(10),getdate(),103)+'  and CodProd = tp.CodProd GROUP BY CodProd)
from [dbo].[DS_NotasVentaDetalle] a
inner JOIN ['+@pv_BaseDatos+'].[softland].[iw_tprod] AS tp on a.CodProd collate Modern_Spanish_CI_AS = tp.CodProd 
where a.IdNotaVenta = '+convert(varchar(100),@nvId)+'
order by a.nvLinea
end
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarParametrosUsuarios]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_BuscarParametrosUsuarios]					*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
  
CREATE procedure [dbo].[FR_BuscarParametrosUsuarios]
(
	@pi_idEmpresa INT
)
AS
BEGIN  
	SELECT	* 
	FROM	[dbo].[DS_Parametros]
	where	IdEmpresa = @pi_idEmpresa  
END  
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarProducto]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarProducto]
	@DesProd	varchar(max),
	@CodLista	varchar(3)
AS
BEGIN
	SELECT DISTINCT	
		CodProd = tp.CodProd, 
		DesProd = ISNULL(tp.DesProd,''), 
		codgrupo = ISNULL(tp.CodGrupo,''),
		codsubgr = ISNULL(tp.CodSubGr,''),
		PrecioVta = pd.valorPct, 
		codumed = pd.CodUmed,
		desumed = ISNULL(detumed.desumed,''),
		CodLista = lp.CodLista,
		Stock =		ISNULL((
						select		Sum (CASE WHEN TipoBod = 'D' THEN Ingresos - Egresos ELSE 0 END) * 1 AS StockDisponible
						FROM		transporte.softland.IW_vsnpMovimStockTipoBod WITH (INDEX(IW_GMOVI_BodPro)) 
						WHERE		Fecha <= GETDATE()  
						and			CodProd = tp.CodProd 
						GROUP BY	CodProd
					), 0)--[DSNotaVenta].[dbo].[stock2018](tp.CodProd)
	FROM 
		[KUPPEL].[softland].[iw_tprod] AS tp 
		LEFT JOIN [KUPPEL].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd 
		LEFT JOIN [KUPPEL].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd
		LEFT JOIN [KUPPEL].[softland].[iw_tlispre] AS lp ON pd.CodLista = lp.CodLista 
		LEFT JOIN [KUPPEL].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed
		WHERE --tp.DesProd = 'GUANTE CABRITILLA CON FORRO'  AND lp.CodLista = '01'
		tp.DesProd LIKE (CASE @DesProd WHEN '' THEN tp.DesProd ELSE '%' + @DesProd +'%' END)
		AND lp.CodLista = @CodLista OR tp.CodProd LIKE (CASE  @DesProd WHEN '' THEN tp.CodProd ElSE '%'+ @DesProd + '%' END) 
					
					
	GROUP BY 
		tp.CodProd, 
		tp.DesProd, 
		tp.CodGrupo, 
		tp.CodSubGr, 
		tp.PrecioVta, 
		pd.ValorPct,
		pd.CodUmed,
		detumed.desumed,
		tp.codumedvta1,
		tp.codumedvta2, 
		tp.codumed,
		tp.preciovtaum1,
		tp.preciovtaum1,
		lp.CodLista
	ORDER BY 
		DesProd ASC 
END
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarProductoRapido]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarProductoRapido]
-- @DesProd   varchar(60),
 @CodRapido	varchar(3),
-- @CodSubGr  varchar(10),
 @CodLista	varchar(3)--,
-- @CodGrupo	varchar(10)
as
begin
SELECT
	tp.CodProd, 
	tp.DesProd, 
	tp.CodGrupo, 
	tp.CodSubGr, 
	pd.valorPct as PrecioVta, 
	pd.CodUmed as codumed, 
	detumed.desumed as desumed,
	lp.CodLista,
	ISNULL((
		select		Sum (CASE WHEN TipoBod = 'D' THEN Ingresos - Egresos ELSE 0 END) * 1 AS StockDisponible
		FROM		transporte.softland.IW_vsnpMovimStockTipoBod WITH (INDEX(IW_GMOVI_BodPro)) 
		WHERE		Fecha <= GETDATE()  
		and			CodProd = tp.CodProd 
		GROUP BY	CodProd
	), 0)--[dbo].[stock2018](tp.CodProd)  'Stock' 
FROM 
	[KUPPEL].[softland].[iw_tprod] AS tp 
	LEFT JOIN [KUPPEL].[softland].[iw_gmovi] AS gm ON tp.CodProd=gm.CodProd 
	LEFT JOIN [KUPPEL].[softland].[iw_tlprprod] AS pd ON tp.CodProd=pd.CodProd
	LEFT JOIN [KUPPEL].[softland].[iw_tlispre] AS lp ON pd.CodLista=lp.CodLista 
	LEFT JOIN [KUPPEL].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed
WHERE  
	tp.CodRapido =  @CodRapido 
	AND
	lp.CodLista = @CodLista
GROUP BY 
	tp.CodProd, 
	tp.DesProd, 
	tp.CodGrupo, 
	tp.CodSubGr, 
	tp.PrecioVta, 
	pd.ValorPct,
	pd.CodUmed,
	detumed.desumed,
	tp.codumedvta1,
	tp.codumedvta2, 
	tp.codumed,
	tp.preciovtaum1,
	tp.preciovtaum1,
	lp.CodLista
ORDER BY 
	DesProd ASC 
end


GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarUsuarios]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarUsuarios]
 @id    int,
 @pv_BaseDatos varchar(100)
as
begin
	select usuario.Usuario,
	usuario.id, 
	usuario.email, 
	tipo.tipoUsuario
	,VenCod =	(
					select	top 1 
							sub_a.VenCod 
					from	ds_usuarioEmpresa sub_a 
						inner join ds_empresa sub_b 
							on sub_a.idempresa = sub_b.id 
					where	sub_b.basedatos = @pv_BaseDatos 
					and		sub_a.IdUsuario = @id
				)
	from [dbo].[DS_Usuarios] usuario
	inner join [dbo].[DS_UsuariosTipos] tipo on usuario.tipoUsuario = tipo.id
	where usuario.id = @id 

	--where clientes.RutAux ='76.387.390-0' and contacto.[NomCon] like '%jorge naza%'
end
GO
/****** Object:  StoredProcedure [dbo].[FR_EliminarUsuario]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_EliminarUsuario]							*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_EliminarUsuario]  
@Id int  
AS  
DECLARE @Estado int
SET @Estado	= (SELECT Estado FROM dbo.DS_Usuarios du WHERE du.ID = @Id)
IF(@Estado = 1)
BEGIN

	UPDATE dbo.DS_Usuarios SET dbo.DS_Usuarios.Estado = 0   
	WHERE dbo.DS_Usuarios.ID = @Id  

	SELECT	Verificador = Cast(1 as bit)
	,		Mensaje = 'Se Deshabilito usuario'   
END
ELSE
BEGIN
	UPDATE dbo.DS_Usuarios SET dbo.DS_Usuarios.Estado = 1   
	WHERE dbo.DS_Usuarios.ID = @Id  

	SELECT	Verificador = Cast(1 as bit)
	,		Mensaje = 'Se Habilito usuario'
END
GO
/****** Object:  StoredProcedure [dbo].[FR_ListaProductos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/  
/*-- Empresa   : DISOFI            */  
/*-- Tipo    : Procedimiento           */  
/*-- Nombre    : [dbo].[FR_ListaProductos]        */  
/*-- Detalle   :              */  
/*-- Autor    : FDURAN            */  
/*-- Modificaciones  :              */  
/*------------------------------------------------------------------------------*/  
CREATE PROCEDURE [dbo].[FR_ListaProductos] 
(  
 @pv_ListaProductos varchar(max)  
, @pv_BaseDatos varchar(100)  
)  
AS    
BEGIN    
 declare @query varchar(max)  
  
 select @query = ''  

 declare @lv_bodega varchar(50)

select	top 1 
		@lv_bodega = 
				case	when a.stockproductoesbodega = 1 
							then isnull(stockproductocodigobodega, '') 
							else '' 
				end 
from	ds_parametros a 
	inner join ds_empresa b 
		on a.idempresa = b.id 
where	b.basedatos = @pv_BaseDatos
  
 if @pv_ListaProductos is not null and rtrim(ltrim(@pv_ListaProductos)) <> '' and rtrim(ltrim(@pv_ListaProductos)) <> '-1' begin  
  select @query = @query + '  
  --CON LISTA DE PRECIO  
  SELECT  DISTINCT     
     CodProd = tp.CodProd  
  ,   DesProd = ISNULL(tp.DesProd,'''')  
  ,   codgrupo = ISNULL(tp.CodGrupo,'''')  
  ,   codsubgr = ISNULL(tp.CodSubGr,'''')  
  ,   PrecioVta = pd.valorPct  
  ,   codumed = pd.CodUmed  
  ,   desumed = ISNULL(detumed.desumed,'''')  
  ,   CodLista = lp.CodLista  
  ,   Stock =   
       ISNULL((  
        select  Sum (CASE WHEN TipoBod = ''D'' THEN Ingresos - Egresos ELSE 0 END) * 1 AS StockDisponible  
        FROM  [' + @pv_BaseDatos + '].[softland].IW_vsnpMovimStockTipoBod WITH (INDEX(IW_GMOVI_BodPro))   
        WHERE  Fecha <= GETDATE()    
        and   CodProd = tp.CodProd   ' +
		case when @lv_bodega = '' then '' else ' and codbode = ''' + @lv_bodega + '''' end + '
        GROUP BY CodProd  
       ), 0)--[dbo].[stock2018](tp.CodProd)    
  FROM  [' + @pv_BaseDatos + '].[softland].[iw_tprod] AS tp     
   LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd     
   LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd    
   LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlispre] AS lp ON pd.CodLista = lp.CodLista     
   LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed    
  where  lp.CodLista = ''' + @pv_ListaProductos + '''  
  and   tp.Inactivo = 0  
  GROUP BY tp.CodProd,   tp.DesProd,   tp.CodGrupo, tp.CodSubGr  
  ,   tp.PrecioVta,  pd.ValorPct,  pd.CodUmed,  detumed.desumed  
  ,   tp.codumedvta1,  tp.codumedvta2,  tp.codumed,  tp.preciovtaum1  
  ,   tp.preciovtaum1, lp.CodLista  
  ORDER BY DesProd ASC  
  '  
 end  
 else begin  
  select @query = @query + '  
  --SIN LISTA DE PRECIO  
  SELECT  DISTINCT     
     CodProd = tp.CodProd  
  ,   DesProd = ISNULL(tp.DesProd,'''')  
  ,   codgrupo = ISNULL(tp.CodGrupo,'''')  
  ,   codsubgr = ISNULL(tp.CodSubGr,'''')  
  ,   PrecioVta = tp.PrecioVta  
  ,   codumed = tp.CodUmed  
  ,   desumed = ISNULL(detumed.desumed,'''')  
  ,   CodLista = ''''  
  ,   Stock = ISNULL((  
      select  Sum (CASE WHEN TipoBod = ''D'' THEN Ingresos - Egresos ELSE 0 END) * 1 AS StockDisponible  
      FROM  [' + @pv_BaseDatos + '].[softland].IW_vsnpMovimStockTipoBod WITH (INDEX(IW_GMOVI_BodPro))   
      WHERE  Fecha <= GETDATE()  
      and   CodProd = tp.CodProd   ' +
		case when @lv_bodega = '' then '' else ' and codbode = ''' + @lv_bodega + '''' end + '
      GROUP BY CodProd  
     ), 0)--Stock = [dbo].[stock2018](tp.CodProd)    
  FROM  [' + @pv_BaseDatos + '].[softland].[iw_tprod] AS tp     
   LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_gmovi] AS gm ON tp.CodProd = gm.CodProd     
   --LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tlprprod] AS pd ON tp.CodProd = pd.CodProd    
   LEFT JOIN [' + @pv_BaseDatos + '].[softland].[iw_tumed] AS detumed on tp.CodUmed = detumed.CodUMed    
  where  tp.Inactivo = 0  
  GROUP BY tp.CodProd,   tp.DesProd,   tp.CodGrupo, tp.CodSubGr  
  ,   tp.PrecioVta,  tp.PrecioVta,  tp.CodUmed,  detumed.desumed  
  ,   tp.codumedvta1,  tp.codumedvta2,  tp.codumed,  tp.preciovtaum1  
  ,   tp.preciovtaum1  
  ORDER BY DesProd ASC  
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCentroDeCosto]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarCentroDeCosto]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_ListarCentroDeCosto]
(
	@pv_BaseDatos VARCHAR(100)
)
AS
BEGIN
	declare @query varchar(max)

	select @query = ''

	-- ==========================================================================================  
	-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
	-- ==========================================================================================  
	select @query = @query + '
		select	* 
		from	[' + @pv_BaseDatos + '].[softland].[cwtccos] 
		where	activo = ''S'' 
		and		DescCC != '''' --and CodiCC = 002  
	'

	exec (@query)
end  
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarClientes]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarClientes]
	@pv_BaseDatos varchar(100)
	as
	declare @query varchar(max)
	select @query = ''

	select @query = @query + '
	select clientes.CodAux,
	clientes.[NomAux],
	clientes.[RutAux],
	clientes.[DirAux],
	clientes.[DirNum],
	contacto.[NomCon], 
	contacto.[FonCon]
    from ['+@pv_BaseDatos+'].[softland].[cwtauxi] clientes
	inner join ['+@pv_BaseDatos+'].[softland].[cwtaxco] contacto on clientes.CodAux = contacto.CodAuc 
	'
	exec (@query)
	


GO
/****** Object:  StoredProcedure [dbo].[FR_ListarClientesTodos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarClientesTodos]

as
begin

SELECT dir.CodAux, dir.NomAux, dir.DirAux, dir.DirNum, ven.NomCon, 
CASE	WHEN ven.FonCon != null	THEN ven.FonCon
		WHEN ven.FonCon != null	THEN ven.FonCon
		ELSE ven.FonCon
		END AS 'FonAux1',
		dir.Notas      
FROM [KUPPEL].softland.cwtauxi dir
inner join [KUPPEL].softland.cwtaxco ven ON ven.CodAuc = dir.CodAux 
ORDER BY dir.CodAux ASC

	
end

GO
/****** Object:  StoredProcedure [dbo].[FR_ListarCondicionesDeVenta]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarCondicionesDeVenta]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[FR_ListarCondicionesDeVenta]
(
	@CodAux varchar(15) 
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''

	-- ==========================================================================================  
	-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
	-- ==========================================================================================  
	select @query = @query + '

	declare @contar  int  
	set @contar =	(  
						select	contar = count(ven.CveDes) 
						from	[' + @pv_BaseDatos + '].[softland].[cwtauxi] cliente   
							inner join [' + @pv_BaseDatos + '].[softland].cwtcvcl condicion 
								on cliente.CodAux = condicion.CodAux  
							inner join [' + @pv_BaseDatos + '].[softland].cwtconv ven 
								on condicion.ConVta = ven.CveCod  
						where	condicion.ConVta != ''''
						and		condicion.ConVta is NOT null   
						and		cliente.CodAux = ''' + @CodAux + '''
					)
	
	if(@contar = 0) BEGIN  
		select	cvecod as ConVta
		,		CveDes 
		from	[' + @pv_BaseDatos + '].[softland].cwtconv   
		where	cvecod = ''005''
	END
	ELSE BEGIN  
		select	ven.CveDes
		,		condicion.ConVta
		,		cliente.CodAux 
		from	[' + @pv_BaseDatos + '].[softland].[cwtauxi] cliente   
			INNER JOIN [' + @pv_BaseDatos + '].[softland].cwtcvcl condicion 
				ON cliente.CodAux = condicion.CodAux  
			INNER JOIN [' + @pv_BaseDatos + '].[softland].cwtconv ven 
				ON condicion.ConVta = ven.CveCod  
		WHERE	condicion.ConVta != ''''
		AND		condicion.ConVta is NOT null   
		AND		cliente.CodAux = ''' + @CodAux + '''
	END
	'
	EXEC (@query)
end  
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarContactos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListarContactos]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
  
CREATE procedure [dbo].[FR_ListarContactos]  
	@CodAuc varchar(10)  
,	@NomCon varchar(30)
,	@pv_BaseDatos varchar(100)  
as  
BEGIN  
	declare @query varchar(max)

	select @query = ''
	
	select @query = @query + '
	SELECT	ven.CodAuc as CodAux
	,		ven.NomCon       
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi] dir 
		INNER JOIN [' + @pv_BaseDatos + '].[softland].[cwtaxco] ven 
			ON ven.CodAuc = dir.CodAux   
	WHERE	CodAuc = ''' + @CodAuc + '''
	'

	EXEC (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosAprobados]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarDocumentosAprobados]
@pv_BaseDatos varchar (100)
	AS
	DECLARE @query varchar(max)
	SELECT @query = ''
	SELECT @query = @query + '
	select 
	a.Id,
	a.NVNumero, 
	clientes.[NomAux], 
	clientes.[RutAux], 
	a.nvFem, 
	a.CodLista,
	a.NomCon, 
	a.nvNetoAfecto, 
	a.TotalBoleta, 
	a.EstadoNP, 
	a.nvSubTotal,
	ISNULL(a.RutSolicitante,0) as RutSolicitante,
	cc.CodiCC,
	cc.DescCC,
	a.ErrorAprobador,
	a.ErrorAprobadorMensaje
	from [dbo].[DS_NotasVenta] a
	inner join ['+@pv_BaseDatos+'].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	left join ['+@pv_BaseDatos+'].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = a.CodiCC)
	where 
	a.EstadoNP = ''A''
	order by a.Id desc
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosPendientes]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarDocumentosPendientes]
	@pv_BaseDatos varchar(100)
	AS
	DECLARE @query varchar (max)
	SELECT @query = ''
	SELECT @query = @query + '

	select	distinct 
			
	--		isnull
	--		((
	--			case	when
	--(select  Sum (CASE WHEN TipoBod = ''D'' THEN Ingresos - Egresos ELSE 0 END)  * 1 AS StockDisponible 
	--FROM  ['+@pv_BaseDatos+'].softland.IW_vsnpMovimStockTipoBod WITH (INDEX(IW_GMOVI_BodPro)) 
	--WHERE Fecha <= getdate()  and CodProd = tp.CodProd 
	--GROUP BY CodProd)>= c.nvCant then 0 else 1 end ), 0) as stocklista,
	a.NVNumero,
	a.Id,
	clientes.[NomAux],
	clientes.[RutAux],
	a.nvEstado,
	a.nvFem, 
	a.nvFeEnt, 
	a.CodLista, 
	a.NomCon, 
	a.nvNetoAfecto, 
	a.TotalBoleta, 
	a.CodAux,
	a.EstadoNP, 
	a.nvSubTotal,
	ISNULL(a.RutSolicitante,0) as RutSolicitante,
	--,[dbo].[func_SaldoClienteCW](a.CodAux,'''+@pv_BaseDatos+''' ) ''Saldo'',
	cc.CodiCC,
	cc.DescCC,
	ErrorAprobador,
	ErrorAprobadorMensaje

	from [dbo].[DS_NotasVenta] a
	inner join ['+ @pv_BaseDatos +'].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	LEFT JOIN [dbo].[DS_NotasVentaDetalle] b on a.NVNumero = b.NVNumero
	LEFT JOIN ['+ @pv_BaseDatos +'].[softland].[iw_tprod] AS tp on b.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
	left join [dbo].[DS_NotasVentaDetalle] c on a.Id = c.IdNotaVenta
	left join ['+@pv_BaseDatos+'].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = a.CodiCC)
	where a.EstadoNP = ''P''
	order by a.Id desc
'
exec (@query)

--[FR_ListarDocumentosPendientes] 'transporte'
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosRechazadas]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[FR_ListarDocumentosRechazadas]
@pv_BaseDatos varchar (100)
	AS
	DECLARE @query varchar(max)
	SELECT @query = ''
	SELECT @query = @query + '
	select 
	a.Id,
	a.NVNumero, 
	clientes.[NomAux], 
	clientes.[RutAux], 
	a.nvFem, 
	a.CodLista,
	a.NomCon, 
	a.nvNetoAfecto, 
	a.TotalBoleta, 
	a.EstadoNP, 
	A.nvSubTotal,
	ISNULL(a.RutSolicitante,0) as RutSolicitante,
	cc.CodiCC,
	cc.DescCC,
	a.ErrorAprobador,
	a.ErrorAprobadorMensaje
	from [dbo].[DS_NotasVenta] a
	inner join ['+@pv_BaseDatos+'].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	left join ['+@pv_BaseDatos+'].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = a.CodiCC)
	where 
	a.EstadoNP = ''R''
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarListaDePrecio]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		where	codlista = ''001''  
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
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuarios]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarUsuarios]
	as
	select usuario.Usuario,
	usuario.id,
	usuario.email,
	usuario.Nombre,
	tipo.tipoUsuario,
	usuario.Estado	
	from [dbo].[DS_Usuarios] usuario
	inner join [dbo].[DS_UsuariosTipos] tipo on usuario.tipoUsuario = tipo.id
	

GO
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuariosTipos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarUsuariosTipos]
	as
	SELECT [ID]
      ,[tipoUsuario]
      ,[urlInicio]
  FROM [dbo].[DS_UsuariosTipos]


GO
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_ListarVendedorSoftland]
	@venCod VARCHAR(8)
AS
BEGIN
		IF NOT EXISTS (SELECT VenCod FROM [KUPPEL].[Softland].[cwtvend] WHERE VenCod=@venCod)
			SET @venCod=''

		SELECT
			VenCod = vendedor.VenCod,
			VenDes = vendedor.VenCod + ' - ' + vendedor.VenDes,
			CodTipV = ISNULL(vendedor.CodTipV,''),
			EMail = ISNULL(vendedor.EMail,''),
			Usuario = ISNULL(vendedor.Usuario,'')
		FROM
			[KUPPEL].[Softland].[cwtvend] vendedor
		WHERE
			vendedor.VenCod = (CASE @venCod WHEN '' THEN vendedor.VenCod ELSE @venCod END)
END
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland2]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_ListarVendedorSoftland2]
@pv_BaseDatos varchar(100)
AS
DECLARE @query varchar(max)

SELECT @query = ''

SELECT @query = @query + '
		SELECT
			VenCod = vendedor.VenCod,
			VenDes = vendedor.VenCod + '' - '' + vendedor.VenDes,
			CodTipV = ISNULL(vendedor.CodTipV,''''),
			EMail = ISNULL(vendedor.EMail,''''),
			Usuario = ISNULL(vendedor.Usuario,'''')
		FROM
			['+@pv_BaseDatos+'].[Softland].[cwtvend] vendedor
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_ListaTallaColorProducto]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListaTallaColorProducto]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[FR_ListaTallaColorProducto]
(
	@pv_CodProd varchar(max)
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''
	select @query = @query + '
	SELECT		CodigoBodega = codbode
	,			CodigoProducto = codprod
	,			Talla = partida
	,			Color = pieza
	,			CantidadBodega = ISNULL(CONVERT(INT, sum(ingresos-egresos)), 0)
	FROM		[' + @pv_BaseDatos + '].[softland].IW_vsnpMovimStockTipoBod  
	where		codprod = ''' + @pv_CodProd + '''
	group by	codprod, codbode, partida, pieza
	'


	exec (@query)
END  
GO
/****** Object:  StoredProcedure [dbo].[FR_ModificarNVCabecera]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ModificarNVCabecera]

@NVNumero int,

@nvFem datetime,
@nvEstado varchar(1),
@nvEstFact int,
@nvEstDesp int,
@nvEstRese int,
@nvEstConc int,
@nvFeEnt datetime,
@CodAux varchar(10),
@VenCod varchar(4),
@CodMon varchar(2),
@CodLista varchar(3),
@nvObser text,
@CveCod varchar(3),
@NomCon varchar(30),
@CodiCC varchar(8),
@nvSubTotal float,
@nvPorcDesc01 float,
@nvDescto01 float,
@nvPorcDesc02 float,
@nvDescto02 float,
@nvPorcDesc03 float,
@nvDescto03 float,
@nvPorcDesc04 float,
@nvDescto04 float,
@nvPorcDesc05 float,
@nvDescto05 float,
@nvMonto float,
@NumGuiaRes int,
@nvPorcFlete float,
@nvValflete float,
@nvPorcEmb float,
@nvEquiv float,
@nvNetoExento float,
@nvNetoAfecto float,
@nvTotalDesc float,
@ConcAuto varchar(1),
@CheckeoPorAlarmaVtas varchar(1),
@EnMantencion int,
@Usuario varchar(8),
@UsuarioGeneraDocto varchar(8),
@FechaHoraCreacion datetime,
@Sistema varchar(2),
@ConcManual varchar(1),
@proceso varchar(50),
@TotalBoleta float,
@NumReq int,
@CodVenWeb varchar(50),
@EstadoNP varchar(1),
@CodLugarDesp varchar(30)
as
begin
	update [DSNotaVenta].[dbo].[DS_NotasVenta]
	SET
	[nvFem]=@nvFem,
	[nvEstado]=@nvEstado,
	[nvEstFact]=@nvEstFact,
	[nvEstDesp]=@nvEstDesp,
	[nvEstRese]=@nvEstRese,
	[nvEstConc]=@nvEstConc,
	[nvFeEnt]=@nvFeEnt,
	[CodAux]=@CodAux,
	[VenCod]=@VenCod,
	[CodMon]=@CodMon,
	[CodLista]=@CodLista,
	[nvObser]=@nvObser,
	[CveCod]=@CveCod,
	[NomCon]=@NomCon,
	[CodiCC]=@CodiCC,
	[nvSubTotal]=@nvSubTotal,
	[nvPorcDesc01]=@nvPorcDesc01,
	[nvDescto01]=@nvDescto01,
	[nvPorcDesc02]=@nvPorcDesc02,
	[nvDescto02]=@nvDescto02,
	[nvPorcDesc03]=@nvPorcDesc03,
	[nvDescto03]=@nvDescto03,
	[nvPorcDesc04]=@nvPorcDesc04,
	[nvDescto04]=@nvDescto04,
	[nvPorcDesc05]=@nvPorcDesc05,
	[nvDescto05]=@nvDescto05,
	[nvMonto]=@nvMonto,
	[NumGuiaRes]=@NumGuiaRes,
	[nvPorcFlete]=@nvPorcFlete,
	[nvValflete]=@nvValflete,
	[nvPorcEmb]=@nvPorcEmb,
	[nvEquiv]=@nvEquiv,
	[nvNetoExento]=@nvNetoExento,
	[nvNetoAfecto]=@nvNetoAfecto,
	[nvTotalDesc]=@nvTotalDesc,
	[ConcAuto]=@ConcAuto,
	[CheckeoPorAlarmaVtas]=@CheckeoPorAlarmaVtas,
	[EnMantencion]=@EnMantencion,
	[Usuario]=@Usuario,
	[UsuarioGeneraDocto]=@UsuarioGeneraDocto,
	[FechaHoraCreacion]=@FechaHoraCreacion,
	[Sistema]=@Sistema,
	[ConcManual]=@ConcManual,
	[proceso]=@proceso,
	[TotalBoleta]=@TotalBoleta,
	[NumReq]=@NumReq,
	[CodVenWeb]=@CodVenWeb,
	[EstadoNP]=@EstadoNP,
	[CodLugarDesp]=@CodLugarDesp
	where 
	[NVNumero] = @NVNumero




	DECLARE @tableHTML  NVARCHAR(MAX) ; 
	declare @NVNumeroc varchar(20);
	declare @cliente varchar(max);
	declare @Usuarioc varchar(max);
	declare @direccion varchar(max);
	declare @fpedido varchar(max);
	declare @fentrega varchar(max);
	declare @Obser varchar(max);
	declare @total varchar(max);
	declare @correo varchar(max);
	declare @totalboleta1 varchar(max);
	declare @iva varchar(max);

	set @NVNumeroc = @NVNumero
	set @cliente = (select (cliente.CodAux+' - '+cliente.NomAux) as Cliente from [DSNotaVenta].dbo.[DS_NotasVenta] nv inner join [KUPPEL].[softland].[cwtauxi] cliente on cliente.CodAux = nv.CodAux  collate Modern_Spanish_CI_AS where nv.NVNumero = @NVNumeroc)
	set @Usuarioc = (select (vend.VenCod+' - '+vend.VenDes) as usuario from [DSNotaVenta].dbo.[DS_NotasVenta] nv inner join [KUPPEL].[softland].cwtvend vend on vend.VenCod = nv.VenCod  collate Modern_Spanish_CI_AS where nv.NVNumero = @NVNumeroc)
	set @direccion = (select CodLugarDesp from  [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @fpedido = (select CONVERT (char(10), nvFem, 103) as fecha from  [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @fentrega = (select CONVERT (char(10), nvFeEnt, 103) as nvFeEnt from [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @Obser = (select nvObser FROM [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @total = (select REPLACE(CONVERT(varchar, convert(money, nvNetoAfecto), 1),'.00','') as monto from [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @correo = 'frojas@disofi.cl;'
	set @totalboleta1 = (select REPLACE(CONVERT(varchar, convert(money, TotalBoleta), 1),'.00','') as monto from [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero=@NVNumeroc) 
	set @iva = (select REPLACE(CONVERT(varchar, convert(money, TotalBoleta-nvNetoAfecto), 1),'.00','') as monto from  [DSNotaVenta].dbo.[DS_NotasVenta] where NVNumero=@NVNumeroc) 
	

	SET @tableHTML = 
	
		N'<H1>Nota de Venta</H1>' + 
		N'<H4>Nº Int: '+@NVNumeroc+'</H4>'+ 
		N'<H4>Cliente: ' + @cliente +'</H4>'+
		N'<H4>Direccion: '+ @Direccion +'</H4>'+
		N'<H4>Fecha Pedido: ' + @fpedido +'</H4>'+
		N'<H4>Fecha Entrega: '+ @fentrega +'</H4>'+
		N'<H4>Observaciones: '+ @Obser+'</H4>'+
		N'<H4>Vendedor: '+ @Usuarioc +'</H4>'+
	
		N'<table border="1">' +  
		N'<tr>' +  
		N'<td>ID</td>'+
		N'<th nowrap="nowrap">Codigo Producto</th>'+
		N'<th>Detalle Producto</th>'+
		N'<th>Cantidad</th>'+
		N'<th>U. Medida</th>'+
		N'<th>Precio</th>'+
		N'<th>Sub-Total</th>'+
		N'<th>Desc.%</th>'+
		N'<th>Total</th>'+
		N'</tr>' +  
		CAST ( ( SELECT td = cast(a.nvLinea as int), '',  
						td = a.CodProd, '',  
						td = b.DesProd, '',  
						td = cast(a.nvCant as int), '',  
						td = a.CodUMed, '',  
						td = REPLACE(CONVERT(varchar, convert(money,  a.nvPrecio), 1),'.00',''), '',
						td = REPLACE(CONVERT(varchar, convert(money,  a.nvSubTotal), 1),'.00',''), '',
						td = REPLACE(CONVERT(varchar, convert(money,  a.nvDPorcDesc01), 1),'.00',''), '',
						td = REPLACE(CONVERT(varchar, convert(money,  a.nvTotLinea), 1),'.00','')
				from [DSNotaVenta].dbo.DS_NotasVentaDetalle as a
				inner join [KUPPEL].[softland].[iw_tprod] as b on b.CodProd = a.CodProd collate Modern_Spanish_CI_AS
				where a.NVNumero = @NVNumeroc 
				order by a.nvLinea
				  FOR XML PATH('tr'), TYPE   
		) AS NVARCHAR(MAX) ) +  

		N'<td colspan="8">Total</td>'+
		N'<td>'+@total+'</td>'+
		N'<tr><td colspan="8">Iva</td>'+
		N'<td>'+@iva+'</td></tr>'+
		N'<tr><td colspan="8">Total</td>'+
		N'<td>'+@totalboleta1+'</td></tr>'+
		N'</table>' ;   


	EXEC  msdb.dbo.sp_send_dbmail @profile_name='Sistema' , 
	@recipients= @correo ,
	@subject= 'Nota de Venta',
	@body = @tableHTML,  
	@body_format = 'HTML' ;





end

GO
/****** Object:  StoredProcedure [dbo].[FR_ModificarParametrosUsuarios]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[FR_ModificarParametrosUsuarios]  
(
	@pi_IdEmpresa INT
,	@pb_MultiEmpresa BIT
,	@pb_ManejaAdministrador BIT
,	@pb_ManejaAprobador BIT
,	@pb_ListaClientesVendedor BIT
,	@pb_ListaClientesTodos BIT
,	@pb_ValidaReglasNegocio BIT
,	@pb_ManejaListaPrecios BIT
,	@pb_EditaPrecioProducto BIT
,	@pb_MuestraCondicionVentaCliente BIT
,	@pb_MuestraCondicionVentaTodos BIT
,	@pb_EditaDescuentoProducto BIT
,	@pd_MaximoDescuentoProducto DECIMAL(18, 2)
,	@pb_CantidadDescuentosProducto INT
,	@pb_MuestraStockProducto BIT
,	@pb_StockProductoEsMasivo BIT
,	@pb_StockProductoEsBodega BIT
,	@pv_StockProductoCodigoBodega VARCHAR(1000)
,	@pb_ControlaStockProducto BIT
,	@pb_EnvioMailCliente BIT
,	@pb_EnvioMailVendedor BIT
,	@pb_EnvioMailContacto BIT
,	@pb_EnvioObligatorioAprobador BIT 
,	@pb_ManejaTallaColor BIT 
,	@pb_CambioVendedorCliente BIT
,	@pb_ManejaDescuentoTotalDocumento BIT 
,	@pi_CantidadDescuentosTotalDocumento INT
,	@pi_CantidadLineas INT
,	@pb_ManejaLineaCreditoVendedor BIT 
,	@pb_ManejaLineaCreditoAprobador BIT 
,	@pb_ManejaCanalVenta BIT 
,	@pb_CreacionNotaVentaUsuariosBloqueados BIT 
,	@pb_CreacionNotaVentaUsuariosInactivos BIT 
,	@pb_PermiteModificacionCondicionVenta BIT 
,	@pv_AtributoSoftlandDescuentoCliente VARCHAR(1000)
,	@pb_PermiteCrearDireccion BIT 
,	@pb_CrearClienteConDV BIT 
,	@pb_MuestraUnidadMedidaProducto BIT 
,	@pb_DescuentoLineaDirectoSoftland BIT 
,	@pb_DescuentoTotalDirectoSoftland BIT 
,	@pb_AgregaCliente BIT 
,	@pb_EnvioMailAprobador BIT 
,	@pb_ManejaSaldo BIT 
)
as  
begin
	UPDATE	[dbo].[DS_Parametros]  
	SET		MultiEmpresa = @pb_MultiEmpresa
	,		ManejaAdministrador = @pb_ManejaAdministrador
	,		ManejaAprobador = @pb_ManejaAprobador
	,		ListaClientesVendedor = @pb_ListaClientesVendedor
	,		ListaClientesTodos = @pb_ListaClientesTodos
	,		ValidaReglasNegocio = @pb_ValidaReglasNegocio
	,		ManejaListaPrecios = @pb_ManejaListaPrecios
	,		EditaPrecioProducto = @pb_EditaPrecioProducto
	,		MuestraCondicionVentaCliente = @pb_MuestraCondicionVentaCliente
	,		MuestraCondicionVentaTodos = @pb_MuestraCondicionVentaTodos
	,		EditaDescuentoProducto = @pb_EditaDescuentoProducto
	,		MaximoDescuentoProducto = @pd_MaximoDescuentoProducto
	,		CantidadDescuentosProducto = @pb_CantidadDescuentosProducto
	,		MuestraStockProducto = @pb_MuestraStockProducto
	,		StockProductoEsMasivo = @pb_StockProductoEsMasivo
	,		StockProductoEsBodega = @pb_StockProductoEsBodega
	,		StockProductoCodigoBodega = @pv_StockProductoCodigoBodega
	,		ControlaStockProducto = @pb_ControlaStockProducto
	,		EnvioMailCliente = @pb_EnvioMailCliente
	,		EnvioMailVendedor = @pb_EnvioMailVendedor
	,		EnvioMailContacto = @pb_EnvioMailContacto
	,		EnvioObligatorioAprobador = @pb_EnvioObligatorioAprobador
	,		ManejaTallaColor = @pb_ManejaTallaColor
	,		CambioVendedorCliente = @pb_CambioVendedorCliente
	,		ManejaDescuentoTotalDocumento = @pb_ManejaDescuentoTotalDocumento
	,		CantidadDescuentosTotalDocumento = @pi_CantidadDescuentosTotalDocumento
	,		CantidadLineas = @pi_CantidadLineas
	,		ManejaLineaCreditoVendedor = @pb_ManejaLineaCreditoVendedor
	,		ManejaLineaCreditoAprobador = @pb_ManejaLineaCreditoAprobador
	,		ManejaCanalVenta = @pb_ManejaCanalVenta
	,		CreacionNotaVentaUsuariosBloqueados = @pb_CreacionNotaVentaUsuariosBloqueados
	,		CreacionNotaVentaUsuariosInactivos = @pb_CreacionNotaVentaUsuariosInactivos
	,		PermiteModificacionCondicionVenta = @pb_PermiteModificacionCondicionVenta
	,		AtributoSoftlandDescuentoCliente = @pv_AtributoSoftlandDescuentoCliente
	,		PermiteCrearDireccion = @pb_PermiteCrearDireccion
	,		CrearClienteConDV = @pb_CrearClienteConDV
	,		MuestraUnidadMedidaProducto = @pb_MuestraUnidadMedidaProducto
	,		DescuentoLineaDirectoSoftland = @pb_DescuentoLineaDirectoSoftland
	,		DescuentoTotalDirectoSoftland = @pb_DescuentoTotalDirectoSoftland
	,		AgregaCliente = @pb_AgregaCliente
	,		EnvioMailAprobador = @pb_EnvioMailAprobador	
	,		ManejaSaldo = @pb_ManejaSaldo	
	WHERE	IdEmpresa = @pi_IdEmpresa
	
	SELECT	Verificador = CAST(1 as bit)
	,		Mensaje = 'Parametros Actualizados satisfactoriamente'
end
GO
/****** Object:  StoredProcedure [dbo].[FR_ObtenerAtributoDescuentoCliente]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		--select	ValorAtributo = 15
		EXEC (@query)
	end try
	begin catch
		select	ValorAtributo = 0
	end catch
GO
/****** Object:  StoredProcedure [dbo].[FR_ObtenerCredito]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ObtenerCredito]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[FR_ObtenerCredito]
	@pv_CodAux varchar(15)
,	@pv_BaseDatos varchar(100)
as
BEGIN
	DECLARE @query varchar(max)
	
	select	@query = ''

	select	@query = @query + '
	IF EXISTS (select codaux from [' + @pv_BaseDatos + '].[softland].[CWDocSaldos] where CodAux = ''' + @pv_CodAux + ''') BEGIN
 		SELECT
			CONVERT(numeric(18,2),vcl.MtoCre) as Credito,
			CONVERT(NUMERIC(18,2),SUM(doc.DEBE)) as Debe,
			CONVERT(numeric(18,2),SUM(doc.HABER)) as Haber
		FROM
			[' + @pv_BaseDatos + '].softland.cwtcvcl as vcl INNER JOIN [' + @pv_BaseDatos + '].softland.CWDocSaldos as doc on vcl.CodAux = ''' + @pv_CodAux + ''' and doc.CodAux= vcl.CodAux 
		GROUP by
			vcl.MtoCre
	END
	ELSE BEGIN
		SELECT
			CONVERT(numeric(18,2),MtoCre) as Credito,
			Debe = CONVERT(numeric(18,2),0),
			Haber = CONVERT(numeric(18,2),0)
		FROM
			[' + @pv_BaseDatos + '].softland.cwtcvcl where CodAux = ''' + @pv_CodAux + '''	
	END
	'

	exec (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Credito_Cliente]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Credito_Cliente]
@pv_BaseDatos varchar (100),
@CodAux varchar (25)
AS
DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '
	Select CONVERT(numeric(18,2),vcl.MtoCre)
	From ['+@pv_BaseDatos+'].softland.cwtcvcl as vcl INNER JOIN ['+@pv_BaseDatos+'].softland.CWDocSaldos as doc on
	 vcl.CodAux = '''+@CodAux+''' and doc.CodAux= vcl.CodAux 
	Group by vcl.MtoCre '

exec (@query)
	
GO
/****** Object:  StoredProcedure [dbo].[Get_cwmovimFV]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_cwmovimFV] 
@pv_BaseDatos varchar (100),
@MovNumDocRef float
AS
BEGIN
DECLARE @query varchar (max)

SELECT @query = ''
SELECT @query = @query + '
select min(MovFv) from  ['+@pv_BaseDatos+'].softland.cwmovim cwom
where cwom.MovNumDocRef = '+convert(varchar(30),@MovNumDocRef)+' and ttdcod= ''FV'' 
'
print (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[Get_DeudaClienteDia]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_DeudaClienteDia]
@CodAux varchar(20)
AS
DECLARE @deuda numeric
Set @deuda = (SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from JS_DebeCliente2 
where CODAUX=  @CodAux)

IF @deuda = null
Set @deuda=0
IF @deuda is null
Set @deuda=0
IF @deuda < 0

SELECT @deuda
GO
/****** Object:  StoredProcedure [dbo].[Get_DeudaClienteTotal]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_DeudaClienteTotal]
@pv_BaseDatos varchar (100),
@CodAux AS varchar(20)
AS
DECLARE @query varchar (max)
SELECT @query = ''
SELECT @query = @query + 'SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  ['+@pv_BaseDatos+'].softland.CWDocSaldos
where CODAUX= '''+@CodAux+'''
'

EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[insertaNVSoftland]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[insertaNVSoftland]
	@nvId int,
	@pv_BaseDatos varchar(100)
AS
	declare @fechanv datetime
	Select @fechanv =  nvfem from [dbo].[DS_NotasVenta] WHERE [Id] = @nvId
	DECLARE @query nvarchar (max)

	--Setear variable @ultimaNvNum
	declare @ultimaNvNumero nvarchar(100) ;
	DECLARE @query1 nvarchar(max);
	SELECT @query1 = N'SELECT @ultimaNvOUT =  max([NVNumero]) + 1  FROM ' + @pv_BaseDatos + '.[softland].[nw_nventa]';
	DECLARE @ParmDefinition nvarchar(500);  
	SET @ParmDefinition = N'@ultimaNvOUT int OUTPUT';  	
	EXEC sp_executesql @query1, @ParmDefinition, @ultimaNvOUT=@ultimaNvNumero OUTPUT;  
	--*****************************
	



	SET @query =  N'insert into ['+@pv_BaseDatos+'].[softland].[nw_nventa] select '+convert(varchar(100),@ultimaNvNumero)+'
	,[nvFem],[nvEstado],[nvEstFact],[nvEstDesp],[nvEstRese],[nvEstConc],''0'',[NumOC],[nvFeEnt],[CodAux],[VenCod],[CodMon],[CodLista],[nvObser],[nvCanalNV]
	,[CveCod],[NomCon],[CodiCC],[CodBode],[nvSubTotal],[nvPorcDesc01],[nvDescto01],[nvPorcDesc02],[nvDescto02],[nvPorcDesc03],[nvDescto03],[nvPorcDesc04]
	,[nvDescto04],[nvPorcDesc05],[nvDescto05],[nvMonto],[nvFeAprob],[NumGuiaRes], Case when nvValflete <> 0 then (([nvValflete]/ [nvSubTotal]) * 100) else [nvPorcFlete] end   as  [nvPorcFlete],[nvValflete],
	Case when [nvValEmb] <> 0 then (([nvValEmb]/ [nvSubTotal]) * 100) else [nvPorcFlete] end   as  [nvPorcEmb],''0'',[nvEquiv],[nvNetoExento]
	,[nvNetoAfecto],[nvTotalDesc],[ConcAuto],[CodLugarDesp],[SolicitadoPor],[DespachadoPor],[Patente],[RetiradoPor],[CheckeoPorAlarmaVtas],[EnMantencion],[Usuario]
	,[UsuarioGeneraDocto],[FechaHoraCreacion],[Sistema],[ConcManual],''0-0'',[MarcaWG],[proceso],[TotalBoleta],[NumReq],[CodBodeWms],CodLugarDocto,RutTransportista, null, null
	FROM [dbo].[DS_NotasVenta] WHERE [Id] = '+CONVERT(VARCHAR(100), @nvId)+';
	
	insert into ['+@pv_BaseDatos+'].[softland].[nw_detnv] SELECT  '+convert(varchar(100),@ultimaNvNumero)+'
	,[nvLinea],[nvCorrela],[nvFecCompr],[CodProd],[nvCant],[nvPrecio],[nvEquiv],[nvSubTotal],[nvDPorcDesc01],[nvDDescto01],[nvDPorcDesc02],[nvDDescto02]
	,[nvDPorcDesc03],[nvDDescto03],[nvDPorcDesc04],[nvDDescto04],[nvDPorcDesc05],[nvDDescto05],[nvTotDesc],[nvTotLinea],[nvCantDesp],[nvCantProd],[nvCantFact]
	,[nvCantDevuelto],[nvCantNC],[nvCantBoleta],[nvCantOC],[DetProd],[CheckeoMovporAlarmaVtas],[KIT],[CodPromocion],[CodUMed],[CantUVta],[MarcaWG],[Partida],[Pieza]
	,[FechaVencto],[CantidadKit],[PorcIncidenciaKit] FROM [dbo].[DS_NotasVentaDetalle] WHERE [IdNotaVenta] =  '+CONVERT(VARCHAR(100), @nvId)+';
	
	insert into ['+@pv_BaseDatos+'].[softland].[nw_impto](nvNumero,codimpto,valpctIni,afectoImpto,Impto)
	select '+convert(varchar(100),@ultimaNvNumero)+' ,iwti.codimpto,iwtv.valpctini,
	Case when iwti.CodImpto =''IVA'' then (nwv.nvvalflete + Sum(nwd.nvSubtotal)) else Sum(nwd.nvSubtotal) END  as afectoImpto,
	Case when iwti.CodImpto =''IVA'' then ((nwv.nvvalflete + Sum(nwd.nvSubtotal))* iwtv.valpctini)/100 else Sum(((iwtv.valpctini * nwd.nvSubtotal)/100)) END  as Impto
	
	from ['+@pv_BaseDatos+'].[softland].[iw_timprod] iwti 
	left join ['+@pv_BaseDatos+'].softland.[iw_timpval] iwtv on iwti.codimpto = iwtv.codimpto
	left join ['+@pv_BaseDatos+'].softland.nw_detnv nwd on nwd.codprod = iwti.codprod 
	left join ['+@pv_BaseDatos+'].softland.nw_nventa nwv on nwv.nvnumero = nwd.nvnumero
	where nwd.codprod = iwti.codprod 
	and '''+convert(varchar(100),@fechanv,103)+''' >iwtv.fecinivig and '''+convert(varchar(100),@fechanv,103)+''' < iwtv.fecfinvig
	and nwd.nvnumero = '+convert(varchar(100),@ultimaNvNumero)+'
	group by iwti.codimpto,iwtv.valpctini,nwv.nvvalflete; 
	'
	EXEC (@query)
	--Fin insercion de impuestos
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarClientesCodAuxRut]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarClientesCodAuxRut]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[JS_ListarClientesCodAuxRut]  
(
	@vchrRutAux VARCHAR(20) = ''
,	@vchrCodAux VARCHAR(10) = ''
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''
	
-- ==========================================================================================  
-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
-- ==========================================================================================  

	select @query = @query + '
	SELECT	CodAux = clientes.CodAux,
			NomAux = clientes.[NomAux],
			RutAux = clientes.[RutAux],
			DirAux = clientes.[DirAux],
			DirNum = ISNULL(clientes.[DirNum],''''),
			NomCon = contacto.[NomCon],
			FonCon = ISNULL(contacto.[FonCon],''''),
			EMail = ISNULL(clientes.EMail,''''),
			Notas = clientes.Notas
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtauxi] clientes 
		left JOIN [' + @pv_BaseDatos + '].[softland].[cwtaxco] contacto 
			ON (clientes.CodAux = contacto.CodAuc)  
	WHERE	CodAux = ''' + @vchrCodAux + '''
	AND		RutAux = (CASE ''' + @vchrRutAux + ''' WHEN '''' THEN RutAux ELSE ''' + @vchrRutAux + ''' END)  
	'

	EXEC (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarContactos]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarContactos]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[JS_ListarContactos]
(
	@vchrCodAux VARCHAR(50) = ''
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''

	-- ==========================================================================================  
	-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
	-- ==========================================================================================  
	select @query = @query + '
	SELECT	CodAux = contacto.CodAuc
	,		NomCon = contacto.[NomCon]
	,		FonCon = ISNULL(contacto.[FonCon],'''')
	,		EMail = ISNULL(contacto.EMail,'''')  
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtaxco] contacto  
	WHERE	contacto.CodAuc = ''' + @vchrCodAux + '''
	'

	exec (@query)
end  
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarListaDePrecio]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[JS_ListarListaDePrecio]
as
BEGIN

Select CodLista, DesLista from 
KUPPEL.[softland].iw_tlispre 

END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes]    Script Date: 19-11-2019 14:45:09 ******/
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
CREATE PROCEDURE [dbo].[JS_ListarMisClientes]
    @cod nchar(10)
,	@ID int
,	@pv_BaseDatos varchar(100)
AS
BEGIN
	declare @query nvarchar(max)
	
	select	@query = ''

	select	@query = @query + '
	SELECT	c.CodAux
	,		c.NomAux
	,		c.DirAux
	,		c.DirNum
	,		c.RutAux
	,		FonAux1 = 
			CASE	WHEN c.FonAux1 IS NOT NULL 
						THEN c.FonAux1 
					WHEN c.FonAux2 IS NOT NULL 
						THEN c.FonAux2 
						ELSE c.FonAux3 
			END
	,		C.Notas
	FROM	['+@pv_BaseDatos+'].softland.[cwtauxven] A 
		INNER JOIN ['+@pv_BaseDatos+'].softland.cwtauxi C 
			ON (c.CodAux = a.CodAux) 
		INNER JOIN ['+@pv_BaseDatos+'].softland.cwtvend B 
			ON (b.VenCod = a.VenCod) 
		LEFT JOIN ['+@pv_BaseDatos+'].softland.cwtcvcl as vcl 
			ON vcl.CodAux = A.CodAux
	WHERE	b.VenCod in (''' + @cod + ''', ''OFI'')
	AND		C.Bloqueado	<> ''S''
	'

	exec (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes_concredito]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext JS_ListarMisClientes
/*------------------------------------------------------------------------------*/  
/*-- Empresa   : DISOFI            */  
/*-- Tipo    : Procedimiento           */  
/*-- Nombre    : [dbo].[JS_ListarMisClientes]        */  
/*-- Detalle   :              */  
/*-- Autor    : FDURAN            */  
/*-- Modificaciones  :              */  
/*------------------------------------------------------------------------------*/  
CREATE PROCEDURE [dbo].[JS_ListarMisClientes_concredito]  
 @cod nchar(10)  
, @ID int  
, @pv_BaseDatos varchar(100)  
AS  
BEGIN  
 declare @query nvarchar(max)  
   
 select @query = ''  
  
 select @query = @query + '  
 SELECT c.CodAux  
 ,  c.NomAux  
 ,  c.DirAux  
 ,  c.DirNum  
 ,  FonAux1 =   
   CASE WHEN c.FonAux1 IS NOT NULL   
      THEN c.FonAux1   
     WHEN c.FonAux2 IS NOT NULL   
      THEN c.FonAux2   
      ELSE c.FonAux3   
   END  
 ,  C.Notas  
 --,  DeudaVencida =   
 --  (  
 --   SELECT isnull(convert (numeric,( (sum(sub_a.DEBE)) - (sum(sub_a.HABER)))), 0)  
 --   from [' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a  
 --   where sub_a.CODAUX = c.CodAux  
 --   and  (  
 --      select isnull(min(MovFv), '''')  
 --      from [' + @pv_BaseDatos + '].[softland].[cwmovim] sub_cwom  
 --      where sub_cwom.MovNumDocRef = sub_a.MOVNUMDOCREF and ttdcod= ''FV''  
 --     ) < getdate()  
 --   and  MONTH  
 --     (  
 --      (  
 --       select isnull(min(MovFv), '''')  
 --       from [' + @pv_BaseDatos + '].[softland].[cwmovim] sub_cwom  
 --       where sub_cwom.MovNumDocRef = sub_a.MOVNUMDOCREF and ttdcod= ''FV''  
 --      )  
 --     ) < getdate()  
 --  )  
 --,  Deuda =   
 --  (  
 --   SELECT isnull(convert (numeric,( (sum(sub_a.DEBE)) - (sum(sub_a.HABER)))), 0)  
 --   FROM [' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a  
 --   where sub_a.CODAUX = c.CodAux  
 --  )  
 ,  Credito =   
   CASE WHEN (  
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
 FROM [' + @pv_BaseDatos + '].softland.[cwtauxven] A   
  INNER JOIN [' + @pv_BaseDatos + '].softland.cwtauxi C   
   ON (c.CodAux = a.CodAux)   
  INNER JOIN [' + @pv_BaseDatos + '].softland.cwtvend B   
   ON (b.VenCod = a.VenCod)   
  INNER JOIN [dbo].[DS_UsuarioEmpresa] D   
   ON (b.VenCod collate Modern_Spanish_CI_AS = d.VenCod)   
  LEFT JOIN [' + @pv_BaseDatos + '].softland.cwtcvcl as vcl   
   ON vcl.CodAux = A.CodAux  
 WHERE D.VenCod = ' + @cod + '  
 and  D.ID = ' + CONVERT(VARCHAR(20), @ID ) + '  
 AND  C.Bloqueado <> ''S''  
 '  
  
 EXEC (@query)  
END  
  
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarNVDETALLENM]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarNVDETALLENM]
		@nvId INT,
		@pv_BaseDatos varchar(100)
		as
		BEGIN
		DECLARE @query varchar(max)
		SELECT @query = ''
-- ==========================================================================================
-----------------Lista detalle  nota de venta según NVNumero-------------------------
-- ==========================================================================================
		SELECT @query = @query + '
			SELECT
				a.nvLinea,
				a.CodProd,
				b.DesProd,
				a.nvCant,
				a.CodUMed,
				a.nvPrecio,
				a.nvSubTotal,
				a.NVNumero,
				ROUND(a.nvDPorcDesc01,0) as nvDPorcDesc01,
				a.nvTotLinea
			FROM
				[dbo].[DS_NotasVentaDetalle] a INNER JOIN
				['+@pv_BaseDatos+'].[softland].[iw_tprod] b ON (b.CodProd collate Modern_Spanish_CI_AS = a.CodProd)
			WHERE
				a.IdNotaVenta = '+convert(varchar(100),@nvId)+'
			ORDER BY
				a.nvLinea
				'
				EXEC (@query)
		END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarNVNM]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarNVNM] --25 'transporte'
		@nvId INT,
		@pv_BaseDatos varchar(100)
		as
		BEGIN
		DECLARE @query varchar(max)
		SELECT @query = ''
-- ==========================================================================================
-----------------Lista la cabecera de la nota de venta según NVNumero-------------------------
-- ==========================================================================================
		SELECT @query = @query + '
			SELECT
				nv.Id,
				nv.NVNumero,
				vend.VenCod,
				vend.Usuario,
				conven.CveCod,
				conven.CveDes,
				nv.nvFem,
				nv.nvFeEnt,
				lista.CodLista,
				lista.DesLista,
				cliente.CodAux,
				cliente.NomAux,
				nv.NomCon,
				cc.CodiCC,
				cc.DescCC,
				nv.nvObser,
				nv.nvSubTotal,
				nv.TotalBoleta,
				nv.ErrorAprobador,
				nv.ErrorAprobadorMensaje
			FROM
				[dbo].[DS_NotasVenta] nv INNER JOIN
				['+@pv_BaseDatos+'].[softland].[cwtauxi] cliente ON (cliente.CodAux collate Modern_Spanish_CI_AS = nv.CodAux) left JOIN
				['+@pv_BaseDatos+'].[softland].cwtvend vend ON (vend.VenCod collate Modern_Spanish_CI_AS = nv.VenCod) left JOIN
				['+@pv_BaseDatos+'].[softland].cwtconv conven ON (conven.CveCod collate Modern_Spanish_CI_AS = nv.CveCod) left JOIN
				['+@pv_BaseDatos+'].[softland].iw_tlispre lista ON (lista.CodLista collate Modern_Spanish_CI_AS = nv.CodLista) left JOIN
				['+@pv_BaseDatos+'].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = nv.CodiCC)
			WHERE
				nv.Id = '+convert(varchar(100),@nvId)+'
				'
		EXEC (@query)
		END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarVendorVenCod]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[JS_ListarVendorVenCod]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE Procedure [dbo].[JS_ListarVendorVenCod]
(
	@VenCod VARCHAR(10)  
,	@pv_BaseDatos varchar(100)
)
AS  
BEGIN  
	declare @query varchar(max)

	select @query = ''
	
-- ==========================================================================================  
-- Lista los clientes filtrados por Codigo Aux y RUT Aux  
-- ========================================================================================== 
	select @query = @query + '
	SELECT	Nombre = du.Nombre,
			VenCod = due.VenCod,
			Email = du.email,
			Contrasena = du.ContrasenaCorreo
	FROM	dbo.DS_Usuarios du join dbo.DS_UsuarioEmpresa due on du.Id = due.IdUsuario
	WHERE	due.VenCod = ''' + @VenCod + '''
	'

	exec (@query)
end  


GO
/****** Object:  StoredProcedure [dbo].[Js_NvSoftland]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Js_NvSoftland] 
	as begin
	select max([NVNumero]) as NVNumero FROM KUPPEL.[softland].[nw_nventa]
	end
GO
/****** Object:  StoredProcedure [dbo].[RRA_ActualizaEstadoNW]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[RRA_ActualizaEstadoNW]
 @nvId    varchar(30),
 @pv_BaseDatos varchar (100)
as
begin
	
	declare @obser varchar(200)
	DECLARE @query varchar (max)
	
	set @obser = (select nvObser from dbo.DS_NotasVenta where dbo.DS_NotasVenta.Id = @nvId )

	declare @ultimaNvNumero nvarchar(100) ;
	DECLARE @query1 nvarchar(max);
	SELECT @query1 = N'SELECT @ultimaNvOUT =  max([NVNumero]) + 1  FROM ' + @pv_BaseDatos + '.[softland].[nw_nventa] 
						if (@ultimaNvOUT is null)
						set @ultimaNvOUT = 1';
	DECLARE @ParmDefinition nvarchar(500);  
	SET @ParmDefinition = N'@ultimaNvOUT int OUTPUT';  	
	EXEC sp_executesql @query1, @ParmDefinition, @ultimaNvOUT=@ultimaNvNumero OUTPUT;  
	
	declare @lv_CodigoCC varchar(100)
	declare @lv_NombreCC varchar(100)

	select	@lv_CodigoCC = CodiCC
	from	DS_Notasventa
	where	Id = @nvId

	DECLARE @query2 nvarchar(max);
	SELECT @query2 = N'SELECT @nomCC = desccc FROM ' + @pv_BaseDatos + '.[softland].[cwtccos] where codicc = ''' + @lv_CodigoCC + '''';
	DECLARE @ParmDefinition2 nvarchar(500);  
	SET @ParmDefinition2 = N'@nomCC varchar(100) OUTPUT';  	
	EXEC sp_executesql @query2, @ParmDefinition2, @nomCC=@lv_NombreCC OUTPUT; 

	
	update dbo.DS_NotasVenta  set EstadoNP = 'A',nvEstado = 'A', nvObser = @lv_CodigoCC + '-' + @lv_NombreCC + '-' + 'N. Int: '+@nvId+' Obs: '+@obser where dbo.DS_NotasVenta.Id = @nvId

	--exec dbo.insertaNVSoftland @nvId,@pv_BaseDatos
	
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

	UPDATE dbo.DS_NotasVenta set RutSolicitante = @ultimaNvNumero, nvObser = @lv_CodigoCC + '-' + @lv_NombreCC + '-' + ' NV: '+@ultimaNvNumero+' Obs: '+@obser  where dbo.DS_NotasVenta.Id = @nvId;

	SELECT convert(int,@ultimaNvNumero) 'NVNumero';

	EXEC SP_INS_AgregaImpuestoNV @pv_BaseDatos, @ultimaNvNumero, @nvId
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DELALL_UsuarioEmpresa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DELALL_UsuarioEmpresa]
(
	@pi_IdUsuario INT
)
AS
BEGIN
	DECLARE @lb_Verificador BIT
	DECLARE @lv_Mensaje VARCHAR(MAX)

	DELETE FROM dbo.DS_UsuarioEmpresa
	WHERE	IdUsuario = @pi_IdUsuario

	SELECT	@lb_Verificador = 1
	,		@lv_Mensaje = 'Usuario empresa eliminado exitosamente'
	
	SELECT	Verificador = @lb_Verificador 
	,		Mensaje = @lv_Mensaje 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Ciudad]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_GET_Ciudad]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[SP_GET_Ciudad]
(
	@pv_BaseDatos varchar(100)
)
AS
	declare @query varchar(max)

	select @query = ''

	select	@query = @query + '
	SELECT	CiuCod
	,		CiuDes 
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtciud] c 
	'

	exec (@query)
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Comuna]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_GET_Comuna]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[SP_GET_Comuna]
(
	@pv_BaseDatos varchar(100)
)
AS
	declare @query varchar(max)

	select @query = ''

	select	@query = @query + '
	SELECT	ComCod
	,		ComDes 
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtcomu] c 
	'

	exec (@query)
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DatosCorreoVend]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_DatosCorreoVend]
@NvNumero int,
 @pv_BaseDatos varchar(100)
as
SELECT	dnv.VenCod
,		u.email
,		u.ContrasenaCorreo
FROM	dbo.DS_NotasVenta dnv
	JOIN ds_usuarios u
		ON u.Id in (select sub_a.idUsuario from ds_usuarioEmpresa sub_a inner join ds_empresa sub_b on sub_a.idempresa = sub_b.id where sub_b.basedatos = @pv_BaseDatos and sub_a.VenCod = dnv.VenCod)
WHERE	dnv.NVNumero = @NvNumero
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Giro]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_Giro]
@pv_BaseDatos varchar(100)
AS
DECLARE @query varchar(max)

SELECT @query = ''

SELECT @query = @query + '
SELECT GirCod,GirDes 
FROM ['+@pv_BaseDatos+'] .softland.cwtgiro c	
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LOGIN]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_GET_LOGIN]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[SP_GET_LOGIN]  
	@Nombre varchar(15),       
	@Contrasena varchar(50)       
as 
begin
	set nocount on       
	
	select	u.Id
	,		u.Usuario
	,		u.TipoUsuario
	from	DS_Usuarios u       
	where	u.Usuario = @Nombre 
	and		u.Contrasena = @Contrasena 
	AND		u.Estado = 1  
	
	set nocount OFF       
end  
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Menu]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_Menu]
@TipoUsuario INT
as  
SELECT m.Id_Menu,m.Clase,m.PieMenu,m.Titulo,m.[Action],m.Controller
from Menu m 
where m.TipoUsuario = @TipoUsuario and m.Activo = 1 order by m.Orden 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCodVendedor]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetCodVendedor]
@pv_BaseDatos varchar(100)
AS
DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '
	select	VenCod
	,		VenDes
	from	(
				select	VenCod
				,		VenDes
				,		esnumero = isnumeric(vencod)
				FROM	['+@pv_BaseDatos+'].softland.cwtvend
			) a
	order by esnumero desc, (case when esnumero = 1 then convert(int, vencod) else 999999999 end) asc
'

EXEC (@query)

GO
/****** Object:  StoredProcedure [dbo].[SP_INS_AgregaImpuestoNV]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INS_AgregaImpuestoNV]
(
	@pv_BaseDatos varchar (100)
,	@pv_nvNumero varchar (100)
,	@pi_IdNotaVenta varchar (100)
)
AS
BEGIN
	DECLARE @query1 nvarchar(max);

	set	@query1 = ''

	set	@query1 = @query1 + '
	declare @codprod varchar(max)
	declare @codImpuesto varchar(max)
	declare @valorImpuesto int

	set @codImpuesto = ''''
	set @valorImpuesto = 0


	declare @IdNotaVenta int
	declare @IdNotaVentaDetalle int
	declare @nvSubTotal int

	declare @total_afecto int
	declare @total_impuesto int

	set @IdNotaVenta = ' + convert(varchar(20), @pi_IdNotaVenta) + '

	declare cursor_lineas cursor for
		select	Id
		,		nvSubTotal
		,		codprod
		from	DS_notasVentaDetalle
		where	idNotaVenta = @IdNotaVenta

	open cursor_lineas 

	fetch next from cursor_lineas 
	into @IdNotaVentaDetalle, @nvSubTotal, @codprod

	select	@total_afecto = 0

	while @@fetch_status = 0 begin
		SELECT top 1 @codImpuesto = CodImpto FROM  [' + @pv_BaseDatos + '].[softland].[iw_timprod] where codprod = @codprod
		SELECT top 1 @valorImpuesto = ValPctIni FROM  [' + @pv_BaseDatos + '].[softland].[iw_timpval] where CodImpto = @codImpuesto and getdate() between FecIniVig and FecFinVig

		select	@total_afecto = (@total_afecto + @nvSubTotal)
	
		fetch next from cursor_lineas 
		into @IdNotaVentaDetalle, @nvSubTotal, @codprod
	end

	select @total_impuesto = (@total_afecto * @valorImpuesto) / 100

	close cursor_lineas 
	deallocate cursor_lineas 

	insert into [' + @pv_BaseDatos + '].[softland].[nw_impto](nvnumero, codimpto, valpctini, afectoImpto, impto)
	select	' + @pv_nvNumero + ', @codImpuesto, @valorImpuesto, @total_afecto, @total_impuesto
	
	select	Verificador = cast(1 as bit)
	,		Mensaje = ''Se agrega impuesto''
	'

	exec (@query1)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INS_UsuarioEmpresa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INS_UsuarioEmpresa]
(
	@pi_IdUsuario INT
,	@pi_IdEmpresa INT
,	@pv_VenCod VARCHAR(50)
)
AS
BEGIN
	DECLARE @lb_Verificador BIT
	DECLARE @lv_Mensaje VARCHAR(MAX)

	INSERT INTO dbo.DS_UsuarioEmpresa
	(
	    IdUsuario,
	    IdEmpresa,
	    VenCod
	)
	VALUES
	(
		@pi_IdUsuario
	,	@pi_IdEmpresa
	,	@pv_VenCod
	)

	SELECT	@lb_Verificador = 1
	,		@lv_Mensaje = 'Usuario empresa insertado exitosamente'
	
	SELECT	Verificador = @lb_Verificador 
	,		Mensaje = @lv_Mensaje 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerCanalVenta]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ObtenerCanalVenta]
(
	@pv_BaseDatos varchar (100)
)
AS
BEGIN
	declare @query varchar(max)

	select @query = ''

	select @query = @query + '
	SELECT	*
	FROM	[' + @pv_BaseDatos + '].[softland].[cwtcana]
	'

	EXEC (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerVendedorCliente]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[SP_ObtenerVendedorCliente]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[SP_ObtenerVendedorCliente]
	@pv_CodAux varchar(100)
,	@pv_BaseDatos varchar(100)
AS
BEGIN
	declare @query nvarchar(max)
	
	select	@query = ''

	select	@query = @query + '
	SELECT	top 1 
			a.VenCod
	,		b.VenDes
	FROM	['+@pv_BaseDatos+'].softland.[cwtauxven] A 
		inner join ['+@pv_BaseDatos+'].softland.[cwtvend] B
			on a.VenCod = B.VenCod
	where	a.CodAux = ''' + @pv_CodAux + '''
	'

	exec (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ValidaExisteUsuarioEmpresa]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ValidaExisteUsuarioEmpresa]
(
	@pv_VenCod VARCHAR(20)
,	@pi_IdEmpresa int
)
AS
BEGIN
	DECLARE @lb_Verificador BIT
	DECLARE @lv_Mensaje VARCHAR(MAX)
	
	SELECT	@lb_Verificador = 0
	,		@lv_Mensaje = 'NO EXISTE'

	IF EXISTS
		(
			SELECT	top 1 1
			FROM	DS_UsuarioEmpresa
			WHERE	Vencod = @pv_VenCod
			and		IdEmpresa = @pi_IdEmpresa
		) BEGIN
		SELECT	@lb_Verificador = 1
		,		@lv_Mensaje = 'EXISTE'
	END
	
	SELECT	Verificador = @lb_Verificador
	,		Mensaje = @lv_Mensaje
END
GO
/****** Object:  StoredProcedure [dbo].[uSP_Login]    Script Date: 19-11-2019 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_Login]							*/
/*-- Detalle			:														*/
/*-- Autor				: YVEGA													*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[uSP_Login]
(
	@pv_Usuario VARCHAR(200)
,	@pv_Contrasena VARCHAR(200)
)
AS
BEGIN
	DECLARE	@lb_Verificador BIT
	DECLARE	@li_Id INT
	DECLARE	@lv_Mensaje VARCHAR(MAX)

	DECLARE	@lb_Estado BIT
	DECLARE	@lv_Contrasena VARCHAR(MAX)

	SELECT	@lb_Verificador = 0
	,		@lv_Mensaje = 'Error de usuario y/o contrasena'
	
	SELECT	@li_Id = Id
	,		@lb_Estado = Estado
	,		@lv_Contrasena = Contrasena
	FROM	Usuario
	WHERE	Usuario = @pv_Usuario

	IF @lb_Estado IS NOT NULL BEGIN
		IF @lb_Estado = 1 BEGIN
			IF @lv_Contrasena = @pv_Contrasena BEGIN
				SELECT	@lb_Verificador = 1
				,		@lv_Mensaje = 'Usuario autorizado'
			END
			ELSE BEGIN
				SELECT	@lb_Verificador = 0
				,		@lv_Mensaje = 'Error de usuario y/o contrasena'
			END
		END
		ELSE BEGIN
			SELECT	@lb_Verificador = 0
			,		@lv_Mensaje = 'Usuario desactivado'
		END
	END
	ELSE BEGIN
		SELECT	@lb_Verificador = 0
		,		@lv_Mensaje = 'Error de usuario y/o contrasena'
	END
	
	SELECT	Id = @li_Id
	,		Verificador = @lb_Verificador
	,		Mensaje = @lv_Mensaje
END
GO
