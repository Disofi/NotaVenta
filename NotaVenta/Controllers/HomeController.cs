using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NotaVenta.UTIL;
using NotaVenta.UTIL.FilterAttributes;

namespace NotaVenta.Controllers
{
    [Autorizacion()]
    public class HomeController : BaseController
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
    }
}