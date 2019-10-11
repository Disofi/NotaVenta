using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Objetos
{
    public class ObjetoLogin
    {
        private int _idUsuario;
        private string _rut;
        private string _nombre;
        private int _idPerfil;
        private bool _autorizaModificacion;
        private bool _activo;
        private int _IdSucursal;
        private string _correo;


        public string correo
        {
            get { return _correo; }
            set { _correo = value; }
        }


        public int IdSucursal
        {
            get { return _IdSucursal; }
            set { _IdSucursal = value; }
        }


        public int IdUsuario
        {
            get { return _idUsuario; }
            set { _idUsuario = value; }
        }
        public string Rut
        {
            get { return _rut; }
            set { _rut = value; }
        }
        public string Nombre
        {
            get { return _nombre; }
            set { _nombre = value; }
        }
        public int IdPerfil
        {
            get { return _idPerfil; }
            set { _idPerfil = value; }
        }
        public bool AutorizaModificacion
        {
            get { return _autorizaModificacion; }
            set { _autorizaModificacion = value; }
        }
        public bool Activo
        {
            get { return _activo; }
            set { _activo = value; }
        }
    }
}
