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

        
        public int DiasVen { get; set; }
        public string movtipdocref { get; set; }
        public string nomtdref { get; set; }
        public DateTime cpbfec { get; set; }
        public string cpbfecString { get { return this.cpbfec == null ? "" : cpbfec.ToString("dd/MM/yyyy"); } }
        public DateTime movfv { get; set; }
        public string movfvString { get { return this.movfv == null ? "" : movfv.ToString("dd/MM/yyyy"); } }
        public string ttdcod { get; set; }
        public string nomtd { get; set; }
        public string cpbnum { get; set; }
        public double movdebe { get; set; }
        public double movhaber { get; set; }
        public double haber { get; set; }
        public double debe { get; set; }
        public string NomB { get; set; }


        public string areacod { get; set; }
        public double? numdoc { get; set; }
        public string movglosa { get; set; }
    }
}
