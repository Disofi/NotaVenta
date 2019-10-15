$(document).ready(function () {
    $("input[switcher]").change(function () {
        var check = estaHabilitadoSwitcher(this.id);
        if (check) {
            $(this).removeAttr("checked");
        }
        else {
            $(this).attr("checked", "");
        }
    });
});

function estaHabilitadoSwitcher(id) {
    var check = $("#" + id).attr("checked");
    if (check !== undefined) {
        return true;
    }
    else {
        return false;
    }
}
function envioDatos() {
    var valor = $('input[name=gender]:checked', '#ff').val();
    $("#valorRadio").val(valor);

    document.getElementById("ff").submit();




    //alert($('input[name=gender]:checked', '#ff').val());
}