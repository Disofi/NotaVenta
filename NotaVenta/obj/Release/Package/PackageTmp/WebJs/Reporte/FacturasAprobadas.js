$(document).ready(function () {
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
                    var htmlCabecera = "<tr><th>N&ordm; Int.</th>" +
                        "<td>" + value.NVNumero + "</td>" +
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




                //<div class="clearing"></div>
                //<div class="table-responsive">
                ////    <div class="row col-md-10">
                ////        <table class="registros table table-hover " id="dataTablePopUp">
                ////            <thead>
                ////                <tr>
                ////                    <td>ID</td>
                ////                    <th nowrap="nowrap">Codigo Producto</th>
                //                    <th>Detalle Producto</th>
                //                    <th>Cantidad</th>
                //                    <th>Stock</th>
                //                    <th>U. Medida</th>
                //                    <th>Precio</th>
                //                    <th>Sub Total</th>
                //                    <th>Desc.%</th>
                //                    <th>Total</th>
                //                </tr>
                //            </thead>
                //            <tbody>
                //                @{
                //                      for (int i = 0; i < detalle.Count; i++)
                //                    {
                //                    {
                //                        if(@detalle [i].Stock < @detalle[i].nvCant)
                //                            {
                //                    <tr id=i>
                //                        <td>@detalle[i].nvLinea</td>
                //                        <td nowrap="nowrap">@detalle[i].CodProd</td>
                //                        <td nowrap="nowrap">@detalle[i].DesProd</td>
                //                        <td nowrap="nowrap" class="ta-r">@detalle[i].nvCant</td>
                //                        <td nowrap="nowrap" class="ta-r bg-danger">@detalle[i].Stock</td>
                //                        <td nowrap="nowrap" class="ta-r">@detalle[i].CodUMed</td>
                //                        <td nowrap="nowrap" class="ta-r">@double.Parse(detalle[i].nvPrecio.ToString()).ToString("N0")</td>
                //                        <td class="ta-r">
                //                            <strong>@double.Parse(detalle[i].nvSubTotal.ToString()).ToString("N0")</strong>
                //                        </td>
                //                        <td nowrap="nowrap" class="ta-r">@detalle[i].nvDPorcDesc01</td>
                //                        <td class="ta-r">
                //                            <strong>@double.Parse(detalle[i].nvTotLinea.ToString()).ToString("N0")</strong>
                //                        </td>
                //                    </tr>
                //                }
                //                else
                //                            {
                //                    <tr id=i>
                //                        <td>@detalle[i].nvLinea</td>
                //                        <td nowrap="nowrap">@detalle[i].CodProd</td>
                //                        <td nowrap="nowrap">@detalle[i].DesProd</td>
                //                        <td nowrap="nowrap" class="ta-r">@detalle[i].nvCant</td>
                //                        <td nowrap="nowrap" class="ta-r bg-success">@detalle[i].Stock</td>
                //                        <td nowrap="nowrap" class="ta-r">@detalle[i].CodUMed</td>
                //                        <td nowrap="nowrap" class="ta-r">@double.Parse(detalle[i].nvPrecio.ToString()).ToString("N0")</td>
                //                        <td class="ta-r">
                //                            <strong>@double.Parse(detalle[i].nvSubTotal.ToString()).ToString("N0")</strong>
                //                        </td>
                //                        <td nowrap="nowrap" class="ta-r">@detalle[i].nvDPorcDesc01</td>
                //                        <td class="ta-r">
                //                            <strong>@double.Parse(detalle[i].nvTotLinea.ToString()).ToString("N0")</strong>
                //                        </td>
                //                    </tr>
                //                }
                //                }

                //            }
                //        }
                //            </tbody>
                //            <tbody>
                //                <tr>
                //                    <td class="ta-r" colspan="8" align="right"><strong>Sub-Total</strong></td>
                //                    <td class="ta-r"><strong>@double.Parse(cabecera[0].nvSubTotal.ToString()).ToString("N0")</strong></td>
                //                </tr>
                //                <tr>
                //                    <td class="ta-r" colspan="8" style="{text-align: right !important}"><strong>Impuesto</strong></td>
                //                    <td class="ta-r"><strong>@double.Parse((cabecera[0].TotalBoleta - cabecera[0].nvSubTotal).ToString()).ToString("N0")</strong></td>
                //                </tr>
                //                <tr>
                //                    <td class="ta-r" colspan="8" align="right"><strong>Total Final</strong></td>
                //                    <td class="ta-r"><strong>@double.Parse(cabecera[0].TotalBoleta.ToString()).ToString("N0")</strong></td>
                //                </tr>
                //            </tbody>
                //        </table>
                //    </div>
                //</div>
