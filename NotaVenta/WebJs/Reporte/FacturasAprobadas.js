var parametros = {};

$(document).ready(function () {
    parametros = {
        ControlaStockProducto: ($("#ControlaStockProducto").val().toLowerCase() === "true"),
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
                    if (value.Usuario == null) {
                        value.Usuario = 'Vendedor';
                    }
                    if (value.CodLista == null) {
                        value.CodLista = 'Sin Lista de Precio';
                    }
                    if (value.DesLista == null) {
                        value.DesLista = '';
                    }
                    if (value.CodiCC == null) {
                        value.CodiCC = '-';
                        value.DescCC = '-';
                    }
                        htmlCabecera = "<tr><th>N&ordm; Softland.</th>" +
                        "<td>" + value.NVNumero + "</td>" +
                        "<th nowrap='nowrap'>N&ordm; Int.</th>" +
                        "<td>" + nvId + "</td>" +
                        "<th nowrap='nowrap'>Vendedor</th>" +
                        "<td>" + value.VenCod + "-" + value.Usuario + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Cond. Venta</th>" +
                        "<td>" + value.CveCod + "-" + value.CveDes + "</td>" +
                        "<th>Fecha Pedido</th>" +
                        "<td>" + value.nvFemString + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Fecha Entrega</th>" +
                        "<td>" + value.nvFeEntString + "</td></tr>" +

                        "<tr><th nowrap='nowrap'>Lista de Precio</th>" +
                        "<td>" + value.CodLista + "-" + value.DesLista + "</td>" +
                        "<th nowrap='nowrap'>Cod. Cliente</th>" +
                        "<td>" + value.CodAux + "-" + value.NomAux + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Contacto</th>" +
                        "<td>" + value.NomCon + "</td>" +
                        "<th nowrap='nowrap'>Centro de Costo</th>" +
                        "<td>" + value.CodiCC + "-" + value.DescCC + "</td></tr>" +
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
                htmlDetalle = htmlDetalle + "<th>Desc.%</th>";
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
                    htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc01 + "</td>";
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
                var htmldetalleTotal = "";
                htmldetalleTotal = htmldetalleTotal + "<tr><th style='text-align: right;' colspan='8'>SubTotal</th>";
                htmldetalleTotal = htmldetalleTotal + "<td>" + subtotal + "</td>";
                htmldetalleTotal = htmldetalleTotal + "</tr>";
                htmldetalleTotal = htmldetalleTotal + "<tr><th style='text-align: right;' colspan='8'>Total Iva</th>";
                htmldetalleTotal = htmldetalleTotal + "<td>" + ivatotal + "</td>";
                htmldetalleTotal = htmldetalleTotal + "</tr>";
                htmldetalleTotal = htmldetalleTotal + "<tr><th style='text-align: right;' colspan='8'>Venta Total</th>";
                htmldetalleTotal = htmldetalleTotal + "<td>" + totalconiva + "</td>";
                htmldetalleTotal = htmldetalleTotal + "</tr>";
                tableDetalle.append(htmldetalleTotal);
            }
        }
    });
}
