﻿using NotaVenta.UTIL;
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

        public ActionResult Index()
        {
            return View();
        }

        [Autorizacion(PERFILES.SUPER_ADMINISTRADOR, PERFILES.VENDEDOR)]
        public ActionResult MisClientes()
        {
            UsuariosModels usr = new UsuariosModels();
            ParametrosModels parametros = ObtieneParametros();
            List<ClientesModels> lclientes = new List<ClientesModels>();

            usr.VenCod = codigoVendedorUsuario().Trim();
            usr.id = SessionVariables.SESSION_DATOS_USUARIO.IdUsuario;
            var misClientes = controlDisofi().BuscarMisClientesVenCod(usr, baseDatosUsuario());

            if (misClientes != null)
            {
                lclientes = misClientes;
            }
            ViewBag.parametros = parametros;
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
        public JsonResult PreNotadeVenta(string CodAux, string NomAux, string RutAux)
        {
            ParametrosModels parametros = ObtieneParametros();
            NotadeVentaCabeceraModels notadeVentaCabeceraModels = new NotadeVentaCabeceraModels();
            notadeVentaCabeceraModels.CodAux = CodAux;
            notadeVentaCabeceraModels.NomAux = NomAux;
            notadeVentaCabeceraModels.RutAux = RutAux;
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

            CreditoModel credito = controlDisofi().ObtenerCredito(cliente.CodAux, baseDatosUsuario());

            if (parametros.ManejaLineaCreditoVendedor)
            {
                if (credito != null)
                {
                    credito.Deuda = credito.Debe - credito.Haber;
                    credito.Saldo = (credito.Credito + credito.Deuda);

                    if (credito.Credito == 0)
                    {
                        validador = -999;
                        return Json(validador);
                    }
                    else
                    {
                        validador = 1;
                        return Json(validador);
                    }

                }
            }

            if (contactoCorreos != null && contactoCorreos.Count > 0 && contactoCorreos[0].EMail != "")
            {
                ViewBag.CorreoCliente = contactoCorreos[0].EMail;
                validador = 1;
                return Json(validador);
            }
            else
            {
                if (clientes != null && clientes.Count > 0)
                {
                    if (parametros.EnvioMailCliente && Convert.ToString(clientes[0].EMail).Trim() == "")
                    {
                        validador = -1;
                        return Json(validador);
                    }
                    else
                    {
                        ViewBag.CorreoCliente = clientes[0].EMail;
                        validador = 1;
                        return Json(validador);
                    }
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
                CodAux = NVC.CodAux,
                RutAux = NVC.RutAux,
            };

            ClientesModels cm = controlDisofi().ObtenerAtributoDescuento(baseDatosUsuario(), cliente.CodAux, parametros.AtributoSoftlandDescuentoCliente);
            cliente.ValorAtributo = cm.ValorAtributo;

            ViewBag.ValorAtributo = cliente.ValorAtributo;
            VendedoresSoftlandModels vendedorCliente = controlDisofi().ObtenerVendedorCliente(cliente.CodAux, baseDatosUsuario());
            ViewBag.VendedorCliente = vendedorCliente;
            CreditoModel credito = controlDisofi().ObtenerCredito(cliente.CodAux, baseDatosUsuario());

            //if (parametros.ManejaLineaCreditoVendedor)
            //{
            //    if (credito != null)
            //    {
            //        credito.Deuda = credito.Debe - credito.Haber;
            //        credito.Saldo = credito.Credito - credito.Deuda;

            //        if (credito.Credito == 0)
            //        {
            //            TempData["Mensaje"] = "CLIENTE NO TIENE CREDITO. <br>";
            //            return RedirectToAction("MisClientes", "Venta");
            //        }

            //    }
            //}



            ViewBag.Credito = credito;
            ViewBag.CodAux = NVC.CodAux;
            ViewBag.RutAux = NVC.RutAux;

            /////
            double MontoTotal = 0;
            double Saldo = 0;
            try
            {
                List<SaldosModel> Saldos = new List<SaldosModel>();
                Saldos = controlDisofi().ObtenerSaldo(ViewBag.RutAux, ViewBag.CodAux, baseDatosUsuario());

                foreach (SaldosModel item in Saldos)
                {
                    MontoTotal = item.Saldo;
                    Saldo = MontoTotal + Saldo;
                }
            }
            catch (Exception)
            {

                throw;
            }

            ViewBag.SaldoTotal = Saldo;
            /////

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
            List<CondicionVentasModels> lCondicionCliente = new List<CondicionVentasModels>();

            conven.CodAux = NVC.CodAux.ToString();
            lCondicionCliente = controlDisofi().listarConVen(baseDatosUsuario(), conven);

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
            lCondicionCliente = (lCondicionCliente == null) ? new List<CondicionVentasModels>() : lCondicionCliente;

            ViewBag.condicionCliente = lCondicionCliente.Count > 0 ? lCondicionCliente[0] : new CondicionVentasModels();

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
        List<NotaDeVentaDetalleModels> NVentaDetalles, List<ClientesModels> Clientes, string nombreEmpresa)
        {
            ParametrosModels parametro = ObtieneParametros();

            char[] blanco = { ' ' };

            int colspan = 7;

            if (parametro.DescuentoLineaDirectoSoftland)
            {
                colspan = colspan + parametro.CantidadDescuentosProducto;
            }

            string direccion = Clientes[0].DirAux;
            direccion = direccion + (Clientes[0].ComCod == null ? "" : ", " + Clientes[0].ComDes);
            direccion = direccion + (Clientes[0].CiuCod == null ? "" : ", " + Clientes[0].CiuDes);

            string htmlBody = String.Format(
            "<html><body>" +
            //"<img src='~/Image/logo.png' />" +
            "<H1> NOTA DE PEDIDO <small>" + nombreEmpresa + "</small></H1>" +
            @"<H4> Nº de Pedido: " + NVentaCabeceras[0].Id + @" </H4>" +
            @"<H4> Fecha Pedido: " + (NVentaCabeceras[0].nvFem == null ? "" : ((DateTime)NVentaCabeceras[0].nvFem).ToShortDateString()) + @" </H4>" +
            @"<H4> Cliente: " + NVentaCabeceras[0].NomAux + @" </H4>" +
            @"<H4> Dirección: " + direccion + @" </H4>" +
            @"<H4> Fecha Entrega: " + (NVentaCabeceras[0].nvFeEnt == null ? "" : ((DateTime)NVentaCabeceras[0].nvFeEnt).ToShortDateString()) + @" </H4>" +
            @"<H4> Observaciones: " + NVentaCabeceras[0].nvObser + @" </H4>" +
            @"<H4> Vendedor: " + NVentaCabeceras[0].VenDes + @" </H4>" +
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
                double precioConIVa = Math.Round(nvd.nvTotLinea * 1.19);
                subtotal = subtotal + nvd.nvTotLinea;
                Iva = (precioConIVa - nvd.nvTotLinea);
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

        public void AgregarContacto(string CodAux, string NomCon)
        {
            ClientesModels cli = new ClientesModels();
            cli.CodAux = CodAux;
            cli.NomCon = NomCon;

            List<ClientesModels> nv = controlDisofi().AgregarContacto(cli);
        }

        [HttpPost]
        public JsonResult AgregarCliente(string NomAux, string RutAux, string FonAux1, string Email, string GirAux, string DirAux, string EmailDte,
            string Comuna, string Ciudad)
        {
            ParametrosModels parametros = ObtieneParametros();
            ClientesModels Cliente = new ClientesModels();
            if (parametros.CrearClienteConDV)
            {
                Cliente.CodAux = RutAux.Replace("-", "").Replace(".", "");
            }
            else
            {
                Cliente.CodAux = (RutAux.Replace("-", "").Replace(".", ""));
                Cliente.CodAux = Cliente.CodAux.Substring(0, Cliente.CodAux.Length - 1);
            }
            Cliente.NomAux = NomAux;
            Cliente.RutAux = RutAux;
            Cliente.FonAux1 = FonAux1;
            Cliente.EMail = Email;
            Cliente.GirCod = GirAux;
            Cliente.DirAux = DirAux;
            Cliente.EmailDte = EmailDte;
            Cliente.ComCod = Comuna;
            Cliente.CiuCod = Ciudad;
            Cliente.VenCod = SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.VenCod;

            RespuestaModel resultExiste = controlDisofi().ExisteCliente(Cliente, baseDatosUsuario());
            if (!resultExiste.Verificador)
            {
                RespuestaModel result = controlDisofi().AgregarCliente(Cliente, baseDatosUsuario());
                return Json(result);
            }
            else
            {
                return Json(new RespuestaModel() { Verificador = false, Mensaje = resultExiste.Mensaje });
            }
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
                IList<NotadeVentaCabeceraModels> listaCabecerasNotasDeVenta = new List<NotadeVentaCabeceraModels>();
                List<List<ProductoAgregadoModel>> listaProductosNotasDeVenta = new List<List<ProductoAgregadoModel>>();

                int contador = 1;
                List<ProductoAgregadoModel> productosTemp = new List<ProductoAgregadoModel>();

                for (int x = 0; x < productos.Count; x++)
                {
                    productosTemp.Add(productos[x]);

                    if (para.CantidadLineas == contador)
                    {
                        CabeceraModel cabeceraModel = CalcularProductosAgregadosFunction(productosTemp, cabecera.Descuentos, productosTemp[0].DescuentoAtributo);
                        NotadeVentaCabeceraModels notadeVentaCabeceraModels = cabecera;
                        notadeVentaCabeceraModels.IdEmpresaInterna = EmpresaUsuario().IdEmpresa;
                        notadeVentaCabeceraModels.nvSubTotal = cabeceraModel.SubTotal;
                        notadeVentaCabeceraModels.nvSubTotalConDescuento = Convert.ToDouble(cabeceraModel.SubTotalConDescuento);

                        notadeVentaCabeceraModels.nvPorcDesc01 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 1) ? cabeceraModel.descuentos[0].Porcentaje : 0);
                        notadeVentaCabeceraModels.nvDescto01 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 1) ? cabeceraModel.descuentos[0].Valor : 0);
                        notadeVentaCabeceraModels.nvPorcDesc02 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 2) ? cabeceraModel.descuentos[1].Porcentaje : 0);
                        notadeVentaCabeceraModels.nvDescto02 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 2) ? cabeceraModel.descuentos[1].Valor : 0);
                        notadeVentaCabeceraModels.nvPorcDesc03 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 3) ? cabeceraModel.descuentos[2].Porcentaje : 0);
                        notadeVentaCabeceraModels.nvDescto03 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 3) ? cabeceraModel.descuentos[2].Valor : 0);
                        notadeVentaCabeceraModels.nvPorcDesc04 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 4) ? cabeceraModel.descuentos[3].Porcentaje : 0);
                        notadeVentaCabeceraModels.nvDescto04 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 4) ? cabeceraModel.descuentos[3].Valor : 0);
                        notadeVentaCabeceraModels.nvPorcDesc05 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 5) ? cabeceraModel.descuentos[4].Porcentaje : 0);
                        notadeVentaCabeceraModels.nvDescto05 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 5) ? cabeceraModel.descuentos[4].Valor : 0);

                        notadeVentaCabeceraModels.Descuentos = cabeceraModel.descuentos;

                        notadeVentaCabeceraModels.nvTotalDesc = 0;
                        notadeVentaCabeceraModels.nvMonto = Convert.ToDouble(cabeceraModel.SubTotalConDescuento);
                        notadeVentaCabeceraModels.nvNetoAfecto = cabeceraModel.Total;
                        notadeVentaCabeceraModels.TotalBoleta = cabeceraModel.Total;

                        listaProductosNotasDeVenta.Add(productosTemp);
                        listaCabecerasNotasDeVenta.Add(AgregarNVCrearCabecera(notadeVentaCabeceraModels));

                        productosTemp = new List<ProductoAgregadoModel>();
                        contador = 1;
                    }
                    else
                    {
                        contador = contador + 1;
                    }
                }

                if (contador != 1)
                {
                    CabeceraModel cabeceraModel = CalcularProductosAgregadosFunction(productosTemp, cabecera.Descuentos, productosTemp[0].DescuentoAtributo);
                    NotadeVentaCabeceraModels notadeVentaCabeceraModels = cabecera;
                    notadeVentaCabeceraModels.IdEmpresaInterna = EmpresaUsuario().IdEmpresa;
                    notadeVentaCabeceraModels.nvSubTotal = cabeceraModel.SubTotal;
                    notadeVentaCabeceraModels.nvSubTotalConDescuento = Convert.ToDouble(cabeceraModel.SubTotalConDescuento);

                    notadeVentaCabeceraModels.nvPorcDesc01 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 1) ? cabeceraModel.descuentos[0].Porcentaje : 0);
                    notadeVentaCabeceraModels.nvDescto01 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 1) ? cabeceraModel.descuentos[0].Valor : 0);
                    notadeVentaCabeceraModels.nvPorcDesc02 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 2) ? cabeceraModel.descuentos[1].Porcentaje : 0);
                    notadeVentaCabeceraModels.nvDescto02 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 2) ? cabeceraModel.descuentos[1].Valor : 0);
                    notadeVentaCabeceraModels.nvPorcDesc03 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 3) ? cabeceraModel.descuentos[2].Porcentaje : 0);
                    notadeVentaCabeceraModels.nvDescto03 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 3) ? cabeceraModel.descuentos[2].Valor : 0);
                    notadeVentaCabeceraModels.nvPorcDesc04 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 4) ? cabeceraModel.descuentos[3].Porcentaje : 0);
                    notadeVentaCabeceraModels.nvDescto04 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 4) ? cabeceraModel.descuentos[3].Valor : 0);
                    notadeVentaCabeceraModels.nvPorcDesc05 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 5) ? cabeceraModel.descuentos[4].Porcentaje : 0);
                    notadeVentaCabeceraModels.nvDescto05 = Convert.ToDouble((cabeceraModel.descuentos != null && cabeceraModel.descuentos.Count >= 5) ? cabeceraModel.descuentos[4].Valor : 0);

                    notadeVentaCabeceraModels.Descuentos = cabeceraModel.descuentos;

                    notadeVentaCabeceraModels.nvTotalDesc = 0;
                    notadeVentaCabeceraModels.nvMonto = Convert.ToDouble(cabeceraModel.SubTotalConDescuento);
                    notadeVentaCabeceraModels.nvNetoAfecto = cabeceraModel.Total;
                    notadeVentaCabeceraModels.TotalBoleta = cabeceraModel.Total;

                    listaProductosNotasDeVenta.Add(productosTemp);
                    listaCabecerasNotasDeVenta.Add(AgregarNVCrearCabecera(notadeVentaCabeceraModels));

                    productosTemp = new List<ProductoAgregadoModel>();
                }


                List<RespuestaNotaVentaModel> listaRespuestaNotaVentaModel = new List<RespuestaNotaVentaModel>();
                for (int i = 0; i < listaProductosNotasDeVenta.Count; i++)
                {
                    RespuestaNotaVentaModel respuestaNotaVenta = creacionCabeceraDetalleNotaVenta(
                        listaCabecerasNotasDeVenta[i],
                        listaProductosNotasDeVenta[i],
                        insertaDisofi,
                        insertaSoftland,
                        para);

                    respuestaNotaVenta.EstadoNP = cabecera.EstadoNP;

                    listaRespuestaNotaVentaModel.Add(respuestaNotaVenta);
                }


                return Json(listaRespuestaNotaVentaModel);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        private NotadeVentaCabeceraModels AgregarNVCrearCabecera(NotadeVentaCabeceraModels cabeceraModels)
        {
            NotadeVentaCabeceraModels retorno = new NotadeVentaCabeceraModels();
            List<DescuentoProductoAgregadoModel> DescuentosTemp = (from item in cabeceraModels.Descuentos
                                                                   select new DescuentoProductoAgregadoModel()
                                                                   {
                                                                       Valor = item.Valor,
                                                                       Porcentaje = item.Porcentaje
                                                                   }).ToList();

            retorno.Id = cabeceraModels.Id;
            retorno.IdEmpresaInterna = cabeceraModels.IdEmpresaInterna;
            retorno.EstadoNP = cabeceraModels.EstadoNP;
            retorno.Saldo = cabeceraModels.Saldo;
            retorno.NomAux = cabeceraModels.NomAux;
            retorno.RutAux = cabeceraModels.RutAux;
            retorno.CveDes = cabeceraModels.CveDes;
            retorno.DesLista = cabeceraModels.DesLista;
            retorno.DescCC = cabeceraModels.DescCC;
            retorno.stocklista = cabeceraModels.stocklista;
            retorno.Descuentos = DescuentosTemp;
            retorno.nvSubTotalConDescuento = cabeceraModels.nvSubTotalConDescuento;
            retorno.NVNumero = cabeceraModels.NVNumero;
            retorno.nvFem = cabeceraModels.nvFem;
            retorno.nvEstado = cabeceraModels.nvEstado;
            retorno.nvEstFact = cabeceraModels.nvEstFact;
            retorno.nvEstDesp = cabeceraModels.nvEstDesp;
            retorno.nvEstRese = cabeceraModels.nvEstRese;
            retorno.nvEstConc = cabeceraModels.nvEstConc;
            retorno.CotNum = cabeceraModels.CotNum;
            retorno.NumOC = cabeceraModels.NumOC;
            retorno.nvFeEnt = cabeceraModels.nvFeEnt;
            retorno.CodAux = cabeceraModels.CodAux;
            retorno.VenCod = cabeceraModels.VenCod;
            retorno.CodMon = cabeceraModels.CodMon;
            retorno.CodLista = cabeceraModels.CodLista;
            retorno.nvObser = cabeceraModels.nvObser;
            retorno.nvCanalNV = cabeceraModels.nvCanalNV;
            retorno.CveCod = cabeceraModels.CveCod;
            retorno.NomCon = cabeceraModels.NomCon;
            retorno.CodiCC = cabeceraModels.CodiCC;
            retorno.CodBode = cabeceraModels.CodBode;
            retorno.nvSubTotal = cabeceraModels.nvSubTotal;
            retorno.nvPorcDesc01 = cabeceraModels.nvPorcDesc01;
            retorno.nvDescto01 = cabeceraModels.nvDescto01;
            retorno.nvPorcDesc02 = cabeceraModels.nvPorcDesc02;
            retorno.nvDescto02 = cabeceraModels.nvDescto02;
            retorno.nvPorcDesc03 = cabeceraModels.nvPorcDesc03;
            retorno.nvDescto03 = cabeceraModels.nvDescto03;
            retorno.nvPorcDesc04 = cabeceraModels.nvPorcDesc04;
            retorno.nvDescto04 = cabeceraModels.nvDescto04;
            retorno.nvPorcDesc05 = cabeceraModels.nvPorcDesc05;
            retorno.nvDescto05 = cabeceraModels.nvDescto05;
            retorno.nvMonto = cabeceraModels.nvMonto;
            retorno.nvFeAprob = cabeceraModels.nvFeAprob;
            retorno.NumGuiaRes = cabeceraModels.NumGuiaRes;
            retorno.nvPorcFlete = cabeceraModels.nvPorcFlete;
            retorno.nvValflete = cabeceraModels.nvValflete;
            retorno.nvPorcEmb = cabeceraModels.nvPorcEmb;
            retorno.nvValEmb = cabeceraModels.nvValEmb;
            retorno.nvEquiv = cabeceraModels.nvEquiv;
            retorno.nvNetoExento = cabeceraModels.nvNetoExento;
            retorno.nvNetoAfecto = cabeceraModels.nvNetoAfecto;
            retorno.nvTotalDesc = cabeceraModels.nvTotalDesc;
            retorno.ConcAuto = cabeceraModels.ConcAuto;
            retorno.CodLugarDesp = cabeceraModels.CodLugarDesp;
            retorno.SolicitadoPor = cabeceraModels.SolicitadoPor;
            retorno.DespachadoPor = cabeceraModels.DespachadoPor;
            retorno.Patente = cabeceraModels.Patente;
            retorno.RetiradoPor = cabeceraModels.RetiradoPor;
            retorno.CheckeoPorAlarmaVtas = cabeceraModels.CheckeoPorAlarmaVtas;
            retorno.EnMantencion = cabeceraModels.EnMantencion;
            retorno.Usuario = cabeceraModels.Usuario;
            retorno.UsuarioGeneraDocto = cabeceraModels.UsuarioGeneraDocto;
            retorno.FechaHoraCreacion = cabeceraModels.FechaHoraCreacion;
            retorno.Sistema = cabeceraModels.Sistema;
            retorno.ConcManual = cabeceraModels.ConcManual;
            retorno.RutSolicitante = cabeceraModels.RutSolicitante;
            retorno.proceso = cabeceraModels.proceso;
            retorno.TotalBoleta = cabeceraModels.TotalBoleta;
            retorno.NumReq = cabeceraModels.NumReq;
            retorno.CodVenWeb = cabeceraModels.CodVenWeb;
            retorno.CodBodeWms = cabeceraModels.CodBodeWms;
            retorno.CodLugarDocto = cabeceraModels.CodLugarDocto;
            retorno.RutTransportista = cabeceraModels.RutTransportista;
            retorno.Cod_Distrib = cabeceraModels.Cod_Distrib;
            retorno.Nom_Distrib = cabeceraModels.Nom_Distrib;
            retorno.MarcaWG = cabeceraModels.MarcaWG;

            return retorno;


        }

        [NonAction]
        public void EnviarEmail(int Id, List<string> para)
        {
            string nombreEmpresa = EmpresaUsuario().NombreEmpresa;
            string subject = string.Format("Nota de Pedido (" + nombreEmpresa + "): " + Id, Id);

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


            //NotadeVentaCabeceraModels NVentaCabecera = new NotadeVentaCabeceraModels
            //{
            //    NVNumero = nvnumero
            //};

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
            mail.AlternateViews.Add(GetEmbeddedImage(NVentaCabeceras, NVentaDetalles, clientes, nombreEmpresa));
            mail.From = new MailAddress(from);

            para = para.Distinct().ToList();

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
                    _descuentos[x].Valor = valorDescuento * _cantidad;
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
            decimal subTotalConDescuento = 0;
            decimal total = 0;

            subTotal = precioUnitario * _cantidad;
            subTotalConDescuento = precioUnitarioConDescuento * _cantidad;

            total = subTotalConDescuento;

            return new ProductoAgregadoModel()
            {
                PrecioUnitario = _precioUnitario,
                PrecioUnitarioConDescuento = precioUnitarioConDescuento,
                Cantidad = _cantidad,
                Descuentos = _descuentos,
                SubTotal = subTotal,
                SubTotalConDescuento = subTotalConDescuento,
                ValorDescuentoAtributo = valorAtributoDescuento,
                Total = total
            };
        }
        private CabeceraModel CalcularProductosAgregadosFunction(List<ProductoAgregadoModel> productos, List<DescuentoProductoAgregadoModel> descuentos, decimal porcentajeAtributoDescuento)
        {
            if (descuentos == null) { descuentos = new List<DescuentoProductoAgregadoModel>(); }
            decimal subTotal = 0;
            decimal subTotalConDescuento = 0;

            foreach (ProductoAgregadoModel item in productos)
            {
                ProductoAgregadoModel producto = CalcularFilaFunction(item.PrecioUnitario, item.Cantidad, item.Descuentos, porcentajeAtributoDescuento);
                subTotal = subTotal + producto.Total;
                subTotalConDescuento = subTotal;
            }

            for (int X = 0; X < descuentos.Count; X++)
            {
                decimal valorDescuento = Convert.ToInt32(((subTotalConDescuento * descuentos[X].Porcentaje) / 100));
                descuentos[X].Valor = valorDescuento;
                subTotalConDescuento = subTotalConDescuento - Convert.ToInt32(valorDescuento);
            }

            decimal impuesto = 0;
            decimal total = 0;

            subTotalConDescuento = Convert.ToInt32(subTotalConDescuento);
            impuesto = Convert.ToInt32(((subTotalConDescuento * 19) / 100));
            total = subTotalConDescuento + impuesto;

            return new CabeceraModel
            {
                Productos = productos,
                descuentos = descuentos,
                SubTotal = Convert.ToInt32(subTotal),
                SubTotalConDescuento = subTotalConDescuento,
                Impuesto = Convert.ToInt32(impuesto),
                Total = Convert.ToInt32(total)
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
            return Json(CalcularProductosAgregadosFunction(productos, descuentos, porcentajeAtributoDescuento));
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

        private RespuestaNotaVentaModel creacionCabeceraDetalleNotaVenta(NotadeVentaCabeceraModels cabecera, List<ProductoAgregadoModel> productos, bool insertaDisofi,
            bool insertaSoftland, ParametrosModels para)
        {
            cabecera.IdEmpresaInterna = cabecera.IdEmpresaInterna;
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
            if (cabecera.CveCod == null)
            {
                if (para.CodigoCondicionVentaPorDefecto != null && para.CodigoCondicionVentaPorDefecto != "")
                {
                    cabecera.CveCod = para.CodigoCondicionVentaPorDefecto;
                }
            }
            cabecera.NomCon = (cabecera.NomCon == null || cabecera.NomCon == "") ? "SIN CONTACTO" : cabecera.NomCon;
            cabecera.CodiCC = cabecera.CodiCC == "-1" ? null : cabecera.CodiCC;
            cabecera.nvSubTotal = para.DescuentoTotalDirectoSoftland ? cabecera.nvSubTotal : cabecera.nvSubTotalConDescuento;

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
            cabecera.nvMonto = para.DescuentoTotalDirectoSoftland ? cabecera.nvNetoAfecto : cabecera.TotalBoleta;
            cabecera.nvFeAprob = insertaSoftland ? (DateTime?)DateTime.Now : null;
            cabecera.NumGuiaRes = 0;
            cabecera.nvPorcFlete = 0;
            cabecera.nvValflete = 0;
            cabecera.nvPorcEmb = 0;
            cabecera.nvValEmb = 0;
            cabecera.nvEquiv = 1;
            cabecera.nvNetoExento = 0;
            cabecera.nvNetoAfecto = cabecera.nvSubTotalConDescuento;
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
            cabecera.NVNumero = respuestaNotaVenta.NVNumero;

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
                        detalle.nvPrecio = para.DescuentoLineaDirectoSoftland ? Convert.ToDouble(productos[x].PrecioUnitario) : Convert.ToDouble(productos[x].PrecioUnitarioConDescuento);
                        detalle.nvEquiv = 1;
                        detalle.nvSubTotal = para.DescuentoLineaDirectoSoftland ? Convert.ToDouble(productos[x].SubTotal) : Convert.ToDouble(productos[x].SubTotalConDescuento);
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
            try
            {
                if (insertaSoftland)
                {
                    RespuestaNotaVentaModel respuesta = controlDisofi().AgregarImpuesto(baseDatosUsuario(), cabecera);
                }
            }
            catch
            {

            }

            EnviarEmailNotaVenta(cabecera, para);

            return respuestaNotaVenta;
        }

        private void EnviarEmailNotaVenta(NotadeVentaCabeceraModels cabecera, ParametrosModels para)
        {

            try
            {
                List<string> paraEmail = new List<string>();

                List<ClientesModels> clientes = controlDisofi().GetClientes(baseDatosUsuario(), new ClientesModels { CodAux = cabecera.CodAux });
                List<VendedorModels> vendedores = controlDisofi().GetVendedores(baseDatosUsuario(), new VendedorModels { VenCod = cabecera.VenCod });
                List<ClientesModels> contacto = controlDisofi().GetContacto(baseDatosUsuario(), new ClientesModels { CodAux = cabecera.CodAux });
                List<AprobadorModels> aprobador = controlDisofi().GetAprobadorNP();

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
                if (para.EnvioMailAprobador)
                {
                    if (aprobador != null && aprobador.Count > 0)
                    {
                        if (aprobador[0].email != null && aprobador[0].email != "")
                        {
                            paraEmail.Add(aprobador[0].email);
                        }
                    }
                }

                EnviarEmail(/*cabecera.NVNumero,*/ cabecera.Id, paraEmail);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
            }
        }

        [HttpPost]
        public JsonResult ObtenerSaldo(string RutAuxiliar, string CodAux)
        {
            double MontoTotal = 0;
            double Saldo = 0;
            try
            {
                List<SaldosModel> Saldos = new List<SaldosModel>();
                Saldos = controlDisofi().ObtenerSaldo(RutAuxiliar, CodAux, baseDatosUsuario());

                foreach (SaldosModel item in Saldos)
                {
                    MontoTotal = item.Saldo;
                    Saldo = MontoTotal + Saldo;
                }

                return Json(new { DetalleSaldo = Saldos, SaldoTotal = MontoTotal }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}