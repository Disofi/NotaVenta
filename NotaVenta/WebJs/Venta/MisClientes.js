$(document).ready(function () {
});

function checkRut() {
    var sRut1 = document.getElementById("RutCli").value;
    sRut1 = sRut1.replace('-', '');// se elimina el guion
    sRut1 = sRut1.replace('.', '');// se elimina el primer punto
    sRut1 = sRut1.replace('.', '');// se elimina el segundo punto
    sRut1 = sRut1.replace(/k$/, "K");
    document.getElementById("RutCli").value = sRut1;
    //contador de para saber cuando insertar el . o la -
    var nPos = 0;
    //Guarda el rut invertido con los puntos y el gui&oacute;n agregado
    var sInvertido = "";
    //Guarda el resultado final del rut como debe ser
    var sRut = "";
    for (var i = sRut1.length - 1; i >= 0; i--) {
        sInvertido += sRut1.charAt(i);
        if (i == sRut1.length - 1)
            sInvertido += "-";
        else if (nPos == 3) {
            sInvertido += ".";
            nPos = 0;
        }
        nPos++;
    }
    for (var j = sInvertido.length - 1; j >= 0; j--) {
        if (sInvertido.charAt(sInvertido.length - 1) != ".")
            sRut += sInvertido.charAt(j);
        else if (j != sInvertido.length - 1)
            sRut += sInvertido.charAt(j);
    }
    //Pasamos al campo el valor formateado
    document.getElementById("RutCli").value = sRut.toUpperCase();
}

function PreNotaVenta (_aCodAux, _aNomAux) {
    var CodAuxi = _aCodAux;
    var urlNotaVenta = $("#urlNotaVenta").val();
    $.ajax({
        type: "POST",
        url: "PreNotadeVenta",
        data: { CodAux: _aCodAux, NomAux: _aNomAux },
        async: true,
        success: function (data) {
            if (data == -1) {
                $("#AgregarCorreo").click();

                $("#btnAgregarCorreo").click(function () {
                    var Email = $("#AddCorreo").val();
                    if (Email == '') {
                        alert("Debe ingresar Correo");
                    }
                    else {
                        $.ajax({
                            type: "POST",
                            url: "AgregarCorreo",
                            data: { _Email: Email, _CodAux: CodAuxi },
                            async: true,
                            success: function (data) {
                                if (data == 1) {
                                    alert("Ficha Cliente Actualizada");
                                    location.reload();
                                }
                                if (data == -666) {
                                    alert("Debe Ingresar formato de Correo");
                                }
                            }
                        });
                    }
                });
            }
            if (data == -999) {
                alert("Cliente no Cuenta con Credito");
            }
            if (data == 1) {
                window.location = urlNotaVenta;
            }
        }
    });
}

function AgregarCliente() {
    var nomaux = $("#NombreCli").val();
    var rutaux = $("#RutCli").val();
    var fonaux1 = $("#TelefonoCli").val();
    var email = $("#EmailMod").val();
    var giraux = $("#GirAux").val();
    var diraux = $("#DireccioCli").val();
    var emaildte = $("#EmailDteMod").val();
    $.ajax({
        type: "POST",
        url: "AgregarCliente",
        data: {
            NomAux: nomaux,
            RutAux: rutaux,
            FonAux1: fonaux1,
            Email: email,
            GirAux: giraux,
            DirAux: diraux,
            EmailDte: emaildte
        },
        async: true,
        success: function (data) {
            if (data == -666) {
                alert("Debe Completar Campos Obligatorios");
            }
            if (data == -1) {
                alert("Mal Formato de Correo");
            }
            if (data.Verificador == 1) {
                alert(data.Mensaje);
                location.reload();
            }
            if (data.Verificador == 0) {
                alert(data.Mensaje);
            }
        }

    });
}