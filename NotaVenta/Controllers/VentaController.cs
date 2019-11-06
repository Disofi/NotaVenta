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
        public JsonResult PreNotadeVenta(string CodAux, string NomAux)
        {
            NotadeVentaCabeceraModels notadeVentaCabeceraModels = new NotadeVentaCabeceraModels();
            notadeVentaCabeceraModels.CodAux = CodAux;
            notadeVentaCabeceraModels.NomAux = NomAux;
            SessionVariables.SESSION_NOTA_VENTA_CABECERA_MODEL = notadeVentaCabeceraModels;


            NotadeVentaCabeceraModels NVC = SessionVariables.SESSION_NOTA_VENTA_CABECERA_MODEL;
            NVC.NVNumero = 0;
            NVC.NumOC = "";
            NVC.NumReq = 0;
            var validador = 0;

            ClientesModels cliente = new ClientesModels
            {
                CodAux = NVC.CodAux
            };

            List<ClientesModels> contactoCorreos = controlDisofi().GetContacto(baseDatosUsuario(), cliente);
            List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), cliente);

            if (contactoCorreos != null && contactoCorreos.Count > 0 && contactoCorreos[0].EMail != "")
            {
                ViewBag.CorreoCliente = contactoCorreos[0].EMail;
                validador = 1;
                return Json(validador);
            }
            else
            {
                if (clientes != null && clientes.Count > 0 && clientes[0].EMail != "")
                {
                    ViewBag.CorreoCliente = clientes[0].EMail;
                    validador = 1;
                    return Json(validador);
                }
                else
                {
                    validador = -1;
                    return Json(validador);
                }

            }
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
            //la lista de precios ,,.....dale...nada
            ClientesModels cm = controlDisofi().ObtenerAtributoDescuento(baseDatosUsuario(), cliente.CodAux, parametros.AtributoSoftlandDescuentoCliente);
            cliente.ValorAtributo = cm.ValorAtributo;

            ViewBag.ValorAtributo = cliente.ValorAtributo;
            VendedoresSoftlandModels vendedorCliente = controlDisofi().ObtenerVendedorCliente(cliente.CodAux, baseDatosUsuario());
            ViewBag.VendedorCliente = vendedorCliente;
            CreditoModel credito = controlDisofi().ObtenerCredito(cliente.CodAux, baseDatosUsuario());

            if (parametros.ManejaLineaCreditoVendedor)
            {
                if (credito != null)
                {
                    credito.Deuda = credito.Debe - credito.Haber;
                    credito.Saldo = credito.Credito - credito.Deuda;

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

            if (contactos == null || contactos.Count == 0)
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
            //List<ListaDePrecioModels> ListDePrecios = new List<ListaDePrecioModels>();

            List<ListaDePrecioModels> ListDePrecios = controlDisofi().listarListaDePrecio(baseDatosUsuario(), ListPrecio);
            if (parametros.ManejaListaPrecios)
            {
                ViewBag.lista = ListDePrecios;
            }
            else
            {
                ViewBag.lista = new List<ListaDePrecioModels>();
            }

            //Se listan los centros de costos
            List<CentrodeCostoModels> lcc = controlDisofi().ListarCentroCosto(baseDatosUsuario());
            ViewBag.cc = lcc;

            List<CanalVentaModels> dataCanalVenta = controlDisofi().ListarCanalVenta(baseDatosUsuario());
            ViewBag.canalVentas = dataCanalVenta;

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

        private AlternateView GetEmbeddedImage(List<NotadeVentaCabeceraModels> NVentaCabeceras,
        List<NotaDeVentaDetalleModels> NVentaDetalles, List<ClientesModels> Clientes)
        {
            char[] blanco = { ' ' };

            string htmlBody = String.Format(
            "<html><body>" +
            //"<img src='~/Image/logo.png' />" +
            "<H1> NOTA DE PEDIDO </H1>" +
            @"<H4> Nº de Pedido: " + NVentaCabeceras[0].Id + @" </H4>" +
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
                           @"<td style='text-align: right;'>" + "$ " + nvd.nvPrecio.ToString("N0") + @"</td>" +
                           @"<td style='text-align: right;'>" + "$ " + nvd.nvSubTotal.ToString("N0") + @"</td>" +
                           @"<td style='text-align: right;'>" + "$ " + Iva.ToString("N0") + @"</td>" +
                           @"<td style='text-align: right;'>" + "$ " + precioConIVa.ToString("N0") + @"</td>" +
                           @"</tr>";
            }
            htmlBody += @"<tr><th style='text-align: right;' colspan =" + 7 + @">Sub Total</th><td style='text-align: right;'>" + "$ " + subtotal.ToString("N0") + @"</td></tr>" +
                        @"<tr><th style='text-align: right;' colspan =" + 7 + @">Total Iva</th><td style='text-align: right;'>" + "$ " + ivaux.ToString("N0") + @"</td></tr>" +
                        @"<tr><th style='text-align: right;' colspan =" + 7 + @">Total</th><td style='text-align: right;'>" + "$ " + NVentaCabeceras[0].TotalBoleta.ToString("N0") + @"</td></tr>";
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

        [HttpPost, ValidateInput(false)]
        public JsonResult AgregarNV(NotadeVentaCabeceraModels cabecera, List<ProductoAgregadoModel> productos)
        {
            try
            {
                ParametrosModels para = ObtieneParametros();

                bool insertaDisofi = true;
                bool insertaSoftland = !para.EnvioObligatorioAprobador;

                cabecera.NVNumero = cabecera.NVNumero;
                cabecera.nvFem = cabecera.nvFem;
                cabecera.nvEstado = insertaSoftland ? "A" : "P";
                cabecera.nvEstFact = 0;
                cabecera.nvEstDesp = 0;
                cabecera.nvEstRese = 0;
                cabecera.nvEstConc = 0;
                cabecera.CotNum = 0;
                cabecera.NumOC = "0";
                cabecera.nvFeEnt = cabecera.nvFeEnt;
                cabecera.CodAux = cabecera.CodAux;
                cabecera.VenCod = SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.VenCod;
                cabecera.CodMon = "01"; //PESO CHILENO

                if (para.ManejaListaPrecios)
                {
                    cabecera.CodLista = (cabecera.CodLista == null || cabecera.CodLista == "" || cabecera.CodLista == "-1") ? null : cabecera.CodLista;
                }
                else
                {
                    cabecera.CodLista = null;
                }

                cabecera.nvObser = cabecera.nvObser;
                cabecera.nvCanalNV = cabecera.nvCanalNV == "-1" ? null : cabecera.nvCanalNV;
                cabecera.CveCod = cabecera.CveCod == "-1" ? null : cabecera.CveCod;
                cabecera.NomCon = (cabecera.NomCon == null || cabecera.NomCon == "") ? "SIN COCTACTO" : cabecera.NomCon;
                cabecera.CodiCC = cabecera.CodiCC == "-1" ? null : cabecera.CodiCC;
                //cabecera.CodBode = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
                cabecera.nvSubTotal = para.DescuentoTotalDirectoSoftland ? cabecera.TotalBoleta : cabecera.nvSubTotal;

                int totalDescuento = 0;
                if (cabecera.Descuentos != null && cabecera.Descuentos.Count > 0 && para.DescuentoTotalDirectoSoftland)
                {
                    cabecera.nvPorcDesc01 = Convert.ToDouble(cabecera.Descuentos[0].Porcentaje);
                    cabecera.nvDescto01 = Convert.ToDouble(cabecera.Descuentos[0].Valor);
                    totalDescuento = totalDescuento + Convert.ToInt32(cabecera.nvDescto01);
                }
                else
                {
                    cabecera.nvPorcDesc01 = 0;
                    cabecera.nvDescto01 = 0;
                }
                if (cabecera.Descuentos != null && cabecera.Descuentos.Count > 1 && para.DescuentoTotalDirectoSoftland)
                {
                    cabecera.nvPorcDesc02 = Convert.ToDouble(cabecera.Descuentos[1].Porcentaje);
                    cabecera.nvDescto02 = Convert.ToDouble(cabecera.Descuentos[1].Valor);
                    totalDescuento = totalDescuento + Convert.ToInt32(cabecera.nvDescto02);
                }
                else
                {
                    cabecera.nvPorcDesc02 = 0;
                    cabecera.nvDescto02 = 0;
                }
                if (cabecera.Descuentos != null && cabecera.Descuentos.Count > 2 && para.DescuentoTotalDirectoSoftland)
                {
                    cabecera.nvPorcDesc03 = Convert.ToDouble(cabecera.Descuentos[2].Porcentaje);
                    cabecera.nvDescto03 = Convert.ToDouble(cabecera.Descuentos[2].Valor);
                    totalDescuento = totalDescuento + Convert.ToInt32(cabecera.nvDescto03);
                }
                else
                {
                    cabecera.nvPorcDesc03 = 0;
                    cabecera.nvDescto03 = 0;
                }
                if (cabecera.Descuentos != null && cabecera.Descuentos.Count > 3 && para.DescuentoTotalDirectoSoftland)
                {
                    cabecera.nvPorcDesc04 = Convert.ToDouble(cabecera.Descuentos[3].Porcentaje);
                    cabecera.nvDescto04 = Convert.ToDouble(cabecera.Descuentos[3].Valor);
                    totalDescuento = totalDescuento + Convert.ToInt32(cabecera.nvDescto04);
                }
                else
                {
                    cabecera.nvPorcDesc04 = 0;
                    cabecera.nvDescto04 = 0;
                }
                if (cabecera.Descuentos != null && cabecera.Descuentos.Count > 4 && para.DescuentoTotalDirectoSoftland)
                {
                    cabecera.nvPorcDesc05 = Convert.ToDouble(cabecera.Descuentos[4].Porcentaje);
                    cabecera.nvDescto05 = Convert.ToDouble(cabecera.Descuentos[4].Valor);
                    totalDescuento = totalDescuento + Convert.ToInt32(cabecera.nvDescto05);
                }
                else
                {
                    cabecera.nvPorcDesc05 = 0;
                    cabecera.nvDescto05 = 0;
                }

                cabecera.nvTotalDesc = totalDescuento;
                cabecera.nvMonto = para.DescuentoTotalDirectoSoftland ? cabecera.nvSubTotal : cabecera.TotalBoleta; //cabecera.nvMonto 
                cabecera.nvFeAprob = insertaSoftland ? (DateTime?)DateTime.Now : null;
                cabecera.NumGuiaRes = 0;
                cabecera.nvPorcFlete = 0;
                cabecera.nvValflete = 0;
                cabecera.nvPorcEmb = 0;
                cabecera.nvValEmb = 0;
                cabecera.nvEquiv = 1;
                cabecera.nvNetoExento = 0;
                cabecera.nvNetoAfecto = para.DescuentoTotalDirectoSoftland ? cabecera.nvNetoAfecto : cabecera.TotalBoleta;
                cabecera.ConcAuto = "N";
                cabecera.CodLugarDesp = cabecera.CodLugarDesp == "-1" ? null : cabecera.CodLugarDesp;
                cabecera.SolicitadoPor = null;
                cabecera.DespachadoPor = null;
                cabecera.Patente = null;
                cabecera.RetiradoPor = null;
                cabecera.CheckeoPorAlarmaVtas = "N";
                cabecera.EnMantencion = 0;
                cabecera.Usuario = SessionVariables.SESSION_DATOS_USUARIO.VenDes;
                cabecera.UsuarioGeneraDocto = SessionVariables.SESSION_DATOS_USUARIO.VenDes;
                cabecera.FechaHoraCreacion = DateTime.Now;
                cabecera.Sistema = "NW";
                cabecera.ConcManual = "N";
                cabecera.RutSolicitante = null;
                cabecera.proceso = "Notas de Venta";
                cabecera.TotalBoleta = cabecera.TotalBoleta;
                cabecera.NumReq = 0;
                //cabecera.CodVenWeb = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
                //cabecera.CodBodeWms = cabecera.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
                cabecera.CodLugarDocto = null;
                cabecera.RutTransportista = null;
                cabecera.Cod_Distrib = null;
                cabecera.Nom_Distrib = null;
                cabecera.MarcaWG = null;



                RespuestaNotaVentaModel respuestaNotaVenta = controlDisofi().AgregarNV(baseDatosUsuario(), insertaDisofi, insertaSoftland, cabecera);

                cabecera.Id = respuestaNotaVenta.IdNotaVenta;

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
                            detalle.nvSubTotal = para.DescuentoLineaDirectoSoftland ? Convert.ToDouble(productos[x].SubTotal) : Convert.ToDouble(productos[x].Total);
                            totalDescuento = 0;
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 0 && para.DescuentoLineaDirectoSoftland)
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
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 1 && para.DescuentoLineaDirectoSoftland)
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
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 2 && para.DescuentoLineaDirectoSoftland)
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
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 3 && para.DescuentoLineaDirectoSoftland)
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
                            if (productos[x].Descuentos != null && productos[x].Descuentos.Count > 4 && para.DescuentoLineaDirectoSoftland)
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

                respuestaNotaVenta.EstadoNP = cabecera.EstadoNP;

                try
                {
                    List<string> paraEmail = new List<string>();




                    List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), new ClientesModels { CodAux = cabecera.CodAux });
                    List<VendedorModels> vendedores = controlDisofi().GetVendedores(baseDatosUsuario(), new VendedorModels { VenCod = cabecera.VenCod });
                    List<ClientesModels> contacto = controlDisofi().GetContacto(baseDatosUsuario(), new ClientesModels { CodAux = cabecera.CodAux });


                    if (para.EnvioMailCliente)
                    {
                        if (clientes != null && clientes.Count > 0)
                        {
                            if (clientes[0].EMail != null && clientes[0].EMail != "")
                            {
                                paraEmail.Add(clientes[0].EMail);
                            }
                        }
                    }
                    if (para.EnvioMailContacto)
                    {
                        if (contacto != null && contacto.Count > 0)
                        {
                            if (contacto[0].EMail != null && contacto[0].EMail != "")
                            {
                                paraEmail.Add(contacto[0].EMail);
                            }
                        }
                    }
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

                    EnviarEmail(cabecera.NVNumero, cabecera.Id, vendedores[0].Email, vendedores[0].Contrasena, paraEmail);
                }
                catch (Exception ex)
                {
                    string error = ex.ToString();
                    return null;
                }

                return Json(respuestaNotaVenta);
            }
            catch (Exception ex)
            {
                throw (ex);
            }

        }

        [NonAction]
        public void EnviarEmail(int nvnumero, int Id, string de, string clavecorreo, List<string> para)
        {
            string subject = string.Format("Nota de Pedido {0}", nvnumero);

            string from = de;
            string displayName = System.Configuration.ConfigurationManager.AppSettings.Get("Remitente");
            string password = clavecorreo;
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


            NotadeVentaCabeceraModels NVentaCabecera = new NotadeVentaCabeceraModels
            {
                NVNumero = nvnumero
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
                smtp.Send(mail);
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
            if (ListaPrecio == null)
            {
                ListaPrecio = "-1";
            }
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

            decimal precioUnitarioConDescuento = _precioUnitario;

            for (int x = 0; x < _descuentos.Count; x++)
            {
                if (_descuentos[x].Porcentaje != 0)
                {
                    decimal valorDescuento = Convert.ToInt32((precioUnitarioConDescuento * (_descuentos[x].Porcentaje / 100)));
                    _descuentos[x].Valor = valorDescuento;
                    precioUnitarioConDescuento = precioUnitarioConDescuento - valorDescuento;
                }
            }
            decimal valorAtributoDescuento = 0;
            if (porcentajeAtributoDescuento > 0)
            {
                valorAtributoDescuento = (precioUnitarioConDescuento * (porcentajeAtributoDescuento / 100));
                precioUnitarioConDescuento = precioUnitarioConDescuento - valorAtributoDescuento;
            }

            decimal subTotal = 0;
            decimal total = 0;

            subTotal = precioUnitarioConDescuento * _cantidad;

            total = subTotal;

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
            total = subTotal + impuesto;

            for (int X = 0; X < descuentos.Count; X++)
            {
                decimal valorDescuento = Convert.ToInt32(((total * descuentos[X].Porcentaje) / 100));
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

        [HttpPost]
        public JsonResult AgregarCorreo(string _Email, string _CodAux)
        {
            var validador = 0;

            if (_Email.Contains("@"))
            {
                ClientesModels Clientes = new ClientesModels();
                Clientes.EMail = _Email;
                Clientes.CodAux = _CodAux;
                List<ClientesModels> cli = controlDisofi().ActualizarCorreoCliente(Clientes, baseDatosUsuario());
                validador = 1;
                return Json(validador);
            }
            else
            {
                validador = -666;
                return Json(validador);
            }



        }
        #endregion

    }
}