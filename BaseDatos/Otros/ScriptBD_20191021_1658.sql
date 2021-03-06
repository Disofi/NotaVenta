USE [DSNotaVenta]
GO
/****** Object:  View [dbo].[JS_DebeCliente2]    Script Date: 21-10-2019 16:58:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JS_DebeCliente2]
AS
SELECT DISTINCT CodAux, DEBE, HABER, MovNumDocRef, dbo.JS_cwmovimFV(MovNumDocRef) AS FV
FROM            TRANSPORTE.softland.CWDocSaldos AS A
WHERE        (dbo.JS_cwmovimFV(MovNumDocRef) < GETDATE()) AND (MONTH(dbo.JS_cwmovimFV(MovNumDocRef)) < GETDATE())
GO
/****** Object:  Table [dbo].[DS_Empresa]    Script Date: 21-10-2019 16:58:00 ******/
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
/****** Object:  Table [dbo].[DS_Estado]    Script Date: 21-10-2019 16:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Estado](
	[estado] [datetime] NULL,
	[proceso] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_Imagenes]    Script Date: 21-10-2019 16:58:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Imagenes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Imagen] [varbinary](max) NULL,
 CONSTRAINT [PK_DS_Imagenes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_NotasVenta]    Script Date: 21-10-2019 16:58:02 ******/
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
 CONSTRAINT [DS_NotasVenta_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_NotasVentaDetalle]    Script Date: 21-10-2019 16:58:02 ******/
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
/****** Object:  Table [dbo].[DS_Parametros]    Script Date: 21-10-2019 16:58:02 ******/
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
	[ManejaLineaCredito] [bit] NULL,
	[ManejaCanalVenta] [bit] NULL,
	[CreacionNotaVentaUsuariosBloqueados] [bit] NULL,
	[CreacionNotaVentaUsuariosInactivos] [bit] NULL,
	[PermiteModificacionCondicionVenta] [bit] NULL,
	[AtributoSoftlandDescuentoCliente] [varchar](1000) NULL,
	[PermiteCrearDireccion] [bit] NULL,
	[CrearClienteConDV] [bit] NULL,
	[MuestraUnidadMedidaProducto] [bit] NULL,
	[DescuentoLineaDirectoSoftland] [bit] NULL,
	[DescuentoTotalDirectoSoftland] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_ParametrosUsuario]    Script Date: 21-10-2019 16:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_ParametrosUsuario](
	[Aprobador] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_UsuarioEmpresa]    Script Date: 21-10-2019 16:58:02 ******/
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
/****** Object:  Table [dbo].[DS_Usuarios]    Script Date: 21-10-2019 16:58:02 ******/
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
/****** Object:  Table [dbo].[DS_UsuariosTipos]    Script Date: 21-10-2019 16:58:02 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 21-10-2019 16:58:02 ******/
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
/****** Object:  Table [dbo].[tabla]    Script Date: 21-10-2019 16:58:02 ******/
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
/****** Object:  Table [dbo].[TABLA2019_10_14_11_39_59]    Script Date: 21-10-2019 16:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA2019_10_14_11_39_59](
	[CodProd] [varchar](20) NOT NULL,
	[Cantidad] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DS_Empresa] ON 
GO
INSERT [dbo].[DS_Empresa] ([Id], [Nombre], [BaseDatos]) VALUES (1, N'TRANSPORTE', N'TRANSPORTE')
GO
INSERT [dbo].[DS_Empresa] ([Id], [Nombre], [BaseDatos]) VALUES (2, N'KUPPEL', N'KUPPEL')
GO
SET IDENTITY_INSERT [dbo].[DS_Empresa] OFF
GO
SET IDENTITY_INSERT [dbo].[DS_NotasVenta] ON 
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (6, N'P', 928082179, CAST(N'2019-10-17T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-18T00:00:00.000' AS DateTime), N'76488070', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-17T13:12:25.697' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', N'SANTIAGO', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-17T13:12:25.697' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (7, N'P', 928082179, CAST(N'2019-10-17T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-18T00:00:00.000' AS DateTime), N'76488070', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-17T13:12:25.697' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', N'SANTIAGO', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-17T13:12:25.697' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (8, N'P', 928082179, CAST(N'2019-10-17T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-18T00:00:00.000' AS DateTime), N'76488070', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-17T13:15:41.467' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', N'SANTIAGO', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-17T13:15:41.467' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (9, N'P', 0, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'P', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T14:51:47.897' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (10, N'P', 928082180, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-21T14:57:52.737' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T14:57:52.737' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (11, N'P', 928082181, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-21T15:32:16.917' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T15:32:16.920' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (12, N'P', 928082182, NULL, N'A', 0, 0, 0, 0, 0, N'0', NULL, NULL, NULL, N'01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-21T15:55:03.283' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', NULL, NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T15:55:03.287' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (13, N'P', 928082183, NULL, N'A', 0, 0, 0, 0, 0, N'0', NULL, NULL, NULL, N'01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-21T15:56:05.220' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', NULL, NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T15:56:05.220' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (14, N'P', 928082184, NULL, N'A', 0, 0, 0, 0, 0, N'0', NULL, NULL, NULL, N'01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-21T15:57:24.787' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', NULL, NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T15:57:24.787' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (15, N'P', 928082185, NULL, N'A', 0, 0, 0, 0, 0, N'0', NULL, NULL, NULL, N'01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-10-21T16:00:54.563' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 0, 0, N'N', NULL, NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:00:54.563' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (16, N'P', 928082186, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 3227, CAST(N'2019-10-21T16:02:02.780' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:02:02.780' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (17, N'P', 928082187, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 3227, CAST(N'2019-10-21T16:09:02.640' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:09:02.640' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (18, N'P', 928082188, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 3227, CAST(N'2019-10-21T16:13:51.187' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:13:51.187' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (19, N'P', 928082189, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 3227, CAST(N'2019-10-21T16:14:44.860' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:14:44.860' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (20, N'P', 928082190, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 150, 7, 0, 8, 0, 9, 0, 10, 0, 3227, CAST(N'2019-10-21T16:19:24.500' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 150, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:19:24.500' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (21, N'P', 928082191, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 157, 7, 172, 8, 183, 9, 189, 10, 191, 3227, CAST(N'2019-10-21T16:21:51.617' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 892, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:21:51.617' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (22, N'P', 928082192, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 157, 7, 172, 8, 183, 9, 189, 10, 191, 3227, CAST(N'2019-10-21T16:32:33.277' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 892, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:32:33.277' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (23, N'P', 928082193, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 157, 7, 172, 8, 183, 9, 189, 10, 191, 3227, CAST(N'2019-10-21T16:34:59.697' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 892, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:34:59.697' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (24, N'P', 928082194, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 157, 7, 172, 8, 183, 9, 189, 10, 191, 3227, CAST(N'2019-10-21T16:36:53.303' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 892, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:36:53.303' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (25, N'P', 928082195, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 157, 7, 172, 8, 183, 9, 189, 10, 191, 3227, CAST(N'2019-10-21T16:47:14.997' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 892, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:47:14.997' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (26, N'P', 928082196, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 3227, 6, 157, 7, 172, 8, 183, 9, 189, 10, 191, 3227, CAST(N'2019-10-21T16:49:30.253' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 892, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:49:30.253' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DS_NotasVenta] ([Id], [EstadoNP], [NVNumero], [nvFem], [nvEstado], [nvEstFact], [nvEstDesp], [nvEstRese], [nvEstConc], [CotNum], [NumOC], [nvFeEnt], [CodAux], [VenCod], [CodMon], [CodLista], [nvObser], [nvCanalNV], [CveCod], [NomCon], [CodiCC], [CodBode], [nvSubTotal], [nvPorcDesc01], [nvDescto01], [nvPorcDesc02], [nvDescto02], [nvPorcDesc03], [nvDescto03], [nvPorcDesc04], [nvDescto04], [nvPorcDesc05], [nvDescto05], [nvMonto], [nvFeAprob], [NumGuiaRes], [nvPorcFlete], [nvValflete], [nvPorcEmb], [nvValEmb], [nvEquiv], [nvNetoExento], [nvNetoAfecto], [nvTotalDesc], [ConcAuto], [CodLugarDesp], [SolicitadoPor], [DespachadoPor], [Patente], [RetiradoPor], [CheckeoPorAlarmaVtas], [EnMantencion], [Usuario], [UsuarioGeneraDocto], [FechaHoraCreacion], [Sistema], [ConcManual], [RutSolicitante], [proceso], [TotalBoleta], [NumReq], [CodVenWeb], [CodBodeWms], [CodLugarDocto], [RutTransportista], [Cod_Distrib], [Nom_Distrib], [MarcaWG]) VALUES (27, N'P', 928082197, CAST(N'2019-10-21T00:00:00.000' AS DateTime), N'A', 0, 0, 0, 0, 0, N'0', CAST(N'2019-10-22T00:00:00.000' AS DateTime), N'52003435', N'15  ', N'01', NULL, N' ', NULL, N'003', NULL, N'40-20-99', NULL, 1722, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1722, CAST(N'2019-10-21T16:50:49.730' AS DateTime), 0, 0, 0, 0, 0, 1, 0, 1722, 0, N'N', N'00', NULL, NULL, NULL, NULL, N'N', 0, N'', N'SOFTLAND', CAST(N'2019-10-21T16:50:49.730' AS DateTime), N'NW', N'N', NULL, N'Notas de Venta', 1722, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[DS_NotasVenta] OFF
GO
SET IDENTITY_INSERT [dbo].[DS_NotasVentaDetalle] ON 
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (1, 3, 0, 2, 0, NULL, NULL, 1, 3760, 0, 3760, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (2, 3, 0, 3, 0, NULL, NULL, 1, 3760, 0, 3760, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (3, 4, 0, 1, 0, NULL, NULL, 6, 3760, 0, 22560, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (4, 4, 0, 2, 0, NULL, NULL, 3, 3760, 0, 11280, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (5, 4, 0, 3, 0, NULL, NULL, 5, 3760, 0, 18800, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (6, 5, 0, 1, 0, CAST(N'2019-10-17T13:10:06.763' AS DateTime), N'PTA822100N', 3, 3760, 1, 11280, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11280, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 3, N'0TU', N'001', NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (7, 5, 0, 2, 0, CAST(N'2019-10-17T13:10:06.800' AS DateTime), N'PTA822100N', 2, 3760, 1, 7520, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7520, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 2, N'0TU', N'002', NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (8, 8, 928082179, 1, 0, CAST(N'2019-10-17T13:15:41.693' AS DateTime), N'PTA822100N', 3, 3760, 1, 11280, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11280, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 3, N'0TU', N'001', NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (9, 8, 928082179, 2, 0, CAST(N'2019-10-17T13:15:41.853' AS DateTime), N'PTA822100N', 2, 3760, 1, 7520, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7520, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 2, N'0TU', N'002', NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (10, 8, 928082179, 3, 0, CAST(N'2019-10-17T13:15:41.970' AS DateTime), N'PTA822100N', 2, 3760, 1, 7520, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7520, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 2, N'0TU', N'003', NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (11, 9, 0, 1, 0, CAST(N'2019-10-21T14:51:47.983' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3760, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (12, 10, 928082180, 1, 0, CAST(N'2019-10-21T14:57:53.363' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3760, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (13, 11, 928082181, 1, 0, CAST(N'2019-10-21T15:32:17.113' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 9, 0, 5, 0, 6, 0, 8, 0, 3, 0, 0, 2726, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (14, 12, 928082182, 1, 0, CAST(N'2019-10-21T15:55:03.613' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 8, 0, 6, 0, 5, 0, 7, 0, 4, 0, 0, 2757, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (15, 13, 928082183, 1, 0, CAST(N'2019-10-21T15:56:05.367' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 8, 0, 13, 0, 17, 0, 6, 0, 9, 0, 0, 2136, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (16, 14, 928082184, 1, 0, CAST(N'2019-10-21T15:57:24.930' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 8, 0, 7, 0, 6, 0, 9, 0, 4, 0, 0, 2641, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (17, 15, 928082185, 1, 0, CAST(N'2019-10-21T16:00:54.733' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 8, 0, 7, 0, 9, 0, 5, 0, 7, 0, 0, 2586, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (18, 16, 928082186, 1, 0, CAST(N'2019-10-21T16:02:02.937' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (19, 17, 928082187, 1, 0, CAST(N'2019-10-21T16:09:02.797' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (20, 18, 928082188, 1, 0, CAST(N'2019-10-21T16:13:51.337' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (21, 19, 928082189, 1, 0, CAST(N'2019-10-21T16:14:45.010' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (22, 20, 928082190, 1, 0, CAST(N'2019-10-21T16:19:24.663' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (23, 21, 928082191, 1, 0, CAST(N'2019-10-21T16:21:51.800' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (24, 22, 928082192, 1, 0, CAST(N'2019-10-21T16:32:33.430' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (25, 23, 928082193, 1, 0, CAST(N'2019-10-21T16:34:59.853' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (26, 24, 928082194, 1, 0, CAST(N'2019-10-21T16:36:53.447' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (27, 25, 928082195, 1, 0, CAST(N'2019-10-21T16:47:15.140' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (28, 26, 928082196, 1, 0, CAST(N'2019-10-21T16:49:30.400' AS DateTime), N'PTA822100N', 1, 3760, 1, 3760, 1, 38, 2, 74, 3, 109, 4, 142, 5, 170, 533, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
INSERT [dbo].[DS_NotasVentaDetalle] ([Id], [IdNotaVenta], [NVNumero], [nvLinea], [nvCorrela], [nvFecCompr], [CodProd], [nvCant], [nvPrecio], [nvEquiv], [nvSubTotal], [nvDPorcDesc01], [nvDDescto01], [nvDPorcDesc02], [nvDDescto02], [nvDPorcDesc03], [nvDDescto03], [nvDPorcDesc04], [nvDDescto04], [nvDPorcDesc05], [nvDDescto05], [nvTotDesc], [nvTotLinea], [nvCantDesp], [nvCantProd], [nvCantFact], [nvCantDevuelto], [nvCantNC], [nvCantBoleta], [nvCantOC], [DetProd], [CheckeoMovporAlarmaVtas], [KIT], [CodPromocion], [CodUMed], [CantUVta], [Partida], [Pieza], [FechaVencto], [CantidadKit], [MarcaWG], [PorcIncidenciaKit]) VALUES (29, 27, 928082197, 1, 0, CAST(N'2019-10-21T16:50:49.903' AS DateTime), N'PTA822100N', 1, 3760, 1, 3227, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3227, 0, 0, 0, 0, 0, 0, NULL, NULL, N'N', NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[DS_NotasVentaDetalle] OFF
GO
SET IDENTITY_INSERT [dbo].[DS_Parametros] ON 
GO
INSERT [dbo].[DS_Parametros] ([Id], [IdEmpresa], [MultiEmpresa], [ManejaAdministrador], [ManejaAprobador], [ListaClientesVendedor], [ListaClientesTodos], [ValidaReglasNegocio], [ManejaListaPrecios], [EditaPrecioProducto], [MuestraCondicionVentaCliente], [MuestraCondicionVentaTodos], [EditaDescuentoProducto], [MaximoDescuentoProducto], [CantidadDescuentosProducto], [MuestraStockProducto], [StockProductoEsMasivo], [StockProductoEsBodega], [StockProductoCodigoBodega], [ControlaStockProducto], [EnvioMailCliente], [EnvioMailVendedor], [EnvioMailContacto], [EnvioObligatorioAprobador], [ManejaTallaColor], [ManejaDescuentoTotalDocumento], [CantidadDescuentosTotalDocumento], [CantidadLineas], [ManejaLineaCredito], [ManejaCanalVenta], [CreacionNotaVentaUsuariosBloqueados], [CreacionNotaVentaUsuariosInactivos], [PermiteModificacionCondicionVenta], [AtributoSoftlandDescuentoCliente], [PermiteCrearDireccion], [CrearClienteConDV], [MuestraUnidadMedidaProducto], [DescuentoLineaDirectoSoftland], [DescuentoTotalDirectoSoftland]) VALUES (1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, CAST(20.00 AS Decimal(18, 2)), 5, 1, 1, 0, N'', 1, 1, 1, 1, 0, 0, 1, 5, 30, 1, 1, 0, 0, 0, N'', 1, 0, 0, 0, 0)
GO
INSERT [dbo].[DS_Parametros] ([Id], [IdEmpresa], [MultiEmpresa], [ManejaAdministrador], [ManejaAprobador], [ListaClientesVendedor], [ListaClientesTodos], [ValidaReglasNegocio], [ManejaListaPrecios], [EditaPrecioProducto], [MuestraCondicionVentaCliente], [MuestraCondicionVentaTodos], [EditaDescuentoProducto], [MaximoDescuentoProducto], [CantidadDescuentosProducto], [MuestraStockProducto], [StockProductoEsMasivo], [StockProductoEsBodega], [StockProductoCodigoBodega], [ControlaStockProducto], [EnvioMailCliente], [EnvioMailVendedor], [EnvioMailContacto], [EnvioObligatorioAprobador], [ManejaTallaColor], [ManejaDescuentoTotalDocumento], [CantidadDescuentosTotalDocumento], [CantidadLineas], [ManejaLineaCredito], [ManejaCanalVenta], [CreacionNotaVentaUsuariosBloqueados], [CreacionNotaVentaUsuariosInactivos], [PermiteModificacionCondicionVenta], [AtributoSoftlandDescuentoCliente], [PermiteCrearDireccion], [CrearClienteConDV], [MuestraUnidadMedidaProducto], [DescuentoLineaDirectoSoftland], [DescuentoTotalDirectoSoftland]) VALUES (2, 2, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, CAST(50.00 AS Decimal(18, 2)), 5, 1, 1, 0, N'', 1, 1, 1, 1, 0, 0, 1, 5, 30, 1, 1, 0, 0, 0, N'', 1, 0, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[DS_Parametros] OFF
GO
INSERT [dbo].[DS_ParametrosUsuario] ([Aprobador]) VALUES (1)
GO
SET IDENTITY_INSERT [dbo].[DS_UsuarioEmpresa] ON 
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) VALUES (1, 2, 1, N'15        ')
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) VALUES (2, 1, 1, N'15        ')
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) VALUES (3, 3, 1, N'15        ')
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) VALUES (11, 1, 2, N'02        ')
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) VALUES (12, 2, 2, N'02        ')
GO
INSERT [dbo].[DS_UsuarioEmpresa] ([Id], [IdUsuario], [IdEmpresa], [VenCod]) VALUES (10, 10, 1, N'083       ')
GO
SET IDENTITY_INSERT [dbo].[DS_UsuarioEmpresa] OFF
GO
SET IDENTITY_INSERT [dbo].[DS_Usuarios] ON 
GO
INSERT [dbo].[DS_Usuarios] ([ID], [Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [Nombre], [ContrasenaCorreo], [Estado]) VALUES (1, N'adm', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 1, N'Admin', N'Disofi2019', 1)
GO
INSERT [dbo].[DS_Usuarios] ([ID], [Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [Nombre], [ContrasenaCorreo], [Estado]) VALUES (2, N'vendedor', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 2, N'Vendedor', N'Disofi2019', 1)
GO
INSERT [dbo].[DS_Usuarios] ([ID], [Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [Nombre], [ContrasenaCorreo], [Estado]) VALUES (3, N'aprobador', N'81dc9bdb52d04dc20036dbd8313ed055', N'CAFSANMART', N'057', N'prueba.disofi@gmail.com', 3, N'Aprobador', N'Disofi2019', 1)
GO
INSERT [dbo].[DS_Usuarios] ([ID], [Usuario], [Contrasena], [Cliente], [CCosto], [email], [tipoUsuario], [Nombre], [ContrasenaCorreo], [Estado]) VALUES (10, N'frandemo', N'81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, N'demo@demo.cl', 2, N'Francisco', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[DS_Usuarios] OFF
GO
SET IDENTITY_INSERT [dbo].[DS_UsuariosTipos] ON 
GO
INSERT [dbo].[DS_UsuariosTipos] ([ID], [tipoUsuario], [urlInicio]) VALUES (1, N'Administrador', N'Parametros')
GO
INSERT [dbo].[DS_UsuariosTipos] ([ID], [tipoUsuario], [urlInicio]) VALUES (2, N'Vendedor', N'Todolosclientes')
GO
INSERT [dbo].[DS_UsuariosTipos] ([ID], [tipoUsuario], [urlInicio]) VALUES (3, N'Aprobador', N'Reporte')
GO
SET IDENTITY_INSERT [dbo].[DS_UsuariosTipos] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (1, N'fa fa-home', N'Administracion', N'Usuario', N'Usuarios', N'Administracion', 1, 1, 1)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (2, N'fa fa-home', N'Administracion', N'Clientes', N'Clientes', N'Administracion', 1, 1, 2)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (3, N'fa fa-home', N'Administracion', N'Parametros', N'Parametros', N'Administracion', 0, 1, 3)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (4, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 0, 1, 4)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (5, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 0, 1, 5)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (6, N'fa fa-home', N'Realizar Venta', N'Ventas', N'MisClientes', N'Venta', 0, 1, 6)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (7, N'fa fa-home', N'Realizar Venta', N'Ventas', N'MisClientes', N'Venta', 2, 1, 1)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (8, N'fa fa-home', N'Reporte', N'Notas de Venta Pendientes', N'FacturasPendientes', N'Reporte', 3, 1, 1)
GO
INSERT [dbo].[Menu] ([Id_Menu], [Clase], [PieMenu], [Titulo], [Action], [Controller], [TipoUsuario], [Activo], [Orden]) VALUES (9, N'fa fa-home', N'Reporte', N'Notas de Venta Aprobadas', N'FacturasAprobadas', N'Reporte', 3, 1, 2)
GO
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'10033152', N'GONZALO PIZARRO PUCIO ', N'LUIS ZEGERS', N'288', N'3547462', N'CLIENTE SIN MOVIMIENTO HACE 2 AÑOS.
EN CASO DE GENERAR COMPRA CONTACTARSE CON VENDEDOR.', 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'10306378', N'JUAN ANDRES GONZALEZ MORALES ', N'LA POSADA', N'2260', N'7710870', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

OK DICOM , S.I.I.  25/03/08  CLIENTE ACTIVADO CHEQUE AL DIA CON 12% DCTO.', 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'10369623', N'GLORIA FUENTES PEREZ', N'PASAJE NIRVILO 5674', NULL, N'7930517', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'11124843', N'MARIA TERESA SILVA BARROS ', N'AV. BORGOÑO       ', N'14190', N'7617415 ', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'11962573', N'MARIA LORENA SAN MARTIN ESCOBAR', N'PASAJE DOLAR CANADIENSE    8572', NULL, N'6672986', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'12005265', N'MAURICIO PEDRO DIAZ ASPEE ', N'BAQUEDANO', N'1280', N'251539 ', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'13094097', N'DAVID PATRICIO AGUIRRE ALDAY ', N'SANTA ROSA', N'1068', N'6348724', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'14727567', N'RICHARD JEAN JACQUES DECOLNET', N'CARRASCAL', NULL, N'786 3586', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'3185807', N'LUIS EDUARDO COVARRUBIAS OVALLE ', N'ALONSO MONROY', N'2539', NULL, N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'4806098', N'HUMBERTO MANOSALVA ALVAREZ', N'GUARDIA MARINA RIQUELME', NULL, N'5224732', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'4829057', N'CARLOS HOMERO RICARDO MENARES BERTRAND ', N'COLLAO', N'2970', N'2428824 ', N'EN ANALISIS DE CARTERA SE ENTREGA CLIENTE A PATRICIA ALVAREZ   PARA SU VISITA   PARA SU POSTERIOR ANALISIS GENERAL
', 0, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'4945289', N'JORGE HERNAN MIRANDA ALVARADO ', N'LORD COCHRANE', N'1060', N'6989147', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'52002892', N'CONFECCIONES LEOPOLDO MEDEL PONS E.I.R.L. ', N'LAS CARABELAS', N'1199', N'8723002', N'Deuda cartigada en un 50 %. Mantiene deuda del otro 50%', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'52003435', N'TAJIMA INDUSTRIAL LTDA.', N'SANTA ELVIRA 82', NULL, N'5443134', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'56032920', N'CAMARA CHIL.CONSTRUCCION', N'SANTIAGO', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'56058190', N'LOTEO AGRICOLA PRIVADO LAS BRISAS DE CHICUREO', N'CARRETERA GENERAL SAN MARTIN', NULL, N'8609202', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'59059900', N'HAMBURG SUD CHILE ', N'AV.APOQUINDO', N'3669', N'2908300', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'5923169', N'BRAULIO ARRIAGADA MATHIEU ', N'AV.IRARRAZABAL', N'2821', N'2747238', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'6035597', N'RICARDO CASTILLO AGUIRRE ', N'ANIBAL PINTO', N'4215', N'8629566', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60505104', N'CARABINEROS DE CHILE PREFECTURA ANTOFAGASTA ', N'MATTA', N'3211', N'755015', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.
COMPRA ATRAVEZ DE CHILE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60505208', N'CARABINEROS DE CHILE PREF. VIÑA DEL MAR ', N'AV. MAR DE CHILE SEC. GLORIAS NAVALES', NULL, N'2862169', N'ATENCION SR. JUAN ZAPATA CABO 1º

PROPUESTA CHILE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60505522', N'CARABINEROS DE CHILE PREF. CAUTIN TEMUCO ', N'LOS NOGALES,                   SECTOR LAS QUILAS', N'SN', N'235857', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60505719', N'CARABINEROS DE CHILE - ESC. DE SUBOFICIALES ', N'RODRIGO DE ARAYA ', N'2601', N'9221300', N'23/04/2008

EN ACTUALIZACION  DE MAESTRO CLIENTE SE REVISA CLIENTE EN EL SII, DANDO CUENTA QUE NO TIENE INICIACION DE ACTIVIDADES.

PROPUESTAS A TRAVEZ DE CHILE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60506000', N'POLICIA DE INVESTIGACIONES DE CHILE ', N'AV.PAJARITOS', N'5783', N'6773910', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SOLICITUD DE PEDIDOS A TRAVEZ DE CHILE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60910000', N'UNIVERSIDAD DE CHILE', N'CAMINO DEL OBSERVATORIO 1515', NULL, N'9771097', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'60911006', N'UNIVERSIDAD DEL BIO BIO, CAMPUS CONCEPCION ', N'AVDA COLLAO', N'1202', N'2731200', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61004000', N'DIRECCION GENERAL DE GENDARMERIA DE CHILE ', N'SANTO DOMINGO', N'1382', N'5891512', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61004035', N'ESCUELA DE GENDARMERIA ', N'ARTEMIO GUTIERREZ', N'1153', N'5552310', N'23/04/2008

EN REVISION DE MAESTRO CLIENTE SE CONFIRMA TERMINO DE GIRO EN EL SII.  POR TANTO NO POSEE DOCUMENTOS TRIBUTARIOS AUTORIZADOS POR EL SII.

TERMINO DEL GIRO 30/09/2003', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61008000', N'COD CERECO ANTUHUE SENAME ', N'CAMIMO LOS ROMERALES    (LA SOLEDAD)', N'S-N', N'621185', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008

BLOQUEADO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61011000', N'MINISTERIO DE DEFENSA NACIONAL DIR. ADMINISTRATIVA', N'VILLA VICENCIO', NULL, N'2221202 A.513', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61103009', N'CLUB OFICIALES DE LA FUERZA AEREA ', N'AGUSTINAS', N'743', N'5402701', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SE GENERA VENTA A TRAVES DE CHILE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61202000', N'DIRECCION GENERAL DE AGUAS - MOP ', N'MORANDE', N'59', N'4493804', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SE GENERA VENTA A TRAVEZ DE CHILE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61219000', N'METRO S.A. ', N'Alameda', N'1414', N'2503164', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61606901', N'SERVICIO DE SALUD DEL MAULE HOSPITAL DE TALCA ', N'1 NORTE', N'1990', N'209347', N'CLIENTE CON RIESGO', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61607100', N'SERVICIO DE SALUD CONCEPCION ', N'AVDA. LIBERTADOR BDO O`HIGGINS', N'297', N'2721773', N'CLIENTE CON RIESGO

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61608003', N'INSTITUTO PSIQUIATRICO DR JOSE HORWITZ BARAK ', N'AV. LA PAZ', N'841', N'4793412', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61608200', N'SERVICIO SALUD METROPOLITANO OCCIDENTE ', N'AVDA LIBERTADOR BERNARDO OHIGGINS', N'2429', N'5741044', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61608203', N'SERV. SALUD OCCIDENTE INST. TRAUMATOLOGICO DE STGO ', N'SAN MARTIN', N'771', N'3970313', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SE GENERA VENTA A TRAVEZ DE CHILE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61608700', N'CENT. DE ABASTECIMIENTO DEL SIST. NAC. SERV. SALUD ', N'AVDA MATTA', N'644', N'5504700', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'61812000', N'SERV. VIVIENDA Y URBANIZACION AREA METROPOLITANA ', N'SERRANO', N'45', N'7820846', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'6227397', N'PATRICIA ELIANA MEDINA BUSTOS ', N'NUEVA SUCRE', N'2544', N'2251824', N'CONTACTO
CAROLA NAVARRO, SUB GERENTE DE MARKETING

E-Mail: carola@mar-k.cl', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69050800', N'I MUNICIPALIDAD DE PANQUEHUE ', N'TRONCAL', N'1166', N'591059', N'CON ORDEN DE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69070100', N'I MUNICIPALIDAD DE SANTIAGO ', N'SANTO DOMINGO', N'916', N'7136000', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SE GENERA VENTA A TRAVEZ DE CHILE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69070200', N'I. MUNICIPALIDAD DE CONCHALI', N'INDEPENDENCIA 3994', NULL, N'8286100', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69070600', N'I.MUNICIPALIDAD DE LA REINA ', N'AVDA. LARRAIN', N'9925', N'5927389', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69071600', N'ILUSTRE MUNICIPALIDAD DE TIL TIL ', N'ARTURO PRAT', N'200', N'8461002', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69072600', N'I. MUNICIPALIDAD DE PAINE ', N'AVDA. GRAL. BAQUEDANO', N'490', N'8218648', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69190300', N'I. MUNICIPALIDAD DE PERQUENCO ', N'ESMERALDA', N'497', N'537132', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SE GENERA VENTA A TRAVEZ DE CHILE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69210100', N'ILUSTRE MUNICIPALIDAD DE OSORNO ', N'MACKENNA', N'851', N'264300', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

SE GENERA VENTA A TRAVEZ DE CHILE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'69253800', N'I. MUNICIPALIDAD DE LA PINTANA ', N'AVDA SANTA ROSA', N'12975', N'3896977 ', N'CONTRA ORDEN DE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'70016380', N'CRUZADA DE LITERATURA CRISTIANA ', N'AMUNATEGUI', N'57', N'6873250', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'70037600', N'CONSEJO DE DEFENSA DEL NIÑO ', N'AV CALERA DE TANGO', N'PARC. 6', N'2330713', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'70285100', N'MUTUAL DE SEGURIDAD C.CH.C. ', N'ALAMEDA', N'194', N'7879000', N'CONTRA ORDEN DE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'70360100', N'ASOCIACION CHILENA DE SEGURIDAD', N'AV. VICUÑA MACKENNA   152', NULL, N'26853787', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'70381100', N'ASOC.GREMIAL DE DUEÑOS DE TAXIBUSES P.DE VALDIVIA ', N'REAL ALICANTE', N'6698', N'2853067', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'7177360', N'ELIZABETH SILVA ROA ', N'CALIFORNIA', N'2448', N'2098301', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'72702600', N'BUSES MANZANAL A.G. DE T. ', N'EDMUNDO CABEZAS', N'01859', N'267252', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'72905900', N'ASOC. GREMIAL DE TAXIBUS GRANJA NELSON PEREIRA. ', N'SANTA LUCIA', N'1799', N'227576', N'24/04/2008

EN REVISION DE MAESTRO CLIENTE SE CONFIRMA TERMINO DE GIRO EN EL SII.  POR TANTO NO POSEE DOCUMENTOS TRIBUTARIOS AUTORIZADOS POR EL SII.

TERMINO DEL GIRO  30/09/2003', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'7315537', N'JAIME GAMBINO ESCOBEDO', N'LUIS INFANTE CERDA   5451', NULL, N'9680067', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'7439017', N'ROSA LILA RAMIREZ ', N'CHILE ANTARTICO', N'603', NULL, N'DEUDA ANTIGUA PENDIENTE

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'74451700', N'CLUB DE GOLF T DEP.CHICUREO ', N'CARRETERA GRAL.SN.MARTIN', N'KM 27', N'8609200', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'7515521', N'MANUEL DEL CARPIO ', N'HAMBURGO', N'1759', N'2775335', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'75971930', N'ESC. DE FORM.POLICIAL DE CARABINEROS ', N'PEDRO AGUIRRE CERDA', N'6655', N'5576171', N'SE GENERA VENTA A TRAVEZ DE CHILE COMPRA 1 VEZ AL AÑO - PROPUESTA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76040320', N'BORQUEZ Y FONCEA CONFECCIONES Y DISEÑO LTDA ', N'PUERTO FINO', N'4355', N'4750259', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76085350', N'YANIRA WALTER Y COMPAÑIA LIMITADA', N'AVDA LIBERTADOR BERNARDO OHIGGINS   949   dpto 112', NULL, N'6968635', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76136150', N'SERTOTAL S.A.', N'CATEDRAL 1009 OF. 407', NULL, N'6725209', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76193360', N'UMBRALE S.A. ', N'CARMEN', N'1320', N'5567821', N'23/04/2008

EN REVISION DE MAESTRO CLIENTE SE CONFIRMA TERMINO DE GIRO EN EL SII, Y TRABAJA CON NUEVA RAZON SOCIAL:

EUROFASHION LIMITADA
RUT : 79829500', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76243150', N'TEXTILES JURI LIMITADA ', N'PORTUGAL', N'1055', N'2222579', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76265740', N'INMOBILIARIA Y CONSTRUCTORA LAPCO LIMITADA ', N'AVDA EL VALLE', N'937', N'7280200', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76268600', N'AGUILERA HERMANOS LIMITADA ', N'AV. JOSE MIGUEL CARRERA', N'5018', N'9442998', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76288880', N'ONETTO MARKETING LTDA ', N'LAS ARAÑAS', N'5805', NULL, N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

CLIENTE DE VICTOR SPIKIN TRASPASADO A PATRICIA ALVAREZ

06/08/2008
QUEDA  INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76408720', N'AMM INVEST S.A. ', N'VITACURA', N'4380', N'3304300', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76421320', N'CAPACITACION USACH COMPAÑIA LIMITADA ', N'ALAMEDA', N'1611', N'6972097', N'COMPRA CONTRA ORDEN DE COMPRA

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76449700', N'BORDADOS CORPORATIVOS S.A.', N'DOMINGO STA. MARIA', NULL, N'7382055', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76475080', N'SANTALO S.A. ', N'BUENOS AIRES', N'330', N'7355100', N'direccion anterior Presidente Riesco 3320
ex-telefono 3334552', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76488070', N'INGENIERIA Y SEGURIDAD INDUSTRIAL KS LIMITADA', N'VICTOR MANUEL 1180', NULL, N'5553343', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76492500', N'COMERCIAL D & D S.A.', N'BUENOS AIRES', NULL, N'7378018', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76509990', N'SERV.LOG.INT.SERVILOG LTDA.', N'NAPOLEON', NULL, N'2487571', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76511910', N'SEMPREVIVO Y AVELLI LTDA.', N'AVDA. MATTA', NULL, N'6347797', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76536220', N'EMPRESA DE TRANSPORTE PUBLICO Y PRIVADO DE PASAJEROS ', N'CORDILLERA DE LOS ANDES', N'222', N'5160955', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76613260', N'COMERCIAL FULL-SEG COM.LTDA.', N'RICARDO CUMMING 72-A', NULL, N'6993127', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76677130', N'CAMPO Y ASOCIADOS LIMITADA ', N'CONFERENCIA', N'1141', N'6834423 ', N'CREADO EL 10-07-2007', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'76693550', N'COMERCIAL VHL LIMITADA ', N'RENATO SANCHEZ', N'3533', N'2445672', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77004250', N'ACEROS COX COMERCIAL S.A. ', N'JUANA WEBER DE AMUNATEGUI', N'4707', N'4981000 ', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77038620', N'COMERCIAL CASTRO LIMITADA ', N'AVDA CERRILLOS', N'4430', N'5571125', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77045700', N'SERV. DE GEST. INF. Y COMP. UNIV DE SANTIAGO CHILE ', N'AVDA. LIB. BDO. OHIGGINS', N'3363', N'7180200', N'PEDIDOS CONTRA ORDEN DE COMPRA

DESPACHOS: 
LUNES A JUEVES
MATUCANA 28-D FRENTE CALLE ROMERO, EST. CENTRAL
VIERNES
ENTRANDO POR AVDA. ECUADOR, PRIMERA ESQUINA HACIA LA DERECHA CALLE SCHATCHTEBECH CON EL BELLOTO S/N (ENTRADA Y SALIDA DE VEHICULOS)', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77061080', N'PETITJEAN CHILE LTDA ', N'PANAMERICA NORTE', N'3525', N'4215100', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77090410', N'AGUILAR CUBILLOS Y MARIANGEL LIMITADA ', N'MATIAS COUSIÑO', N'82', N'3353848', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77122460', N'COMERCIAL SEGPOINT LIMITADA ', N'LIRA', N'1561', N'5514962', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77154110', N'INM.E INV.VALLE CENTRAL LTDA. ', N'AV.VITACURA  (PUEBLO INGLES)', N'6255', N'2187347', N'CONTRA ORDEN DE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77165540', N'SOC.DE SERV.Y CAPACITACION EN SEGURIDAD INTEGRAL L ', N'AV. ANTONIO VARAS', N'2693', N'3436953', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77247050', N'BAILAC SAN LIMITADA ', N'MAPOCHO', N'1999', N'6721431', N'CONOCIDO DON MAURICIO', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77262170', N'SOC. DE DISTRIBUCION CANJE Y MENSAJERIA LIMITADA ', N'LOS GOBELINOS', N'2567', N'3648500', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77287350', N'TRANSPORTES NELLY LTDA ', N'AV. MARCOLETA', N'10689', N'6281844', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77340250', N'IND. MERCHANDESING CHILE LTDA ', N'EL ROBLE', N'693', NULL, N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77358940', N'COM. Y PROVEEDORA DE PROD.ESPECIALES LTDA ', N'EDO.FREI MONTALVA', N'3525', N'4215114', N'06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77393720', N'CORPGROUP FINANCIAL SERVICES S.A. ', N'ROSARIO NORTE ', N'660', N'6606040', N'CONTRA ORDEN DE COMPRA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77402210', N'TRANSPORTE GOLDEN TOURS LTDA. ', N'GASPAR DE ORENSE', N'992', N'7720359', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77427000', N'ISS INGENIERA LIMITADA ', N'LUIS MONTANER', N'585', N'2054709', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77431200', N'QUEZADA Y ASAC LTDA. ', N'AV. AMERICO VESPUCIO', N'2880', N'6239151 ', N'ESTABLECIDO DESDE: 2000

GIRO: IMPORTACION, EXPORTACION Y COMERCIALIZACION

REPRESENTANTE LEGAL: VICTOR QUEZADA

BANCO BCI - CHILE - SANTANDER

CONTACTO: MAFALDA QUEZADA

PROVEEDORES COMERCIALES:
FERRETERIA AMUNATEGUI
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77470040', N'CENTRO PUERTO LTDA.', N'MANUEL RODRIGUEZ', NULL, N'6958058', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77595130', N'U.P.S.  S.C.F. TRANSPORTE (CHILE) LTDA. ', N'CARRET.GRAL.S.MARTIN', N'9260', N'4993667', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77612470', N'MATERIALES Y SERVICIOS ELECTRICOS CBN LIMITADA ', N'AVENIDA BALMACEDA', N'1063-A', N'316026', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77620020', N'AGRO COM.TERRAMAR CHILE LTDA', N'CARRET.  GRAL. SAN MARTIN PARCELA 27   13240  PARAD.24', NULL, N'8608212', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77643220', N'CARMEN VILLASECA E HIJA LTDA. ', N'3 SUR   (6 Y 7) ORIENTE', N'1350', N'713992', N'28/04/2008
CONTACTO
 SR. LUIS ZARATE , SOLO ESTARA DISPONIBLE HASTA FINES DE MAYO DEL 2008', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77676280', N'EPYSA EQUIPOS LTDA. ', N'AV. AMERICO VESPUCIO', N'1367', N'6232000 ', N'CREADO 26.06.08  (MONICA)

CLIENTE CAPTADO POR PATRICIA ALVAREZ

ESTABLECIDO 22.01.2001
REPRESENTANTE LEGAL: JUAN FCO. NOVION VERDUGO

BANCO SANTANDER - SUCURSAL CASA MATRIZ
CTA. : 28054-2

********************************************************
Rut 	Nombre
77.676.280-6  	EPYSA EQUIPOS PARA TRANSPORTE DE CARGA LIMITADA 

Dicom Plus Gold Empresas 	
Impagos: 0 		Acreditaciones: SI

		

Identificación
Rut 	  77.676.280-6
Razón Social 	  EPYSA EQUIPOS PARA TRANSPORTE DE CARGA LIMITADA
Rubro 	  VENTA O COMPRAVENTA AL POR MENOR DE VEHI

Antecedentes Comerciales
Última Dirección registrada 	 AMERICO VESPUCIO NORTE 1367 HUECHURABA, SANTIAGO 	N° de Direcciones registradas 	 2 	Direcciones registradas
Teléfono 1 	 02-6232000

Indicadores de Riesgo Crediticio ( Nueva Sección para Empresas )

				
	Al 27 de Junio de 2008 		A 	
				

Indicadores de Acreditación
Bancos en que ha registrado movimientos 	  1 : SANTANDER-CHILE. 	  	  	No significa que la cuenta corriente bancaria esté vigente
Socios y Sociedades 	  1 Vinculaciones como Socio ,
  2 Vinculaciones como Sociedad. 	Socios y Sociedades 	  	No implica vigencia de la vinculación
Ultimos movimientos de Comercio Exterior 	  Importaciones: año 2008 , CIF US$ 11.802.263,97
  Exportaciones: año 2008 , FOB US$ 1.377.718,96 	  	 

Indicadores de Prevención de Fraude

Registro de Morosidades y Protestos Impagos
No posee documentos impagos y/o protestados a la fecha de emisión de este informe

Indicador de Consultas al Rut
Rut registra 87 consultas en los últimos 6 MESES. Se presentan sólo las últimas 20 consultas.
Fecha 	Empresa 	Informes
25JUN2008 	EPYSA EQUIPOS PARA TRANSPORTE DE CARGA L 	DICOM FULL
25JUN2008 	EPYSA EQUIPOS PARA TRANSPORTE DE CARGA L 	DICOM PLUS
25JUN2008 	CITIBANK N.A. CC37100 	DICOM PLUS
25JUN2008 	SCOTIABANK SUD AMERICANO CC 2294 	DICOM PLUS
25JUN2008 	BANCO SANTANDER CHILE CC 34062 	DICOM PLUS
24JUN2008 	BANCO DEL ESTADO DE CHILE * RIESGO 	DICOM PLUS
20JUN2008 	BANCO SUD AMERICANO 	DICOM PLUS
18JUN2008 	BANCO ITAU CHILE 	DICOM PLUS
18JUN2008 	MUEBLES SUR S A 	DICOM PLUS
17JUN2008 	BANCO ITAU CHILE 	DICOM PLUS
12JUN2008 	W.B. WORK BEST CHILE S. A. 	DICOM PLUS
12JUN2008 	BANCO DEL DESARROLLO CC 504 	DICOM PLUS
06JUN2008 	BANCO SANTIAGO S.A. 	DICOM PLUS
05JUN2008 	BANCO ITAU CHILE 	DICOM PLUS
05JUN2008 	BANCO SANTIAGO S.A. 	DICOM PLUS
30MAY2008 	W.B. WORK BEST CHILE S. A. 	DICOM PLUS
29MAY2008 	TRANSWORLD SERVICES S.A. 	DICOM PLUS
28MAY2008 	NEFEX S.A. 	DICOM PLUS
28MAY2008 	SEGURYCEL S.A. 	DICOM PLUS
27MAY2008 	BANCO SANTANDER CHILE S.A. 	DICOM PLUS


Fuentes: Bases de Datos Equifax, Información Pública, Diario Oficial, Aportante Boletín DICOM, Servicio Nacional de Aduanas, Boletín de Informaciones Comerciales, Dirección del Trabajo . La data contenida en el informe se ajusta a la Ley N° 19.628 y su modificación contenida en la Ley N° 19.812.

 EQUIFAX   27/06/2008 10:11
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77698270', N'CABRERA NUÑEZ TECHNOLOGIES LIMITADA ', N'CAMINO LAS HUALTATAS', N'5000-28', N'2054305', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO  POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77744760', N'AL SUR LTDA. ', N'CALLE DEL ARZOBISPO', N'0637', N'7323437', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77782810', N'ABASTECEDOR IND. MULTISERVICE LTDA. ', N'MADRID', N'1111', N'5563973', N'MALAS REFERENCIAS COMERCIALES
DEUDA PENDIENTE IMPORTANTE', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77805340', N'SOC. COM. Y GANADERA PURRANQUE LTDA. ', N'BUZETA', N'4328', N'6837352', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77896350', N'VALLE DEL NORTE LIMITADA ', N'TABANCURA', N'1091', N'9-9987286 ', N'ARRENDATARIO 5 DE ABRIL, INMOBILIARIA SABA', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'77965030', N'BALUT HERMANOS LTDA. ', N'SIERRA BELLA', N'1448', N'5557725', N'EX FULL-SEG, RUT: 76.613.260

CONTACTO: ANDRES BOLIVAR', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78034470', N'LINDE HIGH LIFT CHILE S.A. ', N'P.EDUARDO FREI MONTALVA', N'6135', N'6242878', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78040120', N'OUTOTEC  CHILE   S.A.', N'AVDA VITACURA  2939 9° PISO', NULL, N'3362000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78080440', N'DESARROLLO DE TECNOLOGIAS Y SISTEMAS LTDA', N'ROSAS    1444', NULL, N'3971062', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78111020', N'ARENAS CONSTRUCTORA LTDA. ', N'AV. RECOLETA', N'4464', N'6251308 ', N'CREADO 29/05/08

INICIACION DE ACTIVIDADES  01.01.1993

CONTACTO: RODRIGO LEADEVIG

CLIENTE CONOCIDO DE MAURICIO SABA
TRASPASADO  A PATRICIA ALVAREZ PARA QUE LO ATIENDA.

OK. S.I.I. Y DICOM 30/05/08', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78125160', N'PROFIO LIMITADA', N'LOTA    2450    OF - 101', NULL, N'2-2335749', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78141500', N'LAHSEN Y LAHSEN LIMITADA', N'SANTA FILOMENA   326', NULL, N'7377768', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78180280', N'COMERCIAL EURO SCAN CHILE LIMITADA', N'DOMINICA 367  OF. 40  PISO 4', NULL, N'27777706', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78239140', N'JAIME MOYA Y COMPAÑIA LTDA.', N'AVDA. COLON 7374', NULL, N'3422148', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78254990', N'CV TRADING S.A. ', N'CAMINO EL GUANACO', N'6464', N'7409077', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78307010', N'ACEROS SANTA ANA DE BOLUETA CHILE LIMITADA ', N'IQUIQUE', N'5520', N'224961', N'A al 19 de Agosto de 2008      Aspectos Relevantes  
 No registra Documentos Protestados  
 No Registra Morosidades Boletín DICOM Recientes  
 No registra Documentos Morosos Boletín DICOM  
 
Autorizado con O/C', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78371310', N'COINTEC INSPECCIONES Y CONTROL LTDA ', N'AV.BDO.O HIGGINS 1146 PISO 3', N'1146', N'6960126', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO  POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78438110', N'GAMA SERVICE LIMITADA ', N'VIRGINIA  OPAZO', N'57', N'6923502', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78462860', N'TRANSPORTES LILA MAR LTDA. ', N'CATEDRAL', N'4387', N'7795691', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78497830', N'L & L ASESORIAS Y SERVICIOS LIMITADA ', N'ALFREDO RIOSECO', N'0305', N'4217800', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78534950', N'SERVICIOS INTEGRADOS LTDA ', N'AV. L. BERNARDO OHIGGINS', N'2136', N'6988242', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78570410', N'SERV. DE SEG. PROSEGUR REGIONES LTDA. ', N'AGUSTIN LOPEZ DE ALCAZAR', N'488', N'5958273', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78572580', N'TRANSCOMET LTDA ', N'ALGARROBO', N'1006', N'6463110', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78577100', N'INMOBILIARIA E INVERSIONES ASTURIAS LIMITADA ', N'CAMINO A RANGE   SITIO 6-A   LAG. ACULEO', NULL, N'3813200 ', N'AL 04/070/07

CLIENTE ASIGNADO POR DON ABDO, 23/11/07', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78798250', N'RESTAURANT QUICK BISS LTDA. ', N'SANTA ELENA', N'1761', N'5654313', N'MISMAS CONDICIONES DE ADELCO 

CONTACTO ELIZABETH RINGLER

', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78830080', N'BLOCKBUSTER VIDEO INT. CORP. CHILE LTDA. ', N'AV.LUIS THAYER OJEDA', N'1955', N'3624500', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78857510', N'SOC.COM.TEXTIL BORDAIN LTDA.', N'AVDA. CONDELL     1681', NULL, N'6359272', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78919170', N'COMERCIAL Y DISTRIBUIDORA PE Y PE LIMITADA ', N'TUCAPEL', N'296', N'6612000', N'PANAMA JAC, POLLINI

CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78950850', N'ACEITES INDUSTRIALES LTDA. ', N'LS NOGALES PONIENTE 30-A LAMPA', N'30-A', N'7387623', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'78959910', N'EMP.SEGURIDAD AREA DOS LTDA ', N'AV. GRECIA', N'2070', N'2399980', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'7901731', N'ALEJANDRO ENRIQUE RIZIK ABUTER', N'BRASIL 864', NULL, N'214902', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79527050', N'EXPORTADORA FRUTAM LTDA. ', N'AV. VITACURA', N'5093', N'3952000 ', N'CREADO 26.06.08  (MONICA)

CLIENTE CONOCIDO DE MAURICIO SABA

ESTABLECIDO DESDE 01.01.1993
REPRESENTANTE LEGAL:  JAIME PRIETO

BANCO SANTANDER SANTIAGO
CTA.; 40-01874-3

COMPRA CHEQUE 30 DIAS C/ORDEN DE COMPRA

OK.  S.I.I. Y DICOM  27.06.08 (EXEQUIEL)', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79554890', N'SERVICIOS GENERALES LTDA.', N'AV.GENERAL BUSTAMANTE', N'42', N'2699368', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79578050', N'AIRMAN MANTENIMIENTO AERONAUTICO LTDA.', N'DIEGO BARROS ORTIZ  (APPTO CAMB)', NULL, N'5654318', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79590160', N'MARVELKLEEN  S.A. ', N'AVDA DON LUIS', N'536', N'7301200 ', N'.- NUEVO AL 24 DE MAYO DE 2007 
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79592440', N'MACARI Y VALLVE LTDA.', N'PADRE ORELLANA 1679', NULL, N'5557015', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79629720', N'DISEÑO Y VESTUARIO MILANO GROUP S.A ', N'RAFAEL CAÑAS', N'234', N'3468727', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
.
06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79693930', N'LOREAL CHILE S.A. ', N'AMERCO VESPUCIO', N'2288', N'4406000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79707240', N'CENTRO DE INVERSIONES MARAZUL LTDA ', N'AV.EDUARDO FREI MONTALVA', N'9871', N'3872365', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79829500', N'EUROFASHION LIMITADA', N'SAN IGNACIO 700', NULL, N'9590555', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79904600', N'CARNES SANTA ANA S.A. ', N'CAMINO OCHAGAVIA', N'12301', N'6554588', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'79970260', N'LUIS SILVA A Y CIA LTDA ', N'AV. ANTILLANCA', N'481', N'2170089', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'80425700', N'TRANSPORTES TAS CHOAPA LIMITADA. ', N'OBISPO MANUEL UMAÑA', N'741', N'7760101', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'80889200', N'ALSTOM CHILE S.A. ', N'MARIANO SANCHEZ FONTECILLA', N'310', N'2908500', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'81151500', N'ABC COMERCIAL LTDA. ', N'NUEVA DE LYON', N'072', NULL, N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'81407200', N'FABRICA DE CALZADOS GINO S.A.', N'EMILIO VAISSE 770', NULL, N'9248300', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'81623500', N'FUND EDUCACIONAL NIDO DE AGUILAS ', N'AV. EL RODEO', N'14200', N'3398100', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'81698800', N'PONTIFICIA UNIV.CATOLICA DE CHILE ', N'AV. VICUÑA MACKENNA', N'4860', N'6864045', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'81698900', N'PONTIFICIA UNIVERSIDAD CATOLICA DE CHILE', N'AVDA. VICUÑA MACKENNA  4860', NULL, N'5520396', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'81788500', N'JORGE RABIE Y CIA. S.A. ', N'CAMINO MELIPILLA', N'15000', N'6773100', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'82525800', N'VETO Y CIA LTDA ', N'SAN EUGENIO', N'567', N'2390461', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'82623500', N'IDEAL S.A.', N'CAÑAVERAL KM.15 PANAMERICANA NORTE 100', NULL, N'6758233 VERO', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'83156400', N'TALLERES LUCAS LIMITADA', N'PANAMERICANA NORTE 5315', NULL, N'25302929', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'83244700', N'CONFECCIONES MELL LTDA. ', N'IRARRAZABAL', N'1860', N'2044248', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'83269500', N'CONFECCIONES FLORENCIA LTDA.', N'AV. FRANCIA 1436', NULL, N'7371661', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'83332100', N'SOC. INMOBILIARIA EDUCACIONAL LIMITADA Y COMP. ', N'LAS HUALTATAS', N'10650', N'3717450 ', N'LA PRIMERA COMPRA SON MUESTRAS, EL VENDEDOR SE HACE RESPONSABLE POR EL NO PAGO DE ELLA.

COLEGIO TABANCURA
CONTACTO: FELIPE FICA
ffica@tabancura.cl', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'83551200', N'DICARCO S.A.', N'BLANCO ENCALADA     3055', NULL, N'6804113', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'84156800', N'COOPERATIVA DE AHORRO Y CREDITO UNION AEREA LTDA ', N'AV.LIB.BDO.O HIGGINS', N'2274', N'6924002', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'84182700', N'SOC.DE MANTENCION CONSERVACION Y REPARACION LTDA ', N'GENERAL GONZALEZ BALCARCE', N'2061', N'6838758', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'85202900', N'CEMCO S.A. ', N'SAN NICOLAS', N'860', N'3901125', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'85437100', N'COMERCIAL RUTMAN LTDA. ', N'NATANIEL', N'641', N'6965809', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'85918000', N'COMERCIAL CAMHI Y COMPAÑIA LIMITADA', N'AVDA. MEXICO', NULL, N'6229940', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86242400', N'TERMOFRIO S.A. ', N'JOSE MANUEL INFANTE', N'1865', N'2047403', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86269900', N'PROSEGUR LTDA ', N'LOS GOBELINOS', N'2567', N'5958000', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86359300', N'SOC.  RECUPERADORA DE PAPEL S.A.', N'VENECIA', NULL, N'4737000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86360200', N'TECNICOLOR SCHALLER Y QUIROZ LIMITADA ', N'SAN IGNACIO', N'1685', N'5551740', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86486100', N'CECINAS BAVARIA LIMITADA', N'PARCELA', NULL, N'8214019', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86887200', N'APRO LTDA.', N'SILVA VILDOSOLA     950', NULL, N'5447600', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'86963200', N'FORUS S.A. ', N'DEPARTAMENTAL', N'01053', N'2903169', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'87682500', N'MAESTRANZA DIESEL LTDA. ', N'SANTA ELENA', N'1433', N'5560574', N'MARITZA MIRANDA
COORDINADORA PERSONAS, ADMINISTRACION Y FINANZAS
SUC. CONCEPCION
TELEFONO DIRECTO: (41) 2907510
CAMINO A PENCO 3054 LOTE C, GALPON 2B - CONCEPCION', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'87828600', N'INDUMARK S.A. ', N'AVDA LIB. BDO, O HIGGINS', N'2136', N'6988242', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'87958900', N'TYCO ELECTRONICS CHILE LTDA. ', N'MANUEL MONTT 1693', N'1693', N'3450300', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.

CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

CLIENTE DE LEONARDO NAVARRETE TRASPASADO A CASA MATRIZ

04/08/2008
QUEDA INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'88104300', N'MARTINEZ Y CIA LTDA ', N'INDEPENDENCIA', N'502', N'228423', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

PATRICIA CON MALA EXPERIENCIA COMERCIAL

30/07/2008

CLIENTE NO DESEA COMPRAR MAS POR MALA ATENCION.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'88417000', N'SKY AIRLINE S.A.', N'AVENIDA DEL VALLE 537 PISO 1 CIUDAD EMPRESARIAL', NULL, N'5654776', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'89274100', N'SERVICIOS PROSEGUR LIMITADA ', N'LOS GOBELINOS', N'2567', N'5958000', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'89622400', N'PULLMAN CARGO S.A. ', N'SAN BORJA', N'235', N'5603735', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'8993314', N'JACQUELINE AVALOS ROMAN ', N'HUERFANOS', N'1117', N'2141348', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

04/08/2008
BLOQUEADO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'90100000', N'AGA S.A. ', N'PASEO PRESIDENTE ERRAZURIZ ECHAURREN', N'2631', N'5312455', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'90266000', N'ENAEX S.A.', N'EL TROVADOR 4253  Piso 5', NULL, N'228377735', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'90320000', N'CIA. ELECTRO METALURGICA S.A.', N'AVDA. VICUÑA MACKENNA 1570', NULL, N'3614000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'91008000', N'TEJIDOS CAFFARENA S.A.', N'CAMINO A MELIPILLA 10600', NULL, N'4505527', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'91300000', N'EMPRESA CONSTRUCTORA TECSA S.A. ', N'APOQUINDO', N'3078-B', N'2411500 ', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'91384000', N'CATECU S.A. ', N'CAMINO MELIPILLA', N'9460', N'5604466', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'91637000', N'LABORATORIO RECALCINE S.A. ', N'PEDRO DE VALDIVIA', N'295', N'3505280 ', N'VERIFICAR GIRO

REPRESENTANTE LEGAL:  PENDIENTE

CONTACTO: CARLOS CARVAJAL

CONDICIONES: O/C 30 DIAS , EXCEPTO SI SE INDICA EN LA NOTA DE PEDIDO.


DICOM.......  OK.

SII..... INICIO DE ACTIVIDADES 01-01-1993', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'92216000', N'BATA CHILE S.A. ', N'CAMINO MELIPILLA', N'9460', N'5604300', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'92273000', N'INDUSTRIA TEXTIL LA SCALA S.A. ', N'AVDA VICUÑA MACKENNA', N'3897', N'5524664 ', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'92555000', N'NORIEGA NORIEGA S.A.C. ', N'AV. REPUBLICA', N'5', N'6964196', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'93037000', N'MAESTRANZA JEMO S.A. ', N'PANAMERICANA NORTE', N'3525', N'4215100', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'93077000', N'METSO MINERALS CHILE S.A.', N'CAMINO INTERNACIONAL 5725', NULL, N'2270800', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'93135000', N'LABORATORIOS BAGO', N'AV.VICUÑA MACKENNA 1835', NULL, N'3682700', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'93384000', N'ESPECIALIDADES INGENIERIA APLICADA ESINA S.A.C. ', N'LOS NOGALES ORIENTE SITIO 4 LAMPA', N'4', N'7387779 ', N'CLIENTE NUEVO CREADO 17/12/07

CONTACTO: JORGE HUERTA

PROVEEDORES COMERCIALES

-OSRAM    FONO: 3334331

-IMPORTADORA COMEX     FONO:7390625

-FARIAS Y CIA.       FONO:  4470432

CUENTA CORRIENTE 60488.07 BANCO DE CHILE ( AHUMADA)

TRASPASADO EL 04/12/08 A PATRICIA ALVAREZ DESDE CASA MATRIZ,  PARA TRABAJAR PRENDAS CON BORDADOS', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'9361218', N'LAURA SEPULVEDA', N'BRASIL 175', NULL, N'412194', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'94795000', N'COMPAÑIA CHILENA DE COMUNICACIONES S.A. ', N'ANTONIO BELLET', N'223', N'3648000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'9539146', N'MANUEL ESCALONA RIVEROS ', N'GRAL.AMENGUAL', N'234', N'3175493', N'NOS ESTAFO, DEUDA VIGENTE', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'95509000', N'COMERCIAL NELBEC S.A. ', N'ALAMEDA', N'3083', N'6816244', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'95748000', N'CAUCHOS INDUSTRIALES S.A. ', N'AMERICO VESPUCIO', N'2101', N'5822700', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'95896000', N'TRANSPORTES COMETA S.A. ', N'SAN BORJA', N'235', N'5603745', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96502530', N'ISAPRE VIDA TRES S.A. ', N'APOQUINDO', N'3600', N'3533344', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96513630', N'CORPBANCA  ADMINISTRADORA GENERAL DE FONDOS  S.A. ', N'ROSARIO NORTE', N'660', N'6756100', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96514060', N'PROSEGUR CHILE S.A. ', N'LOS GOBELINOS', N'2567', N'5958000', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96519240', N'INPACT S.A. ', N'ANTONIO VARAS', N'697', N'3763800', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96526580', N'COMERCIAL RAMSES S.A.', N'MORANDE 880', NULL, N'6961637', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96529310', N'CMPC TISSUE S.A. ', N'AGUSTINAS', N'1343', N'4412510', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96531800', N'HOOKIPA S.A. ', N'AVDA LAS CONDES', N'7991', N'2202014', N'04/08/2008

QUEDA  INACTIVO POR EL DEPTO. COMERCIAL

13/08/2008
COMPRA POR DELAY S.A.  rut: 76.846.350-6', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96538310', N'HIPOTECARIOS CRUZ DEL SUR ', N'AVDA. EL GOLF', N'150', N'4618680', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96543670', N'COMPAÑIA AMERICANA DE MULTISERVICIOS LIMITADA ', N'BULNES', N'1238', N'3897887', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96556470', N'IDEAS DE DECORACION  S.A ', N'STA.ELENA DE HUECHURABA', N'1135', N'7400999', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96571220', N'BANCHILE CORREDORES DE BOLSA S ', N'AGUSTINAS', N'975', N'8736155', N'24/04/2008

CONTACTO:
  DON LUIS ESCOBAR ENCARGADO DE FACTURACION,  DEPARTAMENTO  DE ADQUISICIONES.

  UBICADA EN MONEDA PISO 15', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96571890', N'CIA. DE SEGUROS CONFUTURO S.A. ', N'ROSARIO NORTE', N'660', N'6603000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96572060', N'CALZADOS ARTESANALES COLLOKY S.A ', N'DAVID ARELLANO', N'1976', N'4477500', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96572800', N'ISAPRE BANMEDICA S.A. ', N'APOQUINDO', N'3600', N'7825520', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96573100', N'MANUFACTURAS DE VESTUARIO MAVESA LTDA.', N'BASCUÑAN GUERRERO   831', NULL, N'2995900', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96586750', N'NEGOCIOS Y VALORES S.A. CORREDORES DE BOLSA ', N'LA BOLSA  2º piso', N'64', N'4119800', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96592740', N'SCHNEIDER ELECTRIC CHILE S.A. ', N'AVDA E. FREI MONTALVA', N'6001', N'4657000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96603390', N'PAPELERA CERRILLOS S.A. ', N'AV.P.A.CERDA', N'4375', N'6832575', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96608070', N'SOINBAL COMERCIAL S.A. ', N'CAMINO MELIPILLA', N'10750', N'5109100', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96628780', N'CIA.SEGUROS DE VIDA CRUZ DEL SUR S.A. ', N'AVDA.EL GOLF', N'150', N'4618000', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96644100', N'STEWARD S.A. ', N'AMERICO VESPUCIO NORTE  0655', NULL, N'7566000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96668460', N'KLASSIK  CAR  S.A. ', N'AV. VITACURA', N'8126', N'731 05 00 ', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96750760', N'IDENTICARD S.A. ', N'SAN DIEGO', N'31', N'6965369', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96752270', N'HOTEL ANTUMALAL S.A. ', N'KM 2 CAMINO PUCON-VILLARRICA', NULL, N'441011', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96767630', N'BANCHILE ADM. GENERAL DE FONDOS S.A. ', N'AGUSTINAS', N'975', N'6612230', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96807120', N'INTER CON SEGURITY SYSTEMS CHILE S.A', N'MONEDA 3099', NULL, N'3671920', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96811970', N'ANDES CONSTRUCCION CHILE S.A. ', N'MAPOCHO', N'3411', N'7727240', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96816800', N'CORP GROUP INTERHOLD .S.A. ', N'AV. VITACURA', N'4380', N'3644628', N'22/04/2008

EN REVISION DE MAESTRO CLIENTE SE CONFIRMA TERMINO DE GIRO EN EL SII.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96859820', N'CORGROUP INTERHOLD S.A ', N'AVDA VITACURA', N'4380', N'3304150', N'2/04/2008

EN REVISION DE MAESTRO CLIENTE, SE CONFIRMA TERMINO DE GIRO EN EL SII. POR TANTO NO POSEE DOCUMENTOS TRIBUTARIOS  AUTORIZADOS POR EL SII.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96863260', N'REPRESENTACIONES INDUSTRIALES S.A. ', N'PANAMERICANA NORTE', N'20720', N'5917000', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96889950', N'GARMENDIA MACUS S.A.', N'CARLOS FERNANDEZ 255', NULL, N'25303000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96901280', N'SHOPPING CASABLANCA DE LO CAÑAS S.A', N'DIAGONAL SANTA IRENE    2941', NULL, N'5131130', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96909130', N'AMMY COMERCIAL  S.A. ', N'AV. RECOLETA ', N'4422', N'6250303 ', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96918300', N'DIFOR CHILE S.A. ', N'CAMINO A CORONEL  SAN PEDRO DE LA PAZ', N'3455', N'2405300', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96924460', N'AUTOS SUMMIT CHILE S.A. ', N'AVDA VICUÑA MACKENNA', N'1130', N'6203100', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96947150', N'INDUSTRIAS PAK S.A. ', N'ALAMEDA', N'2136', N'6988242', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96963080', N'TECNOLOGIA EN MINERIA IND. S.A ', N'AV. EL BOSQUE SUR', N'1867', N'2238383', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96972470', N'TAURUS S.A. ', N'COMPAÑIA', N'1390', N'6986993', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96986830', N'TERMINAL RENCA S.A. ', N'CAMINO LO RUIZ', N'3200', N'4415300', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'96988640', N'POLAR FRUIT INTERNACIONAL S.A. ', N'AV. VITACURA     5093', N'5093', N'3952000 ', N'CREADO 26.06.08  (MONICA)

CONOCIDO DE MAURICIO SABA

ESTABLECIDO DESDE 01.06.02
REPRESENTANTE LEGAL:  JAIME PRIETO

BANCO SANTANDER SANTIAGO
CTA. 00-50102-6

COMPRA CH. 30 DIAS C/ORDEN DE COMPRA
', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'97004000', N'BANCO DE CHILE ', N'AHUMADA', N'251', N'4683388', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'97023000', N'CORPBANCA ', N'ROSARIO NORTE 660 PISO 14', NULL, N'6602562', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'9721066', N'SYLVIA S. MUÑOZ CONCHA', N'RAYEN', NULL, N'8-1597414', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'97952000', N'BANCO PENTA ', N'AV.EL BOSQUE NORTE', N'0440', N'8733416', N'CLIENTE DE PATRICIO BARRALES TRASPASADO A PATRICIA ALVAREZ A PARTIR ENERO 2008.

08/01/2008

CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99285000', N'SEGUROS CRUZ DEL SUR S.A ', N'AVEIDA EL GOLF', N'150', N'4618000', N'23/04/2008

EN REVISION DE MAESTRO CLIENTE SE CONFIRMA TERMINO DE GIRO EN EL SII.  POR TANTO NO POSEE DOCUMENTOS TRIBUTARIOS AUTORIZADOS POR EL SII.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99289000', N'LA INTERAMERICANA CIA DE SEGUROS DE VIDA ', N'AGUSTINAS', N'640', N'6303000', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99504470', N'COTECNA INSPECTION CHILE S.A. ', N'AVDA VITACURA', N'5250', N'5968250', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99509980', N'ALSA METROPOLITANO S.A. ', N'OBISPO MANUEL UMAÑA', N'741', N'2305900', N'CLIENTE SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.

06/08/2008

QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99511100', N'HOTELERA SAN FRANCISCO S.A.', N'AVENIDA LIBERTADOR BERNARDO O´HIGGINS 816 SANTIAGO CENTRO', NULL, N'223604419', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99518380', N'CRUZ DEL SUR ADM.GRL.DE FONDO ', N'AV.EL GOLF', N'100', N'4618011', N'04/08/2008
QUEDA BLOQUEADO E INACTIVO POR EL DEPTO. COMERCIAL.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99526820', N'RETAIL BUSINESS SUPPORT S.A. ', N'AV. EL BOSQUE NORTE', N'0140', N'2339790', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99548850', N'PROMOTORA CAMINO CANAAN S.A. ', N'AV. BUSTAMANTE', N'26', N'4762500', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99549330', N'MULTIVAC CHILE S.A. ', N'RIO REFUGIO PARQUE INDUSTRIAL ENEA', N'9665', N'7996000', N'CLIENTE ESPORADICO, SIN RELACION COMERCIAL CON VENDEDOR.
CONTACTARSE CON VENDEDOR EN CASO DE GENERAR VENTA.', NULL, NULL, NULL)
GO
INSERT [dbo].[tabla] ([CodAux], [NomAux], [DirAux], [DirNum], [FonAux1], [Notas], [DeudaVencida], [Deuda], [Credito]) VALUES (N'99596430', N'CONTACTOS GENERALES S.A. ', N'LIMACHE', N'3637', N'206100', N'04/08/2008

BLOQUEADO POR EL DEPTO. COMERCIAL', NULL, NULL, NULL)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99100', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99100001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99101', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99101001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99102', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99102001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99200', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT99300001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTR805000N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTR805001N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTR805010N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTR807000N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI02100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI02101', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI02500', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03090', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03100', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03101', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03131', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03160', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03410', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03550', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03560', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI03610', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI04100', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI04200', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI050000', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI050001', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI050002', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI050010', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI050011', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI050012', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI05150', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI05151', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI05200', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI05300', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI09100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI10300', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTRI4400', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS02100', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS02101', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS02102', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS03560', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS06100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS06101', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS07100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS07200', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS07300', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS14500', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS15800', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS16672', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS16700', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS17675', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS19800', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS20102', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS20103', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS21540', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS22100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS22200', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS22400', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS22500', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS22600', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS22700', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS39800', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTSS992017', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001010N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001020N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001060N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001070N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001080N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001100N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001120N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001130N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV001150N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV003001N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV003002N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV006000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV006010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV006020N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV007001N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV007002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV007003N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV015000N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV015010N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017000N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017010N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017030N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017040N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017050N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017070N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017080N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017090N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017100N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017110N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017120N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV017900N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV019000N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020000N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020020N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020030N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020040N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020060N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020070N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV020080N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV021000N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV021010N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV021020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025040N', 72)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025090N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025120N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025140N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025150N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025160N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV025170N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV033010N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV036010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV038000N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801002N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801051N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801101N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801151N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801201N', 72)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801251N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801301N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801351N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801401N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801451N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801501N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801551N', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV801601N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV806051N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV806101N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV806151N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV815051N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV815100N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817002N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817051N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817101N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817151N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817201N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817251N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817351N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV817401N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV819002N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820002N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820051N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820101N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820151N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820201N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820251N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820301N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV820351N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV821002N', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV821051N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV821101N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV833002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV833051N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV836301N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV838002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV899002N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901010N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901020N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901030N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901040N', 72)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901050N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901060N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901070N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901080N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901090N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901100N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901110N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901120N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901130N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV901140N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV906000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV906010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV906020N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV907001N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV907002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV907003N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV907004N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV915000N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV915010N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917000N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917010N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917030N', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917040N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917050N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917060N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917070N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV917080N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV919000N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920000N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920010N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920020N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920030N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920040N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920050N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920060N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV920070N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV921000N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV921010N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV921020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV933010N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV936010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV938000N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTV999000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010010', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01010', 120)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010100', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01011', 234)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010110', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01012', 88)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01013', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01014', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010140', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01015', 52)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01016', 88)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010160', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01017', 47)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010190', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01020', 610)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01021', 104)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010210', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01022', 86)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01023', 96)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01024', 442)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01025', 256)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01026', 408)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01027', 112)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01028', 37)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01029', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01030', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE010500', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE011000', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE011500', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01200', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE012000', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE012500', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE013000', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01307', 125)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE013500', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014000', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014010', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014030', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01410', 78)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014100', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01411', 196)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01412', 110)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01413', 112)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01414', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014140', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01415', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014150', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01416', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE014500', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE015000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE015500', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE016000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE01614', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE016140', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE060010', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE060500', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE061000', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE061500', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06201', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06202', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06203', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06204', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06207', 53)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06208', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06209', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06211', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06220', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06221', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06222', 88)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE062220', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06223', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06224', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06227', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE062280', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06230', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06231', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE062310', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06232', 58)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE062330', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE063200', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE063210', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE06601', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE066020', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE150010', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE150500', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15100', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15101', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15102', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15103', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15104', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15105', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15106', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15107', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15108', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15109', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15110', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15111', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15112', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15113', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15114', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15115', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15116', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15117', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE15118', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE152100', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE152200', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE170010', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE170500', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE171000', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE171500', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE172000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE172500', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE173000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE173500', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE174000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17660', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17661', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17662', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17663', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17671', 116)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17672', 143)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176720', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17673', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17674', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17676', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176760', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17677', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17678', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176780', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17679', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17680', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176800', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17681', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17682', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176820', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17683', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17684', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17685', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17686', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17687', 105)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176870', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17688', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE176880', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17689', 77)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17690', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17691', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17692', 71)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17693', 76)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17694', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17695', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17696', 204)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17697', 330)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17698', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17699', 93)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17700', 127)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17701', 121)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17702', 76)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17703', 97)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE17705', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE190010', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE19700', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE19710', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE19830', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE200010', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE200500', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE201000', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20102', 68)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE201500', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20154', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE201540', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE202000', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE202500', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE203000', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20330', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20331', 79)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20332', 92)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20333', 75)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE203340', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20336', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20337', 75)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE203370', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20338', 59)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE203380', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20340', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20344', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20345', 158)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20347', 58)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE203500', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20353', 300)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE203530', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20538', 142)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20539', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20540', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20541', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20542', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20543', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20545', 34)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20546', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20547', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20550', 63)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE205500', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20551', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE20552', 46)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE210010', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE210500', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE211000', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE21540', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE215420', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE21544', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE21545', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE215500', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE330010', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE330500', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE380010', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE38716', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE387160', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE391200', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVE990010', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER18510', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER18513', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER18514', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER18515', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER18516', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER18610', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER21539', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER21540', 92)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER21541', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER21542', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTVER21543', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'TRIV061160', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'TRIV061170', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'ZBOLSA', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'ZCINTA', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'..', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100INV060', 69)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100INV060-34', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100IOV-INS01', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100IOV10', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100IOV11-32', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100IOV11-34', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100IOV130', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100VER05', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100VER140-1', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100VER140-2', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'100VER17', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'200INV34', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'200IOV062', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'200VER21', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'500VER43', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'600INV05', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700.IOV013', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700INV05', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700INV06', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700INV51', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700IOV01', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700IOV013', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700IOV05', 327)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700IOV113', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700IOV50-1', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'700IOV51', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'800VER17', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'800VER18-2', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'9001103', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'900FO-190031', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'900FO-70112', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'900FO1289-06M', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'900fo2391-2', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'900SP781003-6', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'B-TEJIDOCOLECCI', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'BOLSACH', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'BOLSAGR', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'BOLSAME', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'cambio', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'DESCUENTO', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC816815N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC816816N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC914000N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC914001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC914002N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC914010N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC914011N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC914012N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC916000N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC916001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC916002N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC916010N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC916011N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC916012N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC938001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC938002N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC938010N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNC938011N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO01001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO01002N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO01010N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO01011N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO01012N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010600', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010620', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010640', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010670', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010680', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010690', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010700', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO010740', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO064010', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO064020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO064040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065050', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065060', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065120', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065140', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065150', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO065160', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO066000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO066020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO066040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO08000N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO08001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO08002N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149220', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149240', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149300', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149320', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149340', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149410', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149420', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149430', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149510', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149520', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO149530', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO151000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO151010', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO151020', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO152000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO152010', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO152020', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168010', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168020', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168100', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168110', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168120', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168400', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168500', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168510', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO168520', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169140', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169200', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169220', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169280', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169440', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169520', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169540', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO169560', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO188120', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO188410', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199100', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199130', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199140', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO1991401', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199180', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199220', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199240', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199260', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199280', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO199300', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO20001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO20002N', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO20011N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO20012N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO201000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO201010', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO201020', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO201070', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202640', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202660', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202680', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202760', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202780', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202800', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202820', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202840', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202860', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202910', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO202920', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208200', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208220', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208230', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208240', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208280', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208300', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208320', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208340', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208360', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208380', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208400', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208460', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208500', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208560', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208610', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208620', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208630', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208710', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208720', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208730', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208920', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208930', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208950', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO208960', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO209010', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO209020', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO209030', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO209040', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO32001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO32002N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327200', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327220', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327240', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327380', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327400', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327420', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327440', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327460', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327480', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327500', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327520', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327540', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327560', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327580', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327600', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327620', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327630', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327640', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327650', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327660', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327670', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327710', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327720', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327730', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327760', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327770', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327780', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327800', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327820', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327910', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327920', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327930', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327960', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327970', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO327980', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO333100', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO333200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO333300', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO333900', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO333920', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO333940', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342000', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342010', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342200', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342220', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342240', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342260', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342280', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO342300', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346010', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346020', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346040', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346060', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346080', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346100', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346120', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346140', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346160', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346180', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346200', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346220', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346240', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346810', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO346910', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO35001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO35002N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO351100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO351120', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO351140', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO351170', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO351180', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNCO351200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801015N', 140)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801016N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801063N', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801413N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801620N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801680N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI801690N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI803565N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI803566N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI806250N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI806251N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI806252N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI806254N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI806258N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI815764N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI815765N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI815766N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI820561N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI820562N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI820563N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI820564N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI820565N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI836694N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI836695N', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI836696N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901015N', 66)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901016N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901017N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901063N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901620N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901680N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI901690N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI903000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI906010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI906020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI906030N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI906040N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI906050N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI915010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI915020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI920001N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI920002N', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI920003N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI920561N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI920563N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI920565N', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI936001N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI936002N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI936003N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI938010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNI938020N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV010140', 110)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV01060', 111)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV010611', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV010620', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV016103', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062010', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062110', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062200', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062300', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062400', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062500', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062510', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062520', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062530', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV062540', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV157600', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV157640', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV157650', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV157660', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV203530', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV203550', 34)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV203570', 37)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV205610', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV205620', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV205630', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV205640', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV205650', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV366930', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV366940', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNIV391200', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI013090', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI014130', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI01415', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI014150', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI062120', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI062130', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI063000', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI147030', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI147230', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI157240', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI168000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI176710', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI176720', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI176730', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI176750', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI176770', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI196100', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI196110', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI199100', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI203350', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI203370', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI205300', 46)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI205380', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI207200', 39)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI353080', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI353090', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI354210', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI354220', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI367730', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI372380', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI372420', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI373500', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNLI373600', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNOV01500', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001014N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001030N', 108)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001040N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001614N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV001616N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV003010N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV006010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV006411N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017000N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017030N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017700N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017704N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017893N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017951N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV017960N', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV018001N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV018002N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV020010N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV020020N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV020030N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV020569N', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV021010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV021571N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV021588N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV038010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV801014N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV801030N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV801417N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV801424N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV801614N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV801615N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV803521N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV806406N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV806410N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV815771N', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV815772N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV817871N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV817904N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV817915N', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV817951N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV817953N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV817960N', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV820564N', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV820567N', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV820568N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV821588N', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV901014N', 88)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV901030N', 187)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV901614N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV901615N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV901616N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV901618N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV903522N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV906410N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV906411N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV915777N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917700N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917701N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917702N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917703N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917704N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917893N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917951N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917952N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV917960N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV918001N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV920564N', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV920568N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV920569N', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV921571N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV921588N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNV921890N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE010110', 131)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE010120', 138)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE010200', 353)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE014240', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE016100', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE016110', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE034590', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE062060', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE064050', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE065010', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE065210', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE156710', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE157350', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176710', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176720', 55)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176730', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176740', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176750', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176760', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176770', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176780', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176790', 119)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176791', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176792', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176802', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176862', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176880', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE176910', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE203360', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE203370', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205300', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205400', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205420', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205440', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205460', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205480', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE205540', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE215780', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE215790', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'JNVE336100', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI901111E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI901111N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI901112E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI901112N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI901114E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI901114N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI902190E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI902190N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI902564N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI903191E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI903191N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI903565N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914135E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914135N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914137E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914137N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914199E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914199N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914562N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI914566N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916120E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916120N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916121E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916121N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916122E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916122N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916123E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916123N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916124E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916124N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916544N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916545N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916546N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916547N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI916590N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI917132E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI917132N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI917133E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI917133N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI917549N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI919134E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI919134N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI919561N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI920155E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI920155N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI920156E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI920156N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI9281020', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI935540N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI936131E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI936131N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI936138E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI936138N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI936560N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI937542N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI937543N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNI942996N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI01100E', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI01100N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI20100E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI20100N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI20105E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI20105N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI241000', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI35200N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNLI37200N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNOT41900N', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNOT41901N', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV001100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV001100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV002200N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV014110E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV014110N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV014200N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV015100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV015100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV015105E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV015105N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV015205N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016105E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016105N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016110E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016110N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016115E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016115N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016200N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV016210N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017100E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017100N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017105E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017105N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017110E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017110N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017115E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017115N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017120E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017120N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017125E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017125N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017200N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017205N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV017210N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV019100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV019100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV019105E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV019105N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV019200N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV019205N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV020100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV020100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV020105E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV020105N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV021100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV021100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV025100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV025100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV025105E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV025105N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV037200N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV051100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV051100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV051200N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV052200N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV052210N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901400E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901400N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901500E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901500N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901501E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901501N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901600E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV901600N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV916982E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV916982N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV916984N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917200E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917200N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917698E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917698N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917699N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917800E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV917800N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV919100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV919100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV920350E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV920350N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV920400E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV920400N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV921200E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV921200N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV935100N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV937400N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KNV937501N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KT-IV-01-100-060-00M', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KT-IV-01-100-060-00S', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KT-IV-01-100-060-0XL', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KT-IV-01-100-060-XXL', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO010580', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO010600', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO010620', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO010640', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO010660', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO010680', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO054000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO054020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO054040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO054060', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO054080', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO054100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO056920', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO056940', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO056960', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06402', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06403', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064040', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064050', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064060', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06409', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06410', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06412', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06415', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06416', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO06418', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064230', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064240', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064250', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064270', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064280', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064300', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064320', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064340', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064360', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064380', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064400', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064420', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064440', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064460', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064480', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064500', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO064520', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14906', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14908', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14910', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14924', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14925', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14926', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14934', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14936', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14938', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO14946', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149500', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149520', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149540', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149560', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149580', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149600', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149620', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149640', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149660', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149680', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149700', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149720', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149740', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149760', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149780', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149800', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149820', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149840', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149860', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149880', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149900', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149920', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149940', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149960', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO149980', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16901', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16902', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16903', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16950', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16952', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16954', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO169560', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO169580', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO169600', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16985', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16986', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO16987', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO19916', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO19918', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199200', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO19922', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO19924', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO19926', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199280', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199300', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199320', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199340', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199360', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199380', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199400', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199420', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199440', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199460', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199480', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO199500', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202010', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202020', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202030', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202050', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202060', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO202070', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208200', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208220', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208230', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208240', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208250', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208280', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208290', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208300', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208320', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO20842', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO20844', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO20846', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208480', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208500', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208520', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO208540', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO322740', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327200', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327220', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327240', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327380', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327400', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327420', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327440', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327460', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327480', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327500', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327520', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327540', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327560', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327580', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO327600', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO333100', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO333200', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO333300', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO333900', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO333920', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO333940', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342000', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342100', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342200', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342220', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342240', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342260', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342280', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO342300', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO34600', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346020', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346060', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346080', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346120', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346140', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346160', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO34618', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346180', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346200', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346220', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346240', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346260', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346280', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346300', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO346500', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO351100', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO351120', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO351140', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO351160', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO351180', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO37270', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372720', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO37276', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372780', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372800', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372820', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372840', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372860', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372880', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372900', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO372920', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373020', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373040', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373060', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373080', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373100', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373120', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373140', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO373160', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374020', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374040', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374060', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374080', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374100', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO374980', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO375000', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381060', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381080', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381120', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381140', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381160', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381180', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO381220', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38614', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38616', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38618', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38622', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38636', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38638', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38640', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386420', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386440', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386460', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386500', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386520', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386540', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386560', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386580', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386600', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386620', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38664', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386660', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386680', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386700', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386720', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386740', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386760', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386780', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386800', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386820', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386840', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386860', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386880', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386900', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO386980', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38702', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38704', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387040', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38706', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387080', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38710', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387100', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38712', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387120', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38714', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38716', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38718', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38722', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387240', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387260', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO387280', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38800', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO388000', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38802', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO388020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38804', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO388040', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO388060', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO38808', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTCO388100', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801009E', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801009N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801010E', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801010N', 104)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801060E', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801060N', 72)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801100N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801300E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801300N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801501E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801501N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801600E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801600N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801700E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI801700N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI803070E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI803070N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI803101E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI803101N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI803173E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI803173N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806123E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806123N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806127E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806127N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806128E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806128N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806129E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI806129N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI814173N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI815719E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI815719N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI815800E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI815800N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI820101E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI820101N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI820300E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI820300N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI820538E', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI820538N', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI8205470', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836500E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836500N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836595E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836595N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836676E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836676N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836687E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836687N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836697E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836697N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836701E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI836701N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI838981E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI838981N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901009E', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901009N', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901010E', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901010N', 104)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901060E', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901060N', 72)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901100E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901100N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901300E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901300N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901501E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901501N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901600E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901600N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901700E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI901700N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI903070E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI903070N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI903101E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI903101N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI903173E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI903173N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906123E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906123N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906127E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906127N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906128E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906128N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906129E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906129N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906130E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI906130N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI908100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI908100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI914173E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI914173N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI915718E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI915718N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI915719E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI915719N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI915919E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI915919N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI916800E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI916800N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI916900E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI916900N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920101E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920101N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920459E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920459N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920538E', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920538N', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI920547N', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936500E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936500N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936676E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936676N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936687E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936687N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936697E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936697N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936701E', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI936701N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI938981E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI938981N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI938982E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTI938982N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01009', 306)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV010090', 110)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01009E', 71)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01010', 761)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV010100', 239)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01010A', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01010B', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01010E', 142)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01060', 410)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV010600', 147)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01060E', 92)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01061', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01062', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01063', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01064A', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01064B', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01065A', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01065B', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01100', 210)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV011000', 107)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01300', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV013000', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01300E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV014000', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01400E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01410', 90)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV015000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV01500E', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03070', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV030700', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03070E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV030720', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV030740', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV031000', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV031010', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03101E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03171', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV031720', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV031730', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03584', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03585A', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03585B', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03586A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03586B', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03587A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03587B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV03590', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV035910', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV035920', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV036120', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06100', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06101', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06102', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06103', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06104', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06105', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06106', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06107', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06108', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06109', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06110', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06111', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06112', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06113', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06114', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061150', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061160', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061170', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061180', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061190', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06119E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061200', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06120E', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061210', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06121E', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061220', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06122E', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061230', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06123E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061250', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06125E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061260', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06126E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV061270', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06127E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV06212', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV14140', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV14150', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV141700', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV14170A', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV14170B', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV141710', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV14171A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV14171B', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV141720', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV153300', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15711', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15715', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV157160', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15717', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV157170', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15717E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV157180', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15718E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15721', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15725', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15730', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV158000', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV15800E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV159810', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV16700', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV16950', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV16955', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV169600', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV169700', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV17682', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV19900', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV19910', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV19930', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV19940', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV19960', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV19970', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV201000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20100E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV201010', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20101E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV202010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20201E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20342B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20500A', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20500B', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20501A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20501B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20534', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV205340', 90)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20534E', 47)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20536', 125)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV205360', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV205370', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV205380', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20538E', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20539', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20540', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20545', 91)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV205460', 55)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV205470', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20720A', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20720B', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20721', 118)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20721A', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20721B', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20722', 115)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20723', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV207230', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV20723E', 46)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36101A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36101B', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36102A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36102B', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36103A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36103B', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36104A', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36104B', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36105A', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36105B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36201A', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36201B', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36202A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36202B', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36203A', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36203B', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36204A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36204B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36301A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36301B', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36302A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36302B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36303A', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36303B', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36304B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36305A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36305B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36390-N', 62)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36401A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36401B', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36402A', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36402B', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36403A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36403B', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV365950', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36595E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36610A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36610B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36670', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36670N', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36671', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36671N', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36672', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36672N', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36673', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV366740', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36674E', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36675', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV366760', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36676E', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36682', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36683', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36684', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36685', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV366860', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36686E', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV366870', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36687E', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36691', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36691N', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36692', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36692-1', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36692-2', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36692-3', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36693', 63)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36694', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36694G', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36695', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV366960', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36696E', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV366970', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36697E', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV367010', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV36701E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV38700A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV38700B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV389800', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTIV38980E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01009', 122)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01010', 141)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01010-1', 66)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01010-2', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01010A', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01010B', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01012', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI010120', 119)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01012E', 63)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01030', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01030E', 34)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01308A', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01308B', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01309', 174)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI013090', 83)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01309E', 139)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI013100', 146)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01310E', 93)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI013120', 97)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01312E', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01413', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI014130', 63)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI01413E', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06202', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06203', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI062100', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06210E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06212', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06213', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06222', 73)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI062220', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06223', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI062240', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06224E', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI062250', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06225E', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI062260', 66)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06226E', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI062270', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI06227E', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI141400', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI14140E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI15700', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI15710', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI157100', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI15710E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI168000', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI16800E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI169000', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI16900E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI16936', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI169360', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI169480', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI1760B', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17612A', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17612B', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI176300', 55)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17630A', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17630B', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17630E', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI176720', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17672E', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI176730', 85)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI17673E', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI176740', 55)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI197000', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI19800', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI19920', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI199200', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20102', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI201020', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20102E', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20340', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI203400', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20439', 73)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI204390', 70)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20439E', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20537', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI205370', 149)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20537E', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI205500', 129)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI206100', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20610E', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI207250', 144)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI20725E', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI35420', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI354200', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI354210', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI36675', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI366750', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI36675E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTLI372380', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO801010E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO801010N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO801600E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO801600N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO816101E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO816101N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO816982E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO816982N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO816983E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO816983N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO817698E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO817698N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO820350E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO820350N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO820351E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO820351N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO821200E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO821200N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO836699E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTO836699N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT311000', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT411000', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT41100099', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT421000', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT431000', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT99100099', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTOT99200099', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR005306E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR005306N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR805151E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR805151N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR805303E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR805303N', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR805305E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR805305N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR905305E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTR905305N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02100', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI021000', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI021010', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI021020', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02102A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02110E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02110N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI022000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI022010', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI022020', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02202A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02203', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02302', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02302A', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02303', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02303B', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI025000', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02510E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI02510N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03070', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03170', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03560', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03561', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03561-1', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03562', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03562-2', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03563', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03570', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03571', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03574', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03575', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03576', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03578', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03580', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03582', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03583-1', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03610', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03611', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI03612', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI041000', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI042000', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI042010', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04201A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04202', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04210E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04210N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI043010', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04310A', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04310B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI044000', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04410E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI04410N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05150', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI051500', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI051510', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05151E', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI052000', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05201', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI052010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05201A', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05202', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05203A', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05203B', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05210E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05210N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05211A', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05211B', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI0521A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05300', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI053000', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05301E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05301N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI053030', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05303A', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI05303B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI053040', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI091000', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI092000', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI09200A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI09201', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI092010', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI09201B', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI10100', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI10150', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI101500', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI10200', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI10250', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTRI102500', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001010E', 70)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001010N', 112)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001020E', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001020N', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001021E', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001021N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001501E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001501N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001502E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001502N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001600E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001600N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001621E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV001621N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV003568E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV003568N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV008100E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV008100N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV015401E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV015401N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017120E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017120N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017200E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017200N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017641E', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017641N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017651E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017651N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017687E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017687N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017699E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017699N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017701E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017701N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017709E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017709N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017800E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV017800N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV018622E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV018622N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV018623E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV018623N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020101E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020101N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020547E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020547N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020700E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020700N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020800E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV020800N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV021554E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV021554N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV021568E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV021568N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV021600E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV021600N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV038981E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV038981N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801010E', 70)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801010N', 112)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801020E', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801020N', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801021E', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801021N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801300E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801300N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801400E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801400N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801500E', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV801500N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV803568A', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV803568B', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV803568E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV803568N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV815400E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV815400N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817620A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817620B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817641E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817641N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817651E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817651N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817687E', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817687N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817699A', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817699B', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817699E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817699N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817701E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817701N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817709E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817709N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817800E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV817800N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV818622E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV818622N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV818623E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV818623N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV820101E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV820101N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV820200E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV820200N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV820742A', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV820742B', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821554E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821554N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821568A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821568B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821568E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821568N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821600E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV821600N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV838101E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV838101N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV838400E', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV838400N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV838401A', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV838401B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901010E', 70)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901010N', 112)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901020E', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901020N', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901021E', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901021N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901300E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901300N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901601E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV901601N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV903568E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV903568N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV915401E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV915401N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917200E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917200N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917641E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917641N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917651E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917651N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917687E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917687N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917699E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917699N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917701E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917701N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917709E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917709N', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917800E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV917800N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV918622E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV918622N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV918623E', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV918623N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV920101E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV920101N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV920553E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV920553N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV921554E', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV921554N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV921568E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV921568N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV921600E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV921600N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV938102E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTV938102N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01010', 212)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE010100', 381)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01010A', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01010B', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01010E', 186)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE010130', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01020', 349)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01020-1', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE010200', 248)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01020E', 162)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01021', 106)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE010210', 183)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01021E', 119)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01022', 63)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01022A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01022B', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01023A', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01023B', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE012000', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01200E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE013000', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01300E', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01311', 300)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE013110', 34)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01311E', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE013120', 103)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE01312E', 66)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE035620', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE035640', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE035660', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE035670', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03567A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03567B', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03567E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03579A', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03579B', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03580A', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE03580B', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE06202', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE06204', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE06205', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE062060', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE062070', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE06207E', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE062080', 37)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE06208E', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE15320', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE153200', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE153310', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE15331E', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE153320', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE153330', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE15333E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE15700', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17610', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17610A', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17610B', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17611', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17612A', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17612B', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17614', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176151', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17616', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17617A', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17617B', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17618A', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17618B', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17619A', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17619B', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176300', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17630A', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17630B', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17630E', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176400', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17640E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176500', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17670', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17671', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17672', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176720', 76)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17672E', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17673', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176730', 97)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17673E', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17674', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176740', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17680', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17681', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17683', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176840', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176850', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17685E', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176860', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17686E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17692', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176920', 58)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17692E', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17692N', 106)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17693', 106)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17693A', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17694', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17694N', 80)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17695', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17695N', 121)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176960', 76)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17696A', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17696B', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176970', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17697A', 65)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17697B', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17697E', 71)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE176980', 70)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17698A', 60)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17698B', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17698E', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE177000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17700E', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17702', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17703', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17704', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17705', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE177060', 66)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE177070', 53)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17707E', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE177080', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE17708E', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE18610', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE186200', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE18620E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE186210', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE18621E', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE19200', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE19210', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE201000', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20100E', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20539', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20550', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE205510', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE205520', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE205530', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE206100', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20610E', 66)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20720A', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20720B', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20740', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE207400', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20740E', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE207410', 56)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20741A', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20741B', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE20741E', 63)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE215530', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21553E', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21563', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE215630', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21564', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21564A', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21564B', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE215650', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21565A', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21565B', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21565E', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE215660', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21566E', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE215670', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21567A', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21567B', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE21567E', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'KTVE381000', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MANIQUIES', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001017N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001507N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001513N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001528N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001546N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001548N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001550N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001564N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001631N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001636N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001638N', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001639N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001640N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001642N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001643N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001644N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001646N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001647N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001648N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001649N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001704N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV001706N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV006152N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV006167N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV006168N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV006169N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV006179N', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV006180N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV015405N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV015407N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV015408N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017827N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017834N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017836N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017838N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017839N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017841N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017842N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017846N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017851N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV017852N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV018201N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV020300N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV020302N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV020441N', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV020443N', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV020444N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV020445N', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV021302N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025528N', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025529N', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025530N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025532N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025533N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025534N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV025535N', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV033924N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV033931N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV033933N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV033937N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV033938N', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV039931N', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV039934N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'MGV039935N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA822001N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA822010N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA822100N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA824001N', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA824002N', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA824003N', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA924001N', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTA924010N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC220001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC220002', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC220501', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22102', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22103', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22104', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22105', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22106', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22107', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22108', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22109', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22110', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22114', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22115', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22116', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC22117', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27101', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27102', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27103', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27107', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27110', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27113', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27116', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27118', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC27121', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC28100', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC400010', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40001N', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40002N', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40010N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40101', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40102', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40103', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40104', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40105', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40106', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40107', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40108', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40109', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40110', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40111', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40112', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40113', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40114', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40115', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40116', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40117', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40118', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40119', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40120', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40121', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40122', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40123', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40124', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40130', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40213', 98)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40313', 115)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40410N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC405000', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40500N', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40510N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC407000', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40700N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40710N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC409000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40900N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC40910N', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC42001N', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC800001', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC800002', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC800003', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC800004', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC800005', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC800006', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99001N', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99100', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC991000', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99200', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99201', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99264', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99265', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99267', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99287', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99620', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99625', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99629', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99632', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTAC99641', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA01010', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA010100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA01011', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA01012', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA01020', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA01060', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA01062', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA03560', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA05100', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA06301', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA06302', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA06401', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA07100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA07200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA14800', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA14801', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA15800', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA15801', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA15802', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA15900', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA16700', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA16702', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA17672', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA17673', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA17675', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA18610', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA19800', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA20102', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA20530', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA20532', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA20534', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA20820', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA21540', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA32720', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA34602', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA35110', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA99100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA99200', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA99300', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA99400', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTBA99500', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI001050N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI001351N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI001353N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI001452N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI006301N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI006450N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI015002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI017002N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI017050N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI017100N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI017150N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI020350N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI020724N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI020850N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI025000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI025010N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI025020N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI036101N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801000N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801050N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801251N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801301N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801351N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801352N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801404N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801452N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801501N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801502N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801551N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801552N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801600N', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801601N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801651N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801701N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI801750N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806051N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806101N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806151N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806201N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806252N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806301N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806302N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806400N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI8064500', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI806450N', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI814101N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815051N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815052N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815100N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815150N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815151N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI815250N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI816002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI817001N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI817050N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI817100N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820000N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820050N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820150N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820201N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820250N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820724N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820801N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820850N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI820851N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI825000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI833002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI833003N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836002N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836050N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836051N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836101N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836151N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836250N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836300N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI836350N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI838000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI838050N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901000N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901050N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901301N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901351N', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901352N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901353N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901404N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901452N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901502N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901551N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901552N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901600N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901601N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901701N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901800N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI901900N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906051N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906101N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906151N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906201N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906252N', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906301N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906302N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906400N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906450N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI906451N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI907001N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI907002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI907003N', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI914101N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915051N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915052N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915100N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915150N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915250N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI915300N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI916002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI917002N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI917050N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI917100N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920050N', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920201N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920300N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920350N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920724N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920801N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920850N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI920851N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI925000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI925503N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI933002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI936002N', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI936060N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI936061N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI936101N', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI936250N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI936300N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTI938000N', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010000', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01010', 512)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01011', 135)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01012', 98)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01013', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01014', 84)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010140', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01015', 117)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010150', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01016', 68)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010160', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01017', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01018', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010180', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01019', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010190', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01020', 102)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01021', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01022', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010500', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01060', 356)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01061', 71)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01062', 369)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010620', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01063', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01064', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01070', 70)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV010700', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01071', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01072', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01073', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01100', 175)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV011000', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV012000', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV012500', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV012510', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV013000', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV013010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV013500', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV013510', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV013520', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014010', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014020', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01403', 133)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014030', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014040', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014500', 44)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014510', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV014520', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV015000', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV015010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV015020', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01510', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01511', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01512', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01513', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01514', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01515', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01516', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01517', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV015500', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV015510', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV015520', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV016000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV016010', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV01610', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV016500', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV016510', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV017000', 30)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV017010', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV060010', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV060500', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV060510', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV061000', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06101', 38)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV061010', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06102', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06103', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06104', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06105', 52)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06109', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06111', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06116', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06117', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV061170', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06120', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06121', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV061210', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06123', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06124', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06125', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06126', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06127', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06128', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06130', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06131', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06132', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06133', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06134', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06135', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06136', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06140', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06141', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV061500', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV061510', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06152', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06154', 46)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06155', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06156', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06157', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV062000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV062010', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV062500', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV062510', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV062520', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06300', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063000', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06301', 99)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063010', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06302', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063020', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06303', 68)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063030', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06305', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063050', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063060', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063210', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV063500', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV064000', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06500', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV065000', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06501', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV065010', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06502', 88)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV06600', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV066000', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14100', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV141000', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV141010', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14150', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14201', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14202', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14203', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14204', 46)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14205', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV14300', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV150010', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV150020', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV150500', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV150510', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV150520', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15100', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV151000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV151500', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV151510', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15200', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV152000', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15201', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15202', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15203', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15204', 34)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15220', 37)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15710', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15711', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15720', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV157200', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV157210', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV157220', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV157230', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV157400', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15742', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15743', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15800', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15801', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15802', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV15803', 58)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV160010', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV160020', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16708', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16710', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16711', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16712', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16715', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV167150', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16716', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16717', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16718', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV167180', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16719', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16720', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16721', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16722', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16723', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16725', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV16726', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV170010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV19100', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV19820', 43)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV200000', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV200500', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV201000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV201500', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV202000', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV202010', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV202500', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20330', 58)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20331', 112)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20332', 100)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20333', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20334', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20335', 35)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20336', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20337', 105)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20530', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20531', 74)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20532', 79)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20533', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20534', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20535', 172)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV205350', 41)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20536', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV205360', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20537', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20538', 210)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV205380', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20539', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV205390', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20540', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20541', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20542', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20543', 55)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20544', 57)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20545', 52)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20721', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV207210', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20722', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV207220', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20723', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV207230', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV20724', 44)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV207240', 45)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV208000', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV208010', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV330010', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV330020', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV330030', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV33100', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV33101', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV33102', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV33103', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV33104', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV33106', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV331060', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV360010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV360020', 36)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV360500', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV360510', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV361000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV361010', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV361500', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV361510', 24)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV362000', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'ptiv36675', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV366750', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV36690', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV366900', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV36691', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV366910', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTIV380000', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTL807001N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTL807002N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTL807003N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI010010', 84)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01009', 241)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01010', 39)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01011', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01012', 39)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01013', 121)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01014', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01015', 91)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01016', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01017', 92)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01018', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01019', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01030', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01031', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01032', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01033', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01034', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01035', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01036', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01037', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01050N', 42)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01301', 138)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01302', 51)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01303', 82)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01309', 59)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01402', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI014020', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01409', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01413', 343)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01414', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01415', 108)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01416', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01417', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI014170', 48)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI01610', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI060010', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI060500', 37)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI061000', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI06101', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI06102', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI06103', 5)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI06202', 77)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI06212', 52)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI06213', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI070001', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI070002', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI070003', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI070004', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI070005', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI070006', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07001', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07001N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07002', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07002N', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07003N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07004N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07005N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07006', 49)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07009', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07010', 33)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07011', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07012', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07015', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07017', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07019', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07020', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07023', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07025', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07029', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07068', 18)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07090', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07097', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100012C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100013C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100014C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100016C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100016M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100017C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100017M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100018C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100018M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100019C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100019M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100020C', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100021M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100025M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100026M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100028C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100028M', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100029M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100030C', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100030M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100031H', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100032M', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100033H', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100034C', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100035C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100035M', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07100038C', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07102', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07103', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07128', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07131', 23)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07168009', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07182', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07183', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07184', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07186', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07187', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07211', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07212', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07215', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07217', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07218', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07219', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07230', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07245', 15)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07256', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07265', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07266', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07267', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07277', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07278', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07285', 22)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07286', 27)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07287', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07289', 26)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07320', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07391', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07443', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07561', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07571', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07601', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07608', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07610', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07613', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07614', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07625', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07689', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07706', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07708', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07711', 28)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07712', 21)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07720', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07725', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07732', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07733', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07736', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07759', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07777', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07778', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07779', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07783', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07785', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07809', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07810', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07813', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07815', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07819', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07850', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07862', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07871', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07873', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07891', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07896', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07898', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07899', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07901', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07910', 29)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07912', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07913', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07924', 20)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07927', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07969', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07971', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI07980', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI200000', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20050N', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI201020', 39)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20103', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI201030', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20104', 32)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20105', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20112', 31)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI201120', 19)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20113', 118)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20114', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20331', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI203310', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI203320', 54)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI203360', 75)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20337', 64)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20338', 81)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20339', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI203390', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20349', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI20539', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI33000N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI33105', 4)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI35420', 11)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36676', 67)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36682', 39)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36683', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36684', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36685', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36686', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36690', 40)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI36692', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTLI37360', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT01011', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'ptot10099102', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT17678', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230001', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230002', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230003', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230004', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230005', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230006', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230007', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230008', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230009', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230010', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230011', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230012', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230013', 10)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230014', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230015', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230016', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230017', 7)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT230018', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23099N', 16)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23101N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23102N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23103N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23104N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23105', 619)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23105N', 17)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23106', 50)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23106N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23107', 61)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23108', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT231090', 91)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT231100', 73)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT231110', 53)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23181', 13)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23182', 9)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23183', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23501N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23502N', 14)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23503N', 8)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23601N', 6)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23701N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23702N', 12)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT23703N', 25)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT280010', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT280020', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT280030', 1)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT311000', 2)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT35422', 3)
GO
INSERT [dbo].[TABLA2019_10_14_11_39_59] ([CodProd], [Cantidad]) VALUES (N'PTOT41000N', 1)
GO
/****** Object:  StoredProcedure [dbo].[DS_AgregarDireccionDespacho]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosCliente]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosUsuario]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DS_GET_ObtenerDatosUsuario]
@IdUsuario int,
@pv_BaseDatos varchar (100)
AS
DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '
	SELECT 
	id = u.ID,
	Usuario = u.Usuario,
	Nombre = u.Nombre,
	email = u.email,
	tipoId = u.tipoUsuario,
	VenCod = due.VenCod,
	tipoUsuario = dut.tipoUsuario,
	VenDes = c.VenDes
	FROM DS_Usuarios u 
	JOIN dbo.DS_UsuariosTipos dut ON u.tipoUsuario = dut.id
	JOIN dbo.DS_UsuarioEmpresa due ON due.IdUsuario = u.ID
	JOIN ['+@pv_BaseDatos+'].softland.cwtvend c ON c.VenCod COLLATE Modern_Spanish_CI_AS = due.VenCod
	WHERE u.ID = ' + CONVERT(VARCHAR(20), @IdUsuario) + '
'

EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[DS_ListaEmpresa]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_ListarPefiles]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_ListarPefiles]
AS
SELECT dut.ID, dut.tipoUsuario AS TipoUsuario FROM dbo.DS_UsuariosTipos dut
GO
/****** Object:  StoredProcedure [dbo].[DS_ListaUsuarioEmpresa]    Script Date: 21-10-2019 16:58:03 ******/
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
	FROM	DS_UsuarioEmpresa a
		INNER JOIN DS_Empresa b
			on a.IdEmpresa = b.Id
	WHERE	a.IdUsuario = @pi_IdUsuario
