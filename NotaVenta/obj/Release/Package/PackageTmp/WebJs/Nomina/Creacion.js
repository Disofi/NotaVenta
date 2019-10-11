var IdNomina = 0;
var path = "";

$(window).ready(function () {
    var i = 0;
    var elementos = $("input[name=txtAnoName]");

    for (i = 0; i < elementos.length; i++) {
        var id = elementos[i].id;
        var elementoArray = "empresa" + id;

        $.ajax({
            url: "ObtieneAnos",
            type: "POST",
            data: {
                idEmpresa: id
            },
            success: (data) => {
                $("#divListaAnos_" + id).append("<a onclick='txtAnoNameChange(\"" + id + "\", event)' class='dropdown-item'></a>")
                $.each(data, (i, item) => {
                    $("#divListaAnos_" + id).append("<a onclick='txtAnoNameChange(\"" + id + "\", event)' class='dropdown-item'>" + item.Ano + "</a>")
                });
            },
            async: false
        });
    }

    $("#btnCrearNomina").click(() => {
        var elementos = $("input[name=txtAnoName]");
        var request = [];
        var hayErrorGeneral = false;
        var hayErrorFechaPago = false;
        //"has-error"

        var causalPago = $("#ddlCausalPago").val();
        var fechaPago = $("#txtFechaPago").val();
        if (fechaPago === "" || fechaPago === undefined || fechaPago === null) { hayErrorFechaPago = true; hayErrorGeneral = true; }
        if (hayErrorFechaPago) { $("#divFechaPago").addClass("has-error"); } else { $("#divFechaPago").removeClass("has-error"); }

        for (i = 0; i < elementos.length; i++) {
            var hayErrorAno = false;
            var hayErrorIdEmpresa = false;
            var hayErrorComprobante = false;

            var id = elementos[i].id;

            var ano = $("#" + id).val();
            var idEmpresa = $("#idEmpresa_" + id).val();
            var comprobante = $("#txtComprobante_" + id).attr("valor");

            if (idEmpresa === "" || idEmpresa === undefined || idEmpresa === null) { hayErrorIdEmpresa = true; }
            if (ano === "" || ano === undefined || ano === null) { }
            else if (comprobante === "" || comprobante === undefined || comprobante === null) { hayErrorComprobante = true; }

            if (hayErrorAno || hayErrorIdEmpresa || hayErrorComprobante) {
                hayErrorGeneral = true;
            }


            if (ano !== "" && ano !== undefined && ano !== null) {
                request.push({
                    id: id,
                    Numero: comprobante,
                    Ano: ano,
                    IdEmpresa: idEmpresa,
                    FechaPago: fechaPago,
                    hayErrorAno: hayErrorAno,
                    hayErrorIdEmpresa: hayErrorIdEmpresa,
                    hayErrorComprobante: hayErrorComprobante,
                    hayErrorFechaPago: hayErrorFechaPago
                });
            }
            if (hayErrorAno) { $("#divAno_" + id).addClass("has-error"); } else { $("#divAno_" + id).removeClass("has-error"); }
            if (hayErrorComprobante) { $("#divComprobante_" + id).addClass("has-error"); } else { $("#divComprobante_" + id).removeClass("has-error"); }
        }
        if (!hayErrorGeneral) {
            if (request.length > 0) {
                $("#divIngresoComprobantes").fadeOut(500, () => {
                    $("#divCargandoNomina").fadeIn(500, () => {

                        $.ajax({
                            url: "CreacionNomina",
                            type: "POST",
                            data: { comprobantes: request, idCausalPago: causalPago },
                            success: (data) => {
                                console.log(data);
                                $("#divCargandoNomina").fadeOut(500, () => {
                                    $("#divResultadoNomina").fadeIn(500, () => {
                                        IdNomina = data.nomina.Id;
                                        path = data.path;
                                    })
                                });
                            },
                            async: true
                        });
                    });
                });
            }
            else {
                abrirError("Error generacion de nomina", "Se debe seleccionar a lo menos 1 comprobante", function () { });
            }
        }
    });
    $("#btnDescargarNomina").click(() => {
        var url = $("#aDescargarNomina").attr("href");
        window.location = url + "?path=" + path;
    });
    $("#btnEnviarNomina").click(() => {
        abrirLoadingCompleto("Se esta cargando el archivo en el servidor");
        $.ajax({
            url: "EnviarNomina",
            type: "POST",
            data: { path: path },
            success: (data) => {
                cerrarLoadingCompleto();
                abrirInformacion("Carga de archivo", "Se cargo el archivo exitosamente", function () { });
            },
            error: (data) => {
                cerrarLoadingCompleto();
            },
            async: true
        });
    });
});
var comprobantes = {};
var comprobantesTemp = {};

