using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Objetos
{
    public class SaldosModel
    {
        public string pccodi { get; set; }
        public string pcdesc { get; set; }
        public string codaux { get; set; }
        public string RutAux { get; set; }
        public string nomaux { get; set; }
        public DateTime fechaemi { get; set; }
        public string fechaemiString { get { return this.fechaemi == null ? "" : fechaemi.ToString("dd/MM/yyyy"); } }
        public string desdoc { get; set; }
        public double movnumdocref { get; set; }
        public double Saldo { get; set; }
        public string PCAUXI { get; set; }
        public string PCCDOC { get; set; }
        public string coddoc { get; set; }
        public string Cpbano { get; set; }
    }
}