END  
GO
/****** Object:  StoredProcedure [dbo].[DS_SET_ActualizaCorreo]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_SET_ActualizaCorreo]
@VendCod varchar(50),
@Email varchar(100),
@Contrasena varchar(50)
AS
UPDATE dbo.DS_Usuarios SET    
dbo.DS_Usuarios.email = @Email,
dbo.DS_Usuarios.ContrasenaCorreo = @Contrasena	
WHERE dbo.DS_Usuarios.VenCod = @VendCod
SELECT 1

GO
/****** Object:  StoredProcedure [dbo].[DS_SET_EditarUsuario]    Script Date: 21-10-2019 16:58:03 ******/
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
@TipoUsuario int,
@VendCod varchar (15)
AS
DECLARE @Existe int
SET @Existe	= (SELECT count(*) FROM dbo.DS_Usuarios du WHERE du.VenCod = @VendCod)
IF(@Existe = 0)
BEGIN
UPDATE dbo.DS_Usuarios
SET
    --ID - column value is auto-generated
    dbo.DS_Usuarios.Usuario = @Usuario, -- varchar
    dbo.DS_Usuarios.Contrasena = @Password, -- varchar
    dbo.DS_Usuarios.Cliente = '', -- varchar
    dbo.DS_Usuarios.CCosto = '', -- varchar
    dbo.DS_Usuarios.email = @Email, -- varchar
    dbo.DS_Usuarios.tipoUsuario = @TipoUsuario, -- int
    dbo.DS_Usuarios.VenCod = @VendCod, -- nchar
    dbo.DS_Usuarios.Nombre = @Nombre, -- varchar
    dbo.DS_Usuarios.ContrasenaCorreo = '', -- varchar
    dbo.DS_Usuarios.Estado = 1 -- int
	WHERE dbo.DS_Usuarios.ID = @IdUsuario

	SELECT Verificador = cast(1 as bit),
	Mensaje = 'Usuario Modificado'
