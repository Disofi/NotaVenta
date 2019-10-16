USE [DSNotaVenta]
GO
/****** Object:  StoredProcedure [dbo].[FR_ListarClientes]    Script Date: 16-10-2019 13:25:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[FR_ListarClientes]
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
	


