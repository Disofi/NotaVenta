using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NotaVenta.UTIL;
using NotaVenta.UTIL.Error;

namespace NotaVenta.Controllers
{
    public class ErrorController : BaseController
    {
        // GET: Error
        public ActionResult Index(Errores.ERRORES codigoError, TipoAccionError.TIPO_ACCION_BTN tipoAccionBtn,
            string __controller, string __action, string texto)
        {
            ErrorModel errorModel = Errores.obtenerError(codigoError);
            ViewBag.CodigoError = errorModel.CodigoError;
            ViewBag.Titulo = errorModel.Titulo;
            ViewBag.Mensaje = errorModel.Mensaje;
            //<a href="@Url.Action("Login","Home")" class="btn btn-success p-l-20 p-r-20">Go Home</a>
            switch (tipoAccionBtn)
            {
                case TipoAccionError.TIPO_ACCION_BTN.SIN_ACCION:
                    {
                        ViewBag.TIPO_ACCION_BTN = "";
                        break;
                    }
                case TipoAccionError.TIPO_ACCION_BTN.IR_ATRAS:
                    {
                        ViewBag.TIPO_ACCION_BTN = "<a href='javascript:history.back()' class='btn btn-success p-l-20 p-r-20'>Volver</a>";
                        break;
                    }
                case TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN:
                    {
                        ViewBag.TIPO_ACCION_BTN = "<a href='" + Url.Action("Login", "Login") + "' class='btn btn-success p-l-20 p-r-20'>Ir al Login</a>";
                        break;
                    }
                case TipoAccionError.TIPO_ACCION_BTN.IR_PERSONALIZADO:
                    {
                        ViewBag.TIPO_ACCION_BTN = "<a href='" + Url.Action(__action, __controller) + "' class='btn btn-success p-l-20 p-r-20'>" + texto + "</a>";
                        break;
                    }
                default:
                    {
                        ViewBag.TIPO_ACCION_BTN = "";
                        break;
                    }
            }

            return View();
        }
    }
}