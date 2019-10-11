using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using cm = System.Configuration.ConfigurationManager;

namespace NotaVenta.UTIL
{
    public class appSettingsConstantes
    {
        public static String FTP_USUARIO { get { return cm.AppSettings["ftp_usuario"]; } }
        public static String FTP_CONTRASENA { get { return cm.AppSettings["ftp_contrasena"]; } }
        public static String FTP_SERVIDOR { get { return cm.AppSettings["ftp_servidor"]; } }
        public static String FTP_CARPETA { get { return cm.AppSettings["ftp_carpeta"]; } }
        public static bool FTP_USE_BINARY { get { return Convert.ToBoolean(cm.AppSettings["ftp_useBinary"]); } }
    }
}