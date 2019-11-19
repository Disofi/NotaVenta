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

function aprobarNW(nvnumero) {
    console.log(nvnumero);

    $("#nvnumero").val(nvnumero);
    var url = $("#urlFacturasPendientes").val();

    var data = {
        NVNumero: nvnumero
    };

    console.log(data);
    debugger
    $.post(url, data).done(function (data) {
        confirm("Numero Nota de Venta:\n" + data[0].NVNumero);
        debugger
    });
}

function DetalleNotaPedido(nvId) {
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

                    htmlCabecera = "<tr><th>N&ordm; Softland.</th>" +
                        "<td>" + value.NVNumero + "</td>" +
                        "<th nowrap='nowrap'>N&ordm; Int.</th>" +
                        "<td>" + nvId + "</td>" +
                        "<th nowrap='nowrap'>Vendedor</th>" +
                        "<td>" + vendedor + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Cond. Venta</th>" +
                        "<td>" + value.CveCod + "-" + value.CveDes + "</td>" +
                        "<th>Fecha Pedido</th>" +
                        "<td>" + value.nvFemString + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Fecha Entrega</th>" +
                        "<td>" + value.nvFeEntString + "</td></tr>" +

                        "<tr><th nowrap='nowrap'>Lista de Precio</th>" +
                        "<td>" + listaPrecio + "</td>" +
                        "<th nowrap='nowrap'>Cod. Cliente</th>" +
                        "<td>" + value.CodAux + "-" + value.NomAux + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Contacto</th>" +
                        "<td>" + value.NomCon + "</td>" +
                        "<th nowrap='nowrap'>Centro de Costo</th>" +
                        "<td>" + centroCosto + "</td></tr>" +
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
