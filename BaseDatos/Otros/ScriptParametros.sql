USE DSNOTAVENTA
GO

DROP TABLE [dbo].[DS_Parametros]

CREATE TABLE [dbo].[DS_Parametros]
(
	Id INT IDENTITY(1, 1)
,	IdEmpresa INT
	--MULTIEMPRESA
,	MultiEmpresa BIT
	--CORREOS OBTENIDOS DESDE LOS CONTACTOS O EL AUXI- SI NO TIENE MAIL GRABA, NO ENVIA MAIL Y AVISA
	--PERFILES ADMINISTRADOR Y APROBADOR 
,	ManejaAdministrador BIT
,	ManejaAprobador BIT
	--LISTA DE CLIENTES POR VENDEDOR O TODOS
,	ListaClientesVendedor BIT
,	ListaClientesTodos BIT
	--VALIDACIÓN DE LA NP CUMPLE CON LAS REGLAS DE NEGOCIOS (SE VA AL APROBADO O NO).
,	ValidaReglasNegocio BIT
	--MANEJO DE LISTA DE PRECIOS (SOLO SE VISUALIZAN LOS PROD DE ESA LISTA) SI NO MANEJAN, SE VEN TODOS LOS PRODUCTOS
,	ManejaListaPrecios BIT
	--EDITA EL PRECIO DEL PRODUCTO SI /NO
,	EditaPrecioProducto BIT
	--CONDICIONES DE VENTA- MOSTRAR TABLA O LA ASOCIADA AL CLIENTE-
,	MuestraCondicionVentaCliente BIT
,	MuestraCondicionVentaTodos BIT
	--CC
	--	- MANEJA DESCUENTO SI/NO
,	EditaDescuentoProducto BIT
	--	- SI, CON CONTROL DE % MAXIMO DE DESCUENTO -SI, CONSULTAR % MAX, NUMERICO, 2 DECIMALES
,	MaximoDescuentoProducto DECIMAL(18, 2)
	--- MANEJA DESCUENTO A LA LINEA DE LA NW   -NO / SI 1 o 2 o 3
,	CantidadDescuentosProducto INT
	--- MUESTRA STOCK DEL PRODUCTO 
,	MuestraStockProducto BIT
	--	- MASIVO O BODEGA
,	StockProductoEsMasivo BIT
,	StockProductoEsBodega BIT
	--		   - QUE BODEGA
,	StockProductoCodigoBodega VARCHAR(1000)
	--- CONTROLA STOCK NO
,	ControlaStockProducto BIT
	--	- SI CONTROLA STOCK,NO DEJA PASAR LA LINEA DE LA NW MAYOR AL STOCK 
	--	- SI CONTROLA STOCK, DEJA PASAR PERO AL APROBADOR- SIEMPRE QUE EXISTA APROBADOR SI NO PASO 3
	--	- SI CONTROLA STOCK ,DEJA PASAR A LA NW
	--- ENVIA MAIL A CLIENTE  Y VENDEDOR SI/NO	--- SI TIENE APROBADOR- ENVIA MAIL AL VENDEDOR CON APROBACION SI / NO
,	EnvioMailCliente BIT
,	EnvioMailVendedor BIT
,	EnvioMailContacto BIT
	--- APROBADOR SI/NO	--	- APROBADOR TODAS LAS NOTAS DE VENTA	--	- APROBADOR SEGUN REGLAS DE NEGOCIOS
,	EnvioObligatorioAprobador BIT 
	--- MANEJA TALLA/COLOR (N)	--- MANEJA PARTIDA/PIEZA (N)
,	ManejaTallaColor BIT 
	--- MANEJA DESCUENTO AL TOTAL DE DOCUMENTO NO / SI (1)
,	ManejaDescuentoTotalDocumento BIT 
,	CantidadDescuentosTotalDocumento INT
	--- CONTROLAR CANTIDAD DE LINEAS DE NP POR IMPRESION DE DOCUMENTO
,	CantidadLineas INT
	--- LINEA DE CREDITO -> VISUALIZACIÓN --	- CONTROL CREACION NOTA DE VENTA	
,	ManejaLineaCredito BIT 
	--- CLIENTE OCUPA CANAL DE VENTA SI/NO
,	ManejaCanalVenta BIT 
	--- CREACION NOTA DE VENTA CON USUARIOS BLOQUEADOS.
,	CreacionNotaVentaUsuariosBloqueados BIT 
	--- CREACION NOTA DE VENTA CON USUARIOS INACTIVOS.
,	CreacionNotaVentaUsuariosInactivos BIT 
	--- MODIFICAR LA CONDICION DE VENTA SEGUN PERMISOS
,	PermiteModificacionCondicionVenta BIT 
	--- EDITAR PRECIO SEGUN EL PERFIL 
	--- ATRIBUTO DESCUENTO CLIENTE.
,	AtributoSoftlandDescuentoCliente VARCHAR(1000)
	--- CREAR DIRECCIÓN
,	PermiteCrearDireccion BIT 
	/*BUSQUEDA SE REALIZA EN DESCRIPCION, ESTA BUSCA POR CODIGO Y DESCRIPCION EN CONJUNTO*/--- HABILITAR CODIGO
	--- CREACIÓN DE CLIENTE 
	--	- CON DIGITO VERIFICADOR SI/NO
,	CrearClienteConDV BIT 
	--ELIMINAR UM
,	MuestraUnidadMedidaProducto BIT
	--PARA FABRICA DEBEN IR LOS PRECIOS CON LOS DESCUENTOS A SOFTLAND
,	DescuentoLineaDirectoSoftland BIT
	--PARA FABRICA DEBEN IR LOS PRECIOS CON LOS DESCUENTOS A SOFTLAND
,	DescuentoTotalDirectoSoftland BIT
)

GO

INSERT INTO [dbo].[DS_Parametros]
(
	IdEmpresa
,	MultiEmpresa
,	ManejaAdministrador
,	ManejaAprobador
,	ListaClientesVendedor
,	ListaClientesTodos
,	ValidaReglasNegocio
,	ManejaListaPrecios
,	EditaPrecioProducto
,	MuestraCondicionVentaCliente
,	MuestraCondicionVentaTodos
,	EditaDescuentoProducto
,	MaximoDescuentoProducto
,	CantidadDescuentosProducto
,	MuestraStockProducto
,	StockProductoEsMasivo
,	StockProductoEsBodega
,	StockProductoCodigoBodega
,	ControlaStockProducto
,	EnvioMailCliente
,	EnvioMailVendedor
,	EnvioMailContacto
,	EnvioObligatorioAprobador 
,	ManejaTallaColor 
,	ManejaDescuentoTotalDocumento 
,	CantidadDescuentosTotalDocumento
,	CantidadLineas
,	ManejaLineaCredito 
,	ManejaCanalVenta 
,	CreacionNotaVentaUsuariosBloqueados 
,	CreacionNotaVentaUsuariosInactivos 
,	PermiteModificacionCondicionVenta 
,	AtributoSoftlandDescuentoCliente
,	PermiteCrearDireccion 
,	CrearClienteConDV 
,	MuestraUnidadMedidaProducto
,	DescuentoLineaDirectoSoftland
,	DescuentoTotalDirectoSoftland
)
SELECT	IdEmpresa = 1
,		MultiEmpresa = 1
,		ManejaAdministrador = 1
,		ManejaAprobador = 1
,		ListaClientesVendedor = 1
,		ListaClientesTodos = 0
,		ValidaReglasNegocio = 0
,		ManejaListaPrecios = 1
,		EditaPrecioProducto = 1
,		MuestraCondicionVentaCliente = 1
,		MuestraCondicionVentaTodos = 0
,		EditaDescuentoProducto = 1
,		MaximoDescuentoProducto = 20
,		CantidadDescuentosProducto = 2
,		MuestraStockProducto = 1
,		StockProductoEsMasivo = 1
,		StockProductoEsBodega = 0
,		StockProductoCodigoBodega = ''
,		ControlaStockProducto = 0
,		EnvioMailCliente = 1
,		EnvioMailVendedor = 1
,		EnvioMailContacto = 1
,		EnvioObligatorioAprobador = 1
,		ManejaTallaColor = 1
,		ManejaDescuentoTotalDocumento = 1
,		CantidadDescuentosTotalDocumento = 2
,		CantidadLineas = 30
,		ManejaLineaCredito = 1
,		ManejaCanalVenta = 1
,		CreacionNotaVentaUsuariosBloqueados = 0
,		CreacionNotaVentaUsuariosInactivos = 0
,		PermiteModificacionCondicionVenta = 0
,		AtributoSoftlandDescuentoCliente = ''
,		PermiteCrearDireccion = 0
,		CrearClienteConDV = 0
,		MuestraUnidadMedidaProducto = 1
,		DescuentoLineaDirectoSoftland = 1
,		DescuentoTotalDirectoSoftland = 1
UNION ALL
SELECT	IdEmpresa = 2
,		MultiEmpresa = 0
,		ManejaAdministrador = 1
,		ManejaAprobador = 1
,		ListaClientesVendedor = 1
,		ListaClientesTodos = 1
,		ValidaReglasNegocio = 1
,		ManejaListaPrecios = 1
,		EditaPrecioProducto = 1
,		MuestraCondicionVentaCliente = 1
,		MuestraCondicionVentaTodos = 1
,		EditaDescuentoProducto = 1
,		MaximoDescuentoProducto = 50
,		CantidadDescuentosProducto = 1
,		MuestraStockProducto = 0
,		StockProductoEsMasivo = 1
,		StockProductoEsBodega = 0
,		StockProductoCodigoBodega = ''
,		ControlaStockProducto = 0
,		EnvioMailCliente = 1
,		EnvioMailVendedor = 1
,		EnvioMailContacto = 1
,		EnvioObligatorioAprobador = 1
,		ManejaTallaColor = 1
,		ManejaDescuentoTotalDocumento = 1
,		CantidadDescuentosTotalDocumento = 2
,		CantidadLineas = 30
,		ManejaLineaCredito = 1
,		ManejaCanalVenta = 1
,		CreacionNotaVentaUsuariosBloqueados = 0
,		CreacionNotaVentaUsuariosInactivos = 0
,		PermiteModificacionCondicionVenta = 0
,		AtributoSoftlandDescuentoCliente = ''
,		PermiteCrearDireccion = 0
,		CrearClienteConDV = 0
,		MuestraUnidadMedidaProducto = 0
,		DescuentoLineaDirectoSoftland = 0
,		DescuentoTotalDirectoSoftland = 0
/*
- PARAMETROS
	- MULTIEMPRESA
	- CORREOS OBTENIDOS DESDE LOS CONTACTOS O EL AUXI- SI NO TIENE MAIL GRABA, NO ENVIA MAIL Y AVISA
	- PERFILES ADMINISTRADOR Y APROBADOR 
	- LISTA DE CLIENTES POR VENDEDOR O TODOS
	- VALIDACIÓN DE LA NP CUMPLE CON LAS REGLAS DE NEGOCIOS (SE VA AL APROBADO O NO).
	- MANEJO DE LISTA DE PRECIOS (SOLO SE VISUALIZAN LOS PROD DE ESA LISTA) SI NO MANEJAN, SE VEN TODOS LOS PRODUCTOS
	- EDITA EL PRECIO DEL PRODUCTO SI /NO
	- CONDICIONES DE VENTA- MOSTRAR TABLA O LA ASOCIADA AL CLIENTE-
	- CC
		- MANEJA DESCUENTO SI/NO
		- SI, CON CONTROL DE % MAXIMO DE DESCUENTO
			-SI, CONSULTAR % MAX, NUMERICO, 2 DECIMALES
			- CONSULTAR SI EDITA PRECIO (EXCLUYENTE) - EJ KUPPEL

	- MUESTRA STOCK DEL PRODUCTO 
		- MASIVO O BODEGA
			   - QUE BODEGA
	- CONTROLA STOCK NO
		- SI CONTROLA STOCK,NO DEJA PASAR LA LINEA DE LA NW MAYOR AL STOCK 
		- SI CONTROLA STOCK, DEJA PASAR PERO AL APROBADOR- SIEMPRE QUE EXISTA APROBADOR SI NO PASO 3
		- SI CONTROLA STOCK ,DEJA PASAR A LA NW
	- ENVIA MAIL A CLIENTE  Y VENDEDOR SI/NO
	- APROBADOR SI/NO 
		- APROBADOR TODAS LAS NOTAS DE VENTA
		- APROBADOR SEGUN REGLAS DE NEGOCIOS
	- SI TIENE APROBADOR- ENVIA MAIL AL VENDEDOR CON APROBACION SI / NO
	- MANEJA TALLA/COLOR (N)
	- MANEJA PARTIDA/PIEZA (N)
	- MANEJA DESCUENTO AL TOTAL DE DOCUMENTO NO / SI (1)
	- MANEJA DESCUENTO A LA LINEA DE LA NW   -NO / SI 1 o 2 o 3
	- CONTROLAR CANTIDAD DE LINEAS DE NP POR IMPRESION DE DOCUMENTO
	- LINEA DE CREDITO -> VISUALIZACIÓN
		- CONTROL CREACION NOTA DE VENTA

	- CLIENTE OCUPA CANAL DE VENTA SI/NO
	- CREACION NOTA DE VENTA CON USUARIOS BLOQUEADOS.
	- CREACION NOTA DE VENTA CON USUARIOS INACTIVOS.
	- MODIFICAR LA CONDICION DE VENTA SEGUN PERMISOS
	- EDITAR PRECIO SEGUN EL PERFIL 
	- ATRIBUTO DESCUENTO CLIENTE.
	- CREAR DIRECCIÓN
	- HABILITAR CODIGO
	- CREACIÓN DE CLIENTE 
		- CON DIGITO VERIFICADOR SI/NO
	- 
 


 
PERFILES
- SUPERUSUARIO
	DISOFI 	- USUARIOS
		- CLIENTES
		- PARAMETROS
		- NO HACE NW
		- TODOS LOS REPORTES

USUARIO ADMINISTRADOR: DISOFI
PASSWORD: D1S0F1Cmc$



- ADMINISTRADOR (OPCIONAL DEPENDE DEL CLIENTE) 
	- MANTENEDORES
		- USUARIOS - ASOCIA VENDEDOR Y EXIGE MAIL
		- CLIENTES
		
	- CONSULTAS - REPORTES
	- NO PUEDE HACER NOTA DE VENTA
- APROBADOR (OPCIONAL DEPENDE DEL CLIENTE)
	- LISTADO DE LAS NOTAS DE PEDIDO -> APROBADAS, RECHAZADAS O PENDIENTES 
	- PUEDE APROBAR O RECHAZAR LA NP
- VENDEDOR
	- MULTIEMPRESA, DESPUES DEL LOGIN DEBE SELECCIONAR LA EMPRESA
	- VISUALIZAR LOS CLIENTES (SOLO SUYOS O TODOS)
	- ASOCIADO A LOS VENDEDORES DE SOFTLAND
	- CREACIÓN DE NOTAS DE VENTAS



OBSERVACIONES:

VISUALIZACIÓN DE LOS CLIENTES -> VENDEDOR
	- CODIGO 
	- RUT
	- NOMBRE CLIENTE
	- DIRECCIÓN
	- TELEFONO
	- NOTAS (PARAMETRO)

	- MANEJA LINEA DE CREDITO (PARAMETRO)
		- DEUDA VENCIDA 
		- DEUDA TOTAL 
		- LINEA DE CREDITO 
	- BOTON DETALLE DEUDA (PARAMETRO)

	- NOMBRE COLUMNA GNP ARRIBA DEL BOTON 

VISUALIZACIÓN DATOS DEL CLIENTE, SI MANEJA LINEA DE CREDITO SE MUESTRA 
	- DEUDA VENCIDA 
	- DEUDA TOTAL 
	- LINEA DE CREDITO 
	- LISTA DE PRECIOS 
		- QUEDE ABIERTO (SE MUESTREN TODOS LOS PRODUCTOS INDEPENDIENTE DE LA LISTA) =  LEE PRIMERO LA LISTA DE PRECIO, SI NO HAY, SE VA AL PRECIO QUE 
		  SALE EN LA FICHA DE PRODUCTOS, Y SI TAMPOCO TIENE LO PUEDE INGRESAR).

GENERACION DE LA NOTA DE VENTA
	DATOS DEL CLIENTE
	- CONTROLAR COND. VENTA
	- CONTROLAR CONTACTO- SI NO TIENE EN LA FICHA SE CARGARA A LA NW EL NOMBRE DEL CLIENTE
	- CC - POR PARAMETRO- NIVEL MAS ALTO Y ACTIVO
	LISTADO DE PRODUCTOS
	- LA VISUALIZACION DEPENDE DEL CHECK DE LISTA DE PRECIO
	- LA BUSQUEDA EN EL CAMPO DESCRIPCION DEBE SER POR CODIGO Y/O DESCRIPCION
	- ELIMINAR CODIGO RAPIDO 
	- SELECCIONADO EL PRODUCTO SI EL CLIENTE VUELVE A SELECCIONAR EL CAMPO SE ELIMINACEL DATO
	- 

VISTA AGREGAR PRODUCTO
CODIGO/DESCRIPCION - CANTIDAD(POR DEFECTO 1 - UM(SIN EDITAR, 3 CARATERES) - STOCK(P) - NETO(EDITABLE ???)  - SUBTOTAL (PXQ) - DESCTO - SUB TOTAL FINAL
10101010 -ZAPATOS	5			PAR				15	1000			5000		10%	   4500
10101010 -ZAPATOS	5			PAR				15	1000			5000		10%	   4500

	
VISTA DETALLES DE PRODUCTO
CODIGO  	- DESCRIPCION - CANTIDAD - UM   -   NETO -     SUBTOTAL      - DESCTO   - SUB TOTAL FINAL
Ç10101010 	- ZAPATOS   	   5      PAR	    1000	5000		10%	        4500
Ç10101010 	- ZAPATOS   	   5      PAR	    1000	5000		10%	        4500

								
							SUB-TOTAL NETO				 9000
								   IVA(NETO *0.19,0 DECIMALES)   1700
								  TOTAL				10700

DETALLE TALLA/COLOR /PIEZA-----CLIENTE TEXSA
DEBE CONSIDERAR DESCTO
VALIDAR FLETE
SELECT * FROM [POTROS].[softland].iw_tprodtallacolor where CodProd  in ('pta822010n', '909090')
SELECT codbode, partida, pieza, sum(ingresos-egresos) FROM [POTROS].[softland].IW_vsnpMovimStockTipoBod  where codprod ='pta822010n' group by codbode,partida, pieza
SELECT * FROM [POTROS].[softland].iw_tprod where codprod in ('pta822010n', '909090')



AL GUARDAR DEBE SALIR EL MAIL Y UN MENSAJE INIDICANDO QUE SE GENERO LA NOTA DE PEDIDO INTERNA N xxx ( NO ES LA NW)





NOTAS. 
- EN EL REPORTE NP PENDIENTE SALE SIEMPRE SOLO LAS PENDIENTES
- EN EL REPORTE NP APROBADAS SALEN IGUALES A LOS ACTUALES INCORPORANDO UN FILTRO PRIMERO- SE DEBE CONSIDERAR EL NUEVO ESTADO RECHAZADO

	


APROBADOR
- NO EXISTEN CAMBIOS DE VISUALIZACION
- SE DEBE AGREGAR UN ICONO DE RECHAZO- Y CONTROLAR ESTE NUEVO ESTADO (R)






- 






 
		
		

*/