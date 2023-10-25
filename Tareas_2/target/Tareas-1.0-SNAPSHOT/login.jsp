
<%@page import="com.mycompany.mundo.Archivos"%>
<%@page import="com.mycompany.mundo.Usuario"%>
<%@page import="com.mycompany.mundo.ListasEnlazadas"%>

<!-- Inclución de la plantilla de header -->
<%@include file= "templates/header.jsp" %>

<% String nombreUsuario = request.getParameter("usuarioNombre");%>

<body >
    <!-- Clase contenedora -->
    <div class="container p-4">
        <div class="row">
            <nav class="navbar navbar-expand-lg bg-body-tertiary" style="margin-bottom: 20px;">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">Bienvenido</a>
                    <div>
                    <h3 align="center"><%out.println(request.getParameter("usuarioNombre"));%></h3>
                    
                </div>
                    
                    <!-- Navbar-->
                    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <li>
                                <center>
                                   <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                        <a href="index.jsp">cerrar sesion</a>

                                    </div>
                                </center>
                        </li>

                    </ul>
                    </li>
                    </ul>
                </div>
            </nav><!-- Cierre de etiqueta nav -->

           
            <!-- Columna izquierda para el formulario -->
            <br><div class="col-lg-4 col-md-4"> <!-- Clase de división en cuatro columnas -->
                <div class="card card-body"> <!-- Tarjeta de trabajo -->
                    <h3>Agregar tarea</h3> <!-- Titulo del formulario para agregar una tarea -->
                    <!-- Formulario que recibe todos los datos para agregar una tarea -->
                    <form action="SvTareas" method="POST">
                        <input type="hidden" name="usuarioNombre" type="text" value="<%= nombreUsuario%>">
                        <div class="col-auto">
                            <label class="visually-hidden">Id</label>
                            <div class="input-group">
                                <div class="input-group-text">Id</div>
                                <input id="id" name="id" type="text" class="form-control" required>
                            </div>
                        </div>

                        <br><div class="col-auto">
                            <label class="visually-hidden">Título</label>
                            <div class="input-group">
                                <div class="input-group-text">Título</div>
                                <input id="titulo" name="titulo" type="text" class="form-control" required>
                            </div>
                        </div>

                        <br><div class="col-auto">
                            <label class="visually-hidden">Descripción</label>
                            <div class="input-group">
                                <div class="input-group-text">Descripción</div>
                                <textarea id="descripcion" name="descripcion" type="text" class="form-control" required></textarea>
                            </div>
                        </div>

                        <br><div class="col-auto">
                            <label class="visually-hidden">Fecha</label>
                            <div class="input-group">
                                <div class="input-group-text">Fecha</div>
                                <input id="fecha" name="fecha" type="date" class="form-control" required>
                            </div>
                        </div>

                        <!-- Botón que permite mostrar las opciones para agregar una tarea -->
                        <br><button id="agregarTareaBtn" type="button" class="btn btn-success">Agregar tarea</button>

                        <div id="radioButtonsContainer" style="display: none;">
                            <!-- Radio buttons para elegir la posición de la tarea -->

                            <div class="form-check" style="margin-bottom: 10px">
                                <input type="radio" name="posicion" id="inicio" value="inicio" class="form-check-input" required>
                                <label for="inicio" class="form-check-label">Al inicio</label>
                            </div>

                            <div class="form-check d-flex" style="max-width: 500px;">
                                <input type="radio" name="posicion" id="antes" value="antes" class="form-check-input" required>
                                <label for="antes" class="form-check-label" style="margin-right: 42px; white-space: nowrap;"> Anterior a una tarea</label>

                                <!-- Input para ID Anterior (deshabilitado inicialmente) -->
                                <div class="input-group" style="max-width: 200px;">
                                    <input id="idAnterior" name="idAnterior" type="text" class="form-control" disabled placeholder="ID anterior">
                                </div>
                            </div>

                            <div class="form-check d-flex" style="max-width: 500px;">
                                <input type="radio" name="posicion" id="despues" value="despues" class="form-check-input" required>
                                <label for="despues" class="form-check-label" style="margin-right: 30px; white-space: nowrap;"> Después de una tarea</label>

                                <!-- Input para ID Siguiente (deshabilitado inicialmente) -->
                                <div class="input-group" style="max-width: 200px;">
                                    <input id="idSiguiente" name="idSiguiente" type="text" class="form-control" disabled placeholder="ID siguiente">
                                </div>
                            </div>

                            <div class="form-check">
                                <input type="radio" name="posicion" id="final" value="final" class="form-check-input" required>
                                <label for="final" class="form-check-label">Al final</label>
                            </div>
                            <center><button id="agregarTareaFinalBtn" type="submit" class="btn btn-success" style="display: none; margin-top: 15px;">Agregar Tarea</button></center>
                        </div>
                    </form>
                </div> <!-- Cierre de la clase card card-body -->
            </div> <!-- Cierre de la clase col-lg-4 col-md-4 -->

            <!---------------------------------------- Verificación de ID -------------------------------------------->
            <%
                String idVerificado = request.getParameter("idVerificado");
                if (idVerificado != null && idVerificado.equals("false")) {
            %>
            <!-- Método que permite mostrar el modal que informa que ya existe el ID en la lista -->
            <script>
                $(document).ready(function () {
                    idExistente();
                });
            </script>
            <%
                }
                if (idVerificado != null && idVerificado.equals("error")) {
            %>
            <!-- Método que permite mostrar el modal que informa que el ID no es valido -->
            <script>
                $(document).ready(function () {
                    idNoValido();
                });
            </script>
            <%
                }
                request.removeAttribute("idVerificado");
            %>

            <!-- Columna del lado derecho para la tabla de datos -->
            <div class="col-lg-8 col-md-8">
                <div class="card card-body"> <!-- Tarjeta de trabajo -->
                    <table class="table table-striped table-hover"> <!-- Estilo de la tabla de datos -->
                        <thead>
                            <tr>
                                <!-- Titulos de la tabla de datos -->
                                <th>Id</th>
                                <th>Título</th>
                                <th>Descripción</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>  
                            <%
                                String inputId = request.getParameter("buscar");  // Obtén el ID de búsqueda
                                ListasEnlazadas listaEnlazada = new ListasEnlazadas();
                                ServletContext context = getServletContext();

                                listaEnlazada = Archivos.leerArchivoTareas(context);

                                if (listaEnlazada == null) {
                                    listaEnlazada = new ListasEnlazadas();
                                }

                                String tablaTareas = "";

                                if (inputId != null && !inputId.isEmpty()) {
                                    // Si se proporciona un ID, genera una tabla de tareas filtrada por ese ID
                                    tablaTareas = listaEnlazada.generarTablaBusqueda(inputId);
                                } else {
                                    // Si no se proporciona un ID, genera la tabla de todas las tareas
                                    tablaTareas = listaEnlazada.MostrarLista();
                                }
                                out.println(tablaTareas);  // Imprime la tabla de tareas
                            %>
                        </tbody>
                    </table> <!-- Cierre de la etiqueta table-->
                </div> <!-- Cierre de la clase card card-body -->
            </div> <!-- Cierre de la clase col-lg-8 col-md-8 -->
        </div>
    </div>           

    <!-- Modal de confirmación para eliminar tarea -->
    <div class="modal fade" id="eliminar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="eliminarLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <h4 align="center">¿Estás seguro de que deseas eliminar esta tarea?</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" style="margin-right: 10px;">Cancelar</button>
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModalConfirm" onclick="eliminarTarea(1)">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <!------------------------------------------ Modales para editar las caracteristicas ---------------------------------------------->

    <!-- Modal principal para editar las caracteristicas de una tarea -->
    <div class="modal fade" id="editModalConfirm" tabindex="-1" aria-labelledby="editModalLabelConfirm" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabelConfirm">Editar información de la tarea</h5>
                </div>
                <div class="modal-body">
                    <div id="editModalConfirm" style="display: flex; justify-content: center;">
                        <button href="#" type="button" class="btn btn-success" data-bs-toggle="modal" style="margin-right: 15px;" data-bs-target="#editTitulo" >Editar título</button>
                        <button href="#" type="button" class="btn btn-success" data-bs-toggle="modal" style="margin-right: 15px;" data-bs-target="#editDescripcion" >Editar descripción</button>
                        <button href="#" type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editFecha" >Editar Fecha</button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="margin-right: 10px;">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para editar el titulo la tarea -->
    <div class="modal fade" id="editTitulo" tabindex="-1" role="dialog" aria-labelledby="editTituloLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form id="miFormularioTitulo">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editTituloLabel">Editar titulo</></h5>
                    </div>
                    <div class="modal-body">
                        <div id="tarea-detalles" style="display: flex; justify-content: center;">
                            <label class="visually-hidden" for="descripcion">Titulo</label>
                            <div class="input-group">
                                <div class="input-group-text">Ingresa el nuevo título:</div>
                                <input type="text" class="form-control" id="nuevoTitulo" name="titulo" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModalConfirm" style="margin-right: 10px;">Cancelar</button>
                        <button type="submit" class="btn btn-danger" onclick="editarCaracteristicas('nuevoTitulo')">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal para editar la descripción de la tarea -->
    <div class="modal fade" id="editDescripcion" tabindex="-1" aria-labelledby="editDescripcionLabelConfirm" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form id="miFormularioDescripcion">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editDescripcionLabelConfirm">Editar descripción</span></h5>
                    </div>
                    <div class="modal-body">
                        <div id="tarea-detalles" style="display: flex; justify-content: center;">
                            <label class="visually-hidden" for="descripcion">Descripción</label>
                            <div class="input-group">
                                <div class="input-group-text">Ingresa la nueva descripción:</div>
                                <textarea type="text" class="form-control" id="nuevaDescripcion" name="descripcion" required></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModalConfirm" style="margin-right: 10px;">Cancelar</button>
                        <button type="submit" class="btn btn-danger" onclick="editarCaracteristicas('miFormularioDescripcion')">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal para editar la fecha de la tarea -->
    <div class="modal fade" id="editFecha" tabindex="-1" aria-labelledby="editFechaLabelConfirm" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form id="miFormularioFecha" >
                    <div class="modal-header">
                        <h5 class="modal-title" id="editFechaLabelConfirm">Editar foto</span></h5>
                    </div>
                    <div class="modal-body">
                        <div id="tarea-detalles" style="display: flex; justify-content: center;">
                            <label class="visually-hidden" for="fecha">Fecha</label>
                            <div class="input-group">
                                <div class="input-group-text">Ingresa la nueva fecha:</div>
                                <input type="date" class="form-control" id="nuevaFecha" name="nuevaFecha" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModalConfirm" style="margin-right: 10px;">Cancelar</button>
                        <button type="submit" class="btn btn-danger" onclick="editarCaracteristicas('miFormularioFecha')">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal que se muestra en caso de que el ID de la tarea ya este en el sistema -->
    <div class="modal fade" id="modalError" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalErrorLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center align-middle">
                    <h2>Datos no validos</h2>
                    <p>El ID que intenta ingresar ya se encuentra registrado, por favor verifique la información</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalErrorReferencia" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalErrorReferenciaLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center align-middle">
                    <h2>Datos no validos</h2>
                    <p>El ID de referencia no es valido, por favor verifique la información</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Inclución de las funciones que se encuentran en el script -->
    <script>
        <%@include file= "scripts/script.js" %>
    </script>  

    <!-- Inclución del css -->
    <link rel="stylesheet" href="css/css.css">

    <!-- Inclución de la plantilla de footer -->
    <%@include file= "templates/footer.jsp" %>