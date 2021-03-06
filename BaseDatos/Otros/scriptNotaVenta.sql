USE [master]
GO
/****** Object:  Database [DSTexsa_NV]    Script Date: 11-10-2019 10:56:18 ******/
CREATE DATABASE [DSTexsa_NV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DSTexsa_NV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DSTexsa_NV.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DSTexsa_NV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DSTexsa_NV_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DSTexsa_NV] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DSTexsa_NV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DSTexsa_NV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET ARITHABORT OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DSTexsa_NV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DSTexsa_NV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DSTexsa_NV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DSTexsa_NV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET RECOVERY FULL 
GO
ALTER DATABASE [DSTexsa_NV] SET  MULTI_USER 
GO
ALTER DATABASE [DSTexsa_NV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DSTexsa_NV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DSTexsa_NV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DSTexsa_NV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DSTexsa_NV] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DSTexsa_NV', N'ON'
GO
ALTER DATABASE [DSTexsa_NV] SET QUERY_STORE = OFF
GO
USE [DSTexsa_NV]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [DSTexsa_NV]
GO
/****** Object:  UserDefinedFunction [dbo].[func_CreditoCliente2]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_CreditoCliente2] ( @Codaux VARCHAR(10))	  
RETURNS Numeric(18,2) AS
BEGIN

DECLARE @Saldo Numeric(18,2)

Set @Saldo = (Select CONVERT(numeric(18,2),vcl.MtoCre)
From KUPPEL.softland.cwtcvcl as vcl INNER JOIN KUPPEL.softland.CWDocSaldos as doc on
 vcl.CodAux = @CodAux and doc.CodAux= vcl.CodAux 
Group by vcl.MtoCre )

Return @Saldo

end
GO
/****** Object:  UserDefinedFunction [dbo].[func_SaldoClienteCW]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_SaldoClienteCW] ( @Codaux VARCHAR(10))	  
RETURNS Float AS
BEGIN

DECLARE @Saldo Float
DECLARE @SaldoFacPend Float
DECLARE @SaldoDoctoContab Float



SELECT @SaldoFacPend = (SUM(movim.MovDebe)-SUM(movim.MovHaber))  FROM [KUPPEL].[Softland].[cwmovim] AS movim
			LEFT JOIN [KUPPEL].[Softland].[cwcpbte] pbte ON pbte.CpbAno=movim.CpbAno AND pbte.cpbNum=movim.CpbNum
			LEFT JOIN [KUPPEL].[Softland].[cwpctas] ctas ON ctas.PCCODI=movim.PctCod
			LEFT JOIN [KUPPEL].[Softland].[cwtauxi] auxi ON auxi.CodAux=movim.CodAux
			LEFT JOIN [KUPPEL].[Softland].[iw_gsaen] gsaen ON gsaen.folio=movim.MovNumDocRef
			WHERE pbte.CpbEst='V' AND ctas.PCCODI in ('1-1-03','1-1-16') AND movim.CpbAno = YEAR(GETDATE()) AND movim.codaux=@Codaux

-- en ABUTEX 
-- es 1-1-03 clientes
-- y 1-1-16 CLIENTES CON BOLETA                                         

SELECT @SaldoDoctoContab = (Sum(movin.movdebe) - sum(movin.movhaber))
			FROM [KUPPEL].[Softland].[cwmovim] movin 
			LEFT JOIN [KUPPEL].[Softland].cwcpbte pbte on pbte.cpbano = movin.cpbano and pbte.cpbnum = movin.cpbnum
			LEFT JOIN [KUPPEL].[Softland].cwtauxi auxi on movin.CodAux = auxi.CodAux
			WHERE pbte.cpbest = 'V' AND movin.codaux=@codaux group by movin.codaux
			Having ((Sum(movin.movdebe) - sum(movin.movhaber)) <> 0) and max(auxi.nomaux) is not null and max(movin.CpbAno) = 2015
			order by max(auxi.nomaux),DATEPART (week,max(movin.MovFv)) asc

if @SaldoFacPend is null
   Set @SaldoFacPend = 0 
if @SaldoDoctoContab is null
   Set @SaldoDoctoContab = 0 

   SET @Saldo = @SaldoFacPend +  @SaldoDoctoContab

if @Saldo is null
   Set @Saldo = 0 

Return @Saldo
END

GO
/****** Object:  UserDefinedFunction [dbo].[JS_cwmovimFV]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[JS_cwmovimFV] (@cod as float)
RETURNS datetime
AS
BEGIN
DECLARE @Fecha Datetime

Set @Fecha = (select min(MovFv)from  KUPPEL.softland.cwmovim cwom
where cwom.MovNumDocRef =@cod and ttdcod= 'FV' )

if @Fecha = NULL
set @Fecha = ''

Return @Fecha
END
GO
/****** Object:  UserDefinedFunction [dbo].[JS_DeudaClienteDia]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  UserDefinedFunction [dbo].[JS_DeudaClienteTotal]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  function [dbo].[JS_DeudaClienteTotal](@cod as varchar(10))
RETURNS numeric
AS
BEGIN
DECLARE @deuda numeric

Set @deuda = (SELECT convert (numeric,( (sum(DEBE)) - (sum(HABER)) ))  from  KUPPEL.softland.CWDocSaldos
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
/****** Object:  UserDefinedFunction [dbo].[stock2018]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  UserDefinedFunction [dbo].[stockListas]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  View [dbo].[JS_DebeCliente2]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JS_DebeCliente2] AS

SELECT distinct A.CODAUX,DEBE,HABER,A.MOVNUMDOCREF,[dbo].[JS_cwmovimFV](a.MOVNUMDOCREF) as FV from KUPPEL.softland.CWDocSaldos AS A
where 
[dbo].[JS_cwmovimFV](a.MOVNUMDOCREF) < getdate()
and MONTH([dbo].[JS_cwmovimFV](a.MOVNUMDOCREF)) < GETDATE()
GO
/****** Object:  Table [dbo].[DS_Estado]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_Estado](
	[estado] [datetime] NULL,
	[proceso] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_Imagenes]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  Table [dbo].[DS_NotasVenta]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_NotasVenta](
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
	[EstadoNP] [varchar](1) NULL,
	[CodBodeWms] [varchar](10) NULL,
	[CodLugarDocto] [varchar](30) NULL,
	[RutTransportista] [varchar](20) NULL,
 CONSTRAINT [DSnw_nventa_PK] PRIMARY KEY CLUSTERED 
(
	[NVNumero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_NotasVentaDetalle]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_NotasVentaDetalle](
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
 CONSTRAINT [DSnw_detnv_PK] PRIMARY KEY CLUSTERED 
(
	[NVNumero] ASC,
	[nvLinea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_ParametrosUsuario]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DS_ParametrosUsuario](
	[Aprobador] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DS_Usuarios]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  Table [dbo].[DS_UsuariosTipos]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 11-10-2019 10:56:18 ******/
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
create table DS_Empresa
(
	Id int identity(1, 1)
,	Nombre varchar(100)
,	BaseDatos varchar(100)
)

