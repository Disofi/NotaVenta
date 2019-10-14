using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotaVenta.UTIL.Error
{
    public class Errores
    {
        public static ErrorModel obtenerError(ERRORES error)
        {
            ErrorModel errorModel = null;

            switch (error)
            {
                case ERRORES.ERROR_LOGIN_1:
                    {
                        return errorModel = new ErrorModel(500, "Login", "Error de usuario y/o contrasena");
                    }
                case ERRORES.ERROR_SESSION_TERMINADA:
                    {
                        return errorModel = new ErrorModel(500, "Sesion terminada", "Sesion de usuario terminada");
                    }
                case ERRORES.ERROR_NO_AUTORIZADO:
                    {
                        return errorModel = new ErrorModel(401, "No Autorizado", "Usuario no esta autorizado a ver pagina solicitada");
                    }
                case ERRORES.ERROR_SIN_EMPRESAS:
                    {
                        return errorModel = new ErrorModel(500, "Empresas de Usuario", "Usuario no tiene empresas asociadas");
                    }
            };

            return errorModel;
        }

        public enum ERRORES
        {
            ERROR_LOGIN_1 = 1,
            ERROR_SESSION_TERMINADA = 2,
            ERROR_NO_AUTORIZADO = 3,
            ERROR_SIN_EMPRESAS = 4,
        }
    }
    public class ErrorModel
    {
        private int codigoError;
        private string titulo;
        private string mensaje;

        public ErrorModel(int codigoError, string titulo, string mensaje)
        {
            this.codigoError = codigoError;
            this.titulo = titulo;
            this.mensaje = mensaje;
        }

        public int CodigoError { get { return this.codigoError; } }
        public string Titulo { get { return this.titulo; } }
        public string Mensaje { get { return this.mensaje; } }
    }
}