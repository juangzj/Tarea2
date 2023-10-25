/**
 * Variable global utilizada para almacenar temporalmente el id de la tarea
 * que se mostrará en el modal de confirmación antes de eliminarlo.
 */
var id = "";

/**
 * Esta función se encarga de mostrar el modal de confirmación antes de eliminar una tarea.
 * Se dispara cuando se muestra el modal.
 */
$('#eliminar').on('show.bs.modal', function (event) {
    // Obtiene el botón que desencadenó el evento de mostrar el modal
    var button = $(event.relatedTarget);

    // Obtiene el id de la tarea desde el atributo 'data-nombre' del botón
    var idTarea = button.data('nombre');

    console.log("idTarea");
    // Obtiene el modal actual
    var modal = $(this);

    // Almacena el nombre de la tarea en la variable global 'id'
    id = idTarea;

});

/**
 * Esta función se encarga de eliminar una tarea a través de una solicitud AJAX al servidor.
 */
function eliminarTarea() {

    // Obtiene el id de la tarea desde una variable previamente definida (id)
    var idTarea = id;

    // Realiza una solicitud AJAX al servlet 'SvEliminar' para eliminar la solicitud
    $.ajax({
        url: 'SvTareas?id=' + idTarea, // URL del servlet con el parámetro 'id' para la eliminación
        method: 'GET', // Método HTTP utilizado para la solicitud (GET en este caso)
        success: function (data) {
            // En caso de éxito en la solicitud:

            // Cierra el modal de eliminación
            $('#eliminar').modal('hide');

            // Recarga la página actual para reflejar los cambios
            location.reload();
        },
        error: function () {
            // En caso de error en la solicitud:

            // Registra un mensaje de error en la consola (para fines de depuración)
            console.log('Error al eliminar la tarea');
        }
    });
}

/**
 * Función que muestra el modal llamado usuarioRegistrado
 */
function usuarioVerificado() {
    $("#usuarioRegistrado").modal("show");
}

/**
 * Función que muestra el modal llamado usuarioNoRegistrado
 */
function usuarioSinVerificar() {
    $("#usuarioNoRegistrado").modal("show");
}

/**
 * Función que muestra el modal llamado mensajeAlerta
 */
function cedulaExistente() {
    $("#mensajeAlerta").modal("show");
}

var idEditar = "";

$('#editModalConfirm').on('show.bs.modal', function (event) {
    // Obtiene el botón que desencadenó el evento de mostrar el modal
    var button = $(event.relatedTarget);

    // Obtiene el id de la tarea desde el atributo 'data-nombre' del botón
    var idTarea = button.data('nombre');

    // Obtiene el modal actual
    var modal = $(this);

    // Almacena el nombre del perro en la variable global 'nombreP'
    idEditar = idTarea;
});

///**
// * Esta función se encarga de editar una tarea a través de una solicitud AJAX al servidor.
// */
function editarCaracteristicas(id) {

    var form = document.getElementById(id);

    // Verificar la validez del formulario
    if (form.checkValidity()) {

        var id = idEditar;

        // Obtener el valor del nuevo título ingresado por el usuario
        var nuevoTitulo = document.getElementById('nuevoTitulo').value || "";

        // Obtener el valor de la nueva descripción ingresada por el usuario
        var nuevaDescripcion = document.getElementById('nuevaDescripcion').value || "";

        // Obtener el valor de la nueva fecha ingresada por el usuario
        var nuevaFecha = document.getElementById('nuevaFecha').value || "";

        // Realiza una solicitud AJAX al servlet 'SvEditar' para editar las características de la tarea
        $.ajax({
            url: 'SvEditar?id=' + id + '&titulo=' + nuevoTitulo + '&descripcion=' + nuevaDescripcion + '&fecha=' + nuevaFecha, // URL con cuatro parámetros: id, titulo, descripcion y fecha
            method: 'GET', // Método HTTP utilizado para la solicitud (POST en este caso)
            success: function (data) {
                // En caso de éxito en la solicitud

                // Recarga la página actual para reflejar los cambios
                location.reload();
            },
            error: function () {
                // En caso de error en la solicitud:

                // Registra un mensaje de error en la consola (para fines de depuración)
                console.log('Error al editar las características de la tarea.');
            }
        });
    } else {
        // Mostrar un mensaje de error o manejar la validación del formulario
        console.log("Error");
    }
}

/**
 * Función que muestra el modal llamado idExistente
 */
function idExistente() {
    $("#modalError").modal("show");
}

/**
 * Función que muestra el modal llamado modalErrorReferencia
 */
function idNoValido() {
    $("#modalErrorReferencia").modal("show");
}

$(document).ready(function () {
    $('#agregarTareaBtn').click(function () {
        $('#agregarTareaBtn').hide();
        $('#radioButtonsContainer').show();
        $('#agregarTareaFinalBtn').show();
    });
});

$(document).ready(function () {
    // Escuchar cambios en la selección de posición
    $('input[name="posicion"]').change(function () {
        if ($(this).val() === "antes") {
            $('#idAnterior').prop('disabled', false);
            $('#idSiguiente').prop('disabled', true);
        } else if ($(this).val() === "despues") {
            $('#idAnterior').prop('disabled', true);
            $('#idSiguiente').prop('disabled', false);
        } else {
            // Al seleccionar otras opciones, deshabilitar ambos campos
            $('#idAnterior').prop('disabled', true);
            $('#idSiguiente').prop('disabled', true);
        }
    });
});

function buscarPor(opcion) {
    var inputId = document.getElementById("inputId").value;
    var buscarPor = opcion;

    // Realiza una solicitud AJAX al servlet para realizar la búsqueda por ID
    $.ajax({
        url: 'SvBuscarOrdenar', // Actualiza la URL al servlet adecuado
        method: 'GET', // Usa el método POST
        data: {
            buscarPor: buscarPor,
            id: inputId
        },
        success: function (data) {
            // En caso de éxito en la solicitud, puedes manejar la respuesta aquí.
            // Por ejemplo, puedes actualizar una tabla con los resultados.
            // Si deseas recargar la página completa, puedes usar:
            location.reload();
        },
        error: function () {
            // En caso de error en la solicitud:
            // Registra un mensaje de error en la consola (para fines de depuración)
            console.log('Error al realizar la búsqueda');
        }
    });
}