using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UTIL.Models;
using UTIL.Objetos;

namespace BLL
{
    public class ControlDisofi
    {
        private FactoryAcceso _Control = new FactoryAcceso();

        public List<_NotaDeVentaDetalleModels> DatosCorreoVend(int NvNUmero)
        {
            return _Control.DatosCorreoVend(NvNUmero);
        }

        public List<_NotaDeVentaDetalleModels> DatosCorreoAprobador(string VendCod)
        {
            return _Control.DatosCorreoAprobador(VendCod);
        }

        public bool ActualizaCorreo(_UsuariosModels Usuario)
        {
            return _Control.ActualizaCorreo(Usuario);
        }

        public List<ObjetoMenu> MenuUsuario(int idUsuario)
        {
            return _Control.MenuUsuario(idUsuario);
        }

        public List<CentrodeCostoModels> ListarCentroCosto(string basedatos)
        {
            return _Control.ListarCentroCosto(basedatos);
        }

        public List<ClientesModels> GetClientes(string basedatos, ClientesModels cliente = null)
        {
            return _Control.GetClientes(basedatos, cliente);
        }

        public List<ClientesModels> GetContacto(string basedatos, ClientesModels cliente = null)
        {
            return _Control.GetContacto(basedatos, cliente);
        }

        public List<ClientesModels> GetCliente(ClientesModels cliente = null)
        {
            return _Control.GetCliente(cliente);
        }

        public List<ClientesModels> listarClientes(string basedatos)
        {
            return _Control.listarClientes(basedatos);
        }

        public List<ClientesModels> BuscarClientes(ClientesModels clientes)
        {
            return _Control.BuscarClientes(clientes);
        }

        public List<EmpresaModel> ListarEmpresas()
        {
            return _Control.ListarEmpresas();
        }

        public List<ClientesModels> ListarClientesTodos()
        {
            return _Control.ListarClientesTodos();
        }

        public List<ClientesModels> BuscarMisClientes(ClientesModels RutAux)
        {
            return _Control.BuscarMisClientes(RutAux);
        }

        public List<ClientesModels> BuscarMisClientesVenCod(UsuariosModels usuario, string basedatos)
        {
            return _Control.BuscarMisClientesVenCod(usuario, basedatos);
        }

        public List<ClientesModels> BuscarContacto(string basedatos, ClientesModels contacto)
        {
            return _Control.BuscarContacto(basedatos, contacto);
        }

        public List<ClientesModels> AgregarContacto(ClientesModels contacto)
        {
            return _Control.AgregarContacto(contacto);
        }

        public List<DireccionDespachoModels> BuscarDirecDespach(DireccionDespachoModels DirDes, string baseDatos)
        {
            return _Control.BuscarDirecDespach(DirDes, baseDatos);
        }

        public RespuestaModel AgregarDireccionDespacho(DireccionDespachoModels DirDes, string baseDatos)
        {
            return _Control.AgregarDireccionDespacho(DirDes, baseDatos);
        }

        public RespuestaModel ActualizarCliente(ClientesModels cliente, string basedatos)
        {
            return _Control.ActualizarCliente(cliente, basedatos);
        }

        public List<CondicionVentasModels> listarConVen(string baseDatos, CondicionVentasModels conven)
        {
            return _Control.listarConVen(baseDatos, conven);
        }

        public List<ListaDePrecioModels> listarListaDePrecio(string baseDatos, ListaDePrecioModels lista)
        {
            return _Control.listarListaDePrecio(baseDatos, lista);
        }

        public ObjetoUsuario Login(ObjetoUsuario usuario)
        {
            return _Control.Login(usuario);
        }

        public RespuestaNotaVentaModel AgregarNV(string baseDatos, bool insertaDisofi, bool insertaSoftland, NotadeVentaCabeceraModels NVC)
        {
            return _Control.AgregarNV(baseDatos, insertaDisofi, insertaSoftland, NVC);
        }

