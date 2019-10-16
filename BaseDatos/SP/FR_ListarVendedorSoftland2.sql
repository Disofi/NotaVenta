USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarVendedorSoftland2]    Script Date: 16-10-2019 13:24:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FR_ListarVendedorSoftland2]
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