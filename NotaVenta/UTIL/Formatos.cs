using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotaVenta.UTIL
{
    public class Formatos
    {
        public static string ObtenerFormatoMoneda(double? numero, string simboloAntes = "", string valorDefecto = "")
        {
            if (numero == null)
            {
                return valorDefecto;
            }
            else
            {
                return simboloAntes + ((double)numero).ToString("N0");
            }
        }
    }
}