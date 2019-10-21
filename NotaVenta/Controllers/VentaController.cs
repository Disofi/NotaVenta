using NotaVenta.UTIL;
using NotaVenta.UTIL.FilterAttributes;
using System;
using System.Collections.Generic;
using System.Globalization;
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
    public class VentaController : BaseController
    {
        #region Vistas

        // GET: Venta
        public ActionResult Index()
        {
            return View();
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.VENDEDOR)]
        public ActionResult MisClientes()
        {
            UsuariosModels usr = new UsuariosModels();

            List<ClientesModels> lclientes = new List<ClientesModels>();

            usr.VenCod = codigoVendedorUsuario().Trim();
            usr.id = SessionVariables.SESSION_DATOS_USUARIO.IdUsuario;
            var misClientes = controlDisofi().BuscarMisClientesVenCod(usr, baseDatosUsuario());

            if (misClientes != null)
            {
                lclientes = misClientes;
            }

            ViewBag.clientes = lclientes;

            IEnumerable<SelectListItem> clientesGiro = controlDisofi().ObtenerGiro(baseDatosUsuario()).Select(c => new SelectListItem()
            {
                Text = c.GirDes,
                Value = c.GirCod
            }).ToList();
            ViewBag.Giro = clientesGiro;

            IEnumerable<SelectListItem> clientesCiudad = controlDisofi().ObtenerCiudad(baseDatosUsuario()).Select(c => new SelectListItem()
            {
                Text = c.CiuDes,
                Value = c.CiuCod
            }).ToList();
            ViewBag.Ciudad = clientesCiudad;

            IEnumerable<SelectListItem> clientesComuna = controlDisofi().ObtenerComuna(baseDatosUsuario()).Select(c => new SelectListItem()
            {
                Text = c.ComDes,
                Value = c.ComCod
            }).ToList();
            ViewBag.Comuna = clientesComuna;

            return View();
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.VENDEDOR)]
        public ActionResult PreNotadeVenta(string CodAux, string NomAux)
        {
            NotadeVentaCabeceraModels notadeVentaCabeceraModels = new NotadeVentaCabeceraModels();
            notadeVentaCabeceraModels.CodAux = CodAux;
            notadeVentaCabeceraModels.NomAux = NomAux;

            SessionVariables.SESSION_NOTA_VENTA_CABECERA_MODEL = notadeVentaCabeceraModels;
            return Redirect("NotaDeVenta");
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.VENDEDOR)]
        public ActionResult NotaDeVenta()
        {
            ParametrosModels parametros = ObtieneParametros();

            ViewBag.Parametros = parametros;

            var id_ = SessionVariables.SESSION_DATOS_USUARIO.IdUsuario.ToString();
            var VenCod = codigoVendedorUsuario();
            var id = id_;

            NotadeVentaCabeceraModels NVC = SessionVariables.SESSION_NOTA_VENTA_CABECERA_MODEL;
            NVC.NVNumero = 0;
            NVC.NumOC = "";
            NVC.NumReq = 0;

            ClientesModels cliente = new ClientesModels
            {
                CodAux = NVC.CodAux
            };

            ClientesModels cm = controlDisofi().ObtenerAtributoDescuento(baseDatosUsuario(), cliente.CodAux, parametros.AtributoSoftlandDescuentoCliente);
            cliente.ValorAtributo = cm.ValorAtributo;

            ViewBag.ValorAtributo = cliente.ValorAtributo;

            CreditoModel credito = controlDisofi().ObtenerCredito(cliente.CodAux, baseDatosUsuario());
            if (credito != null)
            {
                credito.Deuda = credito.Debe - credito.Haber;
                credito.Saldo = credito.Credito - credito.Deuda;
                if (parametros.ManejaLineaCredito)
                {
                    if (credito.Credito == 0)
                    {
                        TempData["Mensaje"] = "CLIENTE NO TIENE CREDITO. <br>";
                        return RedirectToAction("MisClientes", "Venta");
                    }
                }
            }

            ViewBag.Credito = credito;


            ViewBag.CodAux = NVC.CodAux;

            List<ClientesModels> contactoCorreos = controlDisofi().GetContacto(baseDatosUsuario(), cliente);
            List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), cliente);

            if (contactoCorreos != null && contactoCorreos.Count > 0 && contactoCorreos[0].EMail != "")
            {
                ViewBag.CorreoCliente = contactoCorreos[0].EMail;
            }
            else
            {
                if (clientes != null && clientes.Count > 0 && clientes[0].EMail != "")
                {
                    ViewBag.CorreoCliente = clientes[0].EMail;
                }
                else
                {
                    TempData["Mensaje"] = "CLIENTE SELECCIONADO NO CUENTA CON CORREO NI CONTACTOS. <br>";
                    return RedirectToAction("MisClientes", "Venta");
                }

            }

            ViewBag.numeronota = NVC;

            CondicionVentasModels conven = new CondicionVentasModels();

            //Se lista(n) la(s) condicion(es) de venta(s)

            List<CondicionVentasModels> lcondicion = new List<CondicionVentasModels>();
            if (parametros.MuestraCondicionVentaCliente)
            {
                conven.CodAux = NVC.CodAux.ToString();
                lcondicion = controlDisofi().listarConVen(baseDatosUsuario(), conven);
            }
            else if (parametros.MuestraCondicionVentaTodos)
            {
                conven.CodAux = "-1";
                lcondicion = controlDisofi().listarConVen(baseDatosUsuario(), conven);
            }

            ViewBag.condicion = lcondicion;

            ClientesModels contacto = new ClientesModels();

            contacto.CodAux = NVC.CodAux.ToString();
            contacto.NomAux = SessionVariables.SESSION_DATOS_USUARIO.Nombre.ToString();

            //Se ubica la lista de contactos
            List<ClientesModels> contactos = controlDisofi().BuscarContacto(baseDatosUsuario(), contacto);

            if (contactos == null)
            {
                ViewBag.contactos = contactos;
                ViewBag.vcontactos = 0;
            }
            else
            {
                ViewBag.contactos = contactos;
                ViewBag.vcontactos = 1;
            }

            DireccionDespachoModels direc = new DireccionDespachoModels();

            direc.CodAxD = NVC.CodAux.ToString();

            //Se lista(n) la(s) dirección(es) de despacho
            List<DireccionDespachoModels> direciones = controlDisofi().BuscarDirecDespach(direc, baseDatosUsuario());

            if (direciones == null)
            {
                ViewBag.vdirecc = 0;
            }
            else
            {
                ViewBag.vdirecc = 1;
            }

            ViewBag.direccion = direciones;
            ViewBag.codigo = NVC.CodAux;
            ViewBag.nombre = NVC.NomAux;

            ListaDePrecioModels ListPrecio = new ListaDePrecioModels();

            ListPrecio.CodAux = NVC.CodAux.ToString();

            //Se listan los precios
            List<ListaDePrecioModels> ListDePrecios = controlDisofi().listarListaDePrecio(baseDatosUsuario(), ListPrecio);

            ViewBag.lista = ListDePrecios;

            //Se listan los centros de costos
            List<CentrodeCostoModels> lcc = controlDisofi().ListarCentroCosto(baseDatosUsuario());
            ViewBag.cc = lcc;

            IEnumerable<SelectListItem> clientesCiudad = controlDisofi().ObtenerCiudad(baseDatosUsuario()).Select(c => new SelectListItem()
            {
                Text = c.CiuDes,
                Value = c.CiuCod
            }).ToList();
            ViewBag.Ciudad = clientesCiudad;

            IEnumerable<SelectListItem> clientesComuna = controlDisofi().ObtenerComuna(baseDatosUsuario()).Select(c => new SelectListItem()
            {
                Text = c.ComDes,
                Value = c.ComCod
            }).ToList();
            ViewBag.Comuna = clientesComuna;

            return View();
        }

        #endregion

        public ActionResult Todolosclientes()
        {
            List<ClientesModels> lclientes = new List<ClientesModels>();
            var todosClientes = controlDisofi().ListarClientesTodos();

            if (lclientes != null)
            {
                lclientes = todosClientes;
            }

            ViewBag.clientes = lclientes;

            return View();
        }

        [NonAction]
        public void VerificationEmail(int nvnumero, string NomCon)
        {
            var de = "";
            var clavecorreo = "";
            IEnumerable<_NotaDeVentaDetalleModels> datosUser = controlDisofi().DatosCorreoVend(nvnumero);
            foreach (_NotaDeVentaDetalleModels ot in datosUser)
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

            var mailWithImg = GetMailWithImg(nvnumero, NomCon);

            if (mailWithImg != null)
            {
                smtp.Send(mailWithImg);
                //smtp.SendAsync(mailWithImg, mailWithImg);
            }

        }

        private MailMessage GetMailWithImg(int nvnumero, string NomCon)
        {
            var de = "";
            var clavecorreo = "";
            IEnumerable<_NotaDeVentaDetalleModels> datosUser = controlDisofi().DatosCorreoVend(nvnumero);
            foreach (_NotaDeVentaDetalleModels ot in datosUser)
            {
                de = ot.EmailVend;
                clavecorreo = ot.PassCorreo;
            }
            string from = de;
            string subject = string.Format("Cotizacion {0}", nvnumero);

            NotadeVentaCabeceraModels NVentaCabecera = new NotadeVentaCabeceraModels
            {
                NVNumero = nvnumero
            };
            List<NotadeVentaCabeceraModels> NVentaCabeceras = controlDisofi().BuscarNVPorNumero(NVentaCabecera);

            List<NotaDeVentaDetalleModels> NVentaDetalles = controlDisofi().BuscarNVDETALLEPorNumero(NVentaCabecera);

            ClientesModels cliente = new ClientesModels
            {
                CodAux = NVentaCabeceras[0].CodAux,
                NomCon = NomCon
            };

            List<ClientesModels> contacto = controlDisofi().GetContacto(baseDatosUsuario(), cliente);

            List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), cliente);

            ClientesModels Vendedor = new ClientesModels
            {
                VenCod = NVentaCabeceras[0].VenCod
            };

            List<ClientesModels> vendedores = controlDisofi().GetVendedores(baseDatosUsuario(), Vendedor);

            MailMessage mail = new MailMessage
            {
                IsBodyHtml = true
            };

            mail.AlternateViews.Add(GetEmbeddedImage(NVentaCabeceras, NVentaDetalles, clientes));
            mail.From = new MailAddress(from);

            if (clientes != null)
            {
                mail.To.Add(vendedores[0].EMail);

                if (contacto[0].EMail == null || contacto[0].EMail.Trim() == "")
                {
                    mail.To.Add(clientes[0].EMail);
                }
                else
                {
                    mail.To.Add(contacto[0].EMail);
                }
                mail.Subject = subject;
                return mail;
            }
            else
            {
                return null;
            }
        }
        /*
        public void SendEmail(string pvarPara, string pvarsAsunto, string pvarsMensaje, string pvarFrom, bool pvarisHtml = false)
        {

            try
            {

                bool wvarEnvia = false;
                MailMessage myMail = new MailMessage();

                myMail.From = new MailAddress("rhurtado@disofi.cl");


                if (pvarPara.Trim() != "")
                {
                    pvarPara = pvarPara + ",";

                    string[] wvarPP = pvarPara.Split(Convert.ToChar(","));

                    foreach (string wvarPara in wvarPP)
                    {
                        if (wvarPara != "")
                        {
                            myMail.To.Add(wvarPara);
                            wvarEnvia = true;
                        }
                    }
                }

                myMail.Subject = pvarsAsunto;
                myMail.SubjectEncoding = System.Text.Encoding.UTF8;

                myMail.Body = pvarsMensaje;
                myMail.BodyEncoding = System.Text.Encoding.UTF8;
                myMail.IsBodyHtml = pvarisHtml;

                SmtpClient mySmtpClient = new SmtpClient();
                mySmtpClient.Host = "mail.disofi.cl";
                mySmtpClient.Port = 25;
                mySmtpClient.EnableSsl = true;


                mySmtpClient.UseDefaultCredentials = false;
                NetworkCredential MyCredentials = new NetworkCredential("fduran@disofi.cl", "D1s0f12019");
                mySmtpClient.Credentials = MyCredentials;

                if (wvarEnvia == true)
                {
                    mySmtpClient.Send(myMail);

                    //ReleaseObject(mySmtpClient);
                    //ReleaseObject(myMail);
                }

            }

            catch (SmtpException ex)
            {
                //WriteLog("SmtpException has occured: " + ex.Message);
            }

        }
        */



        private AlternateView GetEmbeddedImage(List<NotadeVentaCabeceraModels> NVentaCabeceras,
        List<NotaDeVentaDetalleModels> NVentaDetalles, List<ClientesModels> Clientes)
        {
            //var connectionString = "";
            //byte[] arrImage = ms.GetBuffer();
            /*
            using (SqlConnection cn = new SqlConnection(connectionString = "Data Source=SRV-DISOFI; Initial Catalog=DSKUPPEL; User ID=sa; Password=Softland2018; MultipleActiveResultSets=True; TrustServerCertificate =True"))
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("select Imagen from DS_Imagenes", cn);
                byte[] datosImagen = (byte[])cmd.ExecuteScalar();
                MemoryStream ms = new MemoryStream(datosImagen);
                System.Drawing.Image img = System.Drawing.Image.FromStream(ms);
                //arrImage = img;
                
            }
            */
            char[] blanco = { ' ' };

            string htmlBody = String.Format(
            "<html><body>" +
            //Cabecera
            /*"<table width ='400' cellspacing ='1' cellpadding ='3' border ='0' bgcolor ='#000000' align ='center'>" +
            "<tr>" +
            "<td width ='120' align ='left' bgcolor ='#ffffff'>" +
            "<div class='custom - banner'>" +

            "</div>" +
            "</td>" +
            "</tr>" +
            "</table>" +*/
            //
            "<img src='~/Image/logo.png' />" +
            "<H1> COTIZACIÓN </H1>" +
            @"<H4> Nº de Cotización: " + NVentaCabeceras[0].NVNumero + @" </H4>" +
            @"<H4> Fecha Pedido: " + NVentaCabeceras[0].nvFem == null ? "" : ((DateTime)NVentaCabeceras[0].nvFem).ToShortDateString() + @" </H4>" +
            @"<H4> Cliente: " + NVentaCabeceras[0].NomAux + @" </H4>" +
            @"<H4> Dirección: " + Clientes[0].DirAux + @" </H4>" +
            @"<H4> Fecha Entrega: " + NVentaCabeceras[0].nvFeEnt == null ? "" : ((DateTime)NVentaCabeceras[0].nvFeEnt).ToShortDateString() + @" </H4>" +
            @"<H4> Observaciones: " + NVentaCabeceras[0].nvObser + @" </H4>" +
            @"<H4> Vendedor: " + SessionVariables.SESSION_DATOS_USUARIO.VenDes.ToString() + @" </H4>" +
            @"<table border = ""1"" >" +
            @"<tr>" +
            @"<td>ID</td>" +
            @"<th nowrap=""nowrap"">Codigo Producto</th>" +
            //@"<th>Imagen</th>" +
            @"<th>Descripcion</th>" +
            @"<th>Cantidad</th>" +
            @"<th>Precio</th>" +
            @"<th>Sub-Total</th>" +
            @"<th>Iva    </th>" +
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

            AlternateView alternateView = AlternateView.CreateAlternateViewFromString(htmlBody, null, MediaTypeNames.Text.Html);
            foreach (LinkedResource r in resources)
            {
                alternateView.LinkedResources.Add(r);
            }
            return alternateView;
        }

        public void AgregarContacto(string CodAux, string NomCon)
        {
            ClientesModels cli = new ClientesModels();
            cli.CodAux = CodAux;
            cli.NomCon = NomCon;

            List<ClientesModels> nv = controlDisofi().AgregarContacto(cli);
        }



        #region"--- Web Métodos ---"
        //[HttpPost, ValidateInput(false)]
        //public JsonResult AgregarNV(FormCollection frm, int NVNumero, DateTime nvFem, DateTime nvFeEnt, string CodAux, string VenCod,
        //string CodLista, string nvObser, string CveCod, string NomCon, string CodiCC, double nvSubTotal, double nvMonto,
        //double nvNetoAfecto, string Usuario, string UsuarioGeneraDocto, DateTime FechaHoraCreacion, double TotalBoleta,
        //string id, string CodLugarDesp)
        //{
        //    int numSoft = 0;
        //    try
        //    {
        //        #region"NVC"
        //        NotadeVentaCabeceraModels NVC = new NotadeVentaCabeceraModels
        //        {
        //            NVNumero = NVNumero,
        //            nvFem = nvFem,
        //            nvEstado = "A",
        //            nvEstFact = 0,
        //            nvEstDesp = 0,
        //            nvEstRese = 0,
        //            nvEstConc = 0,
        //            nvFeEnt = nvFeEnt,
        //            CodAux = CodAux,
        //            VenCod = VenCod,
        //            CodMon = "01",
        //            CodLista = CodLista,
        //            nvObser = nvObser,
        //            CveCod = CveCod,
        //            NomCon = NomCon,
        //            CodiCC = CodiCC,
        //            nvSubTotal = nvSubTotal,
        //            nvPorcDesc01 = 0,
        //            nvDescto01 = 0,
        //            nvPorcDesc02 = 0,
        //            nvDescto02 = 0,
        //            nvPorcDesc03 = 0,
        //            nvDescto03 = 0,
        //            nvPorcDesc04 = 0,
        //            nvDescto04 = 0,
        //            nvPorcDesc05 = 0,
        //            nvDescto05 = 0,
        //            nvMonto = nvMonto,
        //            NumGuiaRes = 0,
        //            nvPorcFlete = 0,
        //            nvValflete = 0,
        //            nvPorcEmb = 0,
        //            nvEquiv = 1,
        //            nvNetoExento = 0,
        //            nvNetoAfecto = nvNetoAfecto,
        //            nvTotalDesc = 0,
        //            ConcAuto = "N",
        //            CheckeoPorAlarmaVtas = "N",
        //            EnMantencion = 0,
        //            Usuario = Usuario,
        //            UsuarioGeneraDocto = UsuarioGeneraDocto,
        //            FechaHoraCreacion = FechaHoraCreacion,
        //            Sistema = "NW",
        //            ConcManual = "N",
        //            proceso = "Notas de Venta",
        //            TotalBoleta = TotalBoleta,
        //            NumReq = 0,
        //            CodVenWeb = "5",
        //            CodLugarDesp = CodLugarDesp
        //        };
        //        #endregion

        //        List<ParametrosModels> para = ParametrosDAO.BuscarParametros();

        //        if (para[0].Aprobador == 1)
        //        {
        //            NVC.EstadoNP = "P";
        //        }
        //        else
        //        {
        //            NVC.EstadoNP = "A";
        //        }

        //        if (para[0].Aprobador == 1)
        //        {
        //            List<NotadeVentaCabeceraModels> NVSoft = NotaDeVentaDAO.EditarNV(NVC);
        //            ViewBag.NVnum = NVC.NVNumero;
        //            numSoft = NVC.NVNumero;
        //        }
        //        else
        //        {
        //            List<NotadeVentaCabeceraModels> NVSoft = NotaDeVentaDAO.InsertarNvSoftland(NVC);
        //            ViewBag.NVnum = NVSoft[0].NVNumero;
        //            numSoft = NVSoft[0].NVNumero;
        //        }


        //        //EMail
        //        VerificationEmail(NVNumero,NomCon);
        //        //return Json(NV);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw(ex);
        //    }

        //    return Json(new { ID = id, NVNUM = numSoft });

        //}

        [HttpPost, ValidateInput(false)]
        public JsonResult AgregarNV(NotadeVentaCabeceraModels cabecera, List<ProductoAgregadoModel> productos)
        {
            try
            {
                ParametrosModels para = ObtieneParametros();

                bool insertaDisofi = true;
                bool insertaSoftland = !para.EnvioObligatorioAprobador;

                cabecera = new NotadeVentaCabeceraModels()
                {
                    NVNumero = cabecera.NVNumero,
                    nvFem = cabecera.nvFem,
                    nvEstado = insertaSoftland ? "A" : "P",
                    nvEstFact = 0,
                    nvEstDesp = 0,
                    nvEstRese = 0,
                    nvEstConc = 0,
                    CotNum = 0,
                    NumOC = "0",
                    nvFeEnt = cabecera.nvFeEnt,
                    CodAux = cabecera.CodAux,
                    VenCod = cabecera.VenCod,
                    CodMon = "01", //PESO CHILENO
                    CodLista = cabecera.CodLista,
                    nvObser = cabecera.nvObser,
                    //nvCanalNV = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    CveCod = cabecera.CveCod,
                    NomCon = cabecera.NomCon,
                    CodiCC = cabecera.CodiCC,
                    //CodBode = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    nvSubTotal = cabecera.nvSubTotal,
                    //nvPorcDesc01 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvDescto01 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvPorcDesc02 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvDescto02 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvPorcDesc03 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvDescto03 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvPorcDesc04 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvDescto04 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvPorcDesc05vaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //nvDescto05 = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    nvMonto = cabecera.nvMonto,
                    nvFeAprob = insertaSoftland ? (DateTime?)DateTime.Now : null,
                    NumGuiaRes = 0,
                    nvPorcFlete = 0,
                    nvValflete = 0,
                    nvPorcEmb = 0,
                    nvValEmb = 0,
                    nvEquiv = 1,
                    nvNetoExento = 0,
                    nvNetoAfecto = cabecera.nvNetoAfecto,
                    //nvTotalDesc = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    ConcAuto = "N",
                    CodLugarDesp = cabecera.CodLugarDesp,
                    SolicitadoPor = null,
                    DespachadoPor = null,
                    Patente = null,
                    RetiradoPor = null,
                    CheckeoPorAlarmaVtas = "N",
                    EnMantencion = 0,
                    Usuario = "",
                    UsuarioGeneraDocto = "SOFTLAND",
                    FechaHoraCreacion = DateTime.Now,
                    Sistema = "NW",
                    ConcManual = "N",
                    RutSolicitante = null,
                    proceso = "Notas de Venta",
                    TotalBoleta = cabecera.TotalBoleta,
                    NumReq = 0,
                    //CodVenWeb = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    //CodBodeWms = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                    CodLugarDocto = null,
                    RutTransportista = null,
                    Cod_Distrib = null,
                    Nom_Distrib = null,
                    MarcaWG = null,
                };



                RespuestaNotaVentaModel respuestaNotaVenta = controlDisofi().AgregarNV(baseDatosUsuario(), insertaDisofi, insertaSoftland, cabecera);

                if ((insertaDisofi && respuestaNotaVenta.VerificadorDisofi) ||
                    (!insertaDisofi && !respuestaNotaVenta.VerificadorDisofi))
                {
                    if ((insertaSoftland && respuestaNotaVenta.VerificadorSoftland) ||
                        (!insertaSoftland && !respuestaNotaVenta.VerificadorSoftland))
                    {
                        for (int x = 0; x < productos.Count; x++)
                        {
                            NotaDeVentaDetalleModels detalle = new NotaDeVentaDetalleModels();

                            detalle.IdNotaVenta = respuestaNotaVenta.IdNotaVenta;
                            detalle.DesProd = productos[x].Descripcion;
                            //detalle.Stock
                            //detalle.Iva
                            //detalle.EmailVend
                            //detalle.PassCorreo
                            detalle.NVNumero = respuestaNotaVenta.NVNumero;
                            detalle.nvLinea = (x + 1);
                            detalle.nvCorrela = 0;
                            detalle.nvFecCompr = DateTime.Now;
                            detalle.CodProd = productos[x].Codigo;
                            detalle.nvCant = Convert.ToDouble(productos[x].Cantidad);
                            detalle.nvPrecio = Convert.ToDouble(productos[x].PrecioUnitario);
                            detalle.nvEquiv = 1;
                            detalle.nvSubTotal = Convert.ToDouble(productos[x].SubTotal);
                            int totalDescuento = 0;
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 0)
                            {
                                detalle.nvDPorcDesc01 = Convert.ToDouble(productos[x].Descuentos[0].Porcentaje);
                                detalle.nvDDescto01 = Convert.ToDouble(productos[x].Descuentos[0].Valor);
                                totalDescuento = totalDescuento + Convert.ToInt32(detalle.nvDDescto01);
                            }
                            else
                            {
                                detalle.nvDPorcDesc01 = 0;
                                detalle.nvDDescto01 = 0;
                            }
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 1)
                            {
                                detalle.nvDPorcDesc02 = Convert.ToDouble(productos[x].Descuentos[1].Porcentaje);
                                detalle.nvDDescto02 = Convert.ToDouble(productos[x].Descuentos[1].Valor);
                                totalDescuento = totalDescuento + Convert.ToInt32(detalle.nvDDescto02);
                            }
                            else
                            {
                                detalle.nvDPorcDesc02 = 0;
                                detalle.nvDDescto02 = 0;
                            }
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 2)
                            {
                                detalle.nvDPorcDesc03 = Convert.ToDouble(productos[x].Descuentos[2].Porcentaje);
                                detalle.nvDDescto03 = Convert.ToDouble(productos[x].Descuentos[2].Valor);
                                totalDescuento = totalDescuento + Convert.ToInt32(detalle.nvDDescto03);
                            }
                            else
                            {
                                detalle.nvDPorcDesc03 = 0;
                                detalle.nvDDescto03 = 0;
                            }
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 3)
                            {
                                detalle.nvDPorcDesc04 = Convert.ToDouble(productos[x].Descuentos[3].Porcentaje);
                                detalle.nvDDescto04 = Convert.ToDouble(productos[x].Descuentos[3].Valor);
                                totalDescuento = totalDescuento + Convert.ToInt32(detalle.nvDDescto04);
                            }
                            else
                            {
                                detalle.nvDPorcDesc04 = 0;
                                detalle.nvDDescto04 = 0;
                            }
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 4)
                            {
                                detalle.nvDPorcDesc05 = Convert.ToDouble(productos[x].Descuentos[4].Porcentaje);
                                detalle.nvDDescto05 = Convert.ToDouble(productos[x].Descuentos[4].Valor);
                                totalDescuento = totalDescuento + Convert.ToInt32(detalle.nvDDescto05);
                            }
                            else
                            {
                                detalle.nvDPorcDesc05 = 0;
                                detalle.nvDDescto05 = 0;
                            }


                            detalle.nvTotDesc = totalDescuento;
                            detalle.nvTotLinea = Convert.ToDouble(productos[x].Total);
                            detalle.nvCantDesp = 0;
                            detalle.nvCantProd = 0;
                            detalle.nvCantFact = 0;
                            detalle.nvCantDevuelto = 0;
                            detalle.nvCantNC = 0;
                            detalle.nvCantBoleta = 0;
                            detalle.nvCantOC = 0;
                            detalle.DetProd = productos[x].Descripcion;
                            detalle.CheckeoMovporAlarmaVtas = "N";
                            detalle.KIT = null;
                            detalle.CodPromocion = null;
                            detalle.CodUMed = productos[x].UnidadMedida;
                            detalle.CantUVta = Convert.ToDouble(productos[x].Cantidad);
                            detalle.Partida = productos[x].Talla;
                            detalle.Pieza = productos[x].Color;
                            detalle.FechaVencto = null;
                            detalle.CantidadKit = 0;
                            detalle.MarcaWG = null;
                            detalle.PorcIncidenciaKit = 0;

                            RespuestaNotaVentaModel respuestaDetalleNotaVenta = controlDisofi().AgregarDetalleNV(baseDatosUsuario(), insertaDisofi, insertaSoftland, detalle);
                        }
                    }
                }

                return Json(new { });
            }
            catch (Exception ex)
            {
                throw (ex);
            }

        }

        [HttpPost, ValidateInput(false)]
        public JsonResult BuscarDireccionDespacho(string CodAux)
        {
            try
            {
                DireccionDespachoModels direc = new DireccionDespachoModels();
                direc.CodAxD = CodAux;

                //Se lista(n) la(s) dirección(es) de despacho
                List<DireccionDespachoModels> direciones = controlDisofi().BuscarDirecDespach(direc, baseDatosUsuario());

                return Json(direciones);
            }
            catch (Exception ex)
            {
                throw (ex);
            }

        }
        [HttpPost, ValidateInput(false)]
        public JsonResult AgregarDireccionDespacho(DireccionDespachoModels direccion)
        {
            try
            {
                RespuestaModel rm = controlDisofi().AgregarDireccionDespacho(direccion, baseDatosUsuario());
                return Json(rm);
            }
            catch (Exception ex)
            {
                throw (ex);
            }

        }

        [HttpPost]
        public JsonResult ObtieneProductosPorListaPrecio(string ListaPrecio)
        {
            List<ProductosModels> pro = controlDisofi().ListarProducto(ListaPrecio, baseDatosUsuario());

            return NotaVenta.UTIL.JsonResultResponse.ObtenerResponse<List<ProductosModels>>(pro);
        }

        [HttpPost]
        public JsonResult ObtieneTallaColorProducto(string CodProd)
        {
            List<TallaColorProductoModels> pro = controlDisofi().ListarTallaColorProducto(CodProd, baseDatosUsuario());

            return Json(pro);
        }



        [HttpPost]
        public JsonResult ProductSearch(string CodProd, string CodLista)
        {
            ProductosModels prod = new ProductosModels();
            prod.CodProd = CodProd;
            prod.DesProd = CodProd;
            prod.CodLista = CodLista;

            List<ProductosModels> pro = controlDisofi().BuscarProducto(prod);

            return Json(pro);
        }

        [HttpPost]
        public JsonResult QuickProductSearch(string CodRapido, string CodLista)
        {
            ProductosModels prod = new ProductosModels();
            prod.CodRapido = CodRapido;
            prod.CodLista = CodLista;

            List<ProductosModels> pro = controlDisofi().BuscarProductoRapido(prod);

            return Json(pro);
        }

        [HttpPost]
        public JsonResult Multiplicar(string punitario, string cantidad)
        {
            double u = double.Parse(punitario);
            double c = double.Parse(cantidad);

            double t = u * c;

            return Json(t.ToString());
        }


        public ProductoAgregadoModel CalcularFilaFunction(decimal precioUnitario, decimal cantidad, List<DescuentoProductoAgregadoModel> descuentos, decimal porcentajeAtributoDescuento)
        {
            if (descuentos == null) { descuentos = new List<DescuentoProductoAgregadoModel>(); }
            decimal _precioUnitario = 0;
            decimal _cantidad = 0;

            if (precioUnitario > 0)
            {
                _precioUnitario = precioUnitario == 0 ? _precioUnitario : Convert.ToDecimal((decimal)precioUnitario / (precioUnitario * 100)) * (precioUnitario * 100);
            }

            if (cantidad > 0)
            {
                _cantidad = cantidad == 0 ? _cantidad : Convert.ToDecimal((decimal)cantidad / (cantidad * 100)) * (cantidad * 100);
            }

            List<DescuentoProductoAgregadoModel> _descuentos = new List<DescuentoProductoAgregadoModel>();

            for (int x = 0; x < descuentos.Count; x++)
            {
                if (descuentos[x].Porcentaje > 0)
                {
                    DescuentoProductoAgregadoModel temp = new DescuentoProductoAgregadoModel()
                    {
                        Porcentaje = Convert.ToDecimal((decimal)descuentos[x].Porcentaje / (descuentos[x].Porcentaje * 100)) * (descuentos[x].Porcentaje * 100)
                    };
                    _descuentos.Add(temp);
                }
            }

            decimal subTotal = 0;
            decimal total = 0;

            subTotal = _precioUnitario * _cantidad;

            total = subTotal;

            for (int x = 0; x < _descuentos.Count; x++)
            {
                if (_descuentos[x].Porcentaje != 0)
                {
                    decimal valorDescuento = (total * (_descuentos[x].Porcentaje / 100));
                    _descuentos[x].Valor = valorDescuento;
                    total = total - valorDescuento;
                }
            }
            decimal valorAtributoDescuento = 0;
            if (porcentajeAtributoDescuento > 0)
            {
                valorAtributoDescuento = (total * (porcentajeAtributoDescuento / 100));
                total = total - valorAtributoDescuento;
            }

            return new ProductoAgregadoModel()
            {
                PrecioUnitario = _precioUnitario,
                Cantidad = _cantidad,
                Descuentos = _descuentos,
                SubTotal = subTotal,
                ValorDescuentoAtributo = valorAtributoDescuento,
                Total = total
            };
        }

        [HttpPost]
        public JsonResult CalcularFila(decimal precioUnitario, decimal cantidad, List<DescuentoProductoAgregadoModel> descuentos, decimal porcentajeAtributoDescuento)
        {
            return Json(CalcularFilaFunction(precioUnitario, cantidad, descuentos, porcentajeAtributoDescuento));
        }




        [HttpPost]
        public JsonResult CalcularProductosAgregados(List<ProductoAgregadoModel> productos, List<DescuentoProductoAgregadoModel> descuentos, decimal porcentajeAtributoDescuento)
        {
            if (descuentos == null) { descuentos = new List<DescuentoProductoAgregadoModel>(); }
            decimal subTotal = 0;
            decimal impuesto = 0;
            decimal total = 0;

            foreach (ProductoAgregadoModel item in productos)
            {
                ProductoAgregadoModel producto = CalcularFilaFunction(item.PrecioUnitario, item.Cantidad, item.Descuentos, porcentajeAtributoDescuento);
                subTotal = subTotal + producto.Total;
            }
            subTotal = Convert.ToInt32(subTotal);
            impuesto = Convert.ToInt32(((subTotal * 19) / 100));
            total = subTotal - impuesto;

            for (int X = 0; X < descuentos.Count; X++)
            {
                decimal valorDescuento = ((total * descuentos[X].Porcentaje) / 100);
                descuentos[X].Valor = valorDescuento;
                total = total - Convert.ToInt32(valorDescuento);
            }

            return Json(new
            {
                Productos = productos,
                descuentos = descuentos,
                SubTotal = Convert.ToInt32(subTotal),
                Impuesto = Convert.ToInt32(impuesto),
                Total = Convert.ToInt32(total)
            });
        }

        [HttpPost]
        public JsonResult Porcentaje(string valor, string porcenta)
        {
            CultureInfo culture = new CultureInfo("en-US");

            double u = double.Parse(valor);
            double c = double.Parse(porcenta, CultureInfo.InvariantCulture);
            double Decimal = c / 100;
            double t = u * Decimal;
            double total = u - t;
            total = Math.Round(total);

            return Json(total.ToString());
        }
        #endregion

    }
}