using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UTIL.Objetos;
using System.Web.Mvc;
using UTIL.Models;

namespace NotaVenta.UTIL
{
    public class SessionVariables
    {
        public static ObjetoUsuario SESSION_DATOS_USUARIO
        {
            get { return (ObjetoUsuario)HttpContext.Current.Session["DatosUsuario"]; }
            set { HttpContext.Current.Session["DatosUsuario"] = value; }
        }

        public static List<ClientesModels> SESSION_BUSCAR_CLIENTE
        {
            get { return (List<ClientesModels>)HttpContext.Current.Session["buscarCliente"]; }
            set { HttpContext.Current.Session["buscarCliente"] = value; }
        }

        public static NotadeVentaCabeceraModels SESSION_NOTA_VENTA_CABECERA_MODEL
        {
            get { return (NotadeVentaCabeceraModels)HttpContext.Current.Session["NotadeVentaCabeceraModels"]; }
            set { HttpContext.Current.Session["NotadeVentaCabeceraModels"] = value; }
        }
    }
}