go

create table DS_UsuarioEmpresa
(
	Id int identity(1, 1)
,	IdUsuario int
,	IdEmpresa int
,	[VenCod] [nchar](10) NULL
)
go
ALTER TABLE [dbo].[DS_NotasVenta] ADD  CONSTRAINT [DF_DS_NotasVenta_EstadoNP]  DEFAULT ('P') FOR [EstadoNP]
GO
ALTER TABLE [dbo].[DS_Usuarios] ADD  CONSTRAINT [DF_DS_Usuarios_Estado]  DEFAULT ((1)) FOR [Estado]
GO
/****** Object:  StoredProcedure [dbo].[DS_SET_ActualizaCorreo]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ActualizarCliente]    Script Date: 11-10-2019 10:56:18 ******/
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
 @Email varchar(100)  
AS  
BEGIN  
 UPDATE [KUPPEL].[softland].[cwtauxi]  
  SET RutAux=@RutAux, NomAux=@NomAux, DirAux=@DirAux, EMail=@Email WHERE CodAux=@CodAux  
  
 UPDATE [KUPPEL].[softland].[cwtaxco]  
  SET NomCon=@NomCon, FonCon=@FonCon WHERE CodAuc=@CodAux  

  SELECT	Verificador = Cast(1 as bit)
  ,			Mensaje = 'Se actualiza cliente' 

