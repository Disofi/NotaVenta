using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NotaVenta.UTIL.Error;

namespace NotaVenta.UTIL
{
    public class BaseController : Controller
    {
        private ControlDisofi _control = new ControlDisofi();

        public string baseDatosUsuario()
        {
            return SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.BaseDatos;
        }

        public ControlDisofi controlDisofi()
        {
            return _control;
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