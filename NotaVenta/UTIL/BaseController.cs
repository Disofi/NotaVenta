using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NotaVenta.UTIL.Error;
using UTIL.Models;

namespace NotaVenta.UTIL
{
    public class BaseController : Controller
    {
        private ControlDisofi _control = new ControlDisofi();

        public string baseDatosUsuario()
        {
            return SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.BaseDatos;
        }
        public UsuarioEmpresaModel EmpresaUsuario()
        {
            return SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel;
        }
        public string codigoVendedorUsuario()
        {
            return SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.VenCod;
        }
        public ParametrosModels ObtieneParametros(int idEmpresa = -1)
        {
            if (idEmpresa == -1) { idEmpresa = SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.IdEmpresa; }
            return controlDisofi().BuscarParametros(idEmpresa);
        }

        public ControlDisofi controlDisofi()
        {
            return _control;
        }

        public JsonResult SeleccionaEmpresa(int _IdEmpresa)
        {
            UsuarioEmpresaModel ue = new UsuarioEmpresaModel();
            List<UsuarioEmpresaModel> empresas = controlDisofi().ListaUsuarioEmpresas(SessionVariables.SESSION_DATOS_USUARIO.IdUsuario);
            UsuarioEmpresaModel usuarioEmpresaModel = empresas.Where(m => m.IdEmpresa == _IdEmpresa).First();
            SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel = usuarioEmpresaModel;

            return Json(new { Validador = 1, NombreEmpresa = usuarioEmpresaModel.NombreEmpresa });
        }

        public ActionResult AbrirError(Errores.ERRORES codigoError, TipoAccionError.TIPO_ACCION_BTN tipoAccionBtn)
        {
            return RedirectToAction("Index", "Error", new { codigoError = codigoError, tipoAccionBtn = tipoAccionBtn });
        }
        public ActionResult AbrirError(Errores.ERRORES codigoError, TipoAccionError.TIPO_ACCION_BTN tipoAccionBtn,
            string controller, string action, string texto)
        {
            return RedirectToAction("Index", "Error", new { codigoError = codigoError, tipoAccionBtn = tipoAccionBtn, controller = controller, action = action, texto = texto });
        }
    }
}