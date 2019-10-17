$(document).ready(function () {
    $("#LoginPrueba").click(function () {
        var nombre = $("#Nombre").val();
        var contrasena = $("#Contrasena").val();
        var urlIndex = $("#urlIndex").val();
        var urlParametros = $("#urlParametros").val();
        $.ajax({
            type: "POST",
            url: "Login/LoginPrueba",
            data: {
                _Nombre: nombre,
                _Contrasena: contrasena
            },
            async: true,
            success: function (data) {
                if (data.Validador == 1) {
                    window.location = urlParametros;
                    //traer url de vista
                }
                if (data.Validador == 2) {
                    window.location = urlIndex;
                    //traer url de vista
                }
                if (data.Validador == 3) {
                    $("#aModalEmpresas").click();

                    $("#ddlEmpresas").find('option').remove().end();

                    $.each(data.empresas, function (index, item) {
                        $("#ddlEmpresas").append('<option value="' + item.IdEmpresa + '">' + item.NombreEmpresa + '</option>');
                    });

                    $("#modalEmpresasAgregar").click(function () {
                        var empresa = $("#ddlEmpresas").val();
                        $.ajax({
                            url: "Login/SeleccionaEmpresa",
                            type: "POST",
                            data: {_IdEmpresa: empresa },
                            async: true,
                            success: function (data) {
                                if (data.Validador = 1) {
                                    alert("Empresa Seleccionada: " + data.NombreEmpresa);
                                    window.location = urlIndex;
                                }
                            }
                        });
                    });
                }
            },
            error: function (a, b, c) {
                console.log(a,b,c);

            }
        });
    });
    $("#modalEmpresasAgregar").click(function () {
        console.log($("#ddlEmpresas").val());
    });
});