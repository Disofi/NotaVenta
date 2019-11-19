$(document).ready(function () {
    $("#tblUsuario").DataTable({
        responsive: true,
        bAutoWidth: true,
        autoWidth: true
    });


    $("#modalEmpresasUsuarioEmpresa").change(function () {
        var idEmpresa = $("#modalEmpresasUsuarioEmpresa").val();
        if (idEmpresa !== '-1') {
            $.ajax({
                type: 'POST',
                url: 'ObtenerVendedoresEmpresa',
                data: { _IdEmpresa: idEmpresa },
                async: true,
                success: function (response) {
                    console.log(response);

                    $("#modalEmpresasUsuarioVendedor").empty();
                    $("#modalEmpresasUsuarioVendedor").append('<option value=""></option>');
                    $.each(response, function (i, item) {
                        $("#modalEmpresasUsuarioVendedor").append('<option value="' + item.VenCod + '">' +
                            item.VenCod + " - " + item.VenDes + '</option>');
                    });

                }
            });
        }
    });

    $("#modalEmpresasUsuarioAgregar").click(function () {
        var id = $("#modalEmpresasUsuarioId").val();

        var empresaUsuario = $.map(vendedoresUsuario, function (m) { return { IdUsuario: id, IdEmpresa: m.IdEmpresa, VenCod: m.IdVendedor } });

        $.ajax({
            type: 'POST',
            url: 'AgregarEmpresasUsuario',
            data: {
                _IdUsuario: id,
                empresasUsuario: empresaUsuario
            },
            async: true,
            success: function (response) {
                if (response.Verificador) {
                    location.reload();
                }
                else {
                    abrirError("Error Proyecto", response.Mensaje);
                }
            }
        });
    });
});

var vendedoresUsuario = [];
var indexCuadrilla = 9999;
function modalEmpresasUsuarioAgregarFilaClick() {
    var idEmpresa = $("#modalEmpresasUsuarioEmpresa").val();
    var textoEmpresa = $("#modalEmpresasUsuarioEmpresa option:selected").text();
    var idVendedor = $("#modalEmpresasUsuarioVendedor").val();
    var textoVendedor = $("#modalEmpresasUsuarioVendedor option:selected").text();
    var tbodyTabla = $("#modalEmpresasUsuarioDatos tbody");

    if (idEmpresa !== "-1" && idVendedor !== "-1") {
        if (vendedoresUsuario.filter(m => ("" + m.IdEmpresa) === ("" + idEmpresa)).length === 0) {
            $.ajax({
                type: 'POST',
                url: 'ValidaExisteEmpresasUsuario',
                data: {
                    _VenCod: idVendedor,
                    _IdEmpresa: idEmpresa
                },
                success: function (data) {
                    if (!data.Verificador) {
                        var item = { IdEmpresa: idEmpresa, NombreEmpresa: textoEmpresa, IdVendedor: idVendedor, NombreVendedor: textoVendedor };

                        vendedoresUsuario.push(item);

                        indexCuadrilla = indexCuadrilla + 1;

                        var index = indexCuadrilla;

                        var fila = "";
                        var fila = fila + "<tr id='modalEmpresasUsuarioDatosTR_" + index + "'>";
                        var fila = fila + "<td>";
                        var fila = fila + "" + item.NombreEmpresa;
                        var fila = fila + "</td>";
                        var fila = fila + "<td>";
                        var fila = fila + "" + item.IdVendedor;
                        var fila = fila + "</td>";
                        var fila = fila + "<td>";
                        var fila = fila + "<button id='modalEmpresasUsuarioEliminar_" + index + "' class='btn btn-red' type='button' tooltip=''";
                        var fila = fila + "onclick='___modalEmpresasUsuarioEliminar(" + item.IdEmpresa + ", " + item.IdVendedor + ", " + index + ")'>";
                        var fila = fila + "<i class='fas fa-trash'></i>";
                        var fila = fila + "</button>";
                        var fila = fila + "</td>";
                        var fila = fila + "</tr>";

                        tbodyTabla.append(fila);
                    }
                    else {
                        abrirInformacion("Usuario Empresa", "El vendedor " + textoVendedor + " ya existe en nuestro sistema para la empresa " + textoEmpresa);
                    }
                }
            });
        }
        else {
            abrirInformacion("Usuario Empresa", "Usuario ya tiene un usuario asociado a esta empresa");
        }
    }
}

function ___modalEmpresasUsuarioEliminar(idEmpresa, idVendedor, index) {
    vendedoresUsuario = vendedoresUsuario.filter(m => ("" + m.IdEmpresa) !== ("" + idEmpresa));
    $('#modalEmpresasUsuarioDatosTR_' + index).remove();
}

function obtenerEmpresasUsuario(idUsuario) {
    $("#modalEmpresasUsuarioId").val(idUsuario);
    var tbodyTabla = $("#modalEmpresasUsuarioDatos tbody");
    tbodyTabla.html("");

    $.ajax({
        type: 'POST',
        url: 'ObtenerEmpresasUsuario',
        data: { _IdUsuario: idUsuario },
        async: true,
        success: function (response) {
            console.log(response);
            vendedoresUsuario = [];

            $.each(response, function (index, item) {
                var item = { IdEmpresa: item.IdEmpresa, NombreEmpresa: item.NombreEmpresa, IdVendedor: item.VenCod, NombreVendedor: '' };
                vendedoresUsuario.push(item);
                var fila = "";
                var fila = fila + "<tr id='modalEmpresasUsuarioDatosTR_" + index + "'>";
                var fila = fila + "<td>";
                var fila = fila + "" + item.NombreEmpresa;
                var fila = fila + "</td>";
                var fila = fila + "<td>";
                var fila = fila + "" + item.IdVendedor;
                var fila = fila + "</td>";
                var fila = fila + "<td>";
                var fila = fila + "<button id='modalEmpresasUsuarioEliminar_" + index + "' class='btn btn-red' type='button' tooltip=''";
                var fila = fila + "onclick='___modalEmpresasUsuarioEliminar(" + item.IdEmpresa + ", " + item.IdVendedor + ", " + index + ")'>";
                var fila = fila + "<i class='fas fa-trash'></i>";
                var fila = fila + "</button>";
                var fila = fila + "</td>";
                var fila = fila + "</tr>";

                tbodyTabla.append(fila);
            });

        }
    });
}

function EliminarUsuario(id, estado) {
    var mensaje;
    if (estado) {
        var opcion = confirm("Desea Eliminar Usuario?");
    }
    else {
        var opcion = confirm("Desea Habilitar Usuario?");
    }
    if (opcion == true) {
        $.ajax({
            type: 'POST',
            url: 'EliminarUsuario',
            data: {
                _Id: id,
            },
            success: function (data) {
                if (data.Verificador) {
                    alert(data.Mensaje);
                    location.reload();
                }
                else {
                    alert("Usuario No Encontrado");
                }
            }
        });
    }
    else {
        mensaje = "Has clickado Cancelar";
    }
}


function AgregarUsuario() {
    var ContrasenaCorreo = $("#txtContrasenaCorreo").val();
    var ValidaContrasenaCorreo = $("#txtValidaContCorreo").val();
    var Usuario = $('#txtUsuario').val();
    var Nombre = $('#txtNombre').val();
    var Contrasena = $('#txtContrasena').val();
    var Email = $('#txtEmail').val();
    var Perfil = $('#Perfil').val();

    if (ContrasenaCorreo == ValidaContrasenaCorreo) {
        $.ajax({
            type: 'POST',
            url: 'Addusuario',
            data: { _Usuario: Usuario, _Nombre: Nombre, _Contrasena: Contrasena, _Email: Email, _Perfil: Perfil, _ContrasenaCorreo: ContrasenaCorreo },
            async: true,
            success: function (data) {
                if (data == -666) {
                    alert("Debe Completar Campos Obligatorios");
                }
                if (data.Verificador) {
                    alert(data.Mensaje);
                    location.reload();
                }
                if (data.Verificador == false) {
                    alert(data.Mensaje);
                }


            }
        });
    }
    else {
        alert("Contraseña de Correo no Coinciden");
    }


}

function ObtenerDatosUsuario(id) {
    $.ajax({
        url: "ObtenerDatosUsuario",
        type: "GET",
        data: {
            _IdUsuario: id
        },
        async: true,
        success: function (data) {
            $.each(data, function (index, value) {
                $.each(this, function (name, value) {
                    $("#IdUsuarioMod").val(value.id);
                    $("#UsuarioMod").val(value.Usuario);
                    $("#NombreMod").val(value.Nombre);
                    $("#EmailMod").val(value.email);
                    $("#PerfilMod").val(value.tipoId);
                    $("#CodVendSoftMod").val(value.VenCod.trim());
                });
            });

        }
    });
}

function EditarUsuario() {
    var id = $("#IdUsuarioMod").val();
    var Usuario = $("#UsuarioMod").val();
    var Nombre = $("#NombreMod").val();
    var Contrasena = $("#ContrasenaMod").val();
    var Email = $("#EmailMod").val();
    var Perfil = $("#PerfilMod").val();
    $.ajax({
        url: "Editarusuario",
        type: "POST",
        data: { _Id: id, _Usuario: Usuario, _Nombre: Nombre, _Contrasena: Contrasena, _Email: Email, _Perfil: Perfil },
        async: true,
        success: function (data) {
            if (data.Verificador) {
                alert(data.Mensaje);
                location.reload();
            }
            if (data.Verificador == false) {
                alert(data.Mensaje);
            }
            if (data == -666) {
                alert("Debe Ingresar Campos Obligatorios");
            }
        }
    });
}







var MensajeDisofi = [[
    {
        "Codigo": "ACHD010090",
        "Descripcion": null,
        "PrecioUnitario": 880.0,
        "PrecioUnitarioConDescuento": 880.0,
        "Cantidad": 1.0,
        "Stock": 0.0,
        "UnidadMedida": null,
        "Descuentos": null,
        "DescuentoAtributo": 0.0,
        "SubTotal": 880.0,
        "SubTotalConDescuento": 880.0, "Total": 880.0, "ValorDescuentoAtributo": 0.0, "Talla": null, "Color": null
    }
]
]


MensajeDisofi: "paso1 - paso2 - paso3 - paso4 - serializado: [[{"Codigo":"AGAM120090","Descripcion":null,"PrecioUnitario":10560.0,"PrecioUnitarioConDescuento":10560.0,"Cantidad":1.0,"Stock":0.0,"UnidadMedida":null,"Descuentos":null,"DescuentoAtributo":0.0,"SubTotal":10560.0,"SubTotalConDescuento":10560.0,"Total":10560.0,"ValorDescuentoAtributo":0.0,"Talla":null,"Color":null}]] - serializado: null - ERROR: Referencia a objeto no establecida como instancia de un objeto."
MensajeSoftland: null