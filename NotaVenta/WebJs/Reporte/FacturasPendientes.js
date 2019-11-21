var parametros = {};

$(document).ready(function () {
    parametros = {
        ControlaStockProducto: ($("#ControlaStockProducto").val().toLowerCase() === "true"),
        DescuentoLineaDirectoSoftland: ($("#DescuentoLineaDirectoSoftland").val().toLowerCase() === "true"),
        DescuentoTotalDirectoSoftland: ($("#DescuentoTotalDirectoSoftland").val().toLowerCase() === "true"),
        CantidadDescuentosProducto: ($("#CantidadDescuentosProducto").val().toLowerCase()),
        CantidadDescuentosTotalDocumento: ($("#CantidadDescuentosTotalDocumento").val().toLowerCase()),
        MuestraUnidadMedidaProducto: ($("#MuestraUnidadMedidaProducto").val().toLowerCase() === "true")
    };
});

function DetalleNotaPedido(nvId, RutAux) {
    var tableCabecera = $("#tblDetalleNotaPedido");
    var tableDetalle = $("#tblDetalleNotaPedidoDetalle");
    var htmlDetalle = "";
    var subtotal = 0;
    var ivatotal = 0;
    var totalconiva = 0;
    var total = 0;
    $.ajax({
        type: "POST",
        url: "FacturasAprobadas",
        data: { _nvId: nvId },
        async: true,
        success: function (data) {
            if (data.Mensaje == 1) {
                alert("No se encontró el documento." + data.nvNum);
            }
            else {
                $("#tblDetalleNotaPedido").html("");
                $("#tblDetalleNotaPedidoDetalle").html("");

                $.each(data.Cabecera, function (index, value) {
                    var vendedor = "Sin vendedor";
                    var listaPrecio = "Sin Lista de Precio";
                    var centroCosto = "Sin centro de costo";


                    if (value.VenCod !== null) {
                        vendedor = value.VenCod;
                    }
                    if (value.CodLista !== null) {
                        listaPrecio = value.CodLista + "-" + value.DesLista
                    }
                    if (value.CodiCC !== null) {
                        centroCosto = value.CodiCC + "-" + value.DescCC;
                    }
                    var htmlCabecera = "<tr><th nowrap='nowrap'>N&ordm; Int.</th>" +
                        "<td>" + nvId + "</td>" +
                        "<th nowrap='nowrap'>Vendedor</th>" +
                        "<td>" + vendedor + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Cond. Venta</th>" +
                        "<td>" + value.CveCod + "-" + value.CveDes + "</td>" +
                        "<th nowrap='nowrap'>Fecha Pedido</th>" +
                        "<td>" + value.nvFemString + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Fecha Entrega</th>" +
                        "<td>" + value.nvFeEntString + "</td>" +
                        "<th nowrap='nowrap'>Lista de Precio</th>" +
                        "<td>" + listaPrecio + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Cod. Cliente</th>" +
                        "<td>" + value.CodAux + "-" + value.NomAux + "</td>" +
                        "<th nowrap='nowrap'>Contacto</th>" +
                        "<td>" + value.NomCon + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Centro de Costo</th>" +
                        "<td>" + centroCosto + "</td>" +
                        "<tr><th nowrap='nowrap'>Observacion</th>" +
                        "<td>" + value.nvObser + "</td></tr>";
                    tableCabecera.append(htmlCabecera);
                });

                htmlDetalle = "";
                htmlDetalle = htmlDetalle + "<th>ID</th>";
                htmlDetalle = htmlDetalle + "<th>Codigo Producto</th>";
                htmlDetalle = htmlDetalle + "<th>Detalle Producto</th>";
                htmlDetalle = htmlDetalle + "<th>Cantidad</th>";
                htmlDetalle = htmlDetalle + "<th>Stock</th>";

                if (parametros.MuestraUnidadMedidaProducto) {
                    htmlDetalle = htmlDetalle + "<th>U.Medida</th>";
                }

                htmlDetalle = htmlDetalle + "<th>Precio</th>";
                htmlDetalle = htmlDetalle + "<th>Sub Total</th>";
                if (parametros.DescuentoLineaDirectoSoftland) {
                    for (z = 0; z < parametros.CantidadDescuentosProducto; z++) {
                        htmlDetalle = htmlDetalle + "<th>Desc. N°" + (z + 1) + " (%)</th>";
                    }
                }
                htmlDetalle = htmlDetalle + "<th>Total</th>";

                tableDetalle.append(htmlDetalle);

                $.each(data.Detalle, function (index, value) {
                    htmlDetalle = "";
                    if (parametros.ControlaStockProducto) {
                        if (value.Stock < value.nvCant) {
                            htmlDetalle = htmlDetalle + "<tr style='background-color: red; color: white'>";
                        }
                        else {
                            htmlDetalle = htmlDetalle + "<tr>";
                        }
                    }
                    htmlDetalle = htmlDetalle + "<tr>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvLinea + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.CodProd + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.DesProd + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvCant + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.Stock + "</td>";

                    if (parametros.MuestraUnidadMedidaProducto) {
                        htmlDetalle = htmlDetalle + "<td>" + value.CodUMed + "</td>";
                    }

                    htmlDetalle = htmlDetalle + "<td>" + value.nvPrecio + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvSubTotal + "</td>";
                    if (parametros.DescuentoLineaDirectoSoftland) {
                        for (z = 0; z < parametros.CantidadDescuentosProducto; z++) {
                            if (z === 0) { htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc01 + "</td>"; }
                            if (z === 1) { htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc02 + "</td>"; }
                            if (z === 2) { htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc03 + "</td>"; }
                            if (z === 3) { htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc04 + "</td>"; }
                            if (z === 4) { htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc05 + "</td>"; }
                        }
                    }
                    htmlDetalle = htmlDetalle + "<td>" + value.nvTotLinea + "</td>";
                    htmlDetalle = htmlDetalle + "</tr>";


                    var subtotalaux = value.nvSubTotal;
                    subtotal = subtotal * value.nvCant + subtotalaux;

                    var ivaaux = (value.nvPrecio * value.nvCant) * 0.19;
                    ivatotal = Math.round(ivatotal + ivaaux);

                    var totalaux = value.nvTotLinea;
                    total = total + totalaux;

                    tableDetalle.append(htmlDetalle);
                });
                totalconiva = Math.round(total + ivatotal);

                var colspanTotales = 7;
                if (parametros.DescuentoLineaDirectoSoftland) {
                    colspanTotales = colspanTotales + parseInt(parametros.CantidadDescuentosProducto);
                }

                var htmldetalleTotal = "";
                htmldetalleTotal = htmldetalleTotal + "<tr><th style='text-align: right;' colspan='" + colspanTotales + "'>SubTotal</th>";
                htmldetalleTotal = htmldetalleTotal + "<td>" + subtotal + "</td>";
                htmldetalleTotal = htmldetalleTotal + "</tr>";
                htmldetalleTotal = htmldetalleTotal + "<tr><th style='text-align: right;' colspan='" + colspanTotales + "'>Total Iva</th>";
                htmldetalleTotal = htmldetalleTotal + "<td>" + ivatotal + "</td>";
                htmldetalleTotal = htmldetalleTotal + "</tr>";
                htmldetalleTotal = htmldetalleTotal + "<tr><th style='text-align: right;' colspan='" + colspanTotales + "'>Venta Total</th>";
                htmldetalleTotal = htmldetalleTotal + "<td>" + totalconiva + "</td>";
                htmldetalleTotal = htmldetalleTotal + "</tr>";
                tableDetalle.append(htmldetalleTotal);
            }
        }
    });
}

