$(document).ready(function () {
    FormEditable.init();
    cbxlistaChange();
});

var handleEditableFormAjaxCall = function () {
    $.mockjax({
        url: '/post',
        response: function (settings) {
            if (settings.data.name === "txtIngresoDescripcionCodigo") {
                var producto = productos.find(m => m.busqueda === settings.data.value);

                $('#txtIngresoCodigoRapido').editable('setValue', producto.CodProd);
                $('#txtIngresoNeto').editable('setValue', producto.PrecioVta);
                $('#txtIngresoUnidadDeMedida').editable('setValue', producto.codumed);
                $('#txtIngresoStock').editable('setValue', producto.Stock);

                CalcularFila(
                    producto.PrecioVta,
                    $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                    [$('#txtIngresoDescuento').editable('getValue').txtIngresoDescuento]
                );
            }
            if (settings.data.name === "txtIngresoCantidad") {
                if (/^([0-9])*$/.test(settings.data.value)) {
                    CalcularFila(
                        $('#txtIngresoNeto').editable('getValue').txtIngresoNeto,
                        settings.data.value,
                        [$('#txtIngresoDescuento').editable('getValue').txtIngresoDescuento]
                    );
                }
                else {
                    this.status = 500;
                    this.statusText = "Solo se admiten numeros";
                }
            }
            if (settings.data.name === "txtIngresoDescuento") {
                if (/^([0-9])*$/.test(settings.data.value)) {
                    if (parseFloat(settings.data.value) <= 100 && parseFloat(settings.data.value) >= 0) {

                        CalcularFila(
                            $('#txtIngresoNeto').editable('getValue').txtIngresoNeto,
                            $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad,
                            [settings.data.value]
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

    $('#txtIngresoCodigoRapido').editable();
    $('#txtIngresoCantidad').editable();
    $('#txtIngresoStock').editable();
    $('#txtIngresoStock').editable('toggleDisabled');
    $('#txtIngresoUnidadDeMedida').editable();
    $('#txtIngresoUnidadDeMedida').editable('toggleDisabled');
    $('#txtIngresoNeto').editable();
    $('#txtIngresoSubTotal').editable();
    $('#txtIngresoDescuento').editable();
    $('#txtIngresoTotal').editable();
};

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



function Multiplicar(tipo, valor) {
    var punitario = $('#txtIngresoNeto').editable('getValue').txtIngresoNeto;

    var cantidad = 0;
    if (tipo === "cantidad") { var cantidad = valor; }
    else { cantidad = $('#txtIngresoCantidad').editable('getValue').txtIngresoCantidad; }

    var porcentaje = $('#txtIngresoDescuento').editable('getValue').txtIngresoDescuento;

    if (cantidad == "") {
        $('#txtIngresoSubTotal').editable('setValue', '');
        $('#txtIngresoCantidad').editable('setValue', '');
        $('#txtIngresoTotal').editable('setValue', '');
    }
    else {
        var url = $("#urlMultiplicar").val();
        var _data = { punitario: punitario, cantidad: cantidad };



        $.ajax({
            url: url,
            data: _data,
            type: "POST",
            dataType: "json",
            async: false,
            success: function (data) {
                $('#txtIngresoSubTotal').editable('setValue', data);

                $('#txtIngresoSubTotal').val(data);
                if (porcentaje == 0) {
                    $('#txtIngresoTotal').editable('setValue', data);
                }
                else {
                    Descuento();
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

function NumCheck(e, field) {
    key = e.keyCode ? e.keyCode : e.which
    // backspace
    if (key == 8) return true
    // 0-9
    if (key > 47 && key < 58) {
        if (field.value == "") return true
        regexp = /.[0-9]{2}$/
        return !(regexp.test(field.value))
    }
    // .
    if (key == 46) {
        if (field.value == "") return false
        regexp = /^[0-9]+$/
        return regexp.test(field.value)
    }
    // other key
    return false

}


function validaNumericos(event) {
    if (event.charCode >= 48 && event.charCode <= 57) {
        return true;
    }
    return false;
}


function Descuento() {
    var valor = $('#txtsubtotal').val();
    var porcenta = $('#txtDescuento').val();

    if (porcenta == '') {
        $('#txtDescuento').val('');
        $('#txtTotalConDes').val(valor);
    }
    else {
        if (valor != '' && parseInt(porcenta) != 0) {
            document.getElementById("txtprecioneto").disabled = true;
            if (porcenta <= 15) {
                var url = $("#urlPorcentaje").val();
                var data = { valor: valor, porcenta: porcenta };

                $.post(url, data).done(function (data) {

                    $('#txtTotalConDes').val(data);
                    if (porcenta == '') {
                        porcenta = 0;
                        $('#txtDescuento').val(porcenta);
                    }
                })

            }
            else {
                document.getElementById("txtprecioneto").disabled = true;
                $('#txtDescuento').val('15');
                Descuento();
            }
        }

    }
}

var precioProducto = 0;

var productos = [];

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
                source: productos.map(m => { return { id: m.busqueda, text: m.busqueda } }),
                select2: {
                    width: 200,
                    placeholder: 'Seleccione Productos',
                    allowClear: true
                }
            });

            $("input#txtdescripcion").autocomplete({
                source: function (request, response) {
                    var valorString = $("input#txtdescripcion").val();
                    var productosFilter = productos.filter(x => x.CodProd.includes(valorString) || x.DesProd.includes(valorString));
                    response($.map(productosFilter, function (item) {
                        return {
                            value: item.CodProd,
                            label: item.CodProd + '-' + item.DesProd,
                            precio: item.PrecioVta,
                            umedida: item.codumed,
                            nompro: item.DesProd,
                            Stock: item.Stock
                        };
                    }));
                },
                minLength: 1,
                select: function (event, ui) {

                    $('#txtcodigoProducto').val(ui.item.value);
                    $('#txtdescripcionProducto').val(ui.item.nompro);
                    $('#txtprecioneto').val(ui.item.precio);
                    precioProducto = ui.item.precio;
                    $('#txtumedida').val(ui.item.umedida);
                    $('#txtstock').val(ui.item.Stock);
                    $(this).val(ui.item.label);

                    $('#txtcantidad').focus();
                    return false;
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

    resta(subtotal);

    fila.remove();
}

function CalcularFila(precioUnitario, cantidad, descuentos) {
    if (precioUnitario === undefined || precioUnitario === null || precioUnitario === "") { precioUnitario = 0; }
    if (cantidad === undefined || cantidad === null || cantidad === "") { cantidad = 0; }

    if (descuentos === undefined || descuentos === null || descuentos === "") { descuentos = []; }

    precioUnitario = parseInt(precioUnitario);
    cantidad = parseInt(cantidad);
    for (i = 0; i < descuentos.length; i++) {
        descuentos[i] = parseInt(descuentos[i]);
    }

    var url = $("#urlCalcularFila").val();

    var dataPost = { precioUnitario: precioUnitario, cantidad: cantidad, descuentos: descuentos };

    $.ajax({
        url: url,
        type: "POST",
        data: dataPost,
        success: function (result) {
            var subTotal = result.subTotal;
            var subTotalDescuento = result.subTotalDescuento;
            var total = result.total;

            $('#txtIngresoSubTotal').editable('setValue', parseInt(subTotal));
            $('#txtIngresoTotal').editable('setValue', parseInt(total));
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
        async: false
    });
}

function suma(valor) {
    valor = valor.replace('.', '');
    var valortotal = $('#txttotal').val();
    var totalfinal = parseFloat(valortotal) + parseFloat(valor);
    var neto = totalfinal;
    var iva = (parseFloat(neto) * parseFloat("0.19"));
    var valorfinal = parseFloat(neto) + parseFloat(iva);
    $('#txtimpuesto').val(Math.round(iva));
    $('#lbimpuesto').html(Math.round(iva));
    $('#txttotalfinal').val(Math.round(valorfinal));
    $('#lbtotalfinal').html(Math.round(valorfinal));
    $('#txttotal').val(Math.round(totalfinal));
    $('#lbtotal').html(Math.round(totalfinal));
}

function resta(valor) {
    valor = valor.replace('.', '');
    var valortotal = $('#txttotal').val();
    var totalfinal = parseFloat(valortotal) - parseFloat(valor);
    var neto = totalfinal;
    var iva = (parseFloat(neto) * parseFloat("0.19"));
    var valorfinal = parseFloat(neto) + parseFloat(iva);
    $('#txtimpuesto').val(Math.round(iva));
    $('#lbimpuesto').html(Math.round(iva));
    $('#txttotalfinal').val(Math.round(valorfinal));
    $('#lbtotalfinal').html(Math.round(valorfinal));
    $('#txttotal').val(Math.round(totalfinal));
    $('#lbtotal').html(Math.round(totalfinal));
}

function PrecioMod() {
    //var valorNeto = $('#txtprecioneto').val();
    var cantidadTotal = $('#txtcantidad').val();
    var preciounitario = parseInt($('#txtprecioneto').val());

    var descuento = Math.round(precioProducto * 0.15);
    var precioMax = (precioProducto - descuento);

    if (preciounitario < precioMax) {
        $('#txtprecioneto').val(precioMax);
        $('#txtsubtotal').val(precioMax * cantidadTotal);
        $('#txtTotalConDes').val(precioMax * cantidadTotal);
        alert("Neto Ingresado Debe ser Hasta el 15% de Descuento");
        document.getElementById("txtDescuento").disabled = true;
    } else {
        $('#txtsubtotal').val($('#txtprecioneto').val() * $('#txtcantidad').val());
        $('#txtTotalConDes').val($('#txtprecioneto').val() * $('#txtcantidad').val());
        //document.getElementById("txtDescuento").disabled = true;
    }
    if (preciounitario > precioMax) {
        document.getElementById("txtDescuento").disabled = true;
    }
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
    var descuento = $('#txtIngresoDescuento').editable('getValue').txtIngresoDescuento;
    var valordescuento = $('#txtIngresoTotal').editable('getValue').txtIngresoTotal;

    var porcentaje = Math.round(precioProducto * 0.15);
    var precioMax = (precioProducto - porcentaje);

    var contador = 0;
    for (i = 0; i < $("#generaTabla tr").length; i++) {
        item = $("#generaTabla tr")[i];
        contador = parseInt(item.id.substring(3, 90)) >= contador ? parseInt(item.id.substring(3, 90)) + 1 : contador;
    }

    var texto_insertar =
        '<tr id="id_' + contador + '" class="thproductolist' + contador + '">' +
        '<td><span id="lblCodigo_' + contador + '">' + codigo + '</td>'
        + '<td><span id="lblDescripcion_' + contador + '">' + descripcion + '</td>'
        + '<td><span id="lblCantidad_' + contador + '">' + cantidad + '</td>'
        + '<td><span id="lblMedida_' + contador + '">' + medida + '</td>'
        + '<td><span id="lblPrecioUnitario_' + contador + '">' + preciounitario + '</td>'
        + '<td><span id="lblSubTotal_' + contador + '">' + subtotal + '</td>'
        + '<td><span id="lblDescuento_' + contador + '">' + descuento + '</td>'
        + '<td><span id="lblTotal_' + contador + '">' + valordescuento + '</td>'
        + '<td><a id="thproductolist' + contador + '" href="#divCodigo" onclick="eliminarFilas(' + contador + ');"><img src="../Content/Image/delete.png" /></a></td>'
        + '</tr>';

    var nuevo_campo = $(texto_insertar);
    $("#generaTabla").append(nuevo_campo);

    $('#txtIngresoCodigoRapido').editable('setValue', '');
    $('#txtIngresoDescripcionCodigo').editable('setValue', '');
    $('#txtIngresoCantidad').editable('setValue', '');
    $('#txtIngresoStock').editable('setValue', '');
    $('#txtIngresoUnidadDeMedida').editable('setValue', '');
    $('#txtIngresoNeto').editable('setValue', '');
    $('#txtIngresoSubTotal').editable('setValue', '');
    $('#txtIngresoDescuento').editable('setValue', '');
    $('#txtIngresoTotal').editable('setValue', '');
}

function agregarnotadeventa() {
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


        //else {
        //    $.post(url, data).done(function (data) {
        //    if (data == null) {
        //        alert("Cliente no tiene Correo Asignado");
        //    }
        //    confirm("Se Genero Cotización" + " " + NVNumero);
        //    var url1 = $("#RedirectTo").val();
        //        location.href = url1;

        //    //Window.location.href = '/Ventas/Misclientes/' + id;
        //});
        //}

    }
}