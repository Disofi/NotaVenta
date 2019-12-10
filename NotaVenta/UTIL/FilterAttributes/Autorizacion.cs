using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using NotaVenta.Controllers;
using NotaVenta.UTIL.Error;
using UTIL.Objetos;

namespace NotaVenta.UTIL.FilterAttributes
{
    public class Autorizacion : ActionFilterAttribute, IActionFilter
    {
        private readonly PERFILES[] perfiles;

        public Autorizacion(params PERFILES[] perfiles)
        {
            this.perfiles = perfiles;
        }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            string action = filterContext.ActionDescriptor.ActionName;
            string controller = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;

            ObjetoUsuario objetoUsuario = SessionVariables.SESSION_DATOS_USUARIO;

            //SESION TERMINADA
            if (objetoUsuario == null)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Error", action = "Index", codigoError = Errores.ERRORES.ERROR_SESSION_TERMINADA, tipoAccionBtn = TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN })
                    );

                filterContext.Result.ExecuteResult(filterContext.Controller.ControllerContext);
            }
            else
            {
                if (perfiles.ToList().Count > 0)
                {
                    if (perfiles.Where(m => Convert.ToInt32(m).Equals(objetoUsuario.TipoUsuario)).Count() == 0)
                    {
                        filterContext.Result = new RedirectToRouteResult(
                            new RouteValueDictionary(new { controller = "Error", action = "Index", codigoError = Errores.ERRORES.ERROR_NO_AUTORIZADO, tipoAccionBtn = TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN })
                            );

                        filterContext.Result.ExecuteResult(filterContext.Controller.ControllerContext);
                    }
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
    public enum PERFILES
    {
        SUPER_ADMINISTRADOR = -1,
        ADMINISTRADOR = 1,
        VENDEDOR = 2,
        APROBADOR = 3
    }
}