END
ELSE
BEGIN
SELECT Verificador = cast(0 AS bit),
Mensaje = 'Codigo de Vendedor Ya Existe'
END
GO
/****** Object:  StoredProcedure [dbo].[FR_ActualizarCliente]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ActualizarUsuario]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarContactos]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabecera]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabeceraSoftland]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_AgregarNVCabeceraSoftland]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_AgregarNVCabeceraSoftland]
(
	@pi_IdNotaVenta INT
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

	SELECT	@NVNumero = (SELECT ISNULL((MAX(sub_a.NVNumero) + 1), 0) FROM [' + @pv_BaseDatos + '].[softland].[nw_nventa] sub_a)

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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalle]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalleSoftland]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarUsuario]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_AgregarUsuario]
	@Usuario	varchar(10),
	@email	varchar(50),
	@Contrasena varchar(150),
	@tipoUsuario	varchar(50),
	@venCod NCHAR(10),
	@Nombre varchar (100),
	@BaseDatos int
 AS
DECLARE @CantVenCod int
DECLARE @IdUsuario int
SET @CantVenCod	= (SELECT count(*) AS cantidad FROM dbo.DS_UsuarioEmpresa due JOIN dbo.DS_Usuarios du ON due.IdUsuario=du.ID WHERE due.VenCod = @venCod AND du.Estado = 1)
if(@CantVenCod = 0)
BEGIN
	INSERT INTO [dbo].[DS_Usuarios] ([Usuario],[Contrasena],[email],[tipoUsuario],[Nombre],[Estado])
		VALUES(@Usuario,(@Contrasena), @email, @tipoUsuario, @Nombre,1)
	 
SET @IdUsuario = (SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY])	

	INSERT dbo.DS_UsuarioEmpresa
	(
	    --Id - column value is auto-generated
	    IdUsuario,
	    IdEmpresa,
	    VenCod
	)
	VALUES
	(
	    -- Id - int
	    @IdUsuario, -- IdUsuario - int
	    @BaseDatos, -- IdEmpresa - int
	    @venCod -- VenCod - nchar
	)

		SELECT Verificador = cast(1 AS bit),
		Mensaje = 'Usuario Creado'
END
ELSE
SELECT	Verificador = cast(0 AS bit),
		Mensaje = 'Usuario ya Existe'
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarClientes]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarDirecDespa]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVCabecera]    Script Date: 21-10-2019 16:58:03 ******/
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
		nv.Id,
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
		nv.TotalBoleta
	FROM
		[dbo].[DS_NotasVenta] nv INNER JOIN
		['+@pv_BaseDatos+'].[softland].[cwtauxi] cliente ON (cliente.CodAux collate Modern_Spanish_CI_AS = nv.CodAux) INNER JOIN
		['+@pv_BaseDatos+'].[softland].cwtvend vend ON (vend.VenCod collate Modern_Spanish_CI_AS = nv.VenCod) INNER JOIN
		['+@pv_BaseDatos+'].[softland].cwtconv conven ON (conven.CveCod collate Modern_Spanish_CI_AS = nv.CveCod) INNER JOIN
		['+@pv_BaseDatos+'].[softland].iw_tlispre lista ON (lista.CodLista collate Modern_Spanish_CI_AS = nv.CodLista) INNER JOIN
		['+@pv_BaseDatos+'].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = nv.CodiCC)
	WHERE
		nv.NVNumero = '+@nvId+'
