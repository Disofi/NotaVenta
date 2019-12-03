using NotaVenta.UTIL;
using NotaVenta.UTIL.FilterAttributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.Mvc;
using UTIL.Models;
using UTIL.Objetos;

namespace NotaVenta.Controllers
{
    public class ReporteController : BaseController
    {
        #region Vistas

        public ActionResult Index()
        {
            return null;
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR, PERFILES.APROBADOR, PERFILES.VENDEDOR)]
        public ActionResult FacturasPendientes()
        {
            ParametrosModels parametros = ObtieneParametros();

            ViewBag.Parametros = parametros;

            List<NotadeVentaCabeceraModels> doc = new List<NotadeVentaCabeceraModels>();
            var docPendientes = controlDisofi().listarDocPendientes(baseDatosUsuario(), EmpresaUsuario().IdEmpresa);

            if (docPendientes != null)
            {
                doc = docPendientes;
            }

            foreach (var item in doc)
            {
                for (int i = 0; i < doc.Count; i++)
                {
                    List<SaldosModel> Saldos = new List<SaldosModel>();
                    Saldos = controlDisofi().ObtenerSaldo(doc[i].RutAux, doc[i].CodAux, baseDatosUsuario());
                    if (Saldos != null && Saldos.Count > 0)
                    {
                        doc[i].Saldo = 0;
                        foreach (SaldosModel itemSaldo in Saldos)
                        {
                            doc[i].Saldo = doc[i].Saldo + itemSaldo.Saldo;
                        }
                    }
                }
            }


            ViewBag.doc = doc;

            return View();
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR, PERFILES.APROBADOR, PERFILES.VENDEDOR)]
        public ActionResult FacturasRechazadas()
        {
            List<NotadeVentaCabeceraModels> doc = new List<NotadeVentaCabeceraModels>();
            var docPendientes = controlDisofi().listarDocRechazadas(baseDatosUsuario(), EmpresaUsuario().IdEmpresa);

            if (docPendientes != null)
            {
                doc = docPendientes;
            }

            ViewBag.doc = doc;

            return View();
        }

        [HttpPost]
        public JsonResult FacturasPendientes(int _nvId)
        {
            NotadeVentaCabeceraModels NVC = new NotadeVentaCabeceraModels();
            List<NotadeVentaCabeceraModels> NVCL = new List<NotadeVentaCabeceraModels>();
            NotaDeVentaDetalleModels NVD = new NotaDeVentaDetalleModels();
            List<NotaDeVentaDetalleModels> NVDL = new List<NotaDeVentaDetalleModels>();

            NVC.Id = _nvId;
            NVD.Id = _nvId;

            var nvc = controlDisofi().BuscarNVC(NVC, baseDatosUsuario());

            if (nvc != null)
            {
                NVCL = nvc;
            }
            else
            {
                ViewBag.mensaje = 1;
                ViewBag.NVnum = _nvId;
                return Json(new { Mensaje = ViewBag.mensaje, nvNum = ViewBag.NVnum });
            }

            ViewBag.cabecera = NVCL;

            var nvd = controlDisofi().BuscarNVD(NVD, baseDatosUsuario());

            if (nvd != null)
            {
                NVDL = nvd;
            }

            ViewBag.detalle = NVDL;

            return Json(new { Cabecera = NVCL, Detalle = NVDL, Mensaje = ViewBag.mensaje, NVNumero = ViewBag.NVnum }, JsonRequestBehavior.AllowGet);
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR, PERFILES.APROBADOR, PERFILES.VENDEDOR)]
        public ActionResult FacturasAprobadas()
        {
            List<NotadeVentaCabeceraModels> doc = new List<NotadeVentaCabeceraModels>();
            var docAprobados = controlDisofi().listarDocAprobados(baseDatosUsuario(), EmpresaUsuario().IdEmpresa);

            ParametrosModels parametros = ObtieneParametros();

            ViewBag.Parametros = parametros;

            if (docAprobados != null)
            {
                doc = docAprobados;
            }

            ViewBag.doc = doc;

            return View();
        }

        [HttpPost]
        public JsonResult FacturasAprobadas(int _nvId)
        {
            NotadeVentaCabeceraModels NVC = new NotadeVentaCabeceraModels();
            List<NotadeVentaCabeceraModels> NVCL = new List<NotadeVentaCabeceraModels>();
            NotaDeVentaDetalleModels NVD = new NotaDeVentaDetalleModels();
            List<NotaDeVentaDetalleModels> NVDL = new List<NotaDeVentaDetalleModels>();

            NVC.Id = _nvId;
            NVD.Id = _nvId;

            var nvc = controlDisofi().BuscarNVC(NVC, baseDatosUsuario());

            if (nvc != null)
            {
                NVCL = nvc;
            }
            else
            {
                ViewBag.mensaje = 1;
                ViewBag.NVnum = _nvId;
                return Json(new { Mensaje = ViewBag.mensaje, nvNum = ViewBag.NVnum });
            }

            ViewBag.cabecera = NVCL;

            var nvd = controlDisofi().BuscarNVD(NVD, baseDatosUsuario());

            if (nvd != null)
            {
                NVDL = nvd;
            }

            ViewBag.detalle = NVDL;

            return Json(new { Cabecera = NVCL, Detalle = NVDL, Mensaje = ViewBag.mensaje, NVNumero = ViewBag.NVnum }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        [HttpPost]
        public JsonResult AprobarNotaVenta(int _nvId)
        {
            NotadeVentaCabeceraModels notaVenta = new NotadeVentaCabeceraModels();

            ParametrosModels para = ObtieneParametros();

            notaVenta.Id = _nvId;

            List<NotadeVentaCabeceraModels> proceso = controlDisofi().actualizaEstado(notaVenta, baseDatosUsuario());

            NotadeVentaCabeceraModels cabecera = controlDisofi().GetCab(_nvId);
            try
            {
                List<string> paraEmail = new List<string>();

                var IdAprobador = SessionVariables.SESSION_DATOS_USUARIO.IdUsuario;

                List<VendedorModels> vendedores = controlDisofi().GetVendedores(baseDatosUsuario(), new VendedorModels { VenCod = cabecera.VenCod });
                List<AprobadorModels> aprobador = controlDisofi().GetAprobador(IdAprobador);
                List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), new ClientesModels { CodAux = cabecera.CodAux });

                if (para.EnvioMailVendedor)
                {
                    if (vendedores != null && vendedores.Count > 0)
                    {
                        if (vendedores[0].Email != null && vendedores[0].Email != "")
                        {
                            paraEmail.Add(vendedores[0].Email);
                        }
                    }
                }
                if (para.EnvioMailCliente)
                {
                    if (vendedores != null && vendedores.Count > 0)
                    {
                        if (clientes[0].EMail != null && clientes[0].EMail != "")
                        {
                            paraEmail.Add(clientes[0].EMail);
                        }
                    }
                }
                if (para.EnvioMailAprobador)
                {
                    if (vendedores != null && vendedores.Count > 0)
                    {
                        if (vendedores[0].Email != null && vendedores[0].Email != "")
                        {
                            paraEmail.Add(vendedores[0].Email);
                        }
                    }
                }

                if (cabecera.CodiCC != null && cabecera.CodiCC.Trim().Equals("01"))
                {
                    string correoTemporal = System.Configuration.ConfigurationManager.AppSettings["CorreoSantiago"];
                    if (correoTemporal != null && correoTemporal != "")
                    {
                        paraEmail.Add(correoTemporal);
                    }
                }
                if (cabecera.CodiCC != null && cabecera.CodiCC.Trim().Equals("02"))
                {
                    string correoTemporal = System.Configuration.ConfigurationManager.AppSettings["CorreoConcepcion"];
                    if (correoTemporal != null && correoTemporal != "")
                    {
                        paraEmail.Add(correoTemporal);
                    }
                }
                if (cabecera.CodiCC != null && cabecera.CodiCC.Trim().Equals("12"))
                {
                    string correoTemporal = System.Configuration.ConfigurationManager.AppSettings["CorreoTemuco"];
                    if (correoTemporal != null && correoTemporal != "")
                    {
                        paraEmail.Add(correoTemporal);
                    }
                }
                {
                    string correoTemporal = System.Configuration.ConfigurationManager.AppSettings["CorreoSiempre"];
                    if (correoTemporal != null && correoTemporal != "")
                    {
                        paraEmail.Add(correoTemporal);
                    }
                }


                EnviarEmail(cabecera.NVNumero, notaVenta.Id, paraEmail);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return Json(new { nvNum = proceso[0].NVNumero });
            }

            return Json(new { nvNum = proceso[0].NVNumero });
        }

        [HttpPost]
        public JsonResult RechazarNotaVenta(int _nvId, int _nvNum)
        {
            NotadeVentaCabeceraModels notaventa = new NotadeVentaCabeceraModels();
            notaventa.Id = _nvId;
            List<NotadeVentaCabeceraModels> proceso = controlDisofi().RechazarNP(notaventa);

            return Json(new { nvNum = _nvId });
        }

        [NonAction]
        public void EnviarEmail(int nvnumero, int Id, List<string> para)
        {
            string subject = string.Format("Nota de Pedido: " + Id + " Aprobada", Id);

            string from = System.Configuration.ConfigurationManager.AppSettings.Get("Para");
            string displayName = System.Configuration.ConfigurationManager.AppSettings.Get("Remitente");
            string password = System.Configuration.ConfigurationManager.AppSettings.Get("ClaveCorreo");
            string host = System.Configuration.ConfigurationManager.AppSettings.Get("Host");
            int port = Int32.Parse(System.Configuration.ConfigurationManager.AppSettings.Get("Port"));
            bool enableSs1 = Boolean.Parse(System.Configuration.ConfigurationManager.AppSettings.Get("EnableSsl"));
            bool useDefaultCredentials = Boolean.Parse(System.Configuration.ConfigurationManager.AppSettings.Get("UseDefaultCredentials"));


            var fromEmail = new MailAddress(from, displayName);

            var smtp = new SmtpClient
            {
                Host = host,
                Port = port,
                EnableSsl = enableSs1,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = useDefaultCredentials,
                Credentials = new NetworkCredential(fromEmail.Address, password)
            };

            List<NotadeVentaCabeceraModels> NVentaCabeceras = controlDisofi().BuscarNVPorNumero(Id, baseDatosUsuario());

            List<NotaDeVentaDetalleModels> NVentaDetalles = controlDisofi().BuscarNVDETALLEPorNumero(Id, baseDatosUsuario());

            ClientesModels cliente = new ClientesModels
            {
                CodAux = NVentaCabeceras[0].CodAux,
            };
            List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), cliente);



            MailMessage mail = new MailMessage
            {
                IsBodyHtml = true
            };
            mail.AlternateViews.Add(GetEmbeddedImage(NVentaCabeceras, NVentaDetalles, clientes));
            mail.From = new MailAddress(from);

            foreach (string item in para)
            {
                mail.To.Add(item);
            }

            if (mail != null)
            {
                mail.Subject = subject;
                smtp.Send(mail);
            }
        }

        private AlternateView GetEmbeddedImage(List<NotadeVentaCabeceraModels> NVentaCabeceras,
        List<NotaDeVentaDetalleModels> NVentaDetalles, List<ClientesModels> Clientes)
        {
            ParametrosModels parametro = ObtieneParametros();

            char[] blanco = { ' ' };

            int colspan = 7;

            if (parametro.DescuentoLineaDirectoSoftland)
            {
                colspan = colspan + parametro.CantidadDescuentosProducto;
            }

            string htmlBody = String.Format(
            "<html><body>" +
            //"<img src='~/Image/logo.png' />" +
            "<H1> APROBACIÓN DE NOTA DE PEDIDO </H1>" +
            @"<H4> Nº de Cotización Interno: " + NVentaCabeceras[0].Id + @" </H4>" +
            @"<H4> Nº de Softland: " + NVentaCabeceras[0].NVNumero + @" </H4>" +
            @"<H4> Fecha Pedido: " + (NVentaCabeceras[0].nvFem == null ? "" : ((DateTime)NVentaCabeceras[0].nvFem).ToShortDateString()) + @" </H4>" +
            @"<H4> Cliente: " + NVentaCabeceras[0].NomAux + @" </H4>" +
            @"<H4> Dirección: " + Clientes[0].DirAux + @" </H4>" +
            @"<H4> Fecha Entrega: " + (NVentaCabeceras[0].nvFeEnt == null ? "" : ((DateTime)NVentaCabeceras[0].nvFeEnt).ToShortDateString()) + @" </H4>" +
            @"<H4> Observaciones: " + NVentaCabeceras[0].nvObser + @" </H4>" +
            @"<H4> Vendedor: " + SessionVariables.SESSION_DATOS_USUARIO.VenDes.ToString() + @" </H4>" +
            @"<table border = ""1"" >" +
            @"<tr>" +
            @"<td>ID</td>" +
            @"<th nowrap=""nowrap"">Codigo Producto</th>" +
            @"<th>Descripcion</th>" +
            @"<th>Cantidad</th>" +
            @"<th>Precio</th>" +
            @"<th>Sub-Total</th>");

            if (parametro.DescuentoLineaDirectoSoftland)
            {
                for (int x = 0; x < parametro.CantidadDescuentosProducto; x++)
                {
                    htmlBody = htmlBody + @"<th>Descuento N°" + (x + 1) + "</th>";
                }
            }

            htmlBody = htmlBody + String.Format(@"<th>Iva    </th>" +
            @"<th>Total   </th>" +
            @"</tr>");

            ProductosModels producto = new ProductosModels();
            List<LinkedResource> resources = new List<LinkedResource>();
            double Iva = 0;
            double subtotal = 0;
            double ivaux = 0;
            foreach (NotaDeVentaDetalleModels nvd in NVentaDetalles)
            {
                double precioConIVa = Math.Round(nvd.nvSubTotal * 1.19);
                subtotal = subtotal + nvd.nvSubTotal;
                Iva = (precioConIVa - nvd.nvSubTotal);
                ivaux = ivaux + Iva;
                producto.CodProd = nvd.CodProd;
                htmlBody = htmlBody + @"<tr>" +
                           @"<td>" + nvd.nvLinea + @"</td>" +
                           @"<td>" + nvd.CodProd + @"</td>" +
                           @"<td>" + nvd.DesProd + @"</td>" +
                           @"<td style='text-align: right;'>" + nvd.nvCant + @"</td>" +
                           @"<td style='text-align: right;'>" + "$ " + nvd.nvPrecio.ToString("N0") + @"</td>" +
                           @"<td style='text-align: right;'>" + "$ " + nvd.nvSubTotal.ToString("N0") + @"</td>";



                if (parametro.DescuentoLineaDirectoSoftland)
                {
                    for (int x = 0; x < parametro.CantidadDescuentosProducto; x++)
                    {
                        switch (x)
                        {
                            case 0:
                                { htmlBody = htmlBody + @"<td style='text-align: right;'>" + "$ " + nvd.nvDDescto01 + @"</td>"; }
                                break;
                            case 1:
                                { htmlBody = htmlBody + @"<td style='text-align: right;'>" + "$ " + nvd.nvDDescto02 + @"</td>"; }
                                break;
                            case 2:
                                { htmlBody = htmlBody + @"<td style='text-align: right;'>" + "$ " + nvd.nvDDescto03 + @"</td>"; }
                                break;
                            case 3:
                                { htmlBody = htmlBody + @"<td style='text-align: right;'>" + "$ " + nvd.nvDDescto04 + @"</td>"; }
                                break;
                            case 4:
                                { htmlBody = htmlBody + @"<td style='text-align: right;'>" + "$ " + nvd.nvDDescto05 + @"</td>"; }
                                break;
                        }
                    }
                }

                htmlBody = htmlBody + @"<td style='text-align: right;'>" + "$ " + Iva.ToString("N0") + @"</td>" +
                           @"<td style='text-align: right;'>" + "$ " + precioConIVa.ToString("N0") + @"</td>" +
                           @"</tr>";
            }
            htmlBody += @"<tr><th style='text-align: right;' colspan =" + colspan + @">Sub Total</th><td style='text-align: right;'>" + "$ " + subtotal.ToString("N0") + @"</td></tr>" +
                        @"<tr><th style='text-align: right;' colspan =" + colspan + @">Total Iva</th><td style='text-align: right;'>" + "$ " + ivaux.ToString("N0") + @"</td></tr>" +
                        @"<tr><th style='text-align: right;' colspan =" + colspan + @">Total</th><td style='text-align: right;'>" + "$ " + NVentaCabeceras[0].TotalBoleta.ToString("N0") + @"</td></tr>";
            htmlBody += @" </body></html>";

            AlternateView alternateView = AlternateView.CreateAlternateViewFromString(htmlBody, null, MediaTypeNames.Text.Html);
            foreach (LinkedResource r in resources)
            {
                alternateView.LinkedResources.Add(r);
            }
            return alternateView;
        }

        public ActionResult ListarNotasdeDetalle(int nvNumero)
        {
            try
            {

                NotadeVentaCabeceraModels NVC = new NotadeVentaCabeceraModels();
                List<NotadeVentaCabeceraModels> NVCL = new List<NotadeVentaCabeceraModels>();
                NotaDeVentaDetalleModels NVD = new NotaDeVentaDetalleModels();
                List<NotaDeVentaDetalleModels> NVDL = new List<NotaDeVentaDetalleModels>();

                NVC.NVNumero = nvNumero;
                NVD.NVNumero = nvNumero;

                var listaNVD = controlDisofi().ListarNotaDetalle(NVD);

                if (listaNVD != null)
                {
                    NVDL = listaNVD;
                }

                ViewBag.NVDL = NVDL;

                return View();
            }
            catch (Exception ex)
            {
                return View(ex.Message);
            }

        }

        public JsonResult ObtenerSaldo()
        {
            return Json(1, JsonRequestBehavior.AllowGet);
        }
    }
}