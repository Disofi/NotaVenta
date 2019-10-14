USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[DS_ListarPefiles]    Script Date: 14-10-2019 16:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DS_ListarPefiles]
AS
SELECT dut.ID, dut.tipoUsuario AS TipoUsuario FROM dbo.DS_UsuariosTipos dut