END
'
EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVDetalle]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarNVDetalle]
 @NVNumero   int
as
begin

select a.nvLinea,  a.CodProd, b.DesProd, a.nvCant, a.CodUMed, a.nvPrecio, a.nvSubTotal, ROUND(a.nvDPorcDesc01,0) as nvDPorcDesc01 , a.nvTotLinea  ,
Stock = [DSNotaVenta].[dbo].[stock2018](tp.CodProd)
from [dbo].[DS_NotasVentaDetalle] a
inner join [KUPPEL].[softland].[iw_tprod] b on b.CodProd collate Modern_Spanish_CI_AS = a.CodProd 
LEFT JOIN [KUPPEL].[softland].[iw_tprod] AS tp on a.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
where a.NVNumero = @NVNumero 
order by a.nvLinea
end



GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarParametrosUsuarios]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarProducto]    Script Date: 21-10-2019 16:58:03 ******/
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
		Stock = [DSNotaVenta].[dbo].[stock2018](tp.CodProd)
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarProductoRapido]    Script Date: 21-10-2019 16:58:03 ******/
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
	[dbo].[stock2018](tp.CodProd)  'Stock' 
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarUsuarios]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarUsuarios]
 @id    int
as
begin
	select usuario.Usuario,
	usuario.id, 
	usuario.email, 
	tipo.tipoUsuario
	,VenCod = ISNULL(usuario.VenCod,'')
	from [dbo].[DS_Usuarios] usuario
	inner join [dbo].[DS_UsuariosTipos] tipo on usuario.tipoUsuario = tipo.id
	where usuario.id = @id 

	--where clientes.RutAux ='76.387.390-0' and contacto.[NomCon] like '%jorge naza%'
