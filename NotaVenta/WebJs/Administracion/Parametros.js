$(document).ready(function () {
    $("input[switcher]").change(function () {
        logicaCambioSwitch(this.id);

        var id = this.id;

        /*
        switch (id) {
            case "ListaClientesVendedor":
                $("#ListaClientesTodos").click();
                break;
            case "ListaClientesTodos":
                $("#ListaClientesVendedor").click();
                break;
        }
        */
    });

    $("#btnGuardarParametro").click(function () {
        GuardarParametros();
    });
    $("#ddlEmpresas").change(function () {
        var idEmpresa = $("#ddlEmpresas").val();
        if (idEmpresa !== '-1') {
            $.ajax({
                url: "ObtieneParametro",
                data: { idEmpresa: idEmpresa },
                type: "POST",
                dataType: "json",
                async: false,
                success: function (response) {
                    cambiarValorSwitcher("MultiEmpresa", response.MultiEmpresa);
                    cambiarValorSwitcher("ManejaAdministrador", response.ManejaAdministrador);
                    cambiarValorSwitcher("ManejaAprobador", response.ManejaAprobador);
                    cambiarValorSwitcher("ListaClientesVendedor", response.ListaClientesVendedor);
                    cambiarValorSwitcher("ListaClientesTodos", response.ListaClientesTodos);
                    cambiarValorSwitcher("ValidaReglasNegocio", response.ValidaReglasNegocio);
                    cambiarValorSwitcher("ManejaListaPrecios", response.ManejaListaPrecios);
                    cambiarValorSwitcher("EditaPrecioProducto", response.EditaPrecioProducto);
                    cambiarValorSwitcher("MuestraCondicionVentaCliente", response.MuestraCondicionVentaCliente);
                    cambiarValorSwitcher("MuestraCondicionVentaTodos", response.MuestraCondicionVentaTodos);
                    cambiarValorSwitcher("EditaDescuentoProducto", response.EditaDescuentoProducto);
                    $("#MaximoDescuentoProducto").val(response.MaximoDescuentoProducto);
                    $("#CantidadDescuentosProducto").val(response.CantidadDescuentosProducto);
                    cambiarValorSwitcher("MuestraStockProducto", response.MuestraStockProducto);
                    cambiarValorSwitcher("StockProductoEsMasivo", response.StockProductoEsMasivo);
                    cambiarValorSwitcher("StockProductoEsBodega", response.StockProductoEsBodega);
                    $("#StockProductoCodigoBodega").val(response.StockProductoCodigoBodega);
                    cambiarValorSwitcher("ControlaStockProducto", response.ControlaStockProducto);
                    cambiarValorSwitcher("EnvioMailCliente", response.EnvioMailCliente);
                    cambiarValorSwitcher("EnvioMailVendedor", response.EnvioMailVendedor);
                    cambiarValorSwitcher("EnvioMailContacto", response.EnvioMailContacto);
                    cambiarValorSwitcher("EnvioObligatorioAprobador", response.EnvioObligatorioAprobador);
                    cambiarValorSwitcher("ManejaTallaColor", response.ManejaTallaColor);
                    cambiarValorSwitcher("ManejaDescuentoTotalDocumento", response.ManejaDescuentoTotalDocumento);
                    $("#CantidadDescuentosTotalDocumento").val(response.CantidadDescuentosTotalDocumento);
                    $("#CantidadLineas").val(response.CantidadLineas);
                    cambiarValorSwitcher("ManejaLineaCredito", response.ManejaLineaCredito);
                    cambiarValorSwitcher("ManejaCanalVenta", response.ManejaCanalVenta);
                    cambiarValorSwitcher("CreacionNotaVentaUsuariosBloqueados", response.CreacionNotaVentaUsuariosBloqueados);
                    cambiarValorSwitcher("CreacionNotaVentaUsuariosInactivos", response.CreacionNotaVentaUsuariosInactivos);
                    cambiarValorSwitcher("PermiteModificacionCondicionVenta", response.PermiteModificacionCondicionVenta);
                    $("#AtributoSoftlandDescuentoCliente").val(response.AtributoSoftlandDescuentoCliente);
                    cambiarValorSwitcher("PermiteCrearDireccion", response.PermiteCrearDireccion);
                    cambiarValorSwitcher("CrearClienteConDV", response.CrearClienteConDV);
                    cambiarValorSwitcher("MuestraUnidadMedidaProducto", response.MuestraUnidadMedidaProducto);
                    cambiarValorSwitcher("DescuentoLineaDirectoSoftland", response.DescuentoLineaDirectoSoftland);
                    cambiarValorSwitcher("DescuentoTotalDirectoSoftland", response.DescuentoTotalDirectoSoftland);

                    $("#divDatos").fadeIn();
                },
                error: function (response) {
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        else {
            $("#divDatos").fadeOut();
        }
    });
});

function logicaCambioSwitch(id) {
    var check = estaHabilitadoSwitcher(id);
    if (check) {
        $("#" + id).removeAttr("checked");
    }
    else {
        $("#" + id).attr("checked", "");
    }
}
function estaHabilitadoSwitcher(id) {
    var check = $("#" + id).attr("checked");
    if (check !== undefined) {
        return true;
    }
    else {
        return false;
    }
}
function cambiarValorSwitcher(id, valor) {
    $("#" + id).removeAttr("checked");
    if (valor) {
        $("#" + id).attr("checked", "");
    }
    else {
        $("#" + id).removeAttr("checked");
    }
}















function GuardarParametros() {
    var IdEmpresa = $("#ddlEmpresas").val();
    var MultiEmpresa = estaHabilitadoSwitcher("MultiEmpresa");
    var ManejaAdministrador = estaHabilitadoSwitcher("ManejaAdministrador");
    var ManejaAprobador = estaHabilitadoSwitcher("ManejaAprobador");
    var ListaClientesVendedor = estaHabilitadoSwitcher("ListaClientesVendedor");
    var ListaClientesTodos = estaHabilitadoSwitcher("ListaClientesTodos");
    var ValidaReglasNegocio = estaHabilitadoSwitcher("ValidaReglasNegocio");
    var ManejaListaPrecios = estaHabilitadoSwitcher("ManejaListaPrecios");
    var EditaPrecioProducto = estaHabilitadoSwitcher("EditaPrecioProducto");
    var MuestraCondicionVentaCliente = estaHabilitadoSwitcher("MuestraCondicionVentaCliente");
    var MuestraCondicionVentaTodos = estaHabilitadoSwitcher("MuestraCondicionVentaTodos");
    var EditaDescuentoProducto = estaHabilitadoSwitcher("EditaDescuentoProducto");
    var MaximoDescuentoProducto = $("#MaximoDescuentoProducto").val();
    var CantidadDescuentosProducto = $("#CantidadDescuentosProducto").val();
    var MuestraStockProducto = estaHabilitadoSwitcher("MuestraStockProducto");
    var StockProductoEsMasivo = estaHabilitadoSwitcher("StockProductoEsMasivo");
    var StockProductoEsBodega = estaHabilitadoSwitcher("StockProductoEsBodega");
    var StockProductoCodigoBodega = $("#StockProductoCodigoBodega").val();
    var ControlaStockProducto = estaHabilitadoSwitcher("ControlaStockProducto");
    var EnvioMailCliente = estaHabilitadoSwitcher("EnvioMailCliente");
    var EnvioMailVendedor = estaHabilitadoSwitcher("EnvioMailVendedor");
    var EnvioMailContacto = estaHabilitadoSwitcher("EnvioMailContacto");
    var EnvioObligatorioAprobador = estaHabilitadoSwitcher("EnvioObligatorioAprobador");
    var ManejaTallaColor = estaHabilitadoSwitcher("ManejaTallaColor");
    var ManejaDescuentoTotalDocumento = estaHabilitadoSwitcher("ManejaDescuentoTotalDocumento");
    var CantidadDescuentosTotalDocumento = $("#CantidadDescuentosTotalDocumento").val();
    var CantidadLineas = $("#CantidadLineas").val();
    var ManejaLineaCredito = estaHabilitadoSwitcher("ManejaLineaCredito");
    var ManejaCanalVenta = estaHabilitadoSwitcher("ManejaCanalVenta");
    var CreacionNotaVentaUsuariosBloqueados = estaHabilitadoSwitcher("CreacionNotaVentaUsuariosBloqueados");
    var CreacionNotaVentaUsuariosInactivos = estaHabilitadoSwitcher("CreacionNotaVentaUsuariosInactivos");
    var PermiteModificacionCondicionVenta = estaHabilitadoSwitcher("PermiteModificacionCondicionVenta");
    var AtributoSoftlandDescuentoCliente = $("#AtributoSoftlandDescuentoCliente").val();
    var PermiteCrearDireccion = estaHabilitadoSwitcher("PermiteCrearDireccion");
    var CrearClienteConDV = estaHabilitadoSwitcher("CrearClienteConDV");
    var MuestraUnidadMedidaProducto = estaHabilitadoSwitcher("MuestraUnidadMedidaProducto");
    var DescuentoLineaDirectoSoftland = estaHabilitadoSwitcher("DescuentoLineaDirectoSoftland");
    var DescuentoTotalDirectoSoftland = estaHabilitadoSwitcher("DescuentoTotalDirectoSoftland");

    var datosRequest = {
        IdEmpresa: IdEmpresa,
        MultiEmpresa: MultiEmpresa,
        ManejaAdministrador: ManejaAdministrador,
        ManejaAprobador: ManejaAprobador,
        ListaClientesVendedor: ListaClientesVendedor,
        ListaClientesTodos: ListaClientesTodos,
        ValidaReglasNegocio: ValidaReglasNegocio,
        ManejaListaPrecios: ManejaListaPrecios,
        EditaPrecioProducto: EditaPrecioProducto,
        MuestraCondicionVentaCliente: MuestraCondicionVentaCliente,
        MuestraCondicionVentaTodos: MuestraCondicionVentaTodos,
        EditaDescuentoProducto: EditaDescuentoProducto,
        MaximoDescuentoProducto: MaximoDescuentoProducto,
        CantidadDescuentosProducto: CantidadDescuentosProducto,
        MuestraStockProducto: MuestraStockProducto,
        StockProductoEsMasivo: StockProductoEsMasivo,
        StockProductoEsBodega: StockProductoEsBodega,
        StockProductoCodigoBodega: StockProductoCodigoBodega,
        ControlaStockProducto: ControlaStockProducto,
        EnvioMailCliente: EnvioMailCliente,
        EnvioMailVendedor: EnvioMailVendedor,
        EnvioMailContacto: EnvioMailContacto,
        EnvioObligatorioAprobador: EnvioObligatorioAprobador,
        ManejaTallaColor: ManejaTallaColor,
        ManejaDescuentoTotalDocumento: ManejaDescuentoTotalDocumento,
        CantidadDescuentosTotalDocumento: CantidadDescuentosTotalDocumento,
        CantidadLineas: CantidadLineas,
        ManejaLineaCredito: ManejaLineaCredito,
        ManejaCanalVenta: ManejaCanalVenta,
        CreacionNotaVentaUsuariosBloqueados: CreacionNotaVentaUsuariosBloqueados,
        CreacionNotaVentaUsuariosInactivos: CreacionNotaVentaUsuariosInactivos,
        PermiteModificacionCondicionVenta: PermiteModificacionCondicionVenta,
        AtributoSoftlandDescuentoCliente: AtributoSoftlandDescuentoCliente,
        PermiteCrearDireccion: PermiteCrearDireccion,
        CrearClienteConDV: CrearClienteConDV,
        MuestraUnidadMedidaProducto: MuestraUnidadMedidaProducto,
        DescuentoLineaDirectoSoftland: DescuentoLineaDirectoSoftland,
        DescuentoTotalDirectoSoftland: DescuentoTotalDirectoSoftland,
    }

    $.ajax({
        url: "GuardarParametro",
        data: { parametro: datosRequest },
        type: "POST",
        dataType: "json",
        async: false,
        success: function (response) {
            console.log(response);
            if (response.Verificador) {
                abrirInformacion("Guardar Parametro", response.Mensaje);
            }
            else {
                abrirError("Guardar Parametro", response.Mensaje);
            }
        },
        error: function (response) {
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}









function envioDatos() {
    var valor = $('input[name=gender]:checked', '#ff').val();
    $("#valorRadio").val(valor);

    document.getElementById("ff").submit();




    //alert($('input[name=gender]:checked', '#ff').val());
}