        public List<NotadeVentaCabeceraModels> EditarNV(NotadeVentaCabeceraModels NVC)
        {
            return _Control.EditarNV(NVC);
        }

        public RespuestaNotaVentaModel AgregarDetalleNV(string baseDatos, bool insertaDisofi, bool insertaSoftland, NotaDeVentaDetalleModels NVD)
        {
            return _Control.AgregarDetalleNV(baseDatos, insertaDisofi, insertaSoftland, NVD);
        }

        public List<NotadeVentaCabeceraModels> BuscarNVPorNumero(int Id, string basedatos)
        {
            return _Control.BuscarNVPorNumero(Id, basedatos);
        }

        public List<NotadeVentaCabeceraModels> BuscarNVNum(NotadeVentaCabeceraModels NVSoft)
        {
            return _Control.BuscarNVNum(NVSoft);
        }

        public List<NotaDeVentaDetalleModels> BuscarNVDETALLEPorNumero(int Id, string basedatos)
        {
            return _Control.BuscarNVDETALLEPorNumero(Id, basedatos);
        }

        public List<NotadeVentaCabeceraModels> InsertarNvSoftland(NotadeVentaCabeceraModels NVC)
        {
            return _Control.InsertarNvSoftland(NVC);
        }
        public ParametrosModels BuscarParametros(int idEmpresa)
        {
            return _Control.BuscarParametros(idEmpresa);
        }

        public RespuestaModel ModificarParametros(ParametrosModels Aprobador)
        {
            Aprobador.AtributoSoftlandDescuentoCliente = Aprobador.AtributoSoftlandDescuentoCliente == null ? "" : Aprobador.AtributoSoftlandDescuentoCliente;
            Aprobador.StockProductoCodigoBodega = Aprobador.StockProductoCodigoBodega == null ? "" : Aprobador.StockProductoCodigoBodega;
            return _Control.ModificarParametros(Aprobador);
        }

        public List<ProductosModels> BuscarProducto(ProductosModels producto)
        {
            return _Control.BuscarProducto(producto);
        }
        public List<ProductosModels> ListarProducto(string ListaPrecio, string baseDatos)
        {
            return _Control.ListarProducto(ListaPrecio, baseDatos);
        }
        public List<TallaColorProductoModels> ListarTallaColorProducto(string CodProd, string baseDatos)
        {
            return _Control.ListarTallaColorProducto(CodProd, baseDatos);
        }

        public List<ProductosModels> BuscarProductoRapido(ProductosModels producto)
        {
            return _Control.BuscarProductoRapido(producto);
        }

        public List<NotadeVentaCabeceraModels> listarDocAprobados(string basedatos)
        {
            return _Control.listarDocAprobados(basedatos);
        }

        public List<NotadeVentaCabeceraModels> listarDocPendientes(string basedatos)
        {
            return _Control.listarDocPendientes(basedatos);
        }

        public List<NotadeVentaCabeceraModels> listarDocRechazadas(string basedatos)
        {
            return _Control.listarDocRechazadas(basedatos);
        }

        public List<NotadeVentaCabeceraModels> actualizaEstado(NotadeVentaCabeceraModels nw, string basedatos)
        {
            return _Control.actualizaEstado(nw, basedatos);
        }

        public NotadeVentaCabeceraModels GetCab(int nvId)
        {
            return _Control.GetCab(nvId);
        }

        public List<NotadeVentaCabeceraModels> BuscarNVC(NotadeVentaCabeceraModels nw, string basedatos)
        {
            return _Control.BuscarNVC(nw, basedatos);
        }

        public List<NotaDeVentaDetalleModels> BuscarNVD(NotaDeVentaDetalleModels nw, string basedatos)
        {
            return _Control.BuscarNVD(nw, basedatos);
        }

        public List<NotaDeVentaDetalleModels> ListarNotaDetalle(NotaDeVentaDetalleModels nw)
        {
            return _Control.ListarNotaDetalle(nw);
        }