end
GO
/****** Object:  StoredProcedure [dbo].[FR_EliminarUsuario]    Script Date: 21-10-2019 16:58:03 ******/
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
	UPDATE dbo.DS_Usuarios SET dbo.DS_Usuarios.Estado = 0   
	WHERE dbo.DS_Usuarios.ID = @Id  

	SELECT	Verificador = Cast(1 as bit)
	,		Mensaje = 'Se elimina usuario'   
GO
/****** Object:  StoredProcedure [dbo].[FR_ListaProductos]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCentroDeCosto]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarClientes]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarClientesTodos]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCondicionesDeVenta]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarContactos]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosAprobados]    Script Date: 21-10-2019 16:58:03 ******/
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
	select a.Id, 
	clientes.[NomAux], 
	clientes.[RutAux], 
	a.nvFem, 
	a.CodLista,
	a.NomCon, 
	a.nvNetoAfecto, 
	a.TotalBoleta, 
	a.nvEstado, 
	ISNULL(a.RutSolicitante,0) as RutSolicitante
	from [dbo].[DS_NotasVenta] a
	inner join ['+@pv_BaseDatos+'].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	where 
	a.nvEstado = ''A''
'
EXEC (@query)

SELECT * FROM dbo.DS_NotasVenta dnv
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosPendientes]    Script Date: 21-10-2019 16:58:03 ******/
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

	select distinct  [dbo].[stockListas] (a.nvnumero ) as stocklista,	
	a.NVNumero,
	clientes.[NomAux],
	clientes.[RutAux],
	a.nvEstado,
	a.nvFem, 
	a.nvFeEnt, 
	a.CodLista, 
	a.NomCon, 
	a.nvNetoAfecto, 
	a.TotalBoleta, 
	a.EstadoNP, 
	ISNULL(a.RutSolicitante,0) as RutSolicitante, 
	[dbo].[func_SaldoClienteCW](a.CodAux,'''+@pv_BaseDatos+''' ) ''Saldo''

	from [dbo].[DS_NotasVenta] a
	inner join ['+ @pv_BaseDatos +'].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	LEFT JOIN [dbo].[DS_NotasVentaDetalle] b on a.NVNumero = b.NVNumero
	LEFT JOIN ['+ @pv_BaseDatos +'].[softland].[iw_tprod] AS tp on b.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
	where a.nvEstado = ''P''
