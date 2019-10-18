using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Objetos
{
    public class CreditoModel
    {
        public decimal Credito { get; set; }
        public decimal Deuda { get; set; }
        public decimal Saldo { get; set; }
        public decimal Debe { get; set; }
        public decimal Haber { get; set; }
        public string StrCredito { get; set; }
        public string StrDeuda { get; set; }
        public string StrSaldo { get; set; }
    }
}
