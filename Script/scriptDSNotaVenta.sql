USE [master]
GO
/****** Object:  Database [DSNotaVenta]    Script Date: 21-10-2019 9:35:45 ******/
CREATE DATABASE [DSNotaVenta]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DSNotaVenta', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DSNotaVenta.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DSNotaVenta_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DSNotaVenta_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DSNotaVenta] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DSNotaVenta].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DSNotaVenta] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DSNotaVenta] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DSNotaVenta] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DSNotaVenta] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DSNotaVenta] SET ARITHABORT OFF 
GO
ALTER DATABASE [DSNotaVenta] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DSNotaVenta] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DSNotaVenta] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DSNotaVenta] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DSNotaVenta] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DSNotaVenta] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DSNotaVenta] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DSNotaVenta] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DSNotaVenta] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DSNotaVenta] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DSNotaVenta] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DSNotaVenta] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DSNotaVenta] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DSNotaVenta] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DSNotaVenta] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DSNotaVenta] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DSNotaVenta] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DSNotaVenta] SET RECOVERY FULL 
GO
ALTER DATABASE [DSNotaVenta] SET  MULTI_USER 
GO
ALTER DATABASE [DSNotaVenta] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DSNotaVenta] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DSNotaVenta] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DSNotaVenta] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DSNotaVenta] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DSNotaVenta', N'ON'
GO
ALTER DATABASE [DSNotaVenta] SET QUERY_STORE = OFF
GO
USE [DSNotaVenta]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [DSNotaVenta]
GO
/****** Object:  UserDefinedFunction [dbo].[FNC_TieneTallaColor]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Funcion												*/
/*-- Nombre				: [dbo].[FNC_TieneTallaColor]							*/
/*-- Detalle			: Verifica si tiene talla y color						*/
/*-- Autor				: YVEGA													*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE FUNCTION [dbo].[FNC_TieneTallaColor]
(
	@CodProducto VARCHAR (100)
,	@BaseDatos varchar(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @query NVARCHAR(MAX)
	DECLARE @campo nvarchar(50),@valor NVARCHAR(MAX)
	
	SELECT	@query = 'SELECT @valor = count(*) FROM [' + @BaseDatos + '].[softland].[iw_tprodtallacolor] WHERE CodProd = ''' + @CodProducto + ''''

	EXECUTE sp_executesql @query, N'@valor NVARCHAR(MAX) OUTPUT', 
						  @valor=@valor OUTPUT
	return @valor
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_CreditoCliente2]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_CreditoCliente2] ( @Codaux VARCHAR(10))	  
RETURNS Numeric(18,2) AS
BEGIN

DECLARE @Saldo Numeric(18,2)

Set @Saldo = (Select CONVERT(numeric(18,2),vcl.MtoCre)
From [TRANSPORTE].softland.cwtcvcl as vcl INNER JOIN TRANSPORTE.softland.CWDocSaldos as doc on
 vcl.CodAux = @CodAux and doc.CodAux= vcl.CodAux 
Group by vcl.MtoCre )

Return @Saldo

end
GO
/****** Object:  UserDefinedFunction [dbo].[func_SaldoClienteCW]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_SaldoClienteCW] ( @Codaux VARCHAR(10),@pv_BaseDatos varchar(100))	  
RETURNS varchar AS
BEGIN

DECLARE @Saldo Float
DECLARE @SaldoFacPend Float
DECLARE @SaldoDoctoContab Float

DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '

SELECT @SaldoFacPend = (SUM(movim.MovDebe)-SUM(movim.MovHaber))  FROM ['''+@pv_BaseDatos+'''].[Softland].[cwmovim] AS movim
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[cwcpbte] pbte ON pbte.CpbAno=movim.CpbAno AND pbte.cpbNum=movim.CpbNum
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[cwpctas] ctas ON ctas.PCCODI=movim.PctCod
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[cwtauxi] auxi ON auxi.CodAux=movim.CodAux
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[iw_gsaen] gsaen ON gsaen.folio=movim.MovNumDocRef
			WHERE pbte.CpbEst=''V'' AND ctas.PCCODI in (''1-1-03'',''1-1-16'') AND movim.CpbAno = YEAR(GETDATE()) AND movim.codaux='''+@Codaux+'''

SELECT @SaldoDoctoContab = (Sum(movin.movdebe) - sum(movin.movhaber))
			FROM ['''+@pv_BaseDatos+'''].[Softland].[cwmovim] movin 
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].cwcpbte pbte on pbte.cpbano = movin.cpbano and pbte.cpbnum = movin.cpbnum
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].cwtauxi auxi on movin.CodAux = auxi.CodAux
			WHERE pbte.cpbest = ''V'' AND movin.codaux='+@codaux+' group by movin.codaux
			Having ((Sum(movin.movdebe) - sum(movin.movhaber)) <> 0) and max(auxi.nomaux) is not null and max(movin.CpbAno) = 2015
			order by max(auxi.nomaux),DATEPART (week,max(movin.MovFv)) asc

if '+@SaldoFacPend+' is null
   Set '+@SaldoFacPend+' = 0 
if '+@SaldoDoctoContab+' is null
   Set '+@SaldoDoctoContab+' = 0 

   SET '+@Saldo+' = '+@SaldoFacPend+' + '+@SaldoDoctoContab+'

if '+@Saldo+' is null
   Set '+@Saldo+' = 0 

Return '+@Saldo+'
'
return (@query)
END	



GO
/****** Object:  UserDefinedFunction [dbo].[func_SaldoClienteCWString]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_SaldoClienteCWString] ( @Codaux VARCHAR(10),@pv_BaseDatos varchar(100))	  
RETURNS varchar AS
BEGIN

DECLARE @query varchar (max)

SELECT @query = ''

SELECT @query = @query + '

SELECT (SUM(movim.MovDebe)-SUM(movim.MovHaber))  FROM ['''+@pv_BaseDatos+'''].[Softland].[cwmovim] AS movim
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[cwcpbte] pbte ON pbte.CpbAno=movim.CpbAno AND pbte.cpbNum=movim.CpbNum
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[cwpctas] ctas ON ctas.PCCODI=movim.PctCod
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[cwtauxi] auxi ON auxi.CodAux=movim.CodAux
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].[iw_gsaen] gsaen ON gsaen.folio=movim.MovNumDocRef
			WHERE pbte.CpbEst=''V'' AND ctas.PCCODI in (''1-1-03'',''1-1-16'') AND movim.CpbAno = YEAR(GETDATE()) AND movim.codaux='''+@Codaux+'''

SELECT (Sum(movin.movdebe) - sum(movin.movhaber))
			FROM ['''+@pv_BaseDatos+'''].[Softland].[cwmovim] movin 
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].cwcpbte pbte on pbte.cpbano = movin.cpbano and pbte.cpbnum = movin.cpbnum
			LEFT JOIN ['''+@pv_BaseDatos+'''].[Softland].cwtauxi auxi on movin.CodAux = auxi.CodAux
			WHERE pbte.cpbest = ''V'' AND movin.codaux='+@codaux+' group by movin.codaux
			Having ((Sum(movin.movdebe) - sum(movin.movhaber)) <> 0) and max(auxi.nomaux) is not null and max(movin.CpbAno) = 2015
			order by max(auxi.nomaux),DATEPART (week,max(movin.MovFv)) asc
'
return @query
END	
GO
/****** Object:  UserDefinedFunction [dbo].[JS_cwmovimFV]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[JS_cwmovimFV] (@cod as float)
RETURNS datetime
AS
BEGIN
DECLARE @Fecha Datetime

Set @Fecha = (select min(MovFv)from  transporte.softland.cwmovim cwom
where cwom.MovNumDocRef =@cod and ttdcod= 'FV' )

if @Fecha = NULL
set @Fecha = ''

Return @Fecha
END
GO
/****** Object:  UserDefinedFunction [dbo].[JS_DeudaClienteDia]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[JS_DeudaClienteDia](@cod as varchar(10))
RETURNS numeric
AS
BEGIN
DECLARE @deuda numeric

Set @deuda = (SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from JS_DebeCliente2 
where CODAUX= @cod)

IF @deuda = null
Set @deuda=0
IF @deuda is null
Set @deuda=0
IF @deuda < 0
Set @deuda=0

Return @deuda
END
GO
/****** Object:  UserDefinedFunction [dbo].[JS_DeudaClienteTotal]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  function [dbo].[JS_DeudaClienteTotal](@cod as varchar(10))
RETURNS numeric
AS
BEGIN
DECLARE @deuda numeric

Set @deuda = (SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  TRANSPORTE.softland.CWDocSaldos
where CODAUX= @cod)

IF @deuda = null
Set @deuda=0
IF @deuda is null
Set @deuda=0
IF @deuda < 0
Set @deuda=0

Return @deuda
END
GO
/****** Object:  UserDefinedFunction [dbo].[stock2018]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[stock2018] (@Producto VARCHAR(20))	  
RETURNS Float AS
BEGIN

declare @Fecha datetime
set @Fecha = (select GETDATE())

DECLARE @Stock Float

set @stock =
(
select  Sum (CASE WHEN TipoBod = 'D' THEN Ingresos - Egresos ELSE 0 END)  * 1 AS StockDisponible
      
FROM  [KUPPEL].softland.IW_vsnpMovimStockTipoBod WITH (INDEX(IW_GMOVI_BodPro)) 
WHERE   Fecha <= @Fecha  and CodProd = @Producto 
GROUP BY CodProd
)

if @Stock is null
   Set @Stock = 0 

Return @Stock
END
GO
/****** Object:  UserDefinedFunction [dbo].[stockListas]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[stockListas] (@numero VARCHAR(max))	  
RETURNS int
AS
begin
declare @stock int

set @stock=(
select 
sum(
case when
[dbo].[stock2018](tp.CodProd) < a.nvCant then 1 
when 
[dbo].[stock2018](tp.CodProd) >= a.nvCant then 0 end )
from [dbo].[DS_NotasVentaDetalle] a
inner join [KUPPEL].[softland].[iw_tprod] b on b.CodProd collate Modern_Spanish_CI_AS = a.CodProd 
LEFT JOIN [KUPPEL].[softland].[iw_tprod] AS tp on a.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
where a.NVNumero = @numero
group by a.NVNumero)

if @stock is null
set @stock = 0

return @stock
end
GO
/****** Object:  View [dbo].[JS_DebeCliente2]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_Empresa]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_Estado]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Estado](
	[estado] [datetime] NULL,
	[proceso] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_Imagenes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_NotasVenta]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_NotasVentaDetalle]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_Parametros]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_ParametrosUsuario]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_ParametrosUsuario](
	[Aprobador] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_UsuarioEmpresa]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_Usuarios]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[DS_UsuariosTipos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[tabla]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  Table [dbo].[TABLA2019_10_14_11_39_59]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA2019_10_14_11_39_59](
	[CodProd] [varchar](20) NOT NULL,
	[Cantidad] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DS_AgregarDireccionDespacho]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosCliente]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_GET_ObtenerDatosUsuario]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_ListaEmpresa]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_ListarPefiles]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DS_ListarPefiles]
AS
SELECT dut.ID, dut.tipoUsuario AS TipoUsuario FROM dbo.DS_UsuariosTipos dut
GO
/****** Object:  StoredProcedure [dbo].[DS_ListaUsuarioEmpresa]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_SET_ActualizaCorreo]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[DS_SET_EditarUsuario]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ActualizarCliente]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ActualizarUsuario]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarContactos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabecera]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabeceraSoftland]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalle]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalleSoftland]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarUsuario]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarClientes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarDirecDespa]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVCabecera]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarNVCabecera]
	@NVNumero   INT
AS
BEGIN
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
		nv.NVNumero = @NVNumero
END

GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVDetalle]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarParametrosUsuarios]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarProducto]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarProductoRapido]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarUsuarios]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_EliminarUsuario]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListaProductos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCentroDeCosto]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarClientes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarClientesTodos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCondicionesDeVenta]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarContactos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosAprobados]    Script Date: 21-10-2019 9:35:45 ******/
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
	a.EstadoNP, 
	ISNULL(a.RutSolicitante,0) as RutSolicitante
	from [dbo].[DS_NotasVenta] a
	inner join ['+@pv_BaseDatos+'].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	where 
	a.nvEstado = ''A''
