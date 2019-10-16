$(document).ready(function () {
    $("#tblUsuario").DataTable({
        responsive: true,
        bAutoWidth: true,
        autoWidth: true 
    }); 

    


});

function EliminarUsuario(id, Estado) {
    var mensaje;
    var opcion = confirm("Desea Eliminar Usuario?");
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
    var Usuario = $('#txtUsuario').val();
    var Nombre = $('#txtNombre').val();
    var Contrasena = $('#txtContrasena').val();
    var Email = $('#txtEmail').val();
    var Perfil = $('#Perfil').val();
    var VenCod = $('#CodVendSoft').val();
    var BaseDatos = $('#ListaBaseDatos').val();
    $.ajax({
        type: 'POST',
        url: 'Addusuario',
        data: { _Usuario: Usuario, _Nombre: Nombre, _Contrasena: Contrasena, _Email: Email, _Perfil: Perfil, _VenCod: VenCod, _BaseDatos:BaseDatos },
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
    var CodVend = $("#CodVendSoftMod").val();
    $.ajax({
        url: "Editarusuario",
        type: "POST",
        data: {_Id:id,_Usuario:Usuario,_Nombre:Nombre,_Contrasena:Contrasena,_Email:Email,_Perfil:Perfil,_CodVend:CodVend},
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

