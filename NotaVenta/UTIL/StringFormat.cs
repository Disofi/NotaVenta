using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotaVenta.UTIL
{
    public class StringFormat
    {
        public static String rellenarIzquierda(string cadena, char letraRelleno, int largoTotal)
        {
            string retorno = cadena;

            for (int x = cadena.Length; x < largoTotal; x++)
            {
                retorno = retorno.Insert(0, Convert.ToString(letraRelleno));
            }
            return retorno;
        }

        public static String rellenarDerecha(string cadena, char letraRelleno, int largoTotal)
        {
            string retorno = cadena;

            for (int x = cadena.Length; x < largoTotal; x++)
            {
                retorno = retorno.Insert(cadena.Length, Convert.ToString(letraRelleno));
            }
            return retorno;
        }
    }
}