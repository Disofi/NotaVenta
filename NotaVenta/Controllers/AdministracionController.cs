using NotaVenta.UTIL;
using NotaVenta.UTIL.FilterAttributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UTIL.Models;
using UTIL.Objetos;
using UTIL.Validaciones;

namespace TexasHub.Controllers
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

            List<VendedoresSoftlandModels> lvendedor = controlDisofi().listarVendedoresSoftland();
            ViewBag.vendedor = lvendedor;

            IEnumerable<SelectListItem> lPerfil = controlDisofi().ListarPerfiles().Select(c => new SelectListItem()
            {
                Text = c.TipoUsuario,
                Value = c.ID.ToString()
            }).ToList();
            ViewBag.Perfil = lPerfil;

            IEnumerable<SelectListItem> lCodVenl = controlDisofi().ListarCodVendedorSoft().Select(c => new SelectListItem()
            {
                Text = c.VenDes + " " + c.VenCod.ToString(),
                Value = c.VenCod.ToString()
            }).ToList();
            ViewBag.VenCodSoft = lCodVenl;

            return View();
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR)]
        public ActionResult Clientes()
        {
            List<ClientesModels> ListClientes = new List<ClientesModels>();
            var listClientes = controlDisofi().listarClientes();

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
            List<ParametrosModels> para = controlDisofi().BuscarParametros();

            ViewBag.Parametros = para;

            return View();
        }

        #endregion

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
            List<UsuariosModels> busuario = controlDisofi().BuscarUsuario(Usuario);
            ViewBag.buscarusuarios = busuario;

            List<UsuariosTiposModels> ltipo = controlDisofi().listarTipo();
            ViewBag.tipo = ltipo;

            List<VendedoresSoftlandModels> LisVendedoresSoftland = controlDisofi().ListarVendedoresSoftland(busuario[0].VenCod.Trim());
            ViewBag.vendedorSoftland = LisVendedoresSoftland;

            return View();
        }

        [HttpPost]
        public JsonResult Addusuario(string _Usuario, string _Nombre, string _Contrasena, string _Email, string _Perfil, string _VenCod)
        {
            if (!string.IsNullOrEmpty(_Usuario) && !string.IsNullOrEmpty(_Nombre) && !string.IsNullOrEmpty(_Contrasena) && !string.IsNullOrEmpty(_Perfil) && !string.IsNullOrEmpty(_VenCod))
            {
                UsuariosModels usuario = new UsuariosModels()
                {
                    Usuario = _Usuario,
                    Nombre = _Nombre,
                    Password = HashMd5.GetMD5(_Contrasena),
                    email = _Email,
                    tipoUsuario = _Perfil,
                    VenCod = _VenCod
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
                RespuestaModel result = controlDisofi().EditarUsuario(usuarios);
                return (Json(result));
            }
            else
            {
                var result = -666;
                return Json(result);
            }
        }

        public JsonResult EditarCliente()
        {
            var validador = 1;
            return Json(validador);
        }

        public JsonResult ObtenerDatosUsuario(string _IdUsuario)
        {
            List<UsuariosModels> usuarios = controlDisofi().GetDatosUsuario(_IdUsuario);
            return Json(new { list = usuarios }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult obtenerDatosClientes(string _CodAux)
        {
            List<ClientesModels> clientes = controlDisofi().GetDatosClientes(_CodAux);
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

            List<UsuariosModels> busuario = controlDisofi().BuscarUsuario(Usuario);
            ViewBag.buscarusuarios = busuario;

            List<UsuariosTiposModels> ltipo = controlDisofi().listarTipo();
            ViewBag.tipo = ltipo;

            List<VendedoresSoftlandModels> LisVendedoresSoftland = controlDisofi().ListarVendedoresSoftland(busuario[0].VenCod);
            ViewBag.vendedorSoftland = LisVendedoresSoftland;

            return View();
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Parametros(FormCollection frm)
        {
            int numero;
            if (Request.Form["valorRadio"].ToString() == "P")
            {
                numero = 0;
            }
            else
            {
                numero = 1;
            }
            ParametrosModels apo = new ParametrosModels();
            apo.Aprobador = numero;

            List<ParametrosModels> lis = controlDisofi().ModificarParametros(apo);

            List<ParametrosModels> para = controlDisofi().BuscarParametros();

            ViewBag.Parametros = para;

            return View();
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Clientes(FormCollection frm)
        {
            return View();
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditCliente(FormCollection frm)
        {
            //ClientesModels cliente = new ClientesModels();
            //cliente.RutAux = Request.Form["txtrut"];

            //return View();
            ClientesModels cliente = new ClientesModels();

            cliente.CodAux = Request.Form["txtcodAux"];
            cliente.RutAux = Request.Form["txtrut"];
            cliente.NomAux = Request.Form["txtnombre"];
            cliente.NomCon = Request.Form["txtcontacto"];
            cliente.FonCon = Request.Form["txttelefono"];
            cliente.DirAux = Request.Form["txtdireccion"];
            cliente.EMail = Request.Form["txtemail"];

            RespuestaModel result = controlDisofi().ActualizarCliente(cliente);

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

        #endregion
    }
}