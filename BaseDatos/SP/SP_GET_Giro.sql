USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Giro]    Script Date: 16-10-2019 13:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GET_Giro]
@pv_BaseDatos varchar(100)
AS
DECLARE @query varchar(max)

SELECT @query = ''

SELECT @query = @query + '
SELECT GirCod,GirDes 
FROM ['+@pv_BaseDatos+'] .softland.cwtgiro c	
'
EXEC (@query)
