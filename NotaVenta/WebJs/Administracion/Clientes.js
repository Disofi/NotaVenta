$(document).ready(function () {
    $("#tblCliente").DataTable({
        responsive: true,
        bAutoWidth: true,
        autoWidth: true 
    }); 
});

function ObtenerDatosCliente(CodAux) {
    $.ajax({
        url: "obtenerDatosClientes",
        type: "GET",
        data: {
            _CodAux: CodAux
        },
        async: true,
        success: function (data) {
            $.each(data, function (index, value) {
                $.each(this, function (name, value) {
                    $('#CodAuxMod').val(value.CodAux);
                    $('#NombreMod').val(value.NomAux);
                    $('#RutMod').val(value.RutAux);
                    $('#ContactoMod').val(value.NomCon);
                    $('#EmailMod').val(value.EMail);
                    $('#TelefonoMod').val(value.FonCon);
                    $('#DireccionMod').val(value.DirAux);
                });
            });
        }
    });
}

function EditarCliente() {
    var CodAux = $("#CodAuxMod").val();
    var Nombre = $("#NombreMod").val();
    var Rut = $("#RutMod").val();
    var Contacto = $("#ContactoMod").val();
    var Email = $("#EmailMod").val();
    var Telefono = $("#TelefonoMod").val();
    var Direccion = $("#DireccionMod").val();
    $.ajax({
        url: "EditarCliente",
        type: "POST",
        data: {_CodAux:CodAux,_Nombre:Nombre,_Rut:Rut,_Contacto:Contacto,_Email:Email,_Telefono:Telefono,_Direccion:Direccion},
        async: true,
        success: function (data) {
            if (data.Verificador) {
                alert(data.Mensaje);
                location.reload();
            }
            if (data == -666) {
                alert("Debe Completar Datos Obligatorios");
            }
            if (data == -999) {
                alert("Rut Ingresado NO Valido");
            }
        }
    });
}

function checkRut() {
    var sRut1 = document.getElementById("RutMod").value;
sRut1 = sRut1.replace('-', '');// se elimina el guion
sRut1 = sRut1.replace('.', '');// se elimina el primer punto
sRut1 = sRut1.replace('.', '');// se elimina el segundo punto
sRut1 = sRut1.replace(/k$/, "K");
document.getElementById("RutMod").value = sRut1;
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
    document.getElementById("RutMod").value = sRut.toUpperCase();
}