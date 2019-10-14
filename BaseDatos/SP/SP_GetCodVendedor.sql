USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCodVendedor]    Script Date: 14-10-2019 16:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCodVendedor]
as
SELECT c.VenCod,c.VenDes FROM kuppel.softland.cwtvend c 