function AprobarNotaVenta(nvId, id) {
    activarLoadingBoton(id);
    $.ajax({
        type: "POST",
        url: "/Reporte/AprobarNotaVenta",
        data: { _nvId: nvId },
        async: true,
        success: function (data) {
            alert("Numero Nota de Venta:" + data.nvNum);
            desactivarLoadingBoton(id);
            location.reload();
        }
    });
}

function RechazarNotaVenta(nvId, nvNum) {
    $.ajax({
        type: "POST",
        url: "/Reporte/RechazarNotaVenta",
        data: { _nvId: nvId, _nvNum: nvNum },
        async: true,
        success: function (data) {
            alert("Numero Nota de Venta Rechazada: " + data.nvNum);
            location.reload();
        }
    });
}
function ObtenerSaldo(RutAux) {
    $("#tblSaldos").html("");
    $.ajax({
        type: "POST",
        url: "/Venta/ObtenerSaldo",
        data: { RutAuxiliar: RutAux },
        async: true,
        success: function (response) {
            console.log(response);
            if (response == 1) {
                alert("Cliente sin Saldo.");
            }
            else {

                var tblSaldos = $("#tblSaldos");

                //$.each(data.Cabecera, function (index, value) {

                var htmlCabecera = "";
                var htmlDetalle = "";

                htmlCabecera = htmlCabecera + "<th>Cuenta</th>";
                htmlCabecera = htmlCabecera + "<th>Desc Cuenta</th>";
                htmlCabecera = htmlCabecera + "<th>CodigoAux</th>";
                htmlCabecera = htmlCabecera + "<th>RutCliente</th>";
                htmlCabecera = htmlCabecera + "<th>Nombre</th>";
                htmlCabecera = htmlCabecera + "<th>FecEmision</th>";
                htmlCabecera = htmlCabecera + "<th>TipoDoc</th>";
                htmlCabecera = htmlCabecera + "<th>NomDoc</th>";
                htmlCabecera = htmlCabecera + "<th>Saldo</th>";
                //htmlCabecera = htmlCabecera + "<th>Cod Documento</th>";
                //htmlCabecera = htmlCabecera + "<th>Año Comprobante</th>";
                htmlCabecera = htmlCabecera + "<th>Dias Vencido</th>";

                tblSaldos.append(htmlCabecera);

                $.each(response.DetalleSaldo, function (index, value) {
                    htmlDetalle = "";
                    htmlDetalle = htmlDetalle + "<tr>";
                    htmlDetalle = htmlDetalle + "<td>" + value.pccodi + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.pcdesc + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.codaux + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.RutAux + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nomaux + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.fechaemiString + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.desdoc + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movnumdocref + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.Saldo + "</td>";
                    //htmlDetalle = htmlDetalle + "<td>" + value.coddoc + "</td>";
                    //htmlDetalle = htmlDetalle + "<td>" + value.Cpbano + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.DiasVen + "</td>";

                    htmlDetalle = htmlDetalle + "</tr>";

                    tblSaldos.append(htmlDetalle);
                });
            }
        }
    });
}