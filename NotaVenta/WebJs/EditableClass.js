class EditableClass {
    constructor(document, id, tipo, opciones) {
        this.id = id;
        opciones = (opciones === null || opciones === undefined)
            ? opciones = {
                textoVacio: "Seleccione",
                desactivar: false
            }
            : opciones;

        opciones = {
            textoVacio: (opciones.textoVacio === null || opciones.textoVacio === undefined) ? "Seleccione" : opciones.textoVacio,
            desactivar: (opciones.desactivar === null || opciones.desactivar === undefined) ? false : opciones.desactivar,
            fuenteDatos: (opciones.fuenteDatos === null || opciones.fuenteDatos === undefined) ? [] : opciones.fuenteDatos
        }

        if (parseInt(tipo) === parseInt(TiposEditable.Texto)) {
            $('#' + id).editable({
                emptytext: opciones.textoVacio,
            });
        }
        else if (parseInt(tipo) === parseInt(TiposEditable.Select2)) {
            $('#' + id).editable({
                emptytext: opciones.textoVacio,
                source: opciones.fuenteDatos,
                select2: opciones.select2
            });
        }

        if (opciones.desactivar) {
            this.desactivar();
        }
    }
    setTextoVacio(texto) {
        $('#' + this.id).editable({
            emptytext: texto,
        });
    }
    setValor(valor) {
        $('#' + this.id).editable('setValue', valor);
    }
    getValor() {
        return $('#' + this.id).editable('getValue')[this.id];
    }
    desactivar() {
        $('#' + this.id).editable('toggleDisabled');
    }
}

var TiposEditable = {
    Texto: 1,
    Select2: 2
}