function txtAnoNameChange(id, event) {
    var ano = $(event.srcElement).html();
    var letrasMinimo = 0;

    $("#" + id).val(ano);

    if (ano !== undefined && ano !== null && ano !== "" && ano !== "-1") {
        $("#txtComprobante_" + id).attr("disabled", "disabled");
        $("#txtComprobante_" + id).val("");
        $("#lblMensaje_" + id).fadeIn();

        $.ajax({
            url: "ObtieneComprobantes",
            type: "POST",
            data: {
                idEmpresa: id,
                ano: ano
            },
            success: (data) => {
                var array = [];
                var i = 0;
                for (i = 0; i < data.length; i++) {
                    array.push({ label: data[i].Nombre, value: data[i].Nombre, valor: data[i].Numero });
                }

                /*
                if (array.length <= 1000) { letrasMinimo = 1; }
                else if (array.length <= 5000) { letrasMinimo = 2; }
                else if (array.length <= 10000) { letrasMinimo = 3; }
                else if (array.length <= 20000) { letrasMinimo = 4; }
                else { letrasMinimo = 5; }

                $("#txtComprobante_" + id).attr("placeholder", "Escriba " + letrasMinimo + " letra(s) para busqueda");
                */

                comprobantes["empresa" + id] = data;
                comprobantesTemp["empresa" + id] = array;

                $("#txtComprobante_" + id).autocomplete({
                    source: comprobantesTemp["empresa" + id],
                    minLength: letrasMinimo,
                    delay: 500,
                    change: (event, item) => { txtComprobanteNameChange(id, event, item) }
                    /*PROPIEDADES*/
                    //appendTo?: any; //Selector;
                    //autoFocus?: boolean;
                    //delay?: number;
                    //disabled?: boolean;
                    //minLength?: number;
                    //position?: any; // object
                    //source?: any; // [], string or ()
                    //classes?: AutocompleteClasses;
                    /*EVENTOS*/
                    //change?: AutocompleteEvent;
                    //close?: AutocompleteEvent;
                    //create?: AutocompleteEvent;
                    //focus?: AutocompleteEvent;
                    //open?: AutocompleteEvent;
                    //response?: AutocompleteEvent;
                    //search?: AutocompleteEvent;
                    //select?: AutocompleteEvent;
                });

                $("#txtComprobante_" + id).removeAttr("disabled");

                $("#lblMensaje_" + id).fadeOut();
            },
            async: true
        });
    }
    else {
        $("#txtComprobante_" + id).autocomplete({
            source: [],
            minLength: letrasMinimo,
            delay: 500,
        });
        $("#txtComprobante_" + id).attr("disabled", "disabled");
    }
}

function txtComprobanteNameChange(id, event, item) {
    var esta = false;
    var valorBusqueda = (item.item !== null) ? item.item.valor : $("#txtComprobante_" + id).val();

    esta = (comprobantes["empresa" + id].find(m => parseInt(m.Numero) === parseInt(valorBusqueda)) !== undefined);

    if (esta) {
        var valorDisplay = comprobantes["empresa" + id].find(m => parseInt(m.Numero) === parseInt(valorBusqueda)).Nombre;
        $("#txtComprobante_" + id).val(valorDisplay);
        $("#txtComprobante_" + id).attr("valor", valorBusqueda);
    }
    else {
        $("#txtComprobante_" + id).val("");
        $("#txtComprobante_" + id).attr("valor", "");
    }
}