        public List<UsuariosModels> listarUsuarios()
        {
            return _Control.listarUsuarios();
        }
        public RespuestaModel eliminaTodosUsuarioEmpresa(int idUsuario)
        {
            return _Control.eliminaTodosUsuarioEmpresa(idUsuario);
        }
        public RespuestaModel insertaUsuarioEmpresa(int idUsuario, int idEmpresa, string venCod)
        {
            return _Control.insertaUsuarioEmpresa(idUsuario, idEmpresa, venCod);
        }

        public List<UsuariosModels> BuscarUsuario(UsuariosModels usuario)
        {
            return _Control.BuscarUsuario(usuario);
        }

        public RespuestaModel ActualizarUsuario(UsuariosModels usuario)
        {
            return _Control.ActualizarUsuario(usuario);
        }

        public RespuestaModel AgregarUsuario(UsuariosModels usuario)
        {
            return _Control.AgregarUsuario(usuario);
        }

        public RespuestaModel EliminarUsuario(UsuariosModels usuarios)
        {
            return _Control.EliminarUsuario(usuarios);
        }

        public RespuestaModel EditarUsuario(UsuariosModels usuarios)
        {
            return _Control.EditarUsuario(usuarios);
        }

        public List<UsuariosTiposModels> listarTipo()
        {
            return _Control.listarTipo();
        }

        public List<VendedoresSoftlandModels> ListarVendedoresSoftland(string venCod)
        {
            return _Control.ListarVendedoresSoftland(venCod);
        }

        public List<VendedoresSoftlandModels> listarVendedoresSoftland(string basedatos)
        {
            return _Control.listarVendedoresSoftland(basedatos);
        }

        public List<ObjetoPerfil> ListarPerfiles()
        {
            return _Control.ListarPerfiles();
        }

        public List<UsuariosModels> ListarCodVendedorSoft(string basedatos)
        {
            return _Control.ListarCodVendedorSoft(basedatos);
        }

        public List<VendedorModels> GetVendedores(string basedatos, VendedorModels cliente = null)
        {
            return _Control.GetVendedores(basedatos, cliente);
        }

        public List<AprobadorModels> GetAprobador(int IdAprobador)
        {
            return _Control.GetAprobador(IdAprobador);
        }

        public List<UsuariosModels> GetDatosUsuario(string Id, string basedatos)
        {
            return _Control.GetDatosUsuario(Id, basedatos);
        }

        public List<ClientesModels> GetDatosClientes(string CodAux, string basedatos)
        {
            return _Control.GetDatosClientes(CodAux, basedatos);
        }

        public List<UsuarioEmpresaModel> ListaUsuarioEmpresas(int idUsuario)
        {
            return _Control.ListaUsuarioEmpresas(idUsuario);
        }

        public List<ClientesModels> ObtenerGiro(string basedatos)
        {
            return _Control.ObtenerGiro(basedatos);
        }

        public ClientesModels ObtenerAtributoDescuento(string basedatos, string codaux, string textoAtributo)
        {
            return _Control.ObtenerAtributoDescuento(basedatos, codaux, textoAtributo);
        }

        public List<CiudadModel> ObtenerCiudad(string baseDatos)
        {
            return _Control.ObtenerCiudad(baseDatos);
        }

        public List<ComunaModel> ObtenerComuna(string baseDatos)
        {
            return _Control.ObtenerComuna(baseDatos);
        }
        public CreditoModel ObtenerCredito(string CodAux, string baseDatos)
        {
            return _Control.ObtenerCredito(CodAux, baseDatos);
        }

        public VendedoresSoftlandModels ObtenerVendedorCliente(string CodAux, string baseDatos)
        {
            return _Control.ObtenerVendedorCliente(CodAux, baseDatos);
        }

        public List<NotadeVentaCabeceraModels> RechazarNP(NotadeVentaCabeceraModels nw)
        {
            return _Control.RechazarNotaVenta(nw);
        }

        public List<ClientesModels> ActualizarCorreoCliente(ClientesModels cli, string basedatos)
        {
            return _Control.ActualizarCorreoCliente(cli, basedatos);
        }
    }
}
