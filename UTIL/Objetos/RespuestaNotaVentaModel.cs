using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Objetos
{
    public class RespuestaNotaVentaModel
    {
        public bool VerificadorDisofi { get; set; }
        public string MensajeDisofi { get; set; }
        public bool VerificadorSoftland { get; set; }
        public string MensajeSoftland { get; set; }
        public int IdNotaVenta { get; set; }
        public int NVNumero { get; set; }
    }
}
