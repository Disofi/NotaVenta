using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Objetos
{
    public class ObjetoUsuario
    {
        private int _IdUsuario;
        private string _Rut;
        private string _Contrasena;
        private string _Email;
        private int _TipoUsuario;
        private string _Nombre;
        private int _Activo;
        private string _VenCod;
        private string _VenDes;
        private string _NombrePerfil;

        public int IdUsuario { get => _IdUsuario; set => _IdUsuario = value; }
        public string Rut { get => _Rut; set => _Rut = value; }
        public string Contrasena { get => _Contrasena; set => _Contrasena = value; }
        public string Email { get => _Email; set => _Email = value; }
        public int TipoUsuario { get => _TipoUsuario; set => _TipoUsuario = value; }
        public string Nombre { get => _Nombre; set => _Nombre = value; }
        public int Activo { get => _Activo; set => _Activo = value; }
        public string VenCod { get => _VenCod; set => _VenCod = value; }
        public string VenDes { get => _VenDes; set => _VenDes = value; }
        public string NombrePerfil { get => _NombrePerfil; set => _NombrePerfil = value; }
    }
}
