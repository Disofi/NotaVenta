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