'
EXEC (@query)

--SELECT * FROM dbo.DS_NotasVenta dnv	SELECT * FROM dbo.DS_NotasVentaDetalle dnvd	
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosPendientes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarListaDePrecio]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarMisClientes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuarios]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuariosTipos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland2]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListaTallaColorProducto]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ModificarNVCabecera]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ModificarParametrosUsuarios]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ObtenerCredito]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_Credito_Cliente]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_cwmovimFV]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_DeudaClienteDia]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_DeudaClienteTotal]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[insertaNVSoftland]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_BuscarProducto]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_DeudaClientes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarClientesCodAuxRut]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarContactos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarDocumentos]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarListaDePrecio]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarNVDETALLENM]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarNVNM]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarVendorVenCod]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[Js_NvSoftland]    Script Date: 21-10-2019 9:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Js_NvSoftland] 
	as begin
	select max([NVNumero]) as NVNumero FROM KUPPEL.[softland].[nw_nventa]
	end
GO
/****** Object:  StoredProcedure [dbo].[RRA_ActualizaEstadoNW]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_Ciudad]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_Comuna]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_DatosCorreoVend]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_EmailVendedor]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_Giro]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_LOGIN]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_Menu]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetCodVendedor]    Script Date: 21-10-2019 9:35:45 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 21-10-2019 9:35:45 ******/
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
USE [master]
GO
ALTER DATABASE [DSNotaVenta] SET  READ_WRITE 
GO
