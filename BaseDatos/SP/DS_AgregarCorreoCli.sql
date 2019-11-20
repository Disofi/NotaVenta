USE [DSNotaVenta]
GO

/****** Object:  StoredProcedure [dbo].[DS_AgregarCorreoCli]    Script Date: 04-11-2019 8:47:27 ******/
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


