﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UTIL.Models
{
    public class UsuarioEmpresaModel
    {
        public int IdUsuario { get; set; }
        public int IdEmpresa { get; set; }
        public string NombreEmpresa { get; set; }
        public string BaseDatos { get; set; }
    }
}