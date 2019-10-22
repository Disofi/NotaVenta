﻿using NotaVenta.UTIL;
using NotaVenta.UTIL.FilterAttributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
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

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR, PERFILES.APROBADOR)]
        public ActionResult FacturasPendientes()
        {
            List<NotadeVentaCabeceraModels> doc = new List<NotadeVentaCabeceraModels>();
            var docPendientes = controlDisofi().listarDocPendientes(baseDatosUsuario());

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

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.ADMINISTRADOR, PERFILES.APROBADOR)]
        public ActionResult FacturasAprobadas()
        {
            List<NotadeVentaCabeceraModels> doc = new List<NotadeVentaCabeceraModels>();
            var docAprobados = controlDisofi().listarDocAprobados(baseDatosUsuario());

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
            NVD.Id= _nvId;

            var nvc = controlDisofi().BuscarNVC(NVC,baseDatosUsuario());

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

            var nvd = controlDisofi().BuscarNVD(NVD,baseDatosUsuario());

            if (nvd != null)
            {
                NVDL = nvd;
            }

            ViewBag.detalle = NVDL;

            return Json(new {Cabecera = NVCL, Detalle = NVDL, Mensaje = ViewBag.mensaje, NVNumero = ViewBag.NVnum }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        [HttpPost]
        public JsonResult AprobarNotaVenta(int _nvId)
        {
            NotadeVentaCabeceraModels notaVenta = new NotadeVentaCabeceraModels();
            notaVenta.Id = _nvId;

            List<NotadeVentaCabeceraModels> proceso = controlDisofi().actualizaEstado(notaVenta,baseDatosUsuario());

            List<NotadeVentaCabeceraModels> doc = controlDisofi().listarDocPendientes(baseDatosUsuario());

            ViewBag.doc = doc;
            //VerificationEmail(notaVenta.NVNumero);
            return Json(proceso);
        }

        [NonAction]
        public void VerificationEmail(int nvnumero)
        {
            var de = "";
            var clavecorreo = "";
            var vendCodi = codigoVendedorUsuario();

            IEnumerable<_NotaDeVentaDetalleModels> datosAprobador = controlDisofi().DatosCorreoAprobador(vendCodi);
            foreach (_NotaDeVentaDetalleModels ot in datosAprobador)
            {
                de = ot.EmailVend;
                clavecorreo = ot.PassCorreo;
            }

            string to = System.Configuration.ConfigurationManager.AppSettings.Get("Para");
            string from = de;
            string displayName = System.Configuration.ConfigurationManager.AppSettings.Get("Remitente");
            string password = clavecorreo;
            string host = System.Configuration.ConfigurationManager.AppSettings.Get("Host");
            int port = Int32.Parse(System.Configuration.ConfigurationManager.AppSettings.Get("Port"));
            bool enableSs1 = Boolean.Parse(System.Configuration.ConfigurationManager.AppSettings.Get("EnableSsl"));
            bool useDefaultCredentials = Boolean.Parse(System.Configuration.ConfigurationManager.AppSettings.Get("UseDefaultCredentials"));


            var fromEmail = new MailAddress(from, displayName);
            var toEmail = new MailAddress(to);

            var smtp = new SmtpClient
            {
                Host = host,
                Port = port,
                EnableSsl = enableSs1,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = useDefaultCredentials,
                Credentials = new NetworkCredential(fromEmail.Address, password)
            };


            MailMessage mailWithImg = GetMailWithImg(nvnumero, vendCodi);
            if (mailWithImg != null)
            {
                smtp.Send(mailWithImg);
                //smtp.SendAsync(mailWithImg, mailWithImg);
            }
        }

        private MailMessage GetMailWithImg(int nvnumero, string vendCodi)
        {
            var de = "";
            var clavecorreo = "";
            //Correo aprobador

            IEnumerable<_NotaDeVentaDetalleModels> datosAprobador = controlDisofi().DatosCorreoAprobador(vendCodi);
            foreach (_NotaDeVentaDetalleModels ot in datosAprobador)
            {
                de = ot.EmailVend;
                clavecorreo = ot.PassCorreo;
            }

            string from = de;
            string subject = string.Format("Aprobación de Cotización {0}", nvnumero);

            NotadeVentaCabeceraModels NVentaCabecera = new NotadeVentaCabeceraModels
            {
                NVNumero = nvnumero
            };
            List<NotadeVentaCabeceraModels> NVentaCabeceras = controlDisofi().BuscarNVPorNumero(NVentaCabecera);

            List<NotaDeVentaDetalleModels> NVentaDetalles = controlDisofi().BuscarNVDETALLEPorNumero(NVentaCabecera);

            List<NotadeVentaCabeceraModels> NVsoft = controlDisofi().BuscarNVNum(NVentaCabecera);

            ClientesModels Vendedor = new ClientesModels
            {
                VenCod = NVentaCabeceras[0].VenCod
            };

            List<ClientesModels> vendedores = controlDisofi().GetVendedores(baseDatosUsuario(), Vendedor);

            MailMessage mail = new MailMessage
            {
                IsBodyHtml = true
            };

            mail.AlternateViews.Add(GetEmbeddedImage(NVentaCabeceras, NVentaDetalles, vendedores, NVsoft));
            mail.From = new MailAddress(from);

            if (vendedores != null)
            {
                mail.To.Add(vendedores[0].EMail);
                mail.Subject = subject;
                return mail;
            }
            else
            {
                return null;
            }
        }

        private AlternateView GetEmbeddedImage(List<NotadeVentaCabeceraModels> NVentaCabeceras,
        List<NotaDeVentaDetalleModels> NVentaDetalles, List<ClientesModels> Clientes, List<NotadeVentaCabeceraModels> NVSoft)
        {
            char[] blanco = { ' ' };

            string htmlBody = String.Format(
            "<html><body>" +
            "<img src='~/Image/logo.png' />" +
            "<H1> APROBACION COTIZACIÓN </H1>" +
            @"<H4> Nº de Cotización: " + NVentaCabeceras[0].NVNumero + @" </H4>" +
            //@"<H4> Nº Nota de Venta Softland: " + NVSoft[0].NVNumero + @" </H4>" +
            @"<H4> Fecha Pedido: " + NVentaCabeceras[0].nvFem == null ? "" : ((DateTime)NVentaCabeceras[0].nvFem).ToShortDateString() + @" </H4>" +
            @"<H4> Cliente: " + NVentaCabeceras[0].NomAux + @" </H4>" +
            @"<H4> Dirección: " + Clientes[0].DirAux + @" </H4>" +
            @"<H4> Fecha Entrega: " + NVentaCabeceras[0].nvFeEnt == null ? "" : ((DateTime)NVentaCabeceras[0].nvFeEnt).ToShortDateString() + @" </H4>" +
            @"<H4> Observaciones: " + NVentaCabeceras[0].nvObser + @" </H4>" +
            @"<H4> Vendedor: " + SessionVariables.SESSION_DATOS_USUARIO.VenDes + @" </H4>" +
            @"<table border = ""1"" >" +
            @"<tr>" +
            @"<td>ID</td>" +
            @"<th nowrap=""nowrap"">Codigo Producto</th>" +
            @"<th>Descripcion</th>" +
            @"<th>Cantidad</th>" +
            @"<th>Precio</th>" +
            @"<th>Sub-Total</th>" +
            @"<th>Iva   </th>" +
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
                htmlBody += @"<tr>" +
                           @"<td>" + nvd.nvLinea + @"</td>" +
                           @"<td>" + nvd.CodProd + @"</td>" +
                           @"<td>" + nvd.DesProd + @"</td>" +
                           @"<td style='text-align: right;'>" + nvd.nvCant + @"</td>" +
                           @"<td style='text-align: right;'>" + nvd.nvPrecio + @"</td>" +
                           @"<td style='text-align: right;'>" + nvd.nvSubTotal + @"</td>" +
                           @"<td style='text-align: right;'>" + Iva + @"</td>" +
                           @"<td style='text-align: right;'>" + precioConIVa + @"</td>" +
                           @"</tr>";
            }
            htmlBody += @"<tr><th style='text-align: right;' colspan =" + 7 + @">Sub Total</th><td style='text-align: right;'>" + subtotal + @"</td></tr>" +
                        @"<tr><th style='text-align: right;' colspan =" + 7 + @">Total Iva</th><td style='text-align: right;'>" + ivaux + @"</td></tr>" +
                        @"<tr><th style='text-align: right;' colspan =" + 7 + @">Total</th><td style='text-align: right;'>" + NVentaCabeceras[0].TotalBoleta + @"</td></tr>";
            htmlBody += @" </body></html>";

            AlternateView alternateView = AlternateView.CreateAlternateViewFromString(htmlBody, null, System.Net.Mime.MediaTypeNames.Text.Html);
            foreach (LinkedResource r in resources)
            {
                alternateView.LinkedResources.Add(r);
            }
            return alternateView;
        }

        //public ActionResult VerDetalleNV(int nvNumero)
        //{
        //    try
        //    {
        //        NotadeVentaCabeceraModels NVC = new NotadeVentaCabeceraModels();
        //        List<NotadeVentaCabeceraModels> NVCL = new List<NotadeVentaCabeceraModels>();
        //        NotaDeVentaDetalleModels NVD = new NotaDeVentaDetalleModels();
        //        List<NotaDeVentaDetalleModels> NVDL = new List<NotaDeVentaDetalleModels>();

        //        NVC.NVNumero = nvNumero;
        //        NVD.NVNumero = nvNumero;

        //        var nvc = controlDisofi().BuscarNVC(NVC);

        //        if (nvc != null)
        //        {
        //            NVCL = nvc;
        //        }
        //        else
        //        {
        //            ViewBag.mensaje = 1;
        //            ViewBag.NVnum = nvNumero;
        //            return View();
        //        }

        //        ViewBag.cabecera = NVCL;

        //        var nvd = controlDisofi().BuscarNVD(NVD);

        //        if (nvd != null)
        //        {
        //            NVDL = nvd;
        //        }

        //        ViewBag.detalle = NVDL;

        //        return View();
        //    }
        //    catch (Exception ex)
        //    {
        //        return View(ex.Message);
        //    }
        //}

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
    }
}