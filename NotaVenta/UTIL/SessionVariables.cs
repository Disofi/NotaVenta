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
            get { return (ObjetoUsuario)HttpContext.Current.Session["EWRWEFVREFGVR"]; }
            set { HttpContext.Current.Session["EWRWEFVREFGVR"] = value; }
        }
        public static List<UsuarioEmpresaModel> SESSION_EMPRESAS_USUARIO
        {
            get { return (List<UsuarioEmpresaModel>)HttpContext.Current.Session["CNDSKOAOIODSFAF"]; }
            set { HttpContext.Current.Session["CNDSKOAOIODSFAF"] = value; }
        }

        public static List<ClientesModels> SESSION_BUSCAR_CLIENTE
        {
            get { return (List<ClientesModels>)HttpContext.Current.Session["FERTG54YHTR"]; }
            set { HttpContext.Current.Session["FERTG54YHTR"] = value; }
        }

        public static NotadeVentaCabeceraModels SESSION_NOTA_VENTA_CABECERA_MODEL
        {
            get { return (NotadeVentaCabeceraModels)HttpContext.Current.Session["4RTG54Y65EY"]; }
            set { HttpContext.Current.Session["4RTG54Y65EY"] = value; }
        }
    }
}
