﻿$(document).ready(function () {
});

function DetalleNotaPedido(nvId) {
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

                var tableCabecera = $("#tblDetalleNotaPedido");
                var tableDetalle = $("#tblDetalleNotaPedidoDetalle");

                $.each(data.Cabecera, function (index, value) {
                    var htmlCabecera = "<tr><th nowrap='nowrap'>N&ordm; Int.</th>" +
                        "<td>" + value.NVNumero + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Vendedor</th>" +
                        "<td>" + value.VenCod + "-" + value.Usuario + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Cond. Venta</th>" +
                        "<td>" + value.CveCod + "-" + value.CveDes + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Fecha Pedido</th>" +
                        "<td>" + value.nvFem + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Fecha Entrega</th>" +
                        "<td>" + value.nvFeEnt + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Lista de Precio</th>" +
                        "<td>" + value.CodLista + "-" + value.DesLista + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Cod. Cliente</th>" +
                        "<td>" + value.CodAux + "-" + value.NomAux + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Contacto</th>" +
                        "<td>" + value.NomCon + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Centro de Costo</th>" +
                        "<td>" + value.CodiCC + "-" + value.DescCC + "</td></tr>" +
                        "<tr><th nowrap='nowrap'>Detalle</th>" +
                        "<td>" + value.nvObser + "</td></tr>";
                    tableCabecera.append(htmlCabecera);
                });

                var htmlDetalle = "";
                htmlDetalle = htmlDetalle + "<th>ID</th>";
                htmlDetalle = htmlDetalle + "<th>Codigo Producto</th>";
                htmlDetalle = htmlDetalle + "<th>Detalle Producto</th>";
                htmlDetalle = htmlDetalle + "<th>Cantidad</th>";
                htmlDetalle = htmlDetalle + "<th>Stock</th>";
                htmlDetalle = htmlDetalle + "<th>U.Medida</th>";
                htmlDetalle = htmlDetalle + "<th>Precio</th>";
                htmlDetalle = htmlDetalle + "<th>Sub Total</th>";
                htmlDetalle = htmlDetalle + "<th>Desc.%</th>";
                htmlDetalle = htmlDetalle + "<th>Total</th>";

                tableDetalle.append(htmlDetalle);

                $.each(data.Detalle, function (index, value) {
                    htmlDetalle = "";
                    if (value.Stock < value.nvCant) {
                        htmlDetalle = htmlDetalle + "<tr style='background-color: red; color: white'>";
                    }
                    else {
                        htmlDetalle = htmlDetalle + "<tr>";
                    }
                    htmlDetalle = htmlDetalle + "<td>" + value.nvLinea + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.CodProd + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.DesProd + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvCant + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.Stock + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.CodUMed + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvPrecio + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvSubTotal + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvDPorcDesc01 + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nvTotLinea + "</td>";
                    htmlDetalle = htmlDetalle + "</tr>";

                    tableDetalle.append(htmlDetalle);
                });
            }
        }
    });
}

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

function AprobarNotaVenta(nvId) {
    $.ajax({
        type: "POST",
        url: "/Reporte/AprobarNotaVenta",
        data: { _nvId: nvId },
        async: true,
        success: function (data) {
            alert("Numero Nota de Venta:\n" + data.nvNum);
            location.reload();
        }
    });
}