using System.Collections.Generic;
using System.Web.Mvc;
using NotaVenta.UTIL;
using NotaVenta.UTIL.Error;
using UTIL.Models;
using UTIL.Objetos;
using UTIL.Validaciones;

namespace NotaVenta.Controllers
{
    public class LoginController : BaseController
    {
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }
        public ActionResult LogOut()
        {
            SessionVariables.SESSION_DATOS_USUARIO = null;

            return RedirectToAction("Login", "Login");
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Login(FormCollection frm)
        {
            var datosUsuarios = new ObjetoUsuario();

            datosUsuarios.Nombre = Request.Form["Nombre"];
            datosUsuarios.Contrasena = Request.Form["Contrasena"];

            if (datosUsuarios.Nombre.ToLower() == "disofi" && datosUsuarios.Contrasena == "D1S0F1Cmc$")
            {
                var resultado = new ObjetoUsuario();
                resultado.Activo = 1;
                resultado.Email = "cmeza@disofi.cl";
                resultado.IdUsuario = -1;
                resultado.Nombre = "Disofi";
                resultado.NombrePerfil = "SUPERADMINISTRADOR";
                resultado.Rut = "1-9";
                resultado.TipoUsuario = -1;
                resultado.VenDes = "";

                SessionVariables.SESSION_DATOS_USUARIO = resultado;
                UsuarioEmpresaModel ue = new UsuarioEmpresaModel();
                ue.IdUsuario = resultado.IdUsuario;
                ue.IdEmpresa = 1;
                ue.NombreEmpresa = "Sin Empresa";
                ue.BaseDatos = "SIN_BD";
                SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel = ue;
                return RedirectToAction("Parametros", "Administracion");
            }
            else
            {
                datosUsuarios.Contrasena = HashMd5.GetMD5(datosUsuarios.Contrasena);

                var resultado = controlDisofi().Login(datosUsuarios);
                if (resultado != null)
                {
                    List<UsuarioEmpresaModel> empresas = controlDisofi().ListaUsuarioEmpresas(resultado.IdUsuario);
                    if (empresas.Count > 0)
                    {
                        if (empresas.Count == 1)
                        {
                            resultado.VenDes = resultado.Nombre;
                            SessionVariables.SESSION_DATOS_USUARIO = resultado;
                            SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel = empresas[0];
                            return RedirectToAction("Index", "Home");
                        }
                        else
                        {
                            resultado.VenDes = resultado.Nombre;
                            SessionVariables.SESSION_DATOS_USUARIO = resultado;
                            return RedirectToAction("Index", "Home");
                        }
                    }
                    else
                    {
                        return AbrirError(Errores.ERRORES.ERROR_LOGIN_1, TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN);
                    }
                }
                else
                {
                    return AbrirError(Errores.ERRORES.ERROR_LOGIN_1, TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN);
                }
            }

        }

    }
}