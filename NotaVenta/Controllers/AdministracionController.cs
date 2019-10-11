using NotaVenta.UTIL;
using NotaVenta.UTIL.FilterAttributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UTIL.Models;
using UTIL.Objetos;

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

        public ActionResult AddUsuario()
        {
            List<UsuariosTiposModels> ltipo = controlDisofi().listarTipo();
            ViewBag.tipo = ltipo;

            List<VendedoresSoftlandModels> lvendedor = controlDisofi().listarVendedoresSoftland();
            ViewBag.vendedor = lvendedor;

            return View();
        }
        [HttpPost, ValidateInput(false)]

        public ActionResult AddUsuario(FormCollection frm)
        {
            UsuariosModels Usuarios = new UsuariosModels();
            Usuarios.Usuario = Request.Form["txtUsuario"];
            Usuarios.email = Request.Form["txtEmail"];
            Usuarios.tipoUsuario = Request.Form["cbxTipo"];
            Usuarios.VenCod = Request.Form["cbxUsuarioSoftland"];
            Usuarios.VenCod = Request.Form["cbxUsuarioSoftland"];
            Usuarios.Password = Request.Form["txtContrasena"];

            List<UsuariosModels> busuario = controlDisofi().AgregarUsuario(Usuarios);
            if (busuario == null || busuario.Count == 0)
            {
                TempData["Mensaje"] = "ERROR - Usuario Creado Correctamente. <br>";
                return RedirectToAction("AddUsuario", "Mantenedores");
            }
            else
            {
                TempData["Mensaje"] = "ERROR - Codigo de vendedor Repetido. <br>";
                return RedirectToAction("AddUsuario", "Mantenedores");
            }
        }

        public JsonResult EliminarUsuario(int _Id)
        {
            UsuariosModels usuarios = new UsuariosModels();
            usuarios.id = _Id;
            RespuestaModel result = controlDisofi().EliminarUsuario(usuarios);

            return (Json(result));
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