END  
GO
/****** Object:  StoredProcedure [dbo].[FR_ActualizarUsuario]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarContactos]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVCabecera]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_AgregarNVCabecera]
	@NVNumero int,
	@NumOC varchar(12),
	@NumReq int
as
BEGIN
	DECLARE @maxnumero int

	SET @maxnumero = (SELECT ISNULL(max([NVNumero]),0) 'maxnumero' FROM [DSTexsa_NV].[dbo].[DS_NotasVenta])	
	SET @maxnumero=@maxnumero+1
	
	INSERT INTO[DSTexsa_NV].[dbo].[DS_NotasVenta]([NVNumero],[NumOC],[NumReq])
		VALUES(@maxnumero,@NumOC,@NumReq)	

	SELECT max([NVNumero]) 'NVNumero' FROM [DSTexsa_NV].[dbo].[DS_NotasVenta]	
END 
GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarNVDetalle]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_AgregarNVDetalle]

@NVNumero int,
@nvLinea float,
@nvCorrela float,
@nvFecCompr datetime,
@CodProd varchar(20),
@nvCant float,
@nvPrecio float,
@nvEquiv float,
@nvSubTotal float,
@nvDPorcDesc01 float,
@nvDDescto01 float,
@nvDPorcDesc02 float,
@nvDDescto02 float,
@nvDPorcDesc03 float,
@nvDDescto03 float,
@nvDPorcDesc04 float,
@nvDDescto04 float,
@nvDPorcDesc05 float,
@nvDDescto05 float,
@nvTotDesc float,
@nvTotLinea float,
@nvCantDesp float,
@nvCantProd float,
@nvCantFact float,
@nvCantDevuelto float,
@nvCantNC float,
@nvCantBoleta float,
@nvCantOC float,
@DetProd text,
@CheckeoMovporAlarmaVtas varchar(1),
@KIT varchar(20),
@CodPromocion int,
@CodUMed varchar(6),
@CantUVta float,
@Partida varchar(20),
@Pieza varchar(20)




as
begin

	declare @codumedRRA varchar(10)
	set @codumedRRA = (select CodUMed from [KUPPEL].softland.iw_tprod where codprod = @CodProd )

	insert into [dbo].[DS_NotasVentaDetalle]
	([NVNumero],[nvLinea],[nvCorrela],[nvFecCompr],[CodProd],[nvCant],[nvPrecio],[nvEquiv],[nvSubTotal],[nvDPorcDesc01],
	[nvDDescto01],[nvDPorcDesc02],[nvDDescto02],[nvDPorcDesc03],[nvDDescto03],[nvDPorcDesc04],[nvDDescto04],[nvDPorcDesc05],
	[nvDDescto05],[nvTotDesc],[nvTotLinea],[nvCantDesp],[nvCantProd],[nvCantFact],[nvCantDevuelto],[nvCantNC],[nvCantBoleta],
	[nvCantOC],[DetProd],[CheckeoMovporAlarmaVtas],[KIT],[CodPromocion],[CodUMed],[CantUVta],[Partida],[Pieza],[FechaVencto])
	values 
	(@NVNumero,@nvLinea,@nvCorrela,@nvFecCompr,@CodProd,@nvCant,@nvPrecio,@nvEquiv,@nvSubTotal,@nvDPorcDesc01,@nvDDescto01,
	@nvDPorcDesc02,@nvDDescto02,@nvDPorcDesc03,@nvDDescto03,@nvDPorcDesc04,@nvDDescto04,@nvDPorcDesc05,@nvDDescto05,
	@nvTotDesc,@nvTotLinea,@nvCantDesp,@nvCantProd,@nvCantFact,@nvCantDevuelto,@nvCantNC,@nvCantBoleta,
	--@nvCantOC,@DetProd,@CheckeoMovporAlarmaVtas,@KIT,@CodPromocion,@CodUMed,@CantUVta,@Partida,@Pieza)
	--@nvCantOC,@DetProd,@CheckeoMovporAlarmaVtas,@KIT,@CodPromocion,@codumedRRA,@CantUVta,@Partida,@Pieza)
	--@nvCantOC,@DetProd,@CheckeoMovporAlarmaVtas,@KIT,@CodPromocion,@codumedRRA,@CantUVta,NULL,NULL,NULL)
	@nvCantOC,@DetProd,@CheckeoMovporAlarmaVtas,NULL,NULL,@codumedRRA,@CantUVta,NULL,NULL,NULL)
	
end

--select CodUMed from golden.softland.iw_tprod where codprod like '%0301001%'

GO
/****** Object:  StoredProcedure [dbo].[FR_AgregarUsuario]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_AgregarUsuario]
	@Usuario	varchar(10),
	@email	varchar(50),
	@Contrasena varchar(150),
	@tipoUsuario	varchar(50),
	@venCod NCHAR(10)

 AS
DECLARE @CantVenCod int
SET @CantVenCod	= (SELECT count(*) AS cantidad FROM dbo.DS_Usuarios du WHERE du.VenCod = @venCod)
if(@CantVenCod = 0)
BEGIN
	INSERT INTO [dbo].[DS_Usuarios] ([Usuario],[Contrasena],[email],[tipoUsuario],[venCod])
		VALUES(@Usuario, PWDENCRYPT(@Contrasena) , @email, @tipoUsuario,@venCod)
END
ELSE
SELECT	null


GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarClientes]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarDirecDespa]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarDirecDespa]
 @CodAxD  varchar(10)
as
begin
	select DirDch, ComDch, nomdch from [KUPPEL].[Softland].cwtauxd
	where CodAxD =  @CodAxD 

end

GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVCabecera]    Script Date: 11-10-2019 10:56:18 ******/
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
		[DSTexsa_NV].[dbo].[DS_NotasVenta] nv INNER JOIN
		[KUPPEL].[softland].[cwtauxi] cliente ON (cliente.CodAux collate Modern_Spanish_CI_AS = nv.CodAux) INNER JOIN
		[KUPPEL].[softland].cwtvend vend ON (vend.VenCod collate Modern_Spanish_CI_AS = nv.VenCod) INNER JOIN
		[KUPPEL].[softland].cwtconv conven ON (conven.CveCod collate Modern_Spanish_CI_AS = nv.CveCod) INNER JOIN
		[KUPPEL].[softland].iw_tlispre lista ON (lista.CodLista collate Modern_Spanish_CI_AS = nv.CodLista) INNER JOIN
		[KUPPEL].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = nv.CodiCC)
	WHERE
		nv.NVNumero = @NVNumero
END

GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarNVDetalle]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarNVDetalle]
 @NVNumero   int
as
begin

select a.nvLinea,  a.CodProd, b.DesProd, a.nvCant, a.CodUMed, a.nvPrecio, a.nvSubTotal, ROUND(a.nvDPorcDesc01,0) as nvDPorcDesc01 , a.nvTotLinea  ,
Stock = [DSTexsa_NV].[dbo].[stock2018](tp.CodProd)
from [dbo].[DS_NotasVentaDetalle] a
inner join [KUPPEL].[softland].[iw_tprod] b on b.CodProd collate Modern_Spanish_CI_AS = a.CodProd 
LEFT JOIN [KUPPEL].[softland].[iw_tprod] AS tp on a.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
where a.NVNumero = @NVNumero 
order by a.nvLinea
end



GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarParametrosUsuarios]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_BuscarParametrosUsuarios]

as
begin
		select * from [dbo].[DS_ParametrosUsuario]
end


