package Servlets;

import com.mycompany.mundo.Archivos;
import com.mycompany.mundo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvUsuario", urlPatterns = {"/SvUsuario"})
public class SvUsuario extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvUsuario at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtiene la sesión actual del usuario
        HttpSession session = request.getSession();

        // Obtiene el contexto del servlet
        ServletContext context = getServletContext();

        // Crea una lista para almacenar objetos de tipo Usuario
        ArrayList<Usuario> misUsuarios = new ArrayList<>();

        // Lee la lista de usuarios existentes desde un archivo utilizando una función llamada leerArchivo
        Archivos.leerArchivo(misUsuarios, context);

        // Obtiene los datos del formulario enviados por POST
        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String contrasenia = request.getParameter("contrasenia");

        // Verificar si la cédula ya existe en la lista de usuarios
        boolean cedulaExistente = false;

        // Ciclo for que recorre el ArrayList para verificar si la cédula a registrar ya se encuentra registrada
        for (Usuario existeUsuario : misUsuarios) {
            if (existeUsuario.getCedula() == Integer.parseInt(cedula)) {
                cedulaExistente = true;
                break;
            }
        }

        if (!cedulaExistente) {
            // Si la cédula no existe se agrega un nuevo usuario a la lista
            Usuario usuario = new Usuario(Integer.parseInt(cedula), nombre, contrasenia);
            misUsuarios.add(usuario);

            // Escribe la lista actualizada de usuarios en un archivo utilizando una función llamada escribirArchivo
            Archivos.escribirArchivo(misUsuarios, context);

            // Establecer un atributo en la solicitud para indicar que el usuario fue agregado correctamente
            String existente = "verdadero";
            request.setAttribute("existente", existente);

        } else {
            // La cédula ya existe en la lista de usuarios
            String existente = "falso";
            request.setAttribute("existente", existente);
        }

        // Redirigir la solicitud a la página "index.jsp"
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
