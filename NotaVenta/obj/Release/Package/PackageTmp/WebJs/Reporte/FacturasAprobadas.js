$(document).ready(function () {
});

function aprobarNW(nvnumero) {
    console.log(nvnumero);

    $("#nvnumero").val(nvnumero);
    var url = $("#urlFacturasPendientes").val();

    var data = {
        NVNumero: nvnumero
    };

    console.log(data);
    debugger
    $.post(url, data).done(function (data) {
        confirm("Numero Nota de Venta:\n" + data[0].NVNumero);
        debugger
    });
}