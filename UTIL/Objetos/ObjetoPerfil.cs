using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Objetos
{
    public class ObjetoPerfil
    {
        private int _ID;
        private string _Nombre;
        private string _Descripcion;
        private string _tipoUsuario;
        private int _Estado;

        public int ID { get => _ID; set => _ID = value; }
        public string Nombre { get => _Nombre; set => _Nombre = value; }
        public string Descripcion { get => _Descripcion; set => _Descripcion = value; }
        public int Estado { get => _Estado; set => _Estado = value; }
        public string TipoUsuario { get => _tipoUsuario; set => _tipoUsuario = value; }
    }
}
