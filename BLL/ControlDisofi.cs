﻿using System;
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

        public List<CentrodeCostoModels> listarCC()
        {
            return _Control.listarCC();
        }

        public List<ClientesModels> GetClientes(ClientesModels cliente = null)
        {
            return _Control.GetClientes(cliente);
        }

        public List<ClientesModels> GetContacto(ClientesModels cliente = null)
        {
            return _Control.GetContacto(cliente);
        }

        public List<ClientesModels> GetCliente(ClientesModels cliente = null)
        {
            return _Control.GetCliente(cliente);
        }

        public List<ClientesModels> listarClientes()
        {
            return _Control.listarClientes();
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

        public List<ClientesModels> BuscarMisClientesVenCod(UsuariosModels usuario,string basedatos)
        {
            return _Control.BuscarMisClientesVenCod(usuario,basedatos);
        }

        public List<ClientesModels> BuscarContacto(ClientesModels contacto)
        {
            return _Control.BuscarContacto(contacto);
        }

        public List<ClientesModels> AgregarContacto(ClientesModels contacto)
        {
            return _Control.AgregarContacto(contacto);
        }

        public List<DireccionDespachoModels> BuscarDirecDespach(DireccionDespachoModels DirDes)
        {
            return _Control.BuscarDirecDespach(DirDes);
        }

        public RespuestaModel ActualizarCliente(ClientesModels cliente)
        {
            return _Control.ActualizarCliente(cliente);
        }

        public List<CondicionVentasModels> listarConVen(CondicionVentasModels conven)
        {
            return _Control.listarConVen(conven);
        }

        public List<ListaDePrecioModels> listarListaDePrecio(ListaDePrecioModels lista)
        {
            return _Control.listarListaDePrecio(lista);
        }

        public ObjetoUsuario Login(ObjetoUsuario usuario)
        {
            return _Control.Login(usuario);
        }

        public List<NotadeVentaCabeceraModels> AgregarNV(NotadeVentaCabeceraModels NVC)
        {
            return _Control.AgregarNV(NVC);
        }

        public List<NotadeVentaCabeceraModels> EditarNV(NotadeVentaCabeceraModels NVC)
        {
            return _Control.EditarNV(NVC);
        }

        public List<NotaDeVentaDetalleModels> DetalleNV(NotaDeVentaDetalleModels NVD)
        {
            return _Control.DetalleNV(NVD);
        }

        public List<NotadeVentaCabeceraModels> BuscarNVPorNumero(NotadeVentaCabeceraModels NVC)
        {
            return _Control.BuscarNVPorNumero(NVC);
        }

        public List<NotadeVentaCabeceraModels> BuscarNVNum(NotadeVentaCabeceraModels NVSoft)
        {
            return _Control.BuscarNVNum(NVSoft);
        }

        public List<NotaDeVentaDetalleModels> BuscarNVDETALLEPorNumero(NotadeVentaCabeceraModels NVC)
        {
            return _Control.BuscarNVDETALLEPorNumero(NVC);
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

        public List<NotadeVentaCabeceraModels> listarDocAprobados()
        {
            return _Control.listarDocAprobados();
        }

        public List<NotadeVentaCabeceraModels> listarDocPendientes()
        {
            return _Control.listarDocPendientes();
        }

        public List<NotadeVentaCabeceraModels> actualizaEstado(NotadeVentaCabeceraModels nw)
        {
            return _Control.actualizaEstado(nw);
        }

        public List<NotadeVentaCabeceraModels> BuscarNVC(NotadeVentaCabeceraModels nw)
        {
            return _Control.BuscarNVC(nw);
        }

        public List<NotaDeVentaDetalleModels> BuscarNVD(NotaDeVentaDetalleModels nw)
        {
            return _Control.BuscarNVD(nw);
        }

        public List<NotaDeVentaDetalleModels> ListarNotaDetalle(NotaDeVentaDetalleModels nw)
        {
            return _Control.ListarNotaDetalle(nw);
        }

        public List<UsuariosModels> listarUsuarios()
        {
            return _Control.listarUsuarios();
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

        public List<VendedoresSoftlandModels> listarVendedoresSoftland()
        {
            return _Control.listarVendedoresSoftland();
        }

        public List<ObjetoPerfil> ListarPerfiles()
        {
            return _Control.ListarPerfiles();
        }

        public List<UsuariosModels> ListarCodVendedorSoft()
        {
            return _Control.ListarCodVendedorSoft();
        }

        public List<ClientesModels> GetVendedores(ClientesModels cliente = null)
        {
            return _Control.GetVendedores(cliente);
        }

        public List<UsuariosModels> GetDatosUsuario(string Id)
        {
            return _Control.GetDatosUsuario(Id);
        }

        public List<ClientesModels> GetDatosClientes(string CodAux)
        {
            return _Control.GetDatosClientes(CodAux);
        }

        public List<UsuarioEmpresaModel> ListaUsuarioEmpresas(int idUsuario)
        {
            return _Control.ListaUsuarioEmpresas(idUsuario);
        }

        public List<ClientesModels> ObtenerGiro(string basedatos)
        {
            return _Control.ObtenerGiro(basedatos);
        }

        public List<ClientesModels> ObtenerCiudad(string basedatos)
        {
            return _Control.ObtenerCiudad(basedatos);
        }
    }
}
