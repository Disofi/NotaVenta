$(document).ready(function () {
});
function EliminarUsuario(id) {
    var mensaje;
    var _url = $("#urlEliminar").val();
    var opcion = confirm("Desea Eliminar Usuario?");
    if (opcion == true) {
        $.ajax({
            type: 'POST',
            url: _url,
            data: {
                _Id: id,
            },
            success: function (data) {
                alert("El Usuario fue Eliminado");
                location.reload();
            }
        });
    }
    else {
        mensaje = "Has clickado Cancelar";
    }
}