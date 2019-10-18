using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Models
{
    public class ProductoAgregadoModel
    {
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal Cantidad { get; set; }
        public decimal Stock { get; set; }
        public string UnidadMedida { get; set; }
        public List<DescuentoProductoAgregadoModel> Descuentos { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Total { get; set; }
        public string Talla { get; set; }
        public string Color { get; set; }
    }
}
