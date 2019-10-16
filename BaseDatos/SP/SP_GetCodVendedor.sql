USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCodVendedor]    Script Date: 16-10-2019 13:22:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCodVendedor]
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