'

EXEC (@query)
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarListaDePrecio]    Script Date: 21-10-2019 16:58:03 ******/
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
		where	codlista = ''LPW''  
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
/****** Object:  StoredProcedure [dbo].[FR_ListarMisClientes]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_ListarMisClientes]
	@ID INT
AS
BEGIN
	SELECT 
		c.CodAux,
		c.NomAux,
		c.DirAux,
		c.DirNum, 
		CASE WHEN c.FonAux1 IS NOT NULL THEN c.FonAux1 WHEN c.FonAux2 IS NOT NULL THEN c.FonAux2 ELSE c.FonAux3 END AS 'FonAux1',
		format(vcl.MtoCre,'$0') as Credito,
		C.Notas   ,
		 [dbo].[JS_DeudaClienteDia](c.CodAux) as Deuda  
	FROM
		[KUPPEL].softland.[cwtauxven] A INNER JOIN
		[KUPPEL].softland.cwtauxi C ON (c.CodAux = a.CodAux) INNER JOIN
		[KUPPEL].softland.cwtvend B ON (b.VenCod = a.VenCod) INNER JOIN 
		[DSNotaVenta].[dbo].[DS_Usuarios] D ON (b.VenCod collate Modern_Spanish_CI_AS = d.VenCod) 
			LEFT JOIN 	KUPPEL.softland.cwtcvcl as vcl on vcl.CodAux = A.CodAux
		
	WHERE
		d.ID =@ID

END
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuarios]    Script Date: 21-10-2019 16:58:03 ******/
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
	usuEmp.VenCod,
	tipo.tipoUsuario,
	usuario.Estado	
	from [dbo].[DS_Usuarios] usuario
	inner join [dbo].[DS_UsuariosTipos] tipo on usuario.tipoUsuario = tipo.id
	join DS_UsuarioEmpresa usuEmp on usuEmp.IdUsuario = usuario.ID
	

GO
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuariosTipos]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland2]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListaTallaColorProducto]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ModificarNVCabecera]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ModificarParametrosUsuarios]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ModificarParametrosUsuarios]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
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
,	@pb_ManejaDescuentoTotalDocumento BIT 
,	@pi_CantidadDescuentosTotalDocumento INT
,	@pi_CantidadLineas INT
,	@pb_ManejaLineaCredito BIT 
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
	,		ManejaDescuentoTotalDocumento = @pb_ManejaDescuentoTotalDocumento
	,		CantidadDescuentosTotalDocumento = @pi_CantidadDescuentosTotalDocumento
	,		CantidadLineas = @pi_CantidadLineas
	,		ManejaLineaCredito = @pb_ManejaLineaCredito
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
	WHERE	IdEmpresa = @pi_IdEmpresa
	
	SELECT	Verificador = CAST(1 as bit)
	,		Mensaje = 'Parametros Actualizados satisfactoriamente'
end
GO
/****** Object:  StoredProcedure [dbo].[FR_ObtenerAtributoDescuentoCliente]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ObtenerCredito]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_Credito_Cliente]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_cwmovimFV]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_DeudaClienteDia]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_DeudaClienteTotal]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[insertaNVSoftland]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[insertaNVSoftland]
	@nvNumero decimal
AS
	declare @ultimaNvNumero decimal 
    SET @ultimaNvNumero = (SELECT max([NVNumero]) + 1  FROM [KUPPEL].[softland].[nw_nventa])
	insert into [KUPPEL].[softland].[nw_nventa] select @ultimaNvNumero
	,[nvFem],[nvEstado],[nvEstFact],[nvEstDesp],[nvEstRese],[nvEstConc],'0',[NumOC],[nvFeEnt],[CodAux],[VenCod],[CodMon],[CodLista],[nvObser],[nvCanalNV]
	,[CveCod],[NomCon],[CodiCC],[CodBode],[nvSubTotal],[nvPorcDesc01],[nvDescto01],[nvPorcDesc02],[nvDescto02],[nvPorcDesc03],[nvDescto03],[nvPorcDesc04]
	,[nvDescto04],[nvPorcDesc05],[nvDescto05],[nvMonto],[nvFeAprob],[NumGuiaRes], Case when nvValflete <> 0 then (([nvValflete]/ [nvSubTotal]) * 100) else [nvPorcFlete] end   as  [nvPorcFlete],[nvValflete],
	Case when [nvValEmb] <> 0 then (([nvValEmb]/ [nvSubTotal]) * 100) else [nvPorcFlete] end   as  [nvPorcEmb],'0',[nvEquiv],[nvNetoExento]
	,[nvNetoAfecto],[nvTotalDesc],[ConcAuto],[CodLugarDesp],[SolicitadoPor],[DespachadoPor],[Patente],[RetiradoPor],[CheckeoPorAlarmaVtas],[EnMantencion],[Usuario]
	,[UsuarioGeneraDocto],[FechaHoraCreacion],[Sistema],[ConcManual],'0-0',[proceso],[TotalBoleta],[NumReq],[CodBodeWms],CodLugarDocto,RutTransportista, null, null
	FROM [dbo].[DS_NotasVenta] WHERE [nvNumero] = @nvNumero
	 

	insert into [KUPPEL].[softland].[nw_detnv] SELECT  @ultimaNvNumero
	,[nvLinea],[nvCorrela],[nvFecCompr],[CodProd],[nvCant],[nvPrecio],[nvEquiv],[nvSubTotal],[nvDPorcDesc01],[nvDDescto01],[nvDPorcDesc02],[nvDDescto02]
	,[nvDPorcDesc03],[nvDDescto03],[nvDPorcDesc04],[nvDDescto04],[nvDPorcDesc05],[nvDDescto05],[nvTotDesc],[nvTotLinea],[nvCantDesp],[nvCantProd],[nvCantFact]
	,[nvCantDevuelto],[nvCantNC],[nvCantBoleta],[nvCantOC],[DetProd],[CheckeoMovporAlarmaVtas],[KIT],[CodPromocion],[CodUMed],[CantUVta],[Partida],[Pieza]
	,[FechaVencto] FROM [dbo].[DS_NotasVentaDetalle] WHERE [nvNumero] = @nvNumero


	--UPDATE [DSSNACKCENTER].[dbo].[DS_NotasVentaAG] SET CotNum=@ultimaNvNumero WHERE NVNumero=@nvNumero
	--Inserta los impuestos
	declare @fechanv datetime
	Select @fechanv =  nvfem from [dbo].[DS_NotasVenta] WHERE [nvNumero] = @nvNumero

	insert into [KUPPEL].[softland].[nw_impto](nvNumero,codimpto,valpctIni,afectoImpto,Impto)
	select @ultimaNvNumero,iwti.codimpto,iwtv.valpctini,
	Case when iwti.CodImpto ='IVA' then (nwv.nvvalflete + Sum(nwd.nvSubtotal)) else Sum(nwd.nvSubtotal) END  as afectoImpto,
	Case when iwti.CodImpto ='IVA' then ((nwv.nvvalflete + Sum(nwd.nvSubtotal))* iwtv.valpctini)/100 else Sum(((iwtv.valpctini * nwd.nvSubtotal)/100)) END  as Impto

	from [KUPPEL].[softland].[iw_timprod] iwti 
	left join [KUPPEL].softland.[iw_timpval] iwtv on iwti.codimpto = iwtv.codimpto
	left join [KUPPEL].softland.nw_detnv nwd on nwd.codprod = iwti.codprod 
	left join [KUPPEL].softland.nw_nventa nwv on nwv.nvnumero = nwd.nvnumero
	where nwd.codprod = iwti.codprod 
	and convert(datetime,@fechanv,103) >iwtv.fecinivig and convert(datetime,@fechanv,103) < iwtv.fecfinvig
	and nwd.nvnumero =@ultimaNvNumero
	group by iwti.codimpto,iwtv.valpctini,nwv.nvvalflete 
	--Fin insercion de impuestos

	--declare @ValPctIni decimal (10,2)
	--declare @CodImpto varchar(3)
	--declare @nvNetoAfecto decimal (18,2)
	--declare @nvNetoConImpto decimal (18,2)

	----Select @fechanv =  nvfem,@nvNetoAfecto = nvNetoAfecto,@nvNetoConImpto =nvNetoAfecto * 1.19 from [DSSNACKCENTER].[dbo].[DS_NotasVentaAG] WHERE [nvNumero] = @nvNumero
	--SELECT @ValPctIni =ValPctIni, @CodImpto = Codimpto FROM [[GOLDEN]].[softland].[Iw_TImpVal] WHERE CodImpto = 'IVA'  AND (Iw_TImpVal.FecIniVig <= Convert(datetime,@fechanv,103) AND Iw_TImpVal.FecFinVig >= Convert(datetime,@fechanv,103) )

	--insert into [TAVELLI1].[softland].[nw_impto](nvNumero,codimpto,valpctIni,afectoImpto,Impto) Values(@ultimaNvNumero,@CodImpto,@ValPctIni,@nvNetoAfecto,@nvNetoConImpto-@nvNetoAfecto)


	


GO
/****** Object:  StoredProcedure [dbo].[JS_BuscarProducto]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[JS_BuscarProducto]
	@DesProd	varchar(max),
	@CodLista	varchar(3)
AS
BEGIN
		SELECT 
			CodProd = tp.CodProd, 
			DesProd = ISNULL(tp.DesProd,''), 
			codgrupo = ISNULL(tp.CodGrupo,''),
			codsubgr = ISNULL(tp.CodSubGr,''),
			PrecioVta = pd.ValorPct, 
			codumed = pd.CodUmed,
			desumed = ISNULL(detumed.desumed,''),
			CodLista = lp.CodLista,
			Stock = [DSNotaVenta].[dbo].[stock2018](tp.CodProd),
			saldoProd = [dbo].[js_saldoProd](tp.CodProd)
			
		FROM 
					KUPPEL.[softland].[iw_tprod] AS tp LEFT JOIN
					KUPPEL.[softland].[iw_gmovi] AS gm ON tp.CodProd=gm.CodProd LEFT JOIN
					KUPPEL.[softland].[iw_tlprprod] AS pd ON tp.CodProd=pd.CodProd LEFT JOIN
					KUPPEL.[softland].[iw_tlispre] AS lp ON pd.CodLista=lp.CodLista LEFT JOIN
					KUPPEL.[softland].[iw_tumed] AS detumed on pd.CodUmed = detumed.CodUMed 
					
		WHERE  

		lp.CodLista = @CodLista and
		tp.DesProd LIKE (CASE @DesProd WHEN '' THEN tp.DesProd ELSE '%' + @DesProd +'%' END)
			OR 
		tp.CodProd LIKE (CASE  @DesProd WHEN '' THEN tp.CodProd ElSE '%'+ @DesProd + '%' END) 
		and  lp.CodLista = @CodLista
					
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
/****** Object:  StoredProcedure [dbo].[JS_DeudaClientes]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[JS_DeudaClientes]
	@cod varchar(10)

AS
BEGIN
select 
	[dbo].[JS_DeudaClienteDia](CodAux)
from 
    [KUPPEL].softland.cwtauxi 
WHERE
	codaux=@cod



END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarClientesCodAuxRut]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarContactos]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarDocumentos]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[JS_ListarDocumentos]
	as
	select distinct  [dbo].[stockListas] (a.nvnumero ) as stocklista,
	
	a.NVNumero, clientes.[NomAux],clientes.[RutAux],a.nvEstado as nvEstado, a.nvFem, a.nvFeEnt, a.CodLista, a.NomCon, a.nvNetoAfecto, a.TotalBoleta, a.EstadoNP, ISNULL(a.RutSolicitante,0) as RutSolicitante, [DSNotaVenta].[dbo].[func_SaldoClienteCW](a.CodAux ) 'Saldo'
	from [[DSNotaVenta]].[dbo].[DS_NotasVenta] a
	inner join [KUPPEL].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	LEFT JOIN [dbo].[DS_NotasVentaDetalle] b on a.NVNumero = b.NVNumero
	LEFT JOIN [KUPPEL].[softland].[iw_tprod] AS tp on b.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
	where a.EstadoNP = 'A' --AND a.CodVenWeb = '5'

GO
/****** Object:  StoredProcedure [dbo].[JS_ListarListaDePrecio]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes]    Script Date: 21-10-2019 16:58:03 ******/
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
	,		FonAux1 = 
			CASE	WHEN c.FonAux1 IS NOT NULL 
						THEN c.FonAux1 
					WHEN c.FonAux2 IS NOT NULL 
						THEN c.FonAux2 
						ELSE c.FonAux3 
			END
	,		C.Notas
	--,		DeudaVencida = 
	--		(
	--			SELECT	isnull(convert (numeric,( (sum(sub_a.DEBE)) - (sum(sub_a.HABER)))), 0)
	--			from	[' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a
	--			where	sub_a.CODAUX = c.CodAux
	--			and		(
	--						select	isnull(min(MovFv), '''')
	--						from	[' + @pv_BaseDatos + '].[softland].[cwmovim] sub_cwom
	--						where	sub_cwom.MovNumDocRef = sub_a.MOVNUMDOCREF and ttdcod= ''FV''
	--					) < getdate()
	--			and		MONTH
	--					(
	--						(
	--							select	isnull(min(MovFv), '''')
	--							from	[' + @pv_BaseDatos + '].[softland].[cwmovim] sub_cwom
	--							where	sub_cwom.MovNumDocRef = sub_a.MOVNUMDOCREF and ttdcod= ''FV''
	--						)
	--					) < getdate()
	--		)
	--,		Deuda = 
	--		(
	--			SELECT	isnull(convert (numeric,( (sum(sub_a.DEBE)) - (sum(sub_a.HABER)))), 0)
	--			FROM	[' + @pv_BaseDatos + '].[softland].[CWDocSaldos] sub_a
	--			where	sub_a.CODAUX = c.CodAux
	--		)
	--,		Credito = 
	--		CASE	WHEN	(
	--							(Select CONVERT(numeric(18,2),vcl.MtoCre)
	--							From [' + @pv_BaseDatos + '].softland.cwtcvcl as vcl INNER JOIN [' + @pv_BaseDatos + '].softland.CWDocSaldos as doc on
	--							 vcl.CodAux = c.CodAux and doc.CodAux= vcl.CodAux 
	--							Group by vcl.MtoCre ) - 
	--							(SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  [' + @pv_BaseDatos + '].softland.CWDocSaldos
	--							where CODAUX= c.CodAux)
	--						) < 0 
	--					then ''$0''
	--					ELSE FORMAT((Select CONVERT(numeric(18,2),vcl.MtoCre)
	--							From [' + @pv_BaseDatos + '].softland.cwtcvcl as vcl INNER JOIN [' + @pv_BaseDatos + '].softland.CWDocSaldos as doc on
	--							 vcl.CodAux = c.CodAux and doc.CodAux= vcl.CodAux 
	--							Group by vcl.MtoCre ) - 
	--							(SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  [' + @pv_BaseDatos + '].softland.CWDocSaldos
	--							where CODAUX= c.CodAux),''$0'')  
	--		END
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

GO
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes_concredito]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarNVDETALLENM]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarNVDETALLENM]
		@intNVNumero INT
		as
		BEGIN
