﻿$(document).ready(function () {
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