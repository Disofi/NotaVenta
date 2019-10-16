﻿var precioProducto = 0;
var productos = [];
var productosAgregados = [];
var descuentosAgregadosProducto = [];
var cantidadDescuentosProducto = 0;
var cantidadDescuentosTotal = 0;
var BodegaPorDefecto = "";
var validaCantidadVSStock = true;
var cantidadMaximaLineas = 0;

$(document).ready(function () {
    precioProducto = 0;
    productos = [];
    productosAgregados = [];
    descuentosAgregadosProducto = [];
    cantidadDescuentosProducto = 5;
    cantidadDescuentosTotal = 2;
    BodegaPorDefecto = "C01";
    validaCantidadVSStock = false;
    cantidadMaximaLineas = 20;

    for (i = 1; i <= cantidadDescuentosTotal; i++) {
        $("#trDescuento" + i).fadeIn();
        $("#txtDescuentoTotal" + i).change(function () {
            CalcularProductosAgregados();
        });
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
                    var urlTC = $("#urlObtieneTallaColorProducto").val();

                    $.ajax({
                        url: urlTC,
                        data: { CodProd: producto.CodProd },
                        type: "POST",
                        dataType: "json",
                        async: false,
                        success: function (response) {
                            console.log(response);
                            if (response.length === 0) {
                                $('#txtIngresoCodigoRapido').editable('setValue', producto.CodProd);
                                $('#txtIngresoNeto').editable('setValue', producto.PrecioVta);
                                $('#txtIngresoUnidadDeMedida').editable('setValue', producto.codumed);
                                $('#txtIngresoStock').editable('setValue', producto.Stock);

                                CalcularFila(
                                    producto.PrecioVta,
                                    $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                                    descuentosAgregadosProducto
                                );
                            }
                            else {
                                verTallaColorDescripcion = settings.data.value;
                                verTallaColorMedida = producto.codumed;
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
            }
            if (settings.data.name === "txtIngresoCantidad") {
                if (/^([0-9])*$/.test(settings.data.value)) {
                    if (parseFloat(settings.data.value) > 0) {
                        if (validaCantidadVSStock) {
                            var stock = parseFloat($('#txtIngresoStock').editable('getValue').txtIngresoStock);
                            var cantidad = parseFloat(settings.data.value);

                            if (stock < cantidad) {
                                this.status = 500;
                                this.statusText = "cantidad no puede superar al stock del producto";
                                return;
                            }
                        }

                        CalcularFila(
                            $('#txtIngresoNeto').editable('getValue').txtIngresoNeto,
                            settings.data.value,
                            descuentosAgregadosProducto
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
                            $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                            descuentosAgregadosProducto
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
                        descuentosAgregadosProducto = [];
                        descuentosAgregadosProducto.push(parseFloat(settings.data.value));
                        CalcularFila(
                            $('#txtIngresoNeto').editable('getValue').txtIngresoNeto,
                            $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                            descuentosAgregadosProducto
                        );
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

var handleEditableFieldConstruct = function () {
    $.fn.editable.defaults.mode = 'inline';
    $.fn.editable.defaults.inputclass = 'form-control input-sm';
    $.fn.editable.defaults.url = '/post';

    $('#txtIngresoCodigoRapido').editable({
        emptytext: '',
    });

    $('#txtIngresoCantidad').editable({
        emptytext: 'Seleccione cantidad',
    });

    $('#txtIngresoStock').editable({
        emptytext: '',
    });
    $('#txtIngresoStock').editable('toggleDisabled');

    $('#txtIngresoUnidadDeMedida').editable({
        emptytext: ''
    });
    $('#txtIngresoUnidadDeMedida').editable('toggleDisabled');

    $('#txtIngresoNeto').editable({
        emptytext: 'Seleccione neto',
    });

    $('#txtIngresoSubTotal').editable();
    $('#txtIngresoSubTotal').editable('toggleDisabled');

    crearControlDescuentos();

    $('#txtIngresoTotal').editable();
    $('#txtIngresoTotal').editable('toggleDisabled');
};

function crearControlDescuentos() {
    descuentosAgregadosProducto = [];
    if (cantidadDescuentosProducto === 0) {
        $('#txtIngresoDescuento').editable({
            emptytext: 'Seleccione descuento',
        });
        $('#txtIngresoDescuento').editable('toggleDisabled');
    }
    else if (cantidadDescuentosProducto === 1) {
        $('#txtIngresoDescuento').editable({
            emptytext: 'Seleccione descuento',
        });
    }
    else {
        $('#txtIngresoDescuento').html("Seleccione descuento");
        $('#txtIngresoDescuento').addClass("editable editable-click editable-empty");

        var descuentosAppend = "";
        descuentosAppend = descuentosAppend
            + '<div class="table-responsive">'
            + '<table id="table" class="table">'
            + '<thead></thead>'
            + '<tbody>';

        for (i = 1; i <= cantidadDescuentosProducto; i++) {
            descuentosAgregadosProducto.push(0);
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

        $('#txtIngresoDescuento').click(function () {
            $("#aModalDescuentos").click();
        });
        $('#modalDescuentosAgregarDescuentos').click(function () {
            var descuentosTemp = [];
            var hayErrorMaximo = false;
            var hayErrorMinimo = false;

            for (i = 1; i <= cantidadDescuentosProducto; i++) {
                var descuento = $("#descuento_" + i).val();
                descuento = parseFloat(descuento);

                if (descuento > 100) { hayErrorMaximo = true; $("#descuento_" + i).val(descuentosAgregadosProducto[i - 1]); }
                if (descuento < 0) { hayErrorMinimo = true; $("#descuento_" + i).val(descuentosAgregadosProducto[i - 1]); }

                descuentosTemp.push(descuento);
            }
            if (!hayErrorMaximo) {
                if (!hayErrorMinimo) {
                    descuentosAgregadosProducto = [];
                    descuentosAgregadosProducto = descuentosTemp;

                    CalcularFila(
                        $('#txtIngresoNeto').editable('getValue').txtIngresoNeto,
                        $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                        descuentosAgregadosProducto
                    );
                    $("#modalDescuentosCerrar").click();
                }
                else {
                    abrirError("Error de descuentos", "Los descuentos no pueden ser inferior a 0%");
                }
            }
            else {
                abrirError("Error de descuentos", "Los descuentos no pueden superar el 100%");
            }
        });
    }
}

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

            $('#txtIngresoDescripcionCodigo').editable({
                emptytext: 'Busqueda de Producto',
                source: productos.map(m => { return { id: m.busqueda, text: m.busqueda } }),
                select2: {
                    width: 200,
                    placeholder: 'Seleccione Productos',
                    allowClear: true
                }
            });
        },
        error: function (response) {
            alert("Este Producto no se encuentra en esta lista de Precio");
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

function CalcularFila(precioUnitario, cantidad, descuentos) {
    if (precioUnitario === undefined || precioUnitario === null || precioUnitario === "") { precioUnitario = 0; }
    if (cantidad === undefined || cantidad === null || cantidad === "") { cantidad = 0; }

    if (descuentos === undefined || descuentos === null || descuentos === "") { descuentos = []; }

    precioUnitario = parseInt(precioUnitario);
    cantidad = parseInt(cantidad);

    var url = $("#urlCalcularFila").val();

    var dataPost = { precioUnitario: precioUnitario, cantidad: cantidad, descuentos: descuentos };

    $.ajax({
        url: url,
        type: "POST",
        data: dataPost,
        success: function (result) {
            var subTotal = result.SubTotal;
            var total = result.Total;

            $('#txtIngresoSubTotal').editable('setValue', parseInt(subTotal));
            $('#txtIngresoTotal').editable('setValue', parseInt(total));
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

        $.ajax({
            url: url,
            type: "POST",
            data: { productos: dataPost, descuentos: descuentos },
            success: function (result) {
                var subTotal = result.SubTotal;
                var impuesto = result.Impuesto;
                var total = result.Total;

                $('#lbtotal').text(subTotal);
                $('#lbimpuesto').text(impuesto);
                $('#lbtotalfinal').text(total);
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
    for (i = 1; i <= cantidadDescuentosTotal; i++) {
        descuentos.push(parseInt($("#txtDescuentoTotal" + i).val()));
    }

    return descuentos;
}

function addRow() {
    var validador = 0;

    var codigo = $('#txtIngresoCodigoRapido').editable('getValue').txtIngresoCodigoRapido;
    var descripcion = $('#txtIngresoDescripcionCodigo').editable('getValue').txtIngresoDescripcionCodigo;
    var cantidad = $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad;
    //$('#txtIngresoStock').editable('getValue').txtIngresoStock;
    var medida = $('#txtIngresoUnidadDeMedida').editable('getValue').txtIngresoUnidadDeMedida;
    var preciounitario = $('#txtIngresoNeto').editable('getValue').txtIngresoNeto;
    var subtotal = $('#txtIngresoSubTotal').editable('getValue').txtIngresoSubTotal;
    var descuento = descuentosAgregadosProducto;
    var valordescuento = $('#txtIngresoTotal').editable('getValue').txtIngresoTotal;
    var talla = verTallaColorTalla;
    var color = verTallaColorColor;

    if (talla === null || talla === undefined || talla === "") {
        talla = "";
    }
    if (color === null || color === undefined || color === "") {
        color = "";
    }

    var porcentaje = Math.round(precioProducto * 0.15);
    var precioMax = (precioProducto - porcentaje);

    if (codigo === null || codigo === undefined || codigo === "" ||
        cantidad === null || cantidad === undefined || cantidad === "" || cantidad === "0" ||
        preciounitario === null || preciounitario === undefined || preciounitario === "" || preciounitario === "0" ||
        descuento === null || descuento === undefined || descuento === "" || descuento === "0") {

        abrirError("Error datos producto", "Favor, complete todos los campos necesarios para agregar producto");
    }
    else {
        var contador = 0;
        for (i = 0; i < $("#generaTabla tr").length; i++) {
            item = $("#generaTabla tr")[i];
            contador = parseInt(item.id.substring(3, 90)) >= contador ? parseInt(item.id.substring(3, 90)) + 1 : contador;
        }

        var texto_insertar =
            '<tr id="id_' + contador + '" class="thproductolist' + contador + '">' +
            '<td><span id="lblCodigo_' + contador + '">' + codigo + '</td>'
            + '<td><span id="lblDescripcion_' + contador + '">' + descripcion + '</td>'
            + '<td><span id="lblTalla_' + contador + '">' + talla + '</td>'
            + '<td><span id="lblColor_' + contador + '">' + color + '</td>'
            + '<td style="text-align: right"><span id="lblCantidad_' + contador + '">' + cantidad + '</td>'
            + '<td><span id="lblMedida_' + contador + '">' + medida + '</td>'
            + '<td style="text-align: right"><span id="lblPrecioUnitario_' + contador + '">' + preciounitario + '</td>'
            + '<td style="text-align: right"><span id="lblSubTotal_' + contador + '">' + subtotal + '</td>'
            + (cantidadDescuentosProducto <= 1 ?
                '<td style="text-align: right"><span id="lblDescuento_' + contador + '">' + descuento[0] + '</td>' :
                '<td><a class="editable editable-click editable-empty" id="verDescuentos_' + contador + '" onclick="verDescuentos(' + contador + ')">Ver Descuentos</a></td>')
            + '<td style="text-align: right"><span id="lblTotal_' + contador + '">' + valordescuento + '</td>'
            + '<td><a id="thproductolist' + contador + '" href="#divCodigo" onclick="eliminarFilas(' + contador + ');"><img src="../Content/Image/delete.png" /></a></td>'
            + '</tr>';

        var nuevo_campo = $(texto_insertar);
        $("#generaTabla").append(nuevo_campo);

        $('#txtIngresoCodigoRapido').editable('setValue', '');
        $('#txtIngresoDescripcionCodigo').editable('setValue', '');
        $('#txtIngresoCantidad').editable('setValue', '1');
        $('#txtIngresoStock').editable('setValue', '0');
        $('#txtIngresoUnidadDeMedida').editable('setValue', '');
        $('#txtIngresoNeto').editable('setValue', '0');
        $('#txtIngresoSubTotal').editable('setValue', '0');
        crearControlDescuentos();
        $('#txtIngresoTotal').editable('setValue', '0');
        verTallaColorTalla = "";
        verTallaColorColor = "";

        var productoAgregado = {
            Codigo: codigo,
            Talla: talla,
            Color: color,
            contador: contador,
            PrecioUnitario: preciounitario,
            Cantidad: cantidad,
            Descuentos: descuento,
            SubTotal: subtotal,
            Total: valordescuento
        };

        productosAgregados.push(productoAgregado);

        CalcularProductosAgregados();
    }
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
            + producto.Descuentos[i]
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
    bodegas.push(BodegaPorDefecto);
    for (i = 0; i < datos.length; i++) {
        if (bodegas.find(m => m === datos[i].CodigoBodega) === undefined) {
            bodegas.push(datos[i].CodigoBodega);
        }
    }
    $("#modalTallaColorBodegas").find('option').remove().end();

    for (i = 0; i < bodegas.length; i++) {
        $("#modalTallaColorBodegas").append('<option value="' + bodegas[i] + '">' + bodegas[i] + '</option>');
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
        + '<th colspan="' + bodegas.length + '">Bodegas</th>'
        + '</tr>'
        + '<tr>'
        + '<th>Codigo Producto</th>'
        + '<th>Talla</th>'
        + '<th>Color</th>'
        + '<th>Cantidad</th>';

    for (y = 0; y < bodegas.length; y++) {
        tallaColorAppend = tallaColorAppend
            + '<th>' + bodegas[y] + '</th>';
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
            var valorStock = $($(filas[i]).children("td")[4]).html();

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

        if (validaCantidadVSStock) {
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
            $('#txtIngresoCodigoRapido').editable('setValue', valores[z].codigoProducto);
            $('#txtIngresoDescripcionCodigo').editable('setValue', verTallaColorDescripcion);
            $('#txtIngresoCantidad').editable('setValue', valores[z].cantidad);
            $('#txtIngresoUnidadDeMedida').editable('setValue', verTallaColorMedida);
            $('#txtIngresoNeto').editable('setValue', verTallaColorPrecioUnitario);
            verTallaColorTalla = valores[z].talla;
            verTallaColorColor = valores[z].color;
            descuentosAgregadosProducto = [verTallaColorDescuento];

            CalcularFila(
                $('#txtIngresoNeto').editable('getValue').txtIngresoNeto,
                $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                descuentosAgregadosProducto
            );

            addRow();
        }

        $("#modalTallaColorCerrar").click();
    });

    $("#aModalTallaColor").click();
}

function agregarnotadeventa() {
    var urlAgregarNotaVenta = $("#urlAgregarNotaVenta").val();
    var urlAgregarNotaVentaDetalle = $("#urlDetalleNotaVenta").val();

    var NVNumero = $('#txtnventa').val();
    var nvFem = $('#txtfechapedido').val();
    var nvFeEnt = $('#txtfechaentrega').val();
    var CodAux = $('#txtcliente').val();
    var VenCod = $('#txtvendedor').val();
    var CodLista = $('#cbxlista').val();
    var nvObser = $('#txtobservacion').val();
    var CveCod = $('#cbxconven').val();
    var CodiCC = $('#cbxccosto').val();
    var nvSubTotal = $('#txttotal').val();
    var nvMonto = $('#txttotalfinal').val();
    var nvNetoAfecto = $('#txttotal').val();

    var Usuario = $('#txtnomvendedor').val();
    var UsuarioGeneraDocto = $('#txtnomvendedor').val();

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

    var cabecera = {
        NVNumero: NVNumero,
        nvFem: nvFem,
        //nvEstado: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstFact: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstDesp: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstRese: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEstConc: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CotNum: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //NumOC: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        nvFeEnt: nvFeEnt,
        CodAux: CodAux,
        VenCod: VenCod,
        //CodMon: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        CodLista: CodLista,
        nvObser: nvObser,
        //nvCanalNV: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        CveCod: CveCod,
        //NomCon: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        CodiCC: CodiCC,
        //CodBode: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        nvSubTotal: nvSubTotal,
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
        nvMonto: nvMonto,
        //nvFeAprob: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //NumGuiaRes: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcFlete: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvValflete: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvPorcEmb: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvValEmb: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvEquiv: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //nvNetoExento: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        nvNetoAfecto: nvNetoAfecto,
        //nvTotalDesc: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //ConcAuto: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        CodLugarDesp: CodLugarDesp,
        //SolicitadoPor: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //DespachadoPor: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Patente: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //RetiradoPor: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CheckeoPorAlarmaVtas: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //EnMantencion: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        Usuario: Usuario,
        UsuarioGeneraDocto: UsuarioGeneraDocto,
        FechaHoraCreacion: FechaHoraCreacion,
        //Sistema: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //ConcManual: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //RutSolicitante: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //proceso: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        TotalBoleta: TotalBoleta,
        //NumReq: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CodVenWeb: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CodBodeWms: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //CodLugarDocto: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //RutTransportista: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Cod_Distrib: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //Nom_Distrib: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        //MarcaWG: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
    };

    for (i = 0; i < productosAgregados.length; i++) {

    }







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
        var VenCod = $('#txtvendedor').val();
        var CodLista = $('#cbxlista').val();
        var nvObser = $('#txtobservacion').val();
        var CveCod = $('#cbxconven').val();
        var CodiCC = $('#cbxccosto').val();
        var nvSubTotal = $('#txttotal').val();
        var nvMonto = $('#txttotalfinal').val();
        var nvNetoAfecto = $('#txttotal').val();

        var Usuario = $('#txtnomvendedor').val();
        var UsuarioGeneraDocto = $('#txtnomvendedor').val();

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
            VenCod: VenCod,
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
        if (CorreoCliente == "" || CorreoCliente == null) {
            alert("Cliente no tiene Correo Asignado");
            var url = $("#NV").val(); location.href = url;
        }
        else {
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
}