GO
/****** Object:  StoredProcedure [dbo].[FR_BuscarProducto]    Script Date: 11-10-2019 10:56:18 ******/
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
		Stock = [DSTexsa_NV].[dbo].[stock2018](tp.CodProd)
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarProductoRapido]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_BuscarUsuarios]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_EliminarUsuario]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListaProductos]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_ListaProductos]							*/
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
		,			Stock = [DSTexsa_NV].[dbo].[stock2018](tp.CodProd)  
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCentroDeCosto]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarCentroDeCosto]

as
begin

select * from [KUPPEL].[softland].[cwtccos] where activo = 'S' and DescCC != '' --and CodiCC = 002

end
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarClientes]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarClientes]
	as
	select clientes.CodAux,clientes.[NomAux],clientes.[RutAux],
	clientes.[DirAux] ,clientes.[DirNum], contacto.[NomCon] , 
	contacto.[FonCon]
    from [KUPPEL].[softland].[cwtauxi] clientes
	inner join [KUPPEL].[softland].[cwtaxco] contacto on clientes.CodAux = contacto.CodAuc 


GO
/****** Object:  StoredProcedure [dbo].[FR_ListarClientesTodos]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarCondicionesDeVenta]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarCondicionesDeVenta]
@CodAux varchar(15)
as
begin

declare @contar  int
set @contar = 
(
select count(ven.CveDes) 'contar' from 
[KUPPEL].[softland].[cwtauxi] cliente 
inner join [KUPPEL].[softland].cwtcvcl condicion on cliente.CodAux = condicion.CodAux
inner join [KUPPEL].[softland].cwtconv ven on condicion.ConVta = ven.CveCod
where condicion.ConVta!='' and  condicion.ConVta is NOT null 
and cliente.CodAux = @CodAux
)

if(@contar = 0)
BEGIN
	select cvecod as ConVta,CveDes from [KUPPEL].[softland].cwtconv 
	where cvecod = '005' 
END
else 
BEGIN
	select ven.CveDes,condicion.ConVta,cliente.CodAux from 
	[KUPPEL].[softland].[cwtauxi] cliente 
	inner join [KUPPEL].[softland].cwtcvcl condicion on cliente.CodAux = condicion.CodAux
	inner join [KUPPEL].[softland].cwtconv ven on condicion.ConVta = ven.CveCod
	where condicion.ConVta!='' and  condicion.ConVta is NOT null 
	and cliente.CodAux = @CodAux
END
end


GO
/****** Object:  StoredProcedure [dbo].[FR_ListarContactos]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarContactos]
	@CodAuc varchar(10),
	@NomCon	varchar(30)
as
BEGIN
	--DECLARE @contacto decimal;

	--SET @contacto = (
	--	SELECT
	--		count(*) as 'CodAux'    
	--	FROM
	--		KUPPEL.softland.cwtauxi dir INNER JOIN 
	--		KUPPEL.softland.cwtaxco ven ON ven.CodAuc = dir.CodAux  
	--	WHERE
	--		CodAuc = @CodAuc
	--	GROUP BY ven.NomCon)
		
	--IF(@contacto IS NULL )
	--	BEGIN 
	--		INSERT INTO KUPPEL.softland.cwtaxco ([CodAuc],[NomCon]) values (@CodAuc, @NomCon)
	--		SELECT
	--			ven.CodAuc as 'CodAux', ven.NomCon     
	--		FROM
	--			KUPPEL.softland.cwtauxi dir INNER JOIN
	--			KUPPEL.softland.cwtaxco ven ON ven.CodAuc = dir.CodAux 
	--		WHERE
	--			CodAuc = @CodAuc
	--	END 
	--ELSE 
		--BEGIN 
			SELECT
				ven.CodAuc as 'CodAux', ven.NomCon     
			FROM
				KUPPEL.softland.cwtauxi dir INNER JOIN 
				KUPPEL.softland.cwtaxco ven ON ven.CodAuc = dir.CodAux 
			WHERE
				CodAuc = @CodAuc
		END 


--end
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosAprobados]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarDocumentosAprobados]
	as
	select  a.NVNumero, clientes.[NomAux], clientes.[RutAux], a.nvFem, a.CodLista, a.NomCon, a.nvNetoAfecto, a.TotalBoleta, a.EstadoNP, ISNULL(a.RutSolicitante,0) as RutSolicitante
	from [dbo].[DS_NotasVenta] a
	inner join [KUPPEL].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	where 
	a.EstadoNP = 'A' --and 
	--a.CodVenWeb = '5' 
	-- borra condicion codvenweb

	--update [DSSNACKCENTER].[dbo].[DS_NotasVenta] set EstadoNP = 'P'

GO
/****** Object:  StoredProcedure [dbo].[FR_ListarDocumentosPendientes]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarDocumentosPendientes]
	as
	select distinct  [dbo].[stockListas] (a.nvnumero ) as stocklista,
	
	a.NVNumero, clientes.[NomAux],clientes.[RutAux],a.nvEstado, a.nvFem, a.nvFeEnt, a.CodLista, a.NomCon, a.nvNetoAfecto, a.TotalBoleta, a.EstadoNP, ISNULL(a.RutSolicitante,0) as RutSolicitante, [DSTexsa_NV].[dbo].[func_SaldoClienteCW](a.CodAux ) 'Saldo'
	from [DSTexsa_NV].[dbo].[DS_NotasVenta] a
	inner join [KUPPEL].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	LEFT JOIN [dbo].[DS_NotasVentaDetalle] b on a.NVNumero = b.NVNumero
	LEFT JOIN [KUPPEL].[softland].[iw_tprod] AS tp on b.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
	where a.EstadoNP = 'P' --AND a.CodVenWeb = '5'
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarListaDePrecio]    Script Date: 11-10-2019 10:56:18 ******/
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
)
as  
BEGIN  
	DECLARE @contar  int  
  
	SET @contar =	(
						SELECT	count(*)  
						FROM	[KUPPEL].[softland].[cwtauxi] cliente 
									INNER JOIN [KUPPEL].[softland].cwtcvcl condicion 
										on cliente.CodAux = condicion.CodAux 
									INNER JOIN [KUPPEL].[softland].iw_tlispre lista 
										on condicion.codlista = lista.CodLista  
						WHERE	condicion.codlista !='' 
						AND		condicion.codlista IS NOT NULL 
						AND		cliente.CodAux = @CodAux
					)  
	IF(@contar = 0)	BEGIN  
		Select	Codlista = CodLista
		,		DesLista = DesLista
		from	[KUPPEL].[softland].iw_tlispre 
		where	codlista = 'LPW'  
	END
	ELSE BEGIN
		Select	Codlista = condicion.codlista
		,		DesLista = lista.DesLista
		,		CodAux = condicion.codaux   
		FROM	[KUPPEL].[softland].[cwtauxi] cliente 
			INNER JOIN [KUPPEL].[softland].cwtcvcl condicion 
				on cliente.CodAux = condicion.CodAux 
			INNER JOIN [KUPPEL].[softland].iw_tlispre lista 
				on condicion.codlista = lista.CodLista
		WHERE	condicion.codlista != ''
		AND		condicion.codlista IS NOT NULL 
		AND		cliente.CodAux = @CodAux  
	END  
END  
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarMisClientes]    Script Date: 11-10-2019 10:56:18 ******/
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
		[DSTexsa_NV].[dbo].[DS_Usuarios] D ON (b.VenCod collate Modern_Spanish_CI_AS = d.VenCod) 
			LEFT JOIN 	KUPPEL.softland.cwtcvcl as vcl on vcl.CodAux = A.CodAux
		
	WHERE
		d.ID =@ID

END
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuarios]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ListarUsuarios]
	as
	select usuario.Usuario,usuario.id, usuario.email, tipo.tipoUsuario
	from [dbo].[DS_Usuarios] usuario
	inner join [dbo].[DS_UsuariosTipos] tipo on usuario.tipoUsuario = tipo.id
	where estado = 1


GO
/****** Object:  StoredProcedure [dbo].[FR_ListarUsuariosTipos]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland2]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FR_ListarVendedorSoftland2]
	
AS

		SELECT
			VenCod = vendedor.VenCod,
			VenDes = vendedor.VenCod + ' - ' + vendedor.VenDes,
			CodTipV = ISNULL(vendedor.CodTipV,''),
			EMail = ISNULL(vendedor.EMail,''),
			Usuario = ISNULL(vendedor.Usuario,'')
		FROM
			[KUPPEL].[Softland].[cwtvend] vendedor
	

GO
/****** Object:  StoredProcedure [dbo].[FR_ModificarNVCabecera]    Script Date: 11-10-2019 10:56:18 ******/
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
	update [DSTexsa_NV].[dbo].[DS_NotasVenta]
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
	set @cliente = (select (cliente.CodAux+' - '+cliente.NomAux) as Cliente from [DSTexsa_NV].dbo.[DS_NotasVenta] nv inner join [KUPPEL].[softland].[cwtauxi] cliente on cliente.CodAux = nv.CodAux  collate Modern_Spanish_CI_AS where nv.NVNumero = @NVNumeroc)
	set @Usuarioc = (select (vend.VenCod+' - '+vend.VenDes) as usuario from [DSTexsa_NV].dbo.[DS_NotasVenta] nv inner join [KUPPEL].[softland].cwtvend vend on vend.VenCod = nv.VenCod  collate Modern_Spanish_CI_AS where nv.NVNumero = @NVNumeroc)
	set @direccion = (select CodLugarDesp from  [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @fpedido = (select CONVERT (char(10), nvFem, 103) as fecha from  [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @fentrega = (select CONVERT (char(10), nvFeEnt, 103) as nvFeEnt from [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @Obser = (select nvObser FROM [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @total = (select REPLACE(CONVERT(varchar, convert(money, nvNetoAfecto), 1),'.00','') as monto from [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero = @NVNumeroc)
	set @correo = 'frojas@disofi.cl;'
	set @totalboleta1 = (select REPLACE(CONVERT(varchar, convert(money, TotalBoleta), 1),'.00','') as monto from [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero=@NVNumeroc) 
	set @iva = (select REPLACE(CONVERT(varchar, convert(money, TotalBoleta-nvNetoAfecto), 1),'.00','') as monto from  [DSTexsa_NV].dbo.[DS_NotasVenta] where NVNumero=@NVNumeroc) 
	

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
				from [DSTexsa_NV].dbo.DS_NotasVentaDetalle as a
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
/****** Object:  StoredProcedure [dbo].[FR_ModificarParametrosUsuarios]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[FR_ModificarParametrosUsuarios]
@Aprobador int
as
begin
		
UPDATE [dbo].[DS_ParametrosUsuario]
SET Aprobador = @Aprobador

end



GO
/****** Object:  StoredProcedure [dbo].[insertaNVSoftland]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_BuscarProducto]    Script Date: 11-10-2019 10:56:18 ******/
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
			Stock = [DSTexsa_NV].[dbo].[stock2018](tp.CodProd),
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
/****** Object:  StoredProcedure [dbo].[JS_DeudaClientes]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarClientesCodAuxRut]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarClientesCodAuxRut]
		@vchrRutAux	VARCHAR(20)='',
		@vchrCodAux	VARCHAR(10)=''
		as
		BEGIN
-- ==========================================================================================
-- Lista los clientes filtrados por Codigo Aux y RUT Aux
-- ==========================================================================================
			SELECT
				CodAux = clientes.CodAux,
				NomAux = clientes.[NomAux],
				RutAux = clientes.[RutAux],
				DirAux = clientes.[DirAux],
				DirNum = ISNULL(clientes.[DirNum],''),
				NomCon = contacto.[NomCon],
				FonCon = ISNULL(contacto.[FonCon],''),
				EMail = ISNULL(clientes.EMail,''),
				Notas= clientes.Notas
			FROM
				[KUPPEL].[softland].[cwtauxi] clientes left JOIN
				[KUPPEL].[softland].[cwtaxco] contacto ON (clientes.CodAux = contacto.CodAuc)
			WHERE
				CodAux = @vchrCodAux AND
				RutAux = (CASE @vchrRutAux WHEN '' THEN RutAux ELSE @vchrRutAux END)
		END

GO
/****** Object:  StoredProcedure [dbo].[JS_ListarContactos]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarContactos]
		--@vchrRutAux	VARCHAR(20)='',
		@vchrCodAux	VARCHAR(50)=''
		as
		BEGIN
-- ==========================================================================================
-- Lista los clientes filtrados por Codigo Aux y RUT Aux
-- ==========================================================================================
			SELECT
				CodAux = contacto.CodAuc,
				NomCon = contacto.[NomCon],
				FonCon = ISNULL(contacto.[FonCon],''),
				EMail = ISNULL(contacto.EMail,'')
			FROM
				KUPPEL.[softland].[cwtaxco] contacto
			WHERE
				contacto.NomCon = @vchrCodAux
		end
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarDocumentos]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[JS_ListarDocumentos]
	as
	select distinct  [dbo].[stockListas] (a.nvnumero ) as stocklista,
	
	a.NVNumero, clientes.[NomAux],clientes.[RutAux],a.nvEstado as nvEstado, a.nvFem, a.nvFeEnt, a.CodLista, a.NomCon, a.nvNetoAfecto, a.TotalBoleta, a.EstadoNP, ISNULL(a.RutSolicitante,0) as RutSolicitante, [DSTexsa_NV].[dbo].[func_SaldoClienteCW](a.CodAux ) 'Saldo'
	from [[DSTexsa_NV]].[dbo].[DS_NotasVenta] a
	inner join [KUPPEL].[softland].[cwtauxi] clientes on  clientes.CodAux collate Modern_Spanish_CI_AS = a.CodAux 
	LEFT JOIN [dbo].[DS_NotasVentaDetalle] b on a.NVNumero = b.NVNumero
	LEFT JOIN [KUPPEL].[softland].[iw_tprod] AS tp on b.CodProd = tp.CodProd collate SQL_Latin1_General_CP1_CI_AS
	where a.EstadoNP = 'A' --AND a.CodVenWeb = '5'

GO
/****** Object:  StoredProcedure [dbo].[JS_ListarListaDePrecio]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarMisClientes]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[JS_ListarMisClientes]
	@cod nchar(10),
	@ID int
AS
BEGIN
	SELECT
		c.CodAux,
		c.NomAux,
		c.DirAux,
		c.DirNum, 
		CASE WHEN c.FonAux1 IS NOT NULL THEN c.FonAux1 WHEN c.FonAux2 IS NOT NULL THEN c.FonAux2 ELSE c.FonAux3 END AS 'FonAux1',
		C.Notas   ,
		 [dbo].[JS_DeudaClienteDia](c.CodAux) as DeudaVencida,
		 [dbo].[JS_DeudaClienteTotal](c.CodAux) as Deuda,
		 case when ([dbo].[func_CreditoCliente2](c.CodAux)- [dbo].[JS_DeudaClienteTotal](c.CodAux)) < 0 then '$0'
		 else 
		 format(([dbo].[func_CreditoCliente2](c.CodAux)- [dbo].[JS_DeudaClienteTotal](c.CodAux)),'$0')  end as Credito 
	FROM
		[KUPPEL].softland.[cwtauxven] A INNER JOIN
		[KUPPEL].softland.cwtauxi C ON (c.CodAux = a.CodAux) INNER JOIN
		[KUPPEL].softland.cwtvend B ON (b.VenCod = a.VenCod) INNER JOIN 
		[DSTexsa_NV].[dbo].[DS_Usuarios] D ON (b.VenCod collate Modern_Spanish_CI_AS = d.VenCod) 
		LEFT JOIN 	[KUPPEL].softland.cwtcvcl as vcl on vcl.CodAux = A.CodAux
	WHERE
		D.VenCod = @cod and D.ID = @ID

END
GO
/****** Object:  StoredProcedure [dbo].[JS_ListarNVDETALLENM]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[JS_ListarNVNM]    Script Date: 11-10-2019 10:56:18 ******/
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
				[DSTexsa_NV].[dbo].[DS_NotasVenta] nv INNER JOIN
				[KUPPEL].[softland].[cwtauxi] cliente ON (cliente.CodAux collate Modern_Spanish_CI_AS = nv.CodAux) INNER JOIN
				[KUPPEL].[softland].cwtvend vend ON (vend.VenCod collate Modern_Spanish_CI_AS = nv.VenCod) INNER JOIN
				[KUPPEL].[softland].cwtconv conven ON (conven.CveCod collate Modern_Spanish_CI_AS = nv.CveCod) INNER JOIN
				[KUPPEL].[softland].iw_tlispre lista ON (lista.CodLista collate Modern_Spanish_CI_AS = nv.CodLista) INNER JOIN
				[KUPPEL].[softland].[cwtccos] cc ON (cc.CodiCC collate Modern_Spanish_CI_AS = nv.CodiCC)
			WHERE
				nv.NVNumero = @intNVNumero
		END

GO
/****** Object:  StoredProcedure [dbo].[JS_ListarVendorVenCod]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[JS_ListarVendorVenCod]
@VenCod	VARCHAR(10)
as
BEGIN
-- ==========================================================================================
-- Lista los clientes filtrados por Codigo Aux y RUT Aux
-- ==========================================================================================
SELECT du.Nombre, du.VenCod,du.email
FROM dbo.DS_Usuarios du
WHERE du.VenCod	= @VenCod
END

GO
/****** Object:  StoredProcedure [dbo].[Js_NvSoftland]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Js_NvSoftland] 
	as begin
	select max([NVNumero]) as NVNumero FROM KUPPEL.[softland].[nw_nventa]
	end
GO
/****** Object:  StoredProcedure [dbo].[RRA_ActualizaEstadoNW]    Script Date: 11-10-2019 10:56:18 ******/
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
	set @obser = (select nvObser from [DSTexsa_NV].dbo.DS_NotasVenta where NVNumero = @nvNumero )

	update [DSTexsa_NV].dbo.DS_NotasVenta  set EstadoNP = 'A', nvObser = 'N. Int: '+@nvNumero+' Obs: '+@obser  where nvnumero = @nvnumero

	exec [DSTexsa_NV].dbo.insertaNVSoftland @nvnumero

	--select max(nvnumero) as nvnumero from TAVELLI1.softland.nw_nventa

	set @variable = (select max(nvnumero) as nvnumero from [KUPPEL].softland.nw_nventa)

	set @obser = (select nvObser from [DSTexsa_NV].dbo.DS_NotasVenta where NVNumero = @nvNumero )

	UPDATE [DSTexsa_NV].dbo.DS_NotasVenta set RutSolicitante = @variable, nvObser = ' NV: '+@variable+' Obs: '+@obser  where nvnumero = @nvNumero


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
set @correo = (select usu.email from [KUPPEL].softland.nw_nventa nv inner join [DSTexsa_NV].[dbo].DS_Usuarios usu on  usu.Usuario  collate Modern_Spanish_CI_AS = nv.UsuarioGeneraDocto where nv.NVNumero=@variable)
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
/****** Object:  StoredProcedure [dbo].[SP_GET_DatosCorreoVend]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_EmailVendedor]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_LOGIN]    Script Date: 11-10-2019 10:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GET_LOGIN]  
@Nombre varchar(15),       
@Contrasena varchar(50)       
as set nocount on       
select u.Id,u.Usuario,u.TipoUsuario,u.VenCod  
from DS_Usuarios u       
where u.Usuario = @Nombre and u.Contrasena = @Contrasena AND u.Estado = 1  
set nocount OFF       
      
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Menu]    Script Date: 11-10-2019 10:56:18 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 11-10-2019 10:56:18 ******/
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
		[DSTexsa_NV].dbo.DS_Usuarios usuario on (usuario.VenCod collate SQL_Latin1_General_CP1_CI_AI = vendedor.VenCod) INNER JOIN
		[DSTexsa_NV].dbo.DS_UsuariosTipos tipo ON (usuario.tipoUsuario = tipo.id)
	WHERE
		usuario.Usuario = @usuario AND
		PWDCOMPARE(@password,usuario.Contrasena) = 1
END

GO
DROP TABLE [dbo].[DS_NotasVenta]
go

CREATE TABLE [dbo].[DS_NotasVenta]
(
	/*-----------------------------------------------------------------------------------------------------------*/
	/*-------------------------------- C A M P O S   D E   D S N O T A V E N T A --------------------------------*/
	/*-----------------------------------------------------------------------------------------------------------*/
	[Id] [int] IDENTITY(1, 1),					[EstadoNP] [varchar](1) NULL
	/*-----------------------------------------------------------------------------------------------------------*/
	/*----------------------------------- C A M P O S   D E   S O F T L A N D -----------------------------------*/
	/*-----------------------------------------------------------------------------------------------------------*/
,	[NVNumero] [int] NOT NULL,					[nvFem] [datetime] NULL,			[nvEstado] [varchar](1) NULL
,	[nvEstFact] [int] NULL,						[nvEstDesp] [int] NULL,				[nvEstRese] [int] NULL
,	[nvEstConc] [int] NULL,						[CotNum] [int] NULL,				[NumOC] [varchar](12) NOT NULL
,	[nvFeEnt] [datetime] NULL,					[CodAux] [varchar](10) NULL,		[VenCod] [varchar](4) NULL
,	[CodMon] [varchar](2) NULL,					[CodLista] [varchar](3) NULL,		[nvObser] [text] NULL
,	[nvCanalNV] [varchar](3) NULL,				[CveCod] [varchar](3) NULL,			[NomCon] [varchar](30) NULL
,	[CodiCC] [varchar](8) NULL,					[CodBode] [varchar](10) NULL,		[nvSubTotal] [float] NULL
,	[nvPorcDesc01] [float] NULL,				[nvDescto01] [float] NULL,			[nvPorcDesc02] [float] NULL
,	[nvDescto02] [float] NULL,					[nvPorcDesc03] [float] NULL,		[nvDescto03] [float] NULL
,	[nvPorcDesc04] [float] NULL,				[nvDescto04] [float] NULL,			[nvPorcDesc05] [float] NULL
,	[nvDescto05] [float] NULL,					[nvMonto] [float] NULL,				[nvFeAprob] [datetime] NULL
,	[NumGuiaRes] [int] NULL,					[nvPorcFlete] [float] NULL,			[nvValflete] [float] NULL
,	[nvPorcEmb] [float] NULL,					[nvValEmb] [float] NULL,			[nvEquiv] [float] NULL
,	[nvNetoExento] [float] NULL,				[nvNetoAfecto] [float] NULL,		[nvTotalDesc] [float] NULL
,	[ConcAuto] [varchar](1) NULL,				[CodLugarDesp] [varchar](30) NULL,	[SolicitadoPor] [varchar](30) NULL
,	[DespachadoPor] [varchar](30) NULL,			[Patente] [varchar](9) NULL,		[RetiradoPor] [varchar](30) NULL
,	[CheckeoPorAlarmaVtas] [varchar](1) NULL,	[EnMantencion] [int] NULL,			[Usuario] [varchar](8) NULL
,	[UsuarioGeneraDocto] [varchar](8) NULL,		[FechaHoraCreacion] [datetime] NULL,[Sistema] [varchar](2) NULL
,	[ConcManual] [varchar](1) NULL,				[RutSolicitante] [varchar](20) NULL,[proceso] [varchar](50) NULL
,	[TotalBoleta] [float] NULL,					[NumReq] [int] NOT NULL,			[CodVenWeb] [varchar](50) NULL
,	[CodBodeWms] [varchar](10) NULL,			[CodLugarDocto] [varchar](30) NULL,	[RutTransportista] [varchar](20) NULL
,	[Cod_Distrib] [varchar](10) NULL,			[Nom_Distrib] [varchar](60) NULL,	[MarcaWG] [int] NULL
,	CONSTRAINT [DS_NotasVenta_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[DS_NotasVenta] ADD  CONSTRAINT [DF_DS_NotasVenta_EstadoNP]  DEFAULT ('P') FOR [EstadoNP]
GO

DROP TABLE [dbo].[DS_NotasVentaDetalle]

GO

CREATE TABLE [dbo].[DS_NotasVentaDetalle]
(
	/*-----------------------------------------------------------------------------------------------------------*/
	/*-------------------------------- C A M P O S   D E   D S N O T A V E N T A --------------------------------*/
	/*-----------------------------------------------------------------------------------------------------------*/
	[Id] [int] IDENTITY(1, 1),		[IdNotaVenta] [int]
	/*-----------------------------------------------------------------------------------------------------------*/
	/*----------------------------------- C A M P O S   D E   S O F T L A N D -----------------------------------*/
	/*-----------------------------------------------------------------------------------------------------------*/
,	[NVNumero] [int] NOT NULL,		[nvLinea] [float] NOT NULL,		[nvCorrela] [float] NULL
,	[nvFecCompr] [datetime] NULL,	[CodProd] [varchar](20) NULL,	[nvCant] [float] NULL
,	[nvPrecio] [float] NULL,		[nvEquiv] [float] NULL,			[nvSubTotal] [float] NULL
,	[nvDPorcDesc01] [float] NULL,	[nvDDescto01] [float] NULL,		[nvDPorcDesc02] [float] NULL
,	[nvDDescto02] [float] NULL,		[nvDPorcDesc03] [float] NULL,	[nvDDescto03] [float] NULL
,	[nvDPorcDesc04] [float] NULL,	[nvDDescto04] [float] NULL,		[nvDPorcDesc05] [float] NULL
,	[nvDDescto05] [float] NULL,		[nvTotDesc] [float] NULL,		[nvTotLinea] [float] NULL
,	[nvCantDesp] [float] NULL,		[nvCantProd] [float] NULL,		[nvCantFact] [float] NULL
,	[nvCantDevuelto] [float] NULL,	[nvCantNC] [float] NULL,		[nvCantBoleta] [float] NULL
,	[nvCantOC] [float] NULL,		[DetProd] [text] NULL,			[CheckeoMovporAlarmaVtas] [varchar](1) NULL
,	[KIT] [varchar](20) NULL,		[CodPromocion] [int] NULL,		[CodUMed] [varchar](6) NULL
,	[CantUVta] [float] NULL,		[Partida] [varchar](20) NULL,	[Pieza] [varchar](20) NULL
,	[FechaVencto] [datetime] NULL,	[CantidadKit] [float] NOT NULL,	[MarcaWG] [int] NULL
,	[PorcIncidenciaKit] [float] NOT NULL
,	CONSTRAINT [DS_NotasVentaDetalle_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO





USE [master]
GO
ALTER DATABASE [DSTexsa_NV] SET  READ_WRITE 