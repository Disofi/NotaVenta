using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Models
{
    public class CabeceraModel
    {
        public List<ProductoAgregadoModel> Productos { get; set; }
        public List<DescuentoProductoAgregadoModel> descuentos { get; set; }
        public int SubTotal { get; set; }
        public decimal SubTotalConDescuento { get; set; }
        public int Impuesto { get; set; }
        public int Total { get; set; }
    }
}
