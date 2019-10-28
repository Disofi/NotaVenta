﻿$(document).ready(function () {
    try {
        $('#dataTable').DataTable({
            language: {
                "sProcessing": "Procesando...",
                "sLengthMenu": "Mostrar _MENU_ Registros",
                "sZeroRecords": "&nbsp;",
                "sEmptyTable": "&nbsp;",
                "sInfo": "Encontrados: _TOTAL_ Registros (Mostrando del _START_ al _END_)",
                "sInfoEmpty": "* No se han encontrado resultados en la búsqueda",
                "sInfoFiltered": "",
                "sInfoPostFix": "",
                "sSearch": "Buscar:",
                "sUrl": "",
                "sInfoThousands": ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst": "Primero",
                    "sLast": "Último",
                    "sNext": "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
            },
            aoColumnDefs: [{ 'bSortable': false, 'aTargets': ['no-sortable'] }]
        });
    }
    catch (e) { }
    /*
    $("#iframe").fancybox({
        width: '85%',
        height: '60%',
        autoScale: false,
        transitionIn: 'elastic',
        transitionOut: 'elastic',
        type: 'iframe'
    });
    */

    $("#modalLayoutEmpresasAgregar").click(function () {
        var empresa = $("#ddlLayoutEmpresas").val();

        var urlSeleccionaEmpresa = $("#urlSeleccionaEmpresa").val();

        $.ajax({
            url: urlSeleccionaEmpresa,
            type: "POST",
            data: { _IdEmpresa: empresa },
            async: true,
            success: function (data) {
                var urlHome = $("#urlHome").val();
                window.location = urlHome;
            }
        });
    });
});


$(document).ready(function () {
    $("#aBaseModalCambioContrasena").click(function () {
        $("#btnBaseModalCambioContrasena").click();
    });

    $("#baseBtnCambiaContrasena").click(function () {
        console.log("sdlfhiosdbvnkld");
        $.ajax({
            url: "BaseCambiaContrasena",
            type: "POST",
            data: {
                contrasena: $("#baseTxtContrasena").val(),
            },
            async: true,
            success: function (data) {
                console.log(data);
                if (data.Verificador) {
                    $("#baseBtnCerrarModal").click();
                    abrirInformacion("Cambio Contraseña", data.Mensaje);
                    $("#baseTxtContrasena").val("");
                }
                else {
                    abrirError("Cambio Contraseña", data.Mensaje);
                }
            }
        });
    });
});

function abrirLoadingCompleto(texto) {
    /*
    if (texto === undefined || texto === null) {
        texto = "Cargando";
    }
    $("#loading-ajax-texto").html(texto);
    jQuery("#loading-ajax").show();
    */
}
function cerrarLoadingCompleto() {
    /*
    jQuery("#loading-ajax").hide();
    */
}


var tipoAlert = 2;

function abrirError(titulo, mensaje, callBackOK) {
    if (tipoAlert === 1) {
        $("#btnModalError").click();

        $("#modalErrorMensaje").html(mensaje);
        $("#modalErrorTitulo").html(titulo);
        $("#modalErrorAceptar").click(function () {
            if (callBackOK !== null && callBackOK !== undefined && (callBackOK instanceof Function)) {
                callBackOK();
            }

            $("#modalErrorCerrar").click();
        });
    }
    else {
        alert(mensaje);
    }
}

function abrirInformacion(titulo, mensaje, callBackOK) {
    if (tipoAlert === 1) {
        $("#btnModalInformacion").click();

        $("#modalInformacionMensaje").html(mensaje);
        $("#modalInformacionTitulo").html(titulo);
        $("#modalInformacionAceptar").click(function () {
            if (callBackOK !== null && callBackOK !== undefined && (callBackOK instanceof Function)) {
                callBackOK();
            }

            $("#modalInformacionCerrar").click();
        });
    }
    else {
        alert(mensaje);
    }
}

function abrirConfirmacion(titulo, mensaje, callBackOK, callBackCancel) {
    if (tipoAlert === 1) {
        $("#btnModalConfirmacion").click();

        $("#modalConfirmacionMensaje").html(mensaje);
        $("#modalConfirmacionTitulo").html(titulo);
        $("#modalConfirmacionAceptar").click(function () {
            if (callBackOK !== null && callBackOK !== undefined && (callBackOK instanceof Function)) {
                callBackOK();
            }

            $("#modalConfirmacionCerrar").click();
        });
        $("#modalConfirmacionCancelar").click(function () {
            if (callBackCancel !== null && callBackCancel !== undefined && (callBackCancel instanceof Function)) {
                callBackCancel();
            }

            $("#modalConfirmacionCerrar").click();
        });
    }
    else {
        var conf = confirm(mensaje);

        if (conf) {
            if (callBackOK !== null && callBackOK !== undefined && (callBackOK instanceof Function)) {
                callBackOK();
            }
        }
        else {
            if (callBackCancel !== null && callBackCancel !== undefined && (callBackCancel instanceof Function)) {
                callBackCancel();
            }
        }
    }
}