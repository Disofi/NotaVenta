using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Models
{
    public class ProductoAgregadoModel
    {
        public decimal PrecioUnitario { get; set; }
        public decimal Cantidad { get; set; }
        public List<decimal> Descuentos { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Total { get; set; }
    }
}
