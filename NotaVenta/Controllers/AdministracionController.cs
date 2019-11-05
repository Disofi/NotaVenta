using NotaVenta.UTIL;
using NotaVenta.UTIL.Error;
using NotaVenta.UTIL.FilterAttributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UTIL.Models;
using UTIL.Objetos;
using UTIL.Validaciones;

namespace NotaVenta.Controllers
{
    public class AdministracionController : BaseController
    {
        #region Vistas

        public ActionResult Index()
        {
            return null;
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR)]
        public ActionResult Usuarios()
        {
            List<UsuariosModels> lUsuarios = controlDisofi().listarUsuarios();
            ViewBag.usuarios = lUsuarios;

            List<UsuariosTiposModels> ltipo = controlDisofi().listarTipo();
            ViewBag.tipo = ltipo;

            List<VendedoresSoftlandModels> lvendedor = controlDisofi().listarVendedoresSoftland(baseDatosUsuario());
            ViewBag.vendedor = lvendedor;

            IEnumerable<SelectListItem> lPerfil = controlDisofi().ListarPerfiles().Select(c => new SelectListItem()
            {
                Text = c.TipoUsuario,
                Value = c.ID.ToString()
            }).ToList();
            ViewBag.Perfil = lPerfil;

            IEnumerable<SelectListItem> dataEmpresas = controlDisofi().ListarEmpresas().Select(c => new SelectListItem()
            {
                Text = c.NombreEmpresa,
                Value = c.IdEmpresa.ToString()
            }).ToList();

            ViewBag.Empresas = dataEmpresas;

            //IEnumerable<SelectListItem> lCodVenl = controlDisofi().ListarCodVendedorSoft(baseDatosUsuario()).Select(c => new SelectListItem()
            //{
            //    Text = c.VenDes + " " + c.VenCod.ToString(),
            //    Value = c.VenCod.ToString()
            //}).ToList();
            //ViewBag.VenCodSoft = lCodVenl;

            //IEnumerable<SelectListItem> lBaseDatos = controlDisofi().ListarEmpresas().Select(c => new SelectListItem()
            //{
            //    Text = c.NombreEmpresa,
            //    Value = c.IdEmpresa.ToString()
            //}).ToList();
            //ViewBag.BaseDatos = lBaseDatos;

            return View();
        }



        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR)]
        public ActionResult Clientes()
        {
            List<ClientesModels> ListClientes = new List<ClientesModels>();
            var listClientes = controlDisofi().listarClientes(baseDatosUsuario());

            if (listClientes != null)
            {
                ListClientes = listClientes;
            }

            ViewBag.clientes = ListClientes;

            return View();
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR)]
        public ActionResult Parametros()
        {
            List<EmpresaModel> empresas = controlDisofi().ListarEmpresas();

            if (empresas != null && empresas.Count > 0)
            {
                ParametrosModels para = ObtieneParametros(empresas[0].IdEmpresa);

                ViewBag.Empresas = empresas;
                ViewBag.Parametros = para;
            }
            else
            {
                return AbrirError(Errores.ERRORES.ERROR_LOGIN_1, TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN);
            }

            return View();
        }

        #endregion


        [HttpPost]
        public JsonResult ObtieneParametro(int idEmpresa)
        {
            try
            {
                ParametrosModels parametro = controlDisofi().BuscarParametros(idEmpresa);

                return Json(parametro);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult EditCliente(string rutAux, string codAux)
        {
            try
            {
                if (rutAux == null)
                {
                    return View();
                }

                if (codAux == null) codAux = string.Empty;

                ClientesModels cliente = new ClientesModels();

                cliente.RutAux = rutAux.ToString();
                cliente.CodAux = codAux.ToString();

                List<ClientesModels> bclientes = controlDisofi().BuscarClientes(cliente);

                if (SessionVariables.SESSION_BUSCAR_CLIENTE != null)
                {
                    SessionVariables.SESSION_BUSCAR_CLIENTE = null;
                    SessionVariables.SESSION_BUSCAR_CLIENTE = bclientes;
                }
                else
                {
                    SessionVariables.SESSION_BUSCAR_CLIENTE = bclientes;
                }

                return View();
            }
            catch (Exception ex)
            {
                return View(ex.Message);
            }
        }



        public ActionResult EditUsuarios(int idUsuario)
        {
            UsuariosModels Usuario = new UsuariosModels();
            Usuario.id = idUsuario;
            List<UsuariosModels> busuario = controlDisofi().BuscarUsuario(Usuario, baseDatosUsuario());
            ViewBag.buscarusuarios = busuario;

            List<UsuariosTiposModels> ltipo = controlDisofi().listarTipo();
            ViewBag.tipo = ltipo;

            List<VendedoresSoftlandModels> LisVendedoresSoftland = controlDisofi().ListarVendedoresSoftland(busuario[0].VenCod.Trim());
            ViewBag.vendedorSoftland = LisVendedoresSoftland;

            return View();
        }

        [HttpPost]
        public JsonResult Addusuario(string _Usuario, string _Nombre, string _Contrasena, string _Email, string _Perfil, string _VenCod, string _BaseDatos)
        {
            if (!string.IsNullOrEmpty(_Usuario) && !string.IsNullOrEmpty(_Nombre) && !string.IsNullOrEmpty(_Contrasena) && !string.IsNullOrEmpty(_Perfil) && !string.IsNullOrEmpty(_VenCod) && !string.IsNullOrEmpty(_BaseDatos))
            {
                UsuariosModels usuario = new UsuariosModels()
                {
                    Usuario = _Usuario,
                    Nombre = _Nombre,
                    Password = HashMd5.GetMD5(_Contrasena),
                    email = _Email,
                    tipoUsuario = _Perfil,
                    VenCod = _VenCod,
                    BaseDatos = int.Parse(_BaseDatos)
                };
                RespuestaModel result = controlDisofi().AgregarUsuario(usuario);
                return Json(result);
            }
            else
            {
                var result = -666;
                return Json(result);
            }
        }



        public JsonResult EliminarUsuario(int _Id)
        {
            UsuariosModels usuarios = new UsuariosModels();
            usuarios.id = _Id;
            RespuestaModel result = controlDisofi().EliminarUsuario(usuarios);

            return (Json(result));
        }

        public JsonResult EditarUsuario(int _Id, string _Usuario, string _Nombre, string _Contrasena, string _Email, string _Perfil, string _CodVend)
        {
            if (!string.IsNullOrEmpty(_Usuario) && !string.IsNullOrEmpty(_Nombre) && !string.IsNullOrEmpty(_Contrasena) && !string.IsNullOrEmpty(_Email) && !string.IsNullOrEmpty(_Perfil) && !string.IsNullOrEmpty(_CodVend))
            {
                UsuariosModels usuarios = new UsuariosModels()
                {
                    id = _Id,
                    Usuario = _Usuario,
                    Nombre = _Nombre,
                    Password = HashMd5.GetMD5(_Contrasena),
                    email = _Email,
                    tipoUsuario = _Perfil,
                    VenCod = _CodVend
                };
                RespuestaModel result = controlDisofi().EditarUsuario(usuarios, baseDatosUsuario());
                return (Json(result));
            }
            else
            {
                var result = -666;
                return Json(result);
            }
        }

        public JsonResult EditarCliente(string _CodAux, string _Nombre, string _Rut, string _Contacto, string _Email, string _Telefono, string _Direccion)
        {
            if (!string.IsNullOrEmpty(_Nombre) && !string.IsNullOrEmpty(_Rut) && !string.IsNullOrEmpty(_Contacto) && !string.IsNullOrEmpty(_Email) && !string.IsNullOrEmpty(_Direccion))
            {
                ClientesModels cliente = new ClientesModels()
                {
                    CodAux = _CodAux,
                    NomAux = _Nombre,
                    RutAux = _Rut,
                    NomCon = _Contacto,
                    EMail = _Email,
                    FonCon = _Telefono,
                    DirAux = _Direccion
                };
                if (ValidaRut.DigitoVerificador(cliente.RutAux))
                {
                    RespuestaModel result = controlDisofi().ActualizarCliente(cliente, baseDatosUsuario());
                    return Json(result);
                }
                else
                {
                    var result = -999;
                    return Json(result);
                }
            }
            else
            {
                var result = -666;
                return Json(result);
            }
        }

        public JsonResult ObtenerDatosUsuario(string _IdUsuario)
        {
            List<UsuariosModels> usuarios = controlDisofi().GetDatosUsuario(_IdUsuario, baseDatosUsuario());
            return Json(new { list = usuarios }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult ObtenerVendedoresEmpresa(string _IdEmpresa)
        {
            List<EmpresaModel> empresaModels = controlDisofi().ListarEmpresas().Where(m => m.IdEmpresa == Convert.ToInt32(_IdEmpresa)).ToList();

            if (empresaModels != null && empresaModels.Count > 0)
            {
                List<UsuariosModels> usuarios = controlDisofi().ListarCodVendedorSoft(empresaModels[0].BaseDatos);

                return Json(usuarios, JsonRequestBehavior.AllowGet); ;
            }
            else
            {
                return Json(new List<UsuariosModels>(), JsonRequestBehavior.AllowGet); ;
            }
        }
        public JsonResult ObtenerEmpresasUsuario(string _IdUsuario)
        {
            List<UsuarioEmpresaModel> usuarios = controlDisofi().ListaUsuarioEmpresas(Convert.ToInt32(_IdUsuario));

            return Json(usuarios, JsonRequestBehavior.AllowGet);
        }


        public JsonResult AgregarEmpresasUsuario(string _IdUsuario, List<UsuarioEmpresaModel> empresasUsuario)
        {
            RespuestaModel respuestaModel = new RespuestaModel();
            
            respuestaModel = controlDisofi().eliminaTodosUsuarioEmpresa(Convert.ToInt32(_IdUsuario));

            if (respuestaModel.Verificador)
            {
                foreach (UsuarioEmpresaModel item in empresasUsuario)
                {
                    controlDisofi().insertaUsuarioEmpresa(item.IdUsuario, item.IdEmpresa, item.VenCod);
                }
            }

            return Json(respuestaModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult obtenerDatosClientes(string _CodAux)
        {
            List<ClientesModels> clientes = controlDisofi().GetDatosClientes(_CodAux, baseDatosUsuario());
            return Json(new { list = clientes }, JsonRequestBehavior.AllowGet);
        }

        #region"--- Web Methods ---"


        [HttpPost, ValidateInput(false)]
        public ActionResult EditUsuarios(FormCollection frm)
        {
            UsuariosModels Usuario = new UsuariosModels();

            Usuario.id = Convert.ToInt32(Request.Form["hdCodigo"]);
            Usuario.Usuario = Request.Form["txtUsuario"];
            Usuario.email = Request.Form["txtEmail"];
            Usuario.tipoUsuario = Request.Form["perfil"];
            Usuario.VenCod = Request.Form["vendedor"];

            RespuestaModel result = controlDisofi().ActualizarUsuario(Usuario);

            List<UsuariosModels> busuario = controlDisofi().BuscarUsuario(Usuario, baseDatosUsuario());
            ViewBag.buscarusuarios = busuario;

            List<UsuariosTiposModels> ltipo = controlDisofi().listarTipo();
            ViewBag.tipo = ltipo;

            List<VendedoresSoftlandModels> LisVendedoresSoftland = controlDisofi().ListarVendedoresSoftland(busuario[0].VenCod);
            ViewBag.vendedorSoftland = LisVendedoresSoftland;

            return View();
        }

        [HttpPost]
        public JsonResult GuardarParametro(ParametrosModels parametro)
        {
            RespuestaModel lis = controlDisofi().ModificarParametros(parametro);

            return Json(lis);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Clientes(FormCollection frm)
        {
            return View();
        }

        //[HttpPost, ValidateInput(false)]
        //public ActionResult EditCliente(FormCollection frm)
        //{
        //    //ClientesModels cliente = new ClientesModels();
        //    //cliente.RutAux = Request.Form["txtrut"];

        //    //return View();
        //    ClientesModels cliente = new ClientesModels();

        //    cliente.CodAux = Request.Form["txtcodAux"];
        //    cliente.RutAux = Request.Form["txtrut"];
        //    cliente.NomAux = Request.Form["txtnombre"];
        //    cliente.NomCon = Request.Form["txtcontacto"];
        //    cliente.FonCon = Request.Form["txttelefono"];
        //    cliente.DirAux = Request.Form["txtdireccion"];
        //    cliente.EMail = Request.Form["txtemail"];

        //    RespuestaModel result = controlDisofi().ActualizarCliente(cliente);

        //    List<ClientesModels> bclientes = controlDisofi().BuscarClientes(cliente);

        //    if (SessionVariables.SESSION_BUSCAR_CLIENTE != null)
        //    {
        //        SessionVariables.SESSION_BUSCAR_CLIENTE = null;
        //        SessionVariables.SESSION_BUSCAR_CLIENTE = bclientes;
        //    }
        //    else
        //    {
        //        SessionVariables.SESSION_BUSCAR_CLIENTE = bclientes;
        //    }

        //    return View();
        //}

        #endregion
    }
}