-- ==========================================================================================
-----------------Lista detalle  nota de venta según NVNumero-------------------------
-- ==========================================================================================
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
				[KUPPEL].[softland].[iw_tprod] b ON (b.CodProd collate Modern_Spanish_CI_AS = a.CodProd)
			WHERE
				a.NVNumero = @intNVNumero 
			ORDER BY
				a.nvLinea
		END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarNVNM]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarNVNM]
		@intNVNumero INT
		as
		BEGIN
-- ==========================================================================================
-----------------Lista la cabecera de la nota de venta según NVNumero-------------------------
-- ==========================================================================================
			SELECT
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
				nv.TotalBoleta
			FROM
				[DSNotaVenta].[dbo].[DS_NotasVenta] nv INNER JOIN
				[KUPPEL].[softland].[cwtauxi] cliente ON (cliente.CodAux collate Modern_Spanish_CI_AS = nv.CodAux) INNER JOIN
				[KUPPEL].[softland].cwtvend vend ON (vend.VenCod collate Modern_Spanish_CI_AS = nv.VenCod) INNER JOIN
				[KUPPEL].[softland].cwtconv conven ON (conven.CveCod collate Modern_Spanish_CI_AS = nv.CveCod) INNER JOIN
				[KUPPEL].[softland].iw_tlispre lista ON (lista.CodLista collate Modern_Spanish_CI_AS = nv.CodLista) INNER JOIN
				[KUPPEL].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = nv.CodiCC)
			WHERE
				nv.NVNumero = @intNVNumero
		END

GO
/****** Object:  StoredProcedure [dbo].[JS_ListarVendorVenCod]    Script Date: 21-10-2019 16:58:03 ******/
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
	SELECT	du.Nombre
	,		du.VenCod
	,		du.email
	FROM	dbo.DS_Usuarios du  
	WHERE	du.VenCod = ''' + @VenCod + '''
	'

	exec (@query)
end  
GO
/****** Object:  StoredProcedure [dbo].[Js_NvSoftland]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Js_NvSoftland] 
	as begin
	select max([NVNumero]) as NVNumero FROM KUPPEL.[softland].[nw_nventa]
	end
GO
/****** Object:  StoredProcedure [dbo].[RRA_ActualizaEstadoNW]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[RRA_ActualizaEstadoNW]
 @nvNumero    varchar(30)

as
begin
	--select * from DSSNACKCENTER.dbo.DS_NotasVenta where nvnumero = '5'

	--where clientes.RutAux ='76.387.390-0' and contacto.[NomCon] like '%jorge naza%'

	declare @variable varchar(20)
	declare @obser varchar(200)

	--insert into dbo.ds_estado values (SYSDATETIME(),'hola')
	set @obser = (select nvObser from [DSNotaVenta].dbo.DS_NotasVenta where NVNumero = @nvNumero )

	update [DSNotaVenta].dbo.DS_NotasVenta  set EstadoNP = 'A', nvObser = 'N. Int: '+@nvNumero+' Obs: '+@obser  where nvnumero = @nvnumero

	exec [DSNotaVenta].dbo.insertaNVSoftland @nvnumero

	--select max(nvnumero) as nvnumero from TAVELLI1.softland.nw_nventa

	set @variable = (select max(nvnumero) as nvnumero from [KUPPEL].softland.nw_nventa)

	set @obser = (select nvObser from [DSNotaVenta].dbo.DS_NotasVenta where NVNumero = @nvNumero )

	UPDATE [DSNotaVenta].dbo.DS_NotasVenta set RutSolicitante = @variable, nvObser = ' NV: '+@variable+' Obs: '+@obser  where nvnumero = @nvNumero


DECLARE @tableHTML  NVARCHAR(MAX) ; 
--declare @variable varchar(20);
declare @cliente varchar(max);
declare @Usuario varchar(max);
declare @direccion varchar(max);
declare @fpedido varchar(max);
declare @fentrega varchar(max);
--declare @Obser varchar(max);
declare @total varchar(max);
declare @correo varchar(max);
declare @totalboleta varchar(max);
declare @iva varchar(max);

set @variable = (select max(nvnumero) as nvnumero from [KUPPEL].softland.nw_nventa)
set @cliente = (select (cliente.CodAux+' - '+cliente.NomAux) as cliente from [KUPPEL].softland.nw_nventa nv inner join [KUPPEL].[softland].[cwtauxi] cliente on cliente.CodAux = nv.CodAux where nv.NVNumero=@variable)
set @Usuario = (select (vend.VenCod+' - '+vend.VenDes) as usuario from [KUPPEL].softland.nw_nventa nv inner join [KUPPEL].[softland].cwtvend vend on vend.VenCod = nv.VenCod  where nv.NVNumero=@variable)
set @direccion = (select CodLugarDesp from [KUPPEL].softland.nw_nventa where NVNumero=@variable)
set @fpedido = (select CONVERT (char(10), nvFem, 103) as fecha from [KUPPEL].softland.nw_nventa where NVNumero=@variable)
set @fentrega = (select CONVERT (char(10), nvFeEnt, 103) as nvFeEnt from [KUPPEL].softland.nw_nventa where NVNumero=@variable)
set @Obser = (select nvObser from [KUPPEL].softland.nw_nventa where NVNumero=@variable)
set @total = (select REPLACE(CONVERT(varchar, convert(money, nvNetoAfecto), 1),'.00','') as monto from [KUPPEL].softland.nw_nventa where NVNumero=@variable)
set @correo = (select usu.email from [KUPPEL].softland.nw_nventa nv inner join [DSNotaVenta].[dbo].DS_Usuarios usu on  usu.Usuario  collate Modern_Spanish_CI_AS = nv.UsuarioGeneraDocto where nv.NVNumero=@variable)
set @totalboleta = (select REPLACE(CONVERT(varchar, convert(money, TotalBoleta), 1),'.00','') as monto from [KUPPEL].softland.nw_nventa where NVNumero=@variable) 
set @iva = (select REPLACE(CONVERT(varchar, convert(money, TotalBoleta-nvNetoAfecto), 1),'.00','') as monto from [KUPPEL].softland.nw_nventa where NVNumero=@variable) 


SET @tableHTML = 
	
    N'<H1>Nota de Venta</H1>' + 
	N'<H4>Nº: '+@variable+'</H4>'+ 
	N'<H4>Cliente: ' + @cliente +'</H4>'+
	N'<H4>Direccion: '+ @Direccion +'</H4>'+
	N'<H4>Fecha Pedido: ' + @fpedido +'</H4>'+
	N'<H4>Fecha Entrega: '+ @fentrega +'</H4>'+
	N'<H4>Observaciones: '+ @Obser+'</H4>'+
	N'<H4>Vendedor: '+ @Usuario +'</H4>'+
	
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
			from [KUPPEL].[softland].[nw_detnv] as a
			inner join [KUPPEL].[softland].[iw_tprod] as b on b.CodProd = a.CodProd 
			where a.NVNumero = @variable 
			order by a.nvLinea
              FOR XML PATH('tr'), TYPE   
    ) AS NVARCHAR(MAX) ) +  

	N'<td colspan="8">Neto</td>'+
	N'<td>'+@total+'</td>'+
	N'<tr><td colspan="8">Iva</td>'+
	N'<td>'+@iva+'</td></tr>'+
	N'<tr><td colspan="8">Total</td>'+
	N'<td>'+@totalboleta+'</td></tr>'+
    N'</table>' ;    



EXEC  msdb.dbo.sp_send_dbmail @profile_name='SistemaQA' , 
@recipients= 'frivas@disofi.cl' ,
@subject= 'Nota de Venta',
@body = @tableHTML,  
@body_format = 'HTML' ;


	BEGIN
	SELECT MAX(NVNumero) 'NVNumero' FROM [KUPPEL].softland.[nw_nventa]
	END	
end

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Ciudad]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_Comuna]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_DatosCorreoVend]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_DatosCorreoVend]
@NvNumero int
as
SELECT dnv.VenCod,u.email,u.ContrasenaCorreo FROM dbo.DS_NotasVenta dnv 
JOIN ds_usuarios u ON dnv.VenCod = u.VenCod 
WHERE dnv.NVNumero	= @NvNumero
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_EmailVendedor]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_GET_EmailVendedor]
(
@nvNum varchar(10)
)
as
begin
select email from DS_NotasVenta a inner join DS_Usuarios b on a.VenCod = b.VenCod 
where a.NVNumero = @nvNum and b.tipoUsuario = 2
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Giro]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_LOGIN]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_Menu]    Script Date: 21-10-2019 16:58:03 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetCodVendedor]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCodVendedor]
@pv_BaseDatos varchar(100)
AS
DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '
	SELECT c.VenCod,
	c.VenDes 
	FROM ['+@pv_BaseDatos+'].softland.cwtvend c 
'

EXEC (@query)

GO
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 21-10-2019 16:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Login]
(
@usuario varchar(50), @password varchar(50)
)
AS
BEGIN

	SELECT
		usuario.id,
		usuario.Usuario,
		tipo.urlInicio,
		tipo.id as tipoId,
		usuario.Nombre,
		usuario.VenCod,
		vendedor.EMail as Email,
		VenDes=(SELECT Ventas.VenDes FROM [KUPPEL].[softland].[cwtvend] Ventas WHERE Ventas.VenCod collate Modern_Spanish_CI_AS = usuario.VenCod)
	FROM
	    KUPPEL.softland.cwtvend vendedor INNER JOIN
		[DSNotaVenta].dbo.DS_Usuarios usuario on (usuario.VenCod collate SQL_Latin1_General_CP1_CI_AI = vendedor.VenCod) INNER JOIN
		[DSNotaVenta].dbo.DS_UsuariosTipos tipo ON (usuario.tipoUsuario = tipo.id)
	WHERE
		usuario.Usuario = @usuario AND
		PWDCOMPARE(@password,usuario.Contrasena) = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JS_DebeCliente2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JS_DebeCliente2'
GO
