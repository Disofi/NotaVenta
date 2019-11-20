using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotaVenta.UTIL
{
    public class JsonResultResponse
    {
        public static JsonResult ObtenerResponse<T>(T objeto)
        {
            JsonResult jsonResult = new JsonResult();

            jsonResult.Data = objeto;

            jsonResult.MaxJsonLength = int.MaxValue;

            return jsonResult;
        }
    }
}