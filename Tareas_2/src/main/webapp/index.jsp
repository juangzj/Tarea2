	
<!-- Inclución de la plantilla de header -->
<%@include file= "templates/header.jsp" %>
<head>
      
<section class="vh-100" style="background-color: #cccccc;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-xl-10">
                <div class="card" style="border-radius: 1rem;">
                    <div class="row g-0">
                        <div class="col-md-6 col-lg-5 d-none d-md-block">
                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img1.webp"
                                 alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
                        </div>
                        <div class="col-md-6 col-lg-7 d-flex align-items-center">
                            <div class="card-body p-4 p-lg-5 text-black">

                                <form action="SvLogin" method="POST" >

                                    <div class="d-flex align-items-center mb-3 pb-1">
                                        <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                                        <span class="h1 fw-bold mb-0">Tareas</span>
                                    </div>

                                    <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Ingresa a tu cuenta</h5>

                                    <div class="form-outline mb-4">
                                        
                                        <input id="cedula" name="cedula" type="text" class="form-control space-narrow" placeholder="Número de cédula" maxlength="10" required pattern="[0-9]+" title="Por favor, ingrese solo números">
                                    </div>

                                    <div class="form-outline mb-4">
                                      
                                    <input id="contrasenia" name="contrasenia" type="password" class="form-control space-narrow" placeholder="Contraseña" required>
                                
                                    </div>

                                    <div class="pt-1 mb-4">
                                        <button class="btn btn-dark btn-lg btn-block" type="submit">Iniciar sesion</button>
                                    </div>
                                    
                                    <div class="social d-flex justify-content-center">
                                    <!-- Link con estilo de botón para registrar un nuevo usuario -->
                                    <a href="#" class="py-2 ml-md-1 rounded btn-narrow" data-bs-toggle="modal" data-bs-target="#registrarUsuario" style="color: #393f81;">Registrate aquí</a>
                                </div>

                                    
                                   
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ventana Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Registro de nuevo usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="tarea-details">
                    <form action="SvTarea" method="POST"  > 
                        <!-- Input para el nombre-->
                        <div class="input-group mb-3">
                            <label class="input-group-text" for="nombre">Nombre:</label>
                            <input type="text" name ="nombre" class="form-control" required>
                        </div>    
                        <!-- Input para cedula-->
                        <div class="input-group mb-3">
                            <label class="input-group-text" for="cedula">Cedula:</label>
                            <input type="text" name ="cedula" class="form-control" required>
                        </div> 
                        <!-- Input para contraseña-->
                        <div class="input-group mb-3">
                            <label class="input-group-text" for="contrasenia">Contraseña:</label>
                            <input type="password" name ="contrasenia" class="form-control" required>
                        </div>    
                        <!-- Boton para agregar perros --> 
                        <input type="submit" value="Crear usuario" class ="form-control"/>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

   
    <%
        // Llama al atributo existente
        String existente = (String) request.getAttribute("existente");

        // Evalua si la variable existente es igual a "verdadero"
        if (existente != null && existente.equals("verdadero")) {
    %>
    <script>
        <!-- Si la condición se cumple llama a la función usuarioVerificado() para mostrar el modal correspondiente -->
        $(document).ready(function () {
            usuarioVerificado();
        });
    </script>
    <%    }
        if (existente != null && existente.equals("falso")) {
    %>
    <script>
        <!-- Si la condición se cumple llama a la función cedulaExistente() para mostrar el modal correspondiente -->
        $(document).ready(function () {
            cedulaExistente();
        });
    </script>
    <%
        }
        String noExistente = request.getParameter("noExistente");

        // Evalua si la variable noExistente es igual a "false"
        if (noExistente != null && noExistente.equals("false")) {
    %>
    <script>
        <!-- Si la condición se cumple llama a la función usuarioSinVerificar() para mostrar el modal correspondiente -->
        $(document).ready(function () {
            usuarioSinVerificar();
        });
    </script>
    <%
        }
        // Limpiar los atributos de la solicitud
        request.removeAttribute("existente");
        request.removeAttribute("noExistente");
    %>

        <!-------------------------------------------- VENTANAS MODALES ------------------------------------------------->

        <!-- Modal que se muestra si el usuario desea registrarse -->

        <div class="modal fade" id="registrarUsuario" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <!-- Acción que conecta con el servlet llamado SvUsuario por metodo POST -->
            <form action="SvUsuario" method="POST">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="registrarUsuarioLabel">Regístrate aquí</h1>
                        </div>
                        <div class="modal-body" style="z-index: 1050;">
                            <div class="form-outline mb-4">
                                <input classtype="text" id="cedula" name="cedula" class="form-control" style="background-color: rgba(128, 128, 128, 0.8); color: black;" maxlength="10" required pattern="[0-9]+" title="Por favor, ingrese solo números">
                                <label class="form-label" for="cedula">Número de cédula</label>
                            </div>

                            <div class="form-outline mb-4">
                                <input type="text" id="nombre" name="nombre" class="form-control" style="background-color: rgba(128, 128, 128, 0.8);" required >
                                <label class="form-label" for="nombre">Nombre</label>
                            </div>

                            <div class="form-outline mb-4";">
                                <input type="password" id="contrasenia" name="contrasenia" class="form-control" style="background-color: rgba(128, 128, 128, 0.8);" required >
                                <label class="form-label" for="contrasenia">Contraseña</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Registrar Usuario</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Modal para informar al usuario que los datos se registraron correctamente-->
        <div class="modal fade" id="usuarioRegistrado" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="registradoLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center align-middle">
                        <h4 align="center">Usuario registrado correctamente</h4>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal que se muestra en caso de que los datos para iniciar sesión no sean validos -->
        <div class="modal fade" id="usuarioNoRegistrado" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="usuarioNoRegistradoLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center align-middle">
                        <h2>Los datos ingresados no son correctos</h2>
                        <p>Por favor verifique la información</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal que se muestra en caso de que la cédula que el usuario intente ingresar ya este en el sistema -->
        <div class="modal fade" id="mensajeAlerta" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="mensajeAlertaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center align-middle">
                        <h2>Datos no validos</h2>
                        <p>La cédula que intenta ingresar ya esta registrada, por favor verifique la información</p>
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

        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

        <!-- Inclución de la plantilla de footer -->
        <%@include file= "templates/footer.jsp" %>