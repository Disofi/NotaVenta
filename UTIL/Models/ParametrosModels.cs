using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UTIL.Models
{
    public class ParametrosModels
    {
        public int Id { get; set; }
        public int IdEmpresa { get; set; }
        //MULTIEMPRESA
        public bool MultiEmpresa { get; set; }
        //CORREOS OBTENIDOS DESDE LOS CONTACTOS O EL AUXI- SI NO TIENE MAIL GRABA, NO ENVIA MAIL Y AVISA
        //PERFILES ADMINISTRADOR Y APROBADOR
        public bool ManejaAdministrador { get; set; }
        public bool ManejaAprobador { get; set; }
        //LISTA DE CLIENTES POR VENDEDOR O TODOS
        public bool ListaClientesVendedor { get; set; }
        public bool ListaClientesTodos { get; set; }
        //VALIDACIÓN DE LA NP CUMPLE CON LAS REGLAS DE NEGOCIOS(SE VA AL APROBADO O NO).
        public bool ValidaReglasNegocio { get; set; }
        //MANEJO DE LISTA DE PRECIOS(SOLO SE VISUALIZAN LOS PROD DE ESA LISTA) SI NO MANEJAN, SE VEN TODOS LOS PRODUCTOS
        public bool ManejaListaPrecios { get; set; }
        //EDITA EL PRECIO DEL PRODUCTO SI /NO
        public bool EditaPrecioProducto { get; set; }
        //CONDICIONES DE VENTA- MOSTRAR TABLA O LA ASOCIADA AL CLIENTE-
        public bool MuestraCondicionVentaCliente { get; set; }
        public bool MuestraCondicionVentaTodos { get; set; }
        //CC
        //	- MANEJA DESCUENTO SI/NO
        public bool EditaDescuentoProducto { get; set; }
        //	- SI, CON CONTROL DE % MAXIMO DE DESCUENTO -SI, CONSULTAR % MAX, NUMERICO, 2 DECIMALES
        public decimal MaximoDescuentoProducto { get; set; }
        //- MANEJA DESCUENTO A LA LINEA DE LA NW   -NO / SI 1 o 2 o 3
        public int CantidadDescuentosProducto { get; set; }
        //- MUESTRA STOCK DEL PRODUCTO
        public bool MuestraStockProducto { get; set; }
        //	- MASIVO O BODEGA
        public bool StockProductoEsMasivo { get; set; }
        public bool StockProductoEsBodega { get; set; }
        //		   - QUE BODEGA
        public string StockProductoCodigoBodega { get; set; }
        //- CONTROLA STOCK NO
        public bool ControlaStockProducto { get; set; }
        //	- SI CONTROLA STOCK,NO DEJA PASAR LA LINEA DE LA NW MAYOR AL STOCK 
        //	- SI CONTROLA STOCK, DEJA PASAR PERO AL APROBADOR- SIEMPRE QUE EXISTA APROBADOR SI NO PASO 3
        //	- SI CONTROLA STOCK ,DEJA PASAR A LA NW
        //- ENVIA MAIL A CLIENTE  Y VENDEDOR SI/NO	//- SI TIENE APROBADOR- ENVIA MAIL AL VENDEDOR CON APROBACION SI / NO
        public bool EnvioMailCliente { get; set; }
        public bool EnvioMailVendedor { get; set; }
        public bool EnvioMailContacto { get; set; }

        public bool EnvioMailAprobador { get; set; }
        //- APROBADOR SI/NO	//	- APROBADOR TODAS LAS NOTAS DE VENTA	//	- APROBADOR SEGUN REGLAS DE NEGOCIOS
        public bool EnvioObligatorioAprobador { get; set; }
        //- MANEJA TALLA/COLOR(N)  //- MANEJA PARTIDA/PIEZA(N)
        public bool ManejaTallaColor { get; set; }
        //- MANEJA DESCUENTO AL TOTAL DE DOCUMENTO NO / SI(1)
        public bool ManejaDescuentoTotalDocumento { get; set; }
        public int CantidadDescuentosTotalDocumento { get; set; }
        //- CONTROLAR CANTIDAD DE LINEAS DE NP POR IMPRESION DE DOCUMENTO
        public int CantidadLineas { get; set; }
        //- LINEA DE CREDITO -> VISUALIZACIÓN //	- CONTROL CREACION NOTA DE VENTA	
        public bool ManejaLineaCreditoVendedor { get; set; }
        //- LINEA DE CREDITO -> VISUALIZACIÓN //	- CONTROL CREACION NOTA DE VENTA	
        public bool ManejaLineaCreditoAprobador { get; set; }
        //- CLIENTE OCUPA CANAL DE VENTA SI/NO
        public bool ManejaCanalVenta { get; set; }
        //- CREACION NOTA DE VENTA CON USUARIOS BLOQUEADOS.
        public bool CreacionNotaVentaUsuariosBloqueados { get; set; }
        //- CREACION NOTA DE VENTA CON USUARIOS INACTIVOS.
        public bool CreacionNotaVentaUsuariosInactivos { get; set; }
        //- MODIFICAR LA CONDICION DE VENTA SEGUN PERMISOS
        public bool PermiteModificacionCondicionVenta { get; set; }
        //- EDITAR PRECIO SEGUN EL PERFIL 
        //- ATRIBUTO DESCUENTO CLIENTE.
        public string AtributoSoftlandDescuentoCliente { get; set; }
        //- CREAR DIRECCIÓN
        public bool PermiteCrearDireccion { get; set; }
        /*BUSQUEDA SE REALIZA EN DESCRIPCION, ESTA BUSCA POR CODIGO Y DESCRIPCION EN CONJUNTO*///- HABILITAR CODIGO
        //- CREACIÓN DE CLIENTE 
        //	- CON DIGITO VERIFICADOR SI/NO
        public bool CrearClienteConDV { get; set; }
        //ELIMINAR UM
        public bool MuestraUnidadMedidaProducto { get; set; }
        //PARA FABRICA DEBEN IR LOS PRECIOS CON LOS DESCUENTOS A SOFTLAND
        public bool DescuentoLineaDirectoSoftland { get; set; }
        //PARA FABRICA DEBEN IR LOS PRECIOS CON LOS DESCUENTOS A SOFTLAND
        public bool DescuentoTotalDirectoSoftland { get; set; }

        public bool AgregaCliente { get; set; }
        public bool CambioVendedorCliente { get; set; }

        public bool ManejaSaldo { get; set; }
    }
}