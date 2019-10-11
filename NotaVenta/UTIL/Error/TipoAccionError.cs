using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotaVenta.UTIL.Error
{
    public class TipoAccionError
    {
        public enum TIPO_ACCION_BTN
        {
            SIN_ACCION = 1,
            IR_ATRAS = 2,
            IR_LOGIN = 3,
            IR_PERSONALIZADO = 4
        }
    }
}