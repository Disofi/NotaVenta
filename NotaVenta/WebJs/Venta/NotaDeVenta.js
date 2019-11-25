var objetosEditable = {};
var caracterSeparadorMiles = ".";
var caracterDecimal = ",";
var parametros = {};




var precioProducto = 0;
var productos = [];
var productosAgregados = [];
var totales = {};
var descuentosAgregadosProducto = [];
var cantidadMaximaLineas = 0;
var PorcentajeAtributoDescuento = 0;



var FormEditable = function () {
    "use strict";
    return {
        //main function
        init: function () {
            handleEditableFormAjaxCall();
            handleEditableFieldConstruct();
        }
    };
}();

var handleEditableFieldConstruct = function () {
    $.fn.editable.defaults.mode = 'inline';
    $.fn.editable.defaults.inputclass = 'form-control input-sm';
    $.fn.editable.defaults.url = '/post';

    objetosEditable = {
        codigoRapido: new EditableClass(document, "txtIngresoCodigoRapido", TiposEditable.Texto, { textoVacio: '', desactivar: true }),
        cantidad: new EditableClass(document, "txtIngresoCantidad", TiposEditable.Texto, { textoVacio: 'Seleccione cantidad', desactivar: false }),
        stock: new EditableClass(document, "txtIngresoStock", TiposEditable.Texto, { textoVacio: '', desactivar: true }),
        unidadDeMedida: new EditableClass(document, "txtIngresoUnidadDeMedida", TiposEditable.Texto, { textoVacio: '', desactivar: true }),
        neto: new EditableClass(document, "txtIngresoNeto", TiposEditable.Texto, { textoVacio: 'Seleccione neto', desactivar: false }),
        descuento: new EditableClass(document, "txtIngresoDescuento", TiposEditable.Texto, { textoVacio: 'Seleccione descuento', desactivar: false }),
        subTotal: new EditableClass(document, "txtIngresoSubTotal", TiposEditable.Texto, { textoVacio: '', desactivar: true }),
        total: new EditableClass(document, "txtIngresoTotal", TiposEditable.Texto, { textoVacio: '', desactivar: true }),
        valorAtributoDescuento: new EditableClass(document, "txtIngresoDescuentoAtributo", TiposEditable.Texto, { textoVacio: '', desactivar: true }),
    };
    if (!parametros.EditaPrecioProducto) {
        objetosEditable.neto.desactivar();
    }
};

$(document).ready(function () {
    parametros = {
        /**/EditaPrecioProducto: ($("#EditaPrecioProducto").val().toLowerCase() === "true"),
        /**/MuestraCondicionVentaCliente: ($("#MuestraCondicionVentaCliente").val().toLowerCase() === "true"),
        /**/MuestraCondicionVentaTodos: ($("#MuestraCondicionVentaTodos").val().toLowerCase() === "true"),
        /**/EditaDescuentoProducto: ($("#EditaDescuentoProducto").val().toLowerCase() === "true"),
        /**/MaximoDescuentoProducto: parseFloat($("#MaximoDescuentoProducto").val()),
        /**/CantidadDescuentosProducto: parseInt($("#CantidadDescuentosProducto").val()),
        /**/MuestraStockProducto: ($("#MuestraStockProducto").val().toLowerCase() === "true"),
        /**/StockProductoEsMasivo: ($("#StockProductoEsMasivo").val().toLowerCase() === "true"),
        /**/StockProductoEsBodega: ($("#StockProductoEsBodega").val().toLowerCase() === "true"),
        /**/StockProductoCodigoBodega: $("#StockProductoCodigoBodega").val(),
        /**/ControlaStockProducto: ($("#ControlaStockProducto").val().toLowerCase() === "true"),
        /**/ManejaTallaColor: ($("#ManejaTallaColor").val().toLowerCase() === "true"),
        /**/ManejaDescuentoTotalDocumento: ($("#ManejaDescuentoTotalDocumento").val().toLowerCase() === "true"),
        /**/CantidadDescuentosTotalDocumento: parseInt($("#CantidadDescuentosTotalDocumento").val()),
        /**/ManejaLineaCreditoVendedor: ($("#ManejaLineaCreditoVendedor").val().toLowerCase() === "true"),
        /**/ManejaLineaCreditoAprobador: ($("#ManejaLineaCreditoAprobador").val().toLowerCase() === "true"),
        ManejaCanalVenta: ($("#ManejaCanalVenta").val().toLowerCase() === "true"),
        PermiteModificacionCondicionVenta: ($("#PermiteModificacionCondicionVenta").val().toLowerCase() === "true"),
        /**/AtributoSoftlandDescuentoCliente: $("#AtributoSoftlandDescuentoCliente").val(),
        /**/PermiteCrearDireccion: ($("#PermiteCrearDireccion").val().toLowerCase() === "true"),
        /**/MuestraUnidadMedidaProducto: ($("#MuestraUnidadMedidaProducto").val().toLowerCase() === "true"),
    };

    PorcentajeAtributoDescuento = parseFloat($("#PorcentajeAtributoDescuento").val());

    //console.log(parametros);

    precioProducto = 0;
    productos = [];
    productosAgregados = [];
    descuentosAgregadosProducto = [];
    cantidadMaximaLineas = 20;

    if (parametros.ManejaDescuentoTotalDocumento) {
        for (i = 1; i <= parametros.CantidadDescuentosTotalDocumento; i++) {
            $("#trDescuento" + i).fadeIn();
            $("#txtDescuentoTotal" + i).change(function () {
                CalcularProductosAgregados();
            });
        }
    }

    $("#btnAgregarDireccionDespacho").click(function () {
        $("#aModalAgregarDireccionDespacho").click();
    });
    $("#modalAgregarDireccionDespachoAgregar").click(function () {
        var codigoCliente = $("#modalAgregarDireccionDespachoCodigoCliente").html();
        var direccion = $("#modalAgregarDireccionDespachoDireccion").val();
        var codigoCiudad = $("#modalAgregarDireccionDespachoCiudad").val();
        var textoCiudad = $("#modalAgregarDireccionDespachoCiudad option:selected").text();
        var codigoComuna = $("#modalAgregarDireccionDespachoComuna").val();

        var data = {
            CodAxD: codigoCliente,
            DirDch: direccion.trim(),
            CiuDch: codigoCiudad.trim(),
            ComDch: codigoComuna.trim(),
            NomDch: textoCiudad.trim()
        };


        if (data.DirDch !== "" && data.CiuDch !== "" && data.DirDch !== "") {
            $.ajax({
                url: "AgregarDireccionDespacho",
                data: { direccion: data },
                type: "POST",
                dataType: "json",
                async: false,
                success: function (response) {
                    if (response.Verificador) {
                        abrirInformacion("Agregar Direccion Despacho", response.Mensaje);
                        $.ajax({
                            url: "BuscarDireccionDespacho",
                            data: { CodAux: data.CodAxD },
                            type: "POST",
                            dataType: "json",
                            async: true,
                            success: function (response) {
                                $("#cbxDireccion").find('option').remove().end();

                                $.each(response, function (index, item) {
                                    $("#cbxDireccion").append('<option value="' + item.NomDch + '">' + item.DirDch + " " + item.ComDch + '</option>');
                                });

                                $("#cbxDireccion").val(data.NomDch);

                                $("#modalAgregarDireccionDespachoCerrar").click();
                            },
                            error: function (response) {
                            },
                            failure: function (response) {
                                alert(response.responseText);
                            }
                        });
                    }
                    else {
                        abrirError("Agregar Direccion Despacho", response.Mensaje);
                    }
                },
                error: function (response) {
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        else {
            abrirError("Agregar Direccion Despacho", "Favor complete los campos requeridos");
        }
    });

    FormEditable.init();

    cbxlistaChange();
    crearControlDescuentos();
});
jQuery.moverColumna = function (table, from, to) {
    var rows = jQuery('tr', table);
    var cols;
    rows.each(function () {
        cols = jQuery(this).children('th, td');
        cols.eq(from).detach().insertBefore(cols.eq(to));
    });
}
var handleEditableFormAjaxCall = function () {
    $.mockjax({
        url: '/post',
        response: function (settings) {
            if (settings.data.name === "txtIngresoDescripcionCodigo") {
                var producto = productos.find(m => m.busqueda === settings.data.value);

                if (jQuery.grep(productosAgregados, function (value) { return value.Codigo === producto.CodProd; }).length > 0) {
                    this.status = 500;
                    this.statusText = "Producto ya fue ingresado";
                }
                else {
                    if (!parametros.EditaPrecioProducto) {
                        if (producto.PrecioVta === 0) {
                            this.status = 500;
                            this.statusText = "Producto no tiene precio asociado y este no se puede editar";
                            limpiarCamposLinea();
                            return;
                        }
                    }
                    if (parametros.ManejaTallaColor) {
                        var urlTC = $("#urlObtieneTallaColorProducto").val();

                        $.ajax({
                            url: urlTC,
                            data: { CodProd: producto.CodProd },
                            type: "POST",
                            dataType: "json",
                            async: false,
                            success: function (response) {
                                if (response.length === 0) {
                                    llenarCamposSeleccionProducto(producto);
                                }
                                else {
                                    verTallaColorDescripcion = settings.data.value;
                                    if (parametros.MuestraUnidadMedidaProducto) {
                                        verTallaColorMedida = producto.codumed;
                                    }
                                    else {
                                        verTallaColorMedida = "";
                                    }
                                    verTallaColorPrecioUnitario = producto.PrecioVta;
                                    verTallaColorDescuento = 0;
                                    verTallaColor(response);
                                }
                            },
                            error: function (response) {
                            },
                            failure: function (response) {
                                alert(response.responseText);
                            }
                        });
                    }
                    else {
                        llenarCamposSeleccionProducto(producto);
                    }
                }
            }
            if (settings.data.name === "txtIngresoCantidad") {
                if (/^([0-9])*$/.test(settings.data.value)) {
                    if (parseFloat(settings.data.value) > 0) {
                        if (parametros.ControlaStockProducto && parametros.MuestraStockProducto) {
                            var stock = parseFloat(objetosEditable.stock.getValor());
                            var cantidad = parseFloat(settings.data.value);

                            if (stock < cantidad) {
                                this.status = 500;
                                this.statusText = "cantidad no puede superar al stock del producto";
                                return;
                            }
                        }

                        CalcularFila(
                            objetosEditable.neto.getValor(),
                            settings.data.value,
                            descuentosAgregadosProducto,
                            PorcentajeAtributoDescuento
                        );
                    }
                    else {
                        this.status = 500;
                        this.statusText = "Debe ser mayor a 0";
                    }
                }
                else {
                    this.status = 500;
                    this.statusText = "Solo se admiten numeros";
                }
            }
            if (settings.data.name === "txtIngresoNeto") {
                if (/^([0-9])*$/.test(settings.data.value)) {
                    if (parseFloat(settings.data.value) > 0) {
                        CalcularFila(
                            settings.data.value,
                            objetosEditable.cantidad.getValor(),
                            descuentosAgregadosProducto,
                            PorcentajeAtributoDescuento
                        );
                    }
                    else {
                        this.status = 500;
                        this.statusText = "Debe ser mayor a 0";
                    }
                }
                else {
                    this.status = 500;
                    this.statusText = "Solo se admiten numeros";
                }
            }
            if (settings.data.name === "txtIngresoDescuento") {
                if (/^([0-9])*$/.test(settings.data.value)) {
                    if (parseFloat(settings.data.value) <= 100 && parseFloat(settings.data.value) >= 0) {
                        if (parametros.MaximoDescuentoProducto === 0 || parametros.MaximoDescuentoProducto >= parseFloat(settings.data.value)) {

                            descuentosAgregadosProducto = [];
                            descuentosAgregadosProducto.push({
                                Porcentaje: parseFloat(settings.data.value)
                            });
                            CalcularFila(
                                objetosEditable.neto.getValor(),
                                objetosEditable.cantidad.getValor(),
                                descuentosAgregadosProducto,
                                PorcentajeAtributoDescuento
                            );
                        }
                        else {
                            this.status = 500;
                            this.statusText = "Descuento no pueden superar el maximo permitido (" + parametros.MaximoDescuentoProducto + "%)";
                        }
                    }
                    else {
                        this.status = 500;
                        this.statusText = "El valor debe estar entre 0 y 100 (%)";
                    }
                }
                else {
                    this.status = 500;
                    this.statusText = "Solo se admiten numeros";
                }
            }
        }
    });
};

function llenarCamposSeleccionProducto(producto) {
    objetosEditable.codigoRapido.setValor(producto.CodProd);
    objetosEditable.neto.setValor(producto.PrecioVta);
    if (parametros.MuestraUnidadMedidaProducto) {
        objetosEditable.unidadDeMedida.setValor(producto.codumed);
    }
    else {
        objetosEditable.unidadDeMedida.setValor("");
    }
    if (parametros.MuestraStockProducto) {
        objetosEditable.stock.setValor(producto.Stock);
    }
    else {
        objetosEditable.stock.setValor(0);
    }

    CalcularFila(
        producto.PrecioVta,
        objetosEditable.cantidad.getValor(),
        descuentosAgregadosProducto,
        PorcentajeAtributoDescuento
    );
}

function crearControlDescuentos() {
    descuentosAgregadosProducto = [];
    if (!parametros.EditaDescuentoProducto) {
        objetosEditable.descuento.setValor("0");
        objetosEditable.descuento.desactivar();
    }
    else if (parametros.CantidadDescuentosProducto === 0) {
        objetosEditable.descuento.setValor("0");
        objetosEditable.descuento.desactivar();
    }
    else if (parametros.CantidadDescuentosProducto === 1) {
    }
    else {
        $('#txtIngresoDescuento').fadeOut();
        $('#txtIngresoDescuentoModal').fadeIn();
        $('#txtIngresoDescuentoModal').addClass("editable editable-click editable-empty");

        var descuentosAppend = "";
        descuentosAppend = descuentosAppend
            + '<div class="table-responsive">'
            + '<table id="table" class="table">'
            + '<thead></thead>'
            + '<tbody>';

        for (i = 1; i <= parametros.CantidadDescuentosProducto; i++) {
            descuentosAgregadosProducto.push({
                Porcentaje: 0
            });
            descuentosAppend = descuentosAppend
                + '<tr>'
                + '<td>'
                + 'Descuento N°' + i
                + '</td>'
                + '<td style="text-align: right">'
                + '<input id="descuento_' + i + '" type="text" value="0" class="form-control" />'
                + '</td>'
                + '</tr>';
        }
        descuentosAppend = descuentosAppend
            + '</tbody>'
            + '</table>';

        $("#modalDescuentosControles").html(descuentosAppend);

        $('#txtIngresoDescuentoModal').click(function () {
            $("#aModalDescuentos").click();
        });
        $('#modalDescuentosAgregarDescuentos').click(function () {
            var descuentosTemp = [];
            var hayErrorMaximoPermitido = false;
            var hayErrorMaximo = false;
            var hayErrorMinimo = false;

            for (i = 1; i <= parametros.CantidadDescuentosProducto; i++) {
                var descuento = $("#descuento_" + i).val();
                descuento = parseFloat(descuento);

                if (descuento > 100) {
                    abrirError("Error de descuentos", "Los descuentos no pueden superar el 100%");
                    return;
                }
                if (descuento < 0) {
                    abrirError("Error de descuentos", "Los descuentos no pueden ser inferior a 0%");
                    return;
                }
                if (parametros.MaximoDescuentoProducto > 0 && parametros.MaximoDescuentoProducto < descuento) {
                    abrirError("Error de descuentos", "Los descuentos no pueden superar el maximo permitido (" + parametros.MaximoDescuentoProducto + "%)");
                    return;
                }

                descuentosTemp.push({
                    Porcentaje: descuento
                });
            }

            descuentosAgregadosProducto = [];
            descuentosAgregadosProducto = descuentosTemp;

            CalcularFila(
                objetosEditable.neto.getValor(),
                objetosEditable.cantidad.getValor(),
                descuentosAgregadosProducto,
                PorcentajeAtributoDescuento
            );
            $("#modalDescuentosCerrar").click();
        });
    }
}

function cbxlistaChange() {
    var _url = $("#urlObtieneProductosPorListaPrecio").val();

    $.ajax({
        url: _url,
        data: { ListaPrecio: $("#cbxlista").val() },
        type: "POST",
        dataType: "json",
        async: false,
        success: function (response) {
            productos = response;

            productos = productos.map(function (x) {
                x.busqueda = x.CodProd + " - " + x.DesProd;
                return x
            });

            objetosEditable.descripcionCodigo = new EditableClass(document,
                "txtIngresoDescripcionCodigo",
                TiposEditable.Select2,
                {
                    textoVacio: "Busqueda de Producto",
                    fuenteDatos: productos.map(m => { return { id: m.busqueda, text: m.busqueda } }),
                    select2: {
                        width: '300',
                        placeholder: 'Seleccione Productos',
                        allowClear: true
                    }
                });
        },
        error: function (response) {
            //alert("Este Producto no se encuentra en esta lista de Precio");
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function valida(e) {
    tecla = (document.all) ? e.keyCode : e.which;

    //Tecla de retroceso para borrar, siempre la permite
    if (tecla == 8) {
        return true;
    }

    // Patron de entrada, en este caso solo acepta numeros
    patron = /[0-9]/;
    tecla_final = String.fromCharCode(tecla);
    return patron.test(tecla_final);
}

function eliminarFilas(filaDelete) {
    var subtotal = $('#lblSubTotal_' + filaDelete).text();

    fila = $('#generaTabla tr[id=id_' + filaDelete + ']');

    productosAgregados = jQuery.grep(productosAgregados, function (value) {
        return value.contador !== filaDelete;
    });

    CalcularProductosAgregados();

    fila.remove();
}

function CalcularFila(precioUnitario, cantidad, descuentos, porcentajeAtributoDescuento) {
    if (precioUnitario === undefined || precioUnitario === null || precioUnitario === "") { precioUnitario = 0; }
    if (cantidad === undefined || cantidad === null || cantidad === "") { cantidad = 0; }
    if (descuentos === undefined || descuentos === null || descuentos === "") { descuentos = []; }
    if (porcentajeAtributoDescuento === undefined || porcentajeAtributoDescuento === null || porcentajeAtributoDescuento === "") { porcentajeAtributoDescuento = 0; }

    precioUnitario = parseInt(precioUnitario);
    cantidad = parseInt(cantidad);

    var url = $("#urlCalcularFila").val();

    var dataPost = { precioUnitario: precioUnitario, cantidad: cantidad, descuentos: descuentos, porcentajeAtributoDescuento: porcentajeAtributoDescuento };

    $.ajax({
        url: url,
        type: "POST",
        data: dataPost,
        success: function (result) {
            var subTotal = result.SubTotal;
            var total = result.Total;
            descuentosAgregadosProducto = result.Descuentos;
            var valorDescuentoAtributo = result.ValorDescuentoAtributo;

            $("#hfSubTotalConDescuento").val(result.SubTotalConDescuento);
            $("#hfPrecioUnitarioConDescuento").val(result.PrecioUnitarioConDescuento);

            objetosEditable.valorAtributoDescuento.setValor(parseInt(valorDescuentoAtributo));
            objetosEditable.subTotal.setValor(parseInt(subTotal));
            objetosEditable.total.setValor(parseInt(total));
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
        async: false
    });
}


function CalcularProductosAgregados() {
    if (productosAgregados.length > 0) {
        var url = $("#urlCalcularProductosAgregados").val();
        var dataPost = productosAgregados;
        var descuentos = obtieneDescuentosTotales();
        var porcentajeAtributoDescuento = PorcentajeAtributoDescuento;

        $.ajax({
            url: url,
            type: "POST",
            data: { productos: dataPost, descuentos: descuentos, porcentajeAtributoDescuento: porcentajeAtributoDescuento },
            success: function (result) {
                var impuesto = result.Impuesto;
                descuentos = result.descuentos;
                var total = result.Total;

                totales.subTotal = result.SubTotal;
                totales.subTotalConDescuento = result.SubTotalConDescuento;
                totales.impuesto = impuesto;
                totales.total = total;
                totales.descuentos = descuentos;

                $('#lbtotal').text(agregarSeparadorMiles(result.SubTotalConDescuento, caracterSeparadorMiles, caracterDecimal));
                $('#lbimpuesto').text(agregarSeparadorMiles(impuesto, caracterSeparadorMiles, caracterDecimal));
                $('#lbtotalfinal').text(agregarSeparadorMiles(total, caracterSeparadorMiles, caracterDecimal));
            },
            error: function (a, b, c) {
                console.log(a, b, c);
            },
            async: false
        });
    }
    else {
        $('#lbtotal').text(0);
        $('#lbimpuesto').text(0);
        $('#lbtotalfinal').text(0);
    }
}

function obtieneDescuentosTotales() {
    var descuentos = [];
    if (parametros.ManejaDescuentoTotalDocumento) {
        for (i = 1; i <= parametros.CantidadDescuentosTotalDocumento; i++) {
            descuentos.push({
                Porcentaje: parseInt($("#txtDescuentoTotal" + i).val())
            });
        }
    }

    return descuentos;
}

function addRow() {
    var validador = 0;

    var codigo = objetosEditable.codigoRapido.getValor();
    var descripcion = objetosEditable.descripcionCodigo.getValor();
    var cantidad = objetosEditable.cantidad.getValor();
    var stock = objetosEditable.stock.getValor();
    var medida = objetosEditable.unidadDeMedida.getValor();
    var preciounitario = objetosEditable.neto.getValor();
    var precioUnitarioConDescuento = $("#hfPrecioUnitarioConDescuento").val();
    var porcentajeAtributoDescuento = objetosEditable.valorAtributoDescuento.getValor();
    var subTotal = objetosEditable.subTotal.getValor();
    var subTotalConDescuento = $("#hfSubTotalConDescuento").val();
    var descuento = descuentosAgregadosProducto;
    var total = objetosEditable.total.getValor();
    var talla = verTallaColorTalla;
    var color = verTallaColorColor;

    if (talla === null || talla === undefined || talla === "") {
        talla = "";
    }
    if (color === null || color === undefined || color === "") {
        color = "";
    }

    if (codigo === null || codigo === undefined || codigo === "" ||
        cantidad === null || cantidad === undefined || cantidad === "" || ("" + cantidad) === "0" ||
        preciounitario === null || preciounitario === undefined || preciounitario === "" || ("" + preciounitario) === "0" ||
        descuento === null || descuento === undefined || descuento === "" || ("" + descuento) === "0") {

        abrirError("Error datos producto", "Favor, complete todos los campos necesarios para agregar producto");
    }
    else {
        var contador = 0;
        for (i = 0; i < $("#generaTabla tr").length; i++) {
            item = $("#generaTabla tr")[i];
            contador = parseInt(item.id.substring(3, 90)) >= contador ? parseInt(item.id.substring(3, 90)) + 1 : contador;
        }

        var texto_insertar =
            '<tr id="id_' + contador + '" class="thproductolist' + contador + '">'
            + '<td><span id="lblCodigo_' + contador + '">' + codigo + '</td>'
            + '<td><span id="lblDescripcion_' + contador + '">' + descripcion + '</td>'
            + '<td style="' + (parametros.ManejaTallaColor ? '' : 'display: none') + '"><span id="lblTalla_' + contador + '">' + talla + '</td>'
            + '<td style="' + (parametros.ManejaTallaColor ? '' : 'display: none') + '"><span id="lblColor_' + contador + '">' + color + '</td>'
            + '<td style="text-align: right"><span id="lblCantidad_' + contador + '">' + agregarSeparadorMiles(cantidad, caracterSeparadorMiles, caracterDecimal) + '</td>'
            + '<td style="' + (parametros.MuestraUnidadMedidaProducto ? '' : 'display: none') + '"><span id="lblMedida_' + contador + '">' + medida + '</td>'
            + '<td style="text-align: right"><span id="lblPrecioUnitario_' + contador + '">' + agregarSeparadorMiles(preciounitario, caracterSeparadorMiles, caracterDecimal) + '</td>'
            + '<td style="text-align: right"><span id="lblSubTotal_' + contador + '">' + agregarSeparadorMiles(subTotal, caracterSeparadorMiles, caracterDecimal) + '</td>'
            + '<td style="' + (PorcentajeAtributoDescuento > 0 ? '' : 'display: none') + '"><span id="lblAtributoDescuento_' + contador + '">' + agregarSeparadorMiles(porcentajeAtributoDescuento, caracterSeparadorMiles, caracterDecimal) + '</td>'
            + (descuento.length === 0 ? '<td style="text-align: right"><span id="lblDescuento_' + contador + '">0</td>' :
                descuento.length === 1 ?
                    '<td style="text-align: right"><span id="lblDescuento_' + contador + '">' + agregarSeparadorMiles(descuento[0].Porcentaje, caracterSeparadorMiles, caracterDecimal) + '%' + '</td>' :
                    '<td><a class="editable editable-click editable-empty" id="verDescuentos_' + contador + '" onclick="verDescuentos(' + contador + ')">Ver Descuentos</a></td>')
            + '<td style="text-align: right"><span id="lblTotal_' + contador + '">' + agregarSeparadorMiles(total, caracterSeparadorMiles, caracterDecimal) + '</td>'
            + '<td><a id="thproductolist' + contador + '" href="#divCodigo" onclick="eliminarFilas(' + contador + ');"><img src="../Content/Image/delete.png" /></a></td>'
            + '</tr>';

        var nuevo_campo = $(texto_insertar);
        $("#generaTabla").append(nuevo_campo);

        limpiarCamposLinea();

        var productoAgregado = {
            Codigo: codigo,
            Talla: talla,
            Color: color,
            contador: contador,
            PrecioUnitario: preciounitario,
            PrecioUnitarioConDescuento: precioUnitarioConDescuento,
            Cantidad: cantidad,
            Stock: stock,
            UnidadMedida: medida,
            Descuentos: descuento,
            DescuentoAtributo: PorcentajeAtributoDescuento,
            SubTotal: subTotal,
            SubTotalConDescuento: subTotalConDescuento,
            Total: total
        };

        productosAgregados.push(productoAgregado);

        CalcularProductosAgregados();
    }
}

function limpiarCamposLinea() {
    objetosEditable.codigoRapido.setValor("");
    objetosEditable.descripcionCodigo.setValor("");
    objetosEditable.cantidad.setValor("1");
    objetosEditable.stock.setValor("0");
    objetosEditable.unidadDeMedida.setValor("");
    objetosEditable.neto.setValor("0");
    objetosEditable.subTotal.setValor("0");
    objetosEditable.total.setValor("0");
    objetosEditable.valorAtributoDescuento.setValor("0");
    crearControlDescuentos();
    verTallaColorTalla = "";
    verTallaColorColor = "";
}

function verDescuentos(contador) {
    var descuentosAppend = "";
    descuentosAppend = descuentosAppend
        + '<div class="table-responsive" >'
        + '<table id="table" class="table">'
        + '<thead></thead>'
        + '<tbody>';

    var producto = jQuery.grep(productosAgregados, function (value) {
        return value.contador === contador;
    })[0];

    for (i = 0; i < producto.Descuentos.length; i++) {
        descuentosAppend = descuentosAppend
            + '<tr>'
            + '<td>'
            + 'Descuento N°' + (i + 1)
            + '</td>'
            + '<td style="text-align: right">'
            + producto.Descuentos[i].Porcentaje + '%'
            + '</td>'
            + '</tr>';
    }
    descuentosAppend = descuentosAppend
        + '</tbody>'
        + '</table>';

    $("#modalDescuentosRealizadosControles").html(descuentosAppend);

    $("#aModalDescuentosRealizados").click();
}

var verTallaColorDescripcion = "";
var verTallaColorMedida = "";
var verTallaColorTalla = "";
var verTallaColorColor = "";
var verTallaColorPrecioUnitario = 0;
var verTallaColorDescuento = 0;

function verTallaColor(datos) {
    var bodegas = [];
    if (parametros.StockProductoEsBodega) {
        bodegas.push(parametros.StockProductoCodigoBodega);
    }
    if (parametros.StockProductoEsMasivo) {
        for (i = 0; i < datos.length; i++) {
            if (bodegas.find(m => m === datos[i].CodigoBodega) === undefined) {
                bodegas.push(datos[i].CodigoBodega);
            }
        }
    }
    $("#modalTallaColorBodegas").find('option').remove().end();

    for (i = 0; i < bodegas.length; i++) {
        $("#modalTallaColorBodegas").append('<option value="' + bodegas[i] + '">' + bodegas[i] + '</option>');
    }
    if (parametros.MuestraStockProducto) {
        $("#modalTallaColorBodegas").fadeIn();
    }
    $("#modalTallaColorBodegas").change(function () {
        var bodegaNombre = $("#modalTallaColorBodegas").val();
        var indexBodega = 0;
        $("#modalTallaColorControlesTable thead > tr > th").each(function (index) {
            if ($(this).text() === bodegaNombre) {
                indexBodega = index - 2;
                jQuery.moverColumna("#modalTallaColorControlesTable", indexBodega, 4);
            }
        });
    });

    var tallaColorAppend = "";
    tallaColorAppend = tallaColorAppend
        + '<div class="table-responsive" >'
        + '<table id="modalTallaColorControlesTable" class="table">'
        + '<thead>'
        + '<tr>'
        + '<th colspan="4">Informacion Producto</th>'
        + (parametros.MuestraStockProducto ? '<th colspan="' + bodegas.length + '">Bodegas</th>' : '')
        + '</tr>'
        + '<tr>'
        + '<th>Codigo Producto</th>'
        + '<th>Talla</th>'
        + '<th>Color</th>'
        + '<th>Cantidad</th>';
    if (parametros.MuestraStockProducto) {
        for (y = 0; y < bodegas.length; y++) {
            tallaColorAppend = tallaColorAppend
                + '<th>' + bodegas[y] + '</th>';
        }
    }

    tallaColorAppend = tallaColorAppend
        + '</tr>'
        + '</thead>'
        + '<tbody>';

    var productoTallaColor = [];
    for (i = 0; i < datos.length; i++) {
        if (productoTallaColor.find(m =>
            m.CodigoProducto === datos[i].CodigoProducto &&
            m.Talla === datos[i].Talla &&
            m.Color === datos[i].Color) === undefined) {
            productoTallaColor.push(datos[i]);
        }
    }

    for (i = 0; i < productoTallaColor.length; i++) {
        tallaColorAppend = tallaColorAppend
            + '<tr>'
            + '<td>' + productoTallaColor[i].CodigoProducto + '</td>'
            + '<td>' + productoTallaColor[i].Talla + '</td>'
            + '<td>' + productoTallaColor[i].Color + '</td>'
            + '<td><input type="number" value="0" class="form-control" /></td>';

        if (parametros.MuestraStockProducto) {
            for (y = 0; y < bodegas.length; y++) {
                var valorBodega = datos.find(m =>
                    m.CodigoProducto === productoTallaColor[i].CodigoProducto &&
                    m.Talla === productoTallaColor[i].Talla &&
                    m.Color === productoTallaColor[i].Color &&
                    m.CodigoBodega === bodegas[y]);
                try {
                    tallaColorAppend = tallaColorAppend
                        + '<td>' + valorBodega.CantidadBodega + '</td>';
                } catch (e) {
                    tallaColorAppend = tallaColorAppend
                        + '<td>0</td>';
                }
            }
        }

        tallaColorAppend = tallaColorAppend
            + '<td></td>'
            + '</tr>';
    }
    tallaColorAppend = tallaColorAppend
        + '</tbody>'
        + '</table>';

    $("#modalTallaColorControles").html(tallaColorAppend);
    $("#modalTallaColorAgregarTallaColor").click(function () {
        var valores = [];

        var filas = $('#modalTallaColorControlesTable tbody tr');
        for (i = 0; i < filas.length; i++) {
            var valorCodigoProducto = $($(filas[i]).children("td")[0]).html();
            var valorTalla = $($(filas[i]).children("td")[1]).html();
            var valorColor = $($(filas[i]).children("td")[2]).html();
            var valorCantidad = $($(filas[i]).children("td")[3]).children("input").val();
            var valorStock = 0;

            if (parametros.MuestraStockProducto) {
                valorStock = $($(filas[i]).children("td")[4]).html();
            }

            if (parseFloat(valorCantidad) > 0) {
                valores.push({
                    codigoProducto: valorCodigoProducto,
                    talla: valorTalla,
                    color: valorColor,
                    stock: parseFloat(valorStock),
                    cantidad: parseFloat(valorCantidad)
                });
            }
        }

        if (parametros.ControlaStockProducto) {
            for (i = 0; i < valores.length; i++) {
                if (valores[i].stock < valores[i].cantidad) {
                    abrirError("Error Cantidad VS Stock", "cantidad no puede superar al stock del producto (Producto: " +
                        valores[i].codigoProducto +
                        ", Talla: " +
                        valores[i].talla +
                        ", Color: " +
                        valores[i].color +
                        ")");
                    return;
                }
            }
        }

        for (z = 0; z < valores.length; z++) {
            objetosEditable.codigoRapido.setValor(valores[z].codigoProducto);
            objetosEditable.descripcionCodigo.setValor(verTallaColorDescripcion);
            objetosEditable.cantidad.setValor(valores[z].cantidad);
            if (parametros.MuestraUnidadMedidaProducto) {
                objetosEditable.unidadDeMedida.setValor(verTallaColorMedida);
            }
            else {
                objetosEditable.unidadDeMedida.setValor("");
            }
            objetosEditable.neto.setValor(verTallaColorPrecioUnitario);

            verTallaColorTalla = valores[z].talla;
            verTallaColorColor = valores[z].color;
            descuentosAgregadosProducto = [{ Porcentaje: verTallaColorDescuento }];

            CalcularFila(
                objetosEditable.neto.getValor(),
                objetosEditable.cantidad.getValor(),
                descuentosAgregadosProducto,
                PorcentajeAtributoDescuento
            );

            addRow();
        }

        $("#modalTallaColorCerrar").click();
    });

    $("#aModalTallaColor").click();
    $("#modalTallaColor").on("hidden.bs.modal", function () {
        limpiarCamposLinea();
    });
}

function agregarnotadeventa() {
    var urlAgregarNotaVenta = $("#urlAgregarNotaVenta").val();
    var urlAgregarNotaVentaDetalle = $("#urlDetalleNotaVenta").val();

    var NVNumero = $('#txtnventa').val();
    var nvFem = $('#txtfechapedido').val();
    var nvFeEnt = $('#txtfechaentrega').val();
    var CodAux = $('#txtcliente').val();
    var CodLista = $('#cbxlista').val();
    var nvObser = $('#txtobservacion').val();
    var CveCod = $('#cbxconven').val();
    var CodiCC = $('#cbxccosto').val();
    var nvSubTotal = $('#txttotal').val();
    var nvMonto = $('#txttotalfinal').val();
    var nvNetoAfecto = $('#txttotal').val();

    var FechaHoraCreacion = $('#txtfechapedido').val();
    var TotalBoleta = $('#txttotalfinal').val();
    var id = $('#txtid').val();
    var canalVenta = $("#ddlCanalVenta").val();
    var CodLugarDesp = '';
    if (validespa == 'No Tiene Dirección Asociado') {
    }
    else {
        CodLugarDesp = $('#cbxDireccion').val();
    }

    var contacto = $('#txtcontacto').val();

    var cabecera = {
        Descuentos: totales.descuentos,
        NVNumero: NVNumero,
        nvFem: nvFem,
        //nvEstado: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstFact: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstDesp: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstRese: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstConc: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CotNum: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        NumOC: 0,
        nvFeEnt: nvFeEnt,
        CodAux: CodAux,
        //VenCod: aaaaaaaaaaaaaaaaaaa,
        //CodMon: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        CodLista: CodLista,
        nvObser: nvObser,
        nvCanalNV: canalVenta,
        CveCod: CveCod,
        NomCon: contacto,
        CodiCC: CodiCC,
        //CodBode: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        nvSubTotal: totales.subTotal,
        nvSubTotalConDescuento: totales.subTotalConDescuento,
        //nvPorcDesc01: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvDescto01: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcDesc02: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvDescto02: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcDesc03: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvDescto03: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcDesc04: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvDescto04: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcDesc05: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvDescto05: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        nvMonto: totales.subTotal,
        //nvFeAprob: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //NumGuiaRes: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcFlete: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvValflete: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcEmb: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvValEmb: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEquiv: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvNetoExento: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        nvNetoAfecto: totales.total,
        //nvTotalDesc: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //ConcAuto: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        CodLugarDesp: CodLugarDesp,
        //SolicitadoPor: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //DespachadoPor: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Patente: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //RetiradoPor: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CheckeoPorAlarmaVtas: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //EnMantencion: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Usuario: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //UsuarioGeneraDocto: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        FechaHoraCreacion: FechaHoraCreacion,
        //Sistema: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //ConcManual: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //RutSolicitante: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //proceso: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        TotalBoleta: totales.total,
        //NumReq: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CodVenWeb: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CodBodeWms: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CodLugarDocto: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //RutTransportista: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Cod_Distrib: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Nom_Distrib: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //MarcaWG: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
    };
    var productos = productosAgregados;

    var dataNotaVenta = {
        cabecera: cabecera,
        productos: productos
    }

    activarLoadingBoton("btnCot");

    $.ajax({
        url: urlAgregarNotaVenta,
        type: "POST",
        data: dataNotaVenta,
        success: function (result) {
            if (result.EstadoNP === "P") {
                $("#divAlertaOkGeneracionNVPendiente").fadeIn();
            }
            else {
                $("#divAlertaOkGeneracionNVPendiente").fadeOut();
            }
            var tblFinal = $("#tblResultadoAgregarNV tbody");
            for (i = 0; i < result.length; i++) {
                var idInterno = result[i].IdNotaVenta;
                var idSoftland = result[i].NVNumero;

                if (idInterno <= 0) {
                    idInterno = "Sin registros";
                }
                if (idSoftland <= 0) {
                    idSoftland = "Sin registros";
                }

                var fila = "<tr><td>" + idInterno + "</td><td>" + idSoftland + "</td></tr>";

                tblFinal.append(fila);
            }

            $("#divFormulacioCompletoIngresoDatos").fadeOut();
            $("#divAlertaOkGeneracionNV").fadeIn();
            desactivarLoadingBoton("btnCot");
        },
        error: function (a, b, c) {
            console.log(a, b, c);
            desactivarLoadingBoton("btnCot");
        },
        async: false
    });

    return;





    var max = $('#contador_registros').val();
    var detalleexi = 0;
    for (var i = 1; i <= max; i++) {
        if ($('#thcodigo' + i).length) {
            detalleexi = 1;
        }
    }
    var validespa = $('#cbxDireccion').val();
    //var valiconta = $('#txtcontacto0').val();

    if (detalleexi == '0') {
        alert("Debe Agregar productos para insertar una Nota de de venta Interna");
    }
    else {
        var max = $('#contador_registros').val();
        var nvlineas = 0;
        for (var i = 1; i <= max; i++) {

            if ($('#thcodigo' + i).length) {
                nvlineas = nvlineas + 1;
                var CodProd = $('#thcodigo' + i).val();
                var DetProd = $('#thdescripcion' + i).val();
                var nvCant = $('#thcantidad' + i).val();
                var CodUMed = 'UN';

                var nvPrecio = $('#thpreciounitario' + i).val();
                var nvSubTotal = $('#thsubtotal' + i).val();
                var nvTotLinea = $('#thvalordescuento' + i).val();
                var NVNumero = $('#txtnventa').val();
                var nvLinea = nvlineas;
                var nvFecCompr = $('#txtfechapedido').val();

                var url = $("#urlDetalleNotaVenta").val();
                var data = {
                    CodProd: CodProd,
                    DetProd: DetProd,
                    nvCant: nvCant,
                    CodUMed: CodUMed,
                    nvPrecio: nvPrecio,
                    CodLista: CodLista,
                    nvSubTotal: nvSubTotal,
                    nvTotLinea: nvSubTotal,
                    NVNumero: NVNumero,
                    nvLinea: nvLinea,
                    nvFecCompr: nvFecCompr
                };
                // $.post(url, data);
                $.ajax({
                    type: 'post',
                    url: url,
                    dataType: 'json',
                    data: data,
                    async: false
                });
            }
        }


        var NomCon2;
        var vcontactos = $('#txtVcontacto').val();
        if (vcontactos == '1') {
            var CodAux2 = $('#txtcliente').val();
            var NomCon = $('#txtcontacto1').val();
            NomCon2 = NomCon;
        }
        else {
            var CodAux2 = $('#txtcliente').val();
            var NomCon = $('#txtcontacto0').val();
            NomCon2 = NomCon;
            var url = $("#urlAgregarContacto").val();
            var data = {
                CodAux: CodAux2,
                NomCon: NomCon
            };

            $.post(url, data)

        }

        var NVNumero = $('#txtnventa').val();
        var nvFem = $('#txtfechapedido').val();
        var nvFeEnt = $('#txtfechaentrega').val();
        var CodAux = $('#txtcliente').val();
        var CodLista = $('#cbxlista').val();
        var nvObser = $('#txtobservacion').val();
        var CveCod = $('#cbxconven').val();
        var CodiCC = $('#cbxccosto').val();
        var nvSubTotal = $('#txttotal').val();
        var nvMonto = $('#txttotalfinal').val();
        var nvNetoAfecto = $('#txttotal').val();

        var FechaHoraCreacion = $('#txtfechapedido').val();
        var TotalBoleta = $('#txttotalfinal').val();
        var id = $('#txtid').val();
        var CodLugarDesp = '';
        if (validespa == 'No Tiene Dirección Asociado') {
        }
        else {
            CodLugarDesp = $('#cbxDireccion').val();
        }

        var CorreoCliente = $("#txtCorreoCliente").val();

        var url = $("#urlAgregarNotaVenta").val();

        var data = {
            NVNumero: NVNumero,
            nvFem: nvFem,
            nvFeEnt: nvFeEnt,
            CodAux: CodAux,
            //VenCod: VenCod,
            CodLista: CodLista,
            nvObser: nvObser,
            CveCod: CveCod,
            NomCon: NomCon,
            CodiCC: CodiCC,
            nvSubTotal: nvSubTotal,
            nvMonto: nvMonto,
            nvNetoAfecto: nvNetoAfecto,
            Usuario: Usuario,
            UsuarioGeneraDocto: UsuarioGeneraDocto,
            FechaHoraCreacion: FechaHoraCreacion,
            TotalBoleta: TotalBoleta,
            id: id,
            CodLugarDesp: CodLugarDesp
        };

        //console.log(data);
        //if (CorreoCliente == "" || CorreoCliente == null) {
        //    alert("Cliente no tiene Correo Asignado");
        //    var url = $("#NV").val(); location.href = url;
        //}
        //else {
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            success: function (result) {
                confirm("Se Genero Cotizacion" + " " + NVNumero);
                var url1 = $("#RedirectTo").val();
                location.href = url1;
            },
            error: function (a, b, c) {
                console.log(a, b, c);
            },
            async: false
        });
    }
}
//}

function ObtenerSaldo(RutAux, CodAux) {
    $("#tblSaldos").html("");
    $.ajax({
        type: "POST",
        url: "ObtenerSaldo",
        data: { RutAuxiliar: RutAux, CodAux: CodAux },
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

                htmlCabecera = htmlCabecera + "<th>Codigo Area</th>";
                htmlCabecera = htmlCabecera + "<th>Desc Cuenta</th>";
                htmlCabecera = htmlCabecera + "<th>Codigo Aux</th>";
                htmlCabecera = htmlCabecera + "<th>Nombre</th>";
                htmlCabecera = htmlCabecera + "<th>Tipo Doc</th>";
                htmlCabecera = htmlCabecera + "<th>Numero Doc</th>";
                htmlCabecera = htmlCabecera + "<th>Fecha Emision</th>";
                htmlCabecera = htmlCabecera + "<th>Fecha Vencimiento</th>";
                htmlCabecera = htmlCabecera + "<th>Tipo Doc Ref</th>";
                htmlCabecera = htmlCabecera + "<th>Numero Doc Ref</th>";
                htmlCabecera = htmlCabecera + "<th>Debe</th>";
                htmlCabecera = htmlCabecera + "<th>Haber</th>";
                htmlCabecera = htmlCabecera + "<th>Saldo</th>";
                htmlCabecera = htmlCabecera + "<th>Glosa</th>";
                htmlCabecera = htmlCabecera + "<th>Dias Vencido</th>";


                tblSaldos.append(htmlCabecera);

                $.each(response.DetalleSaldo, function (index, value) {
                    htmlDetalle = "";
                    htmlDetalle = htmlDetalle + "<tr>";

                    htmlDetalle = htmlDetalle + "<td>" + value.areacod + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.pcdesc + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.codaux + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.nomaux + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.ttdcod + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.numdoc + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.fechaemiString + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movfvString + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movtipdocref + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movnumdocref + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movdebe + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movhaber + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.Saldo + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.movglosa + "</td>";
                    htmlDetalle = htmlDetalle + "<td>" + value.DiasVen + "</td>";

                    htmlDetalle = htmlDetalle + "</tr>";

                    tblSaldos.append(htmlDetalle);
                });
            }
        }
    });
}