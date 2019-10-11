using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace NotaVenta.UTIL
{
    public class FTP
    {
        public static void enviarArchivo(string path)
        {
            FtpWebRequest ftpRequest;
            FtpWebResponse ftpResponse;
            try
            {
                string nombreArchivo = new System.IO.FileInfo(path).Name;
                string extensionArchivo = new System.IO.FileInfo(nombreArchivo).Extension;
                nombreArchivo = nombreArchivo.Replace(extensionArchivo, "");

                //define os requesitos para se conectar com o servidor
                ftpRequest = (FtpWebRequest)WebRequest.Create(
                    "ftp://" +
                    appSettingsConstantes.FTP_SERVIDOR + @"/" + appSettingsConstantes.FTP_CARPETA +
                    "/" +
                    nombreArchivo + extensionArchivo
                    );

                ftpRequest.Method = WebRequestMethods.Ftp.UploadFile;
                ftpRequest.Proxy = null;
                ftpRequest.UseBinary = appSettingsConstantes.FTP_USE_BINARY;
                ftpRequest.Timeout = 480000;
                ftpRequest.Credentials = new NetworkCredential(
                    appSettingsConstantes.FTP_USUARIO, 
                    appSettingsConstantes.FTP_CONTRASENA);

                FileInfo arquivo = new FileInfo(path);
                byte[] fileContents = new byte[arquivo.Length];

                using (FileStream fr = arquivo.OpenRead())
                {
                    fr.Read(fileContents, 0, Convert.ToInt32(arquivo.Length));
                }

                using (Stream writer = ftpRequest.GetRequestStream())
                {
                    writer.Write(fileContents, 0, fileContents.Length);
                }

                ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
            }
            catch (Exception err)
            {
            }

        }
    }
}