package Servlets;

import com.mycompany.mundo.Archivos;
import com.mycompany.mundo.Usuario;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {


    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener el valor de la cédula y la contraseña desde la solicitud HTTP
        int cedula = Integer.parseInt(request.getParameter("cedula"));
        String contrasenia = request.getParameter("contrasenia");

        // Obtener el contexto del servlet 
        ServletContext context = getServletContext();

        // Verificar si el usuario existe utilizando la función verificarUsuario
        String user = verificarUsuario(cedula, contrasenia, context);

        // Si el usuario existe, configurar atributos en la solicitud y redirigir a "login.jsp"
        if (user != null) {
            // request.setAttribute("nombre", user.getNombre());
            request.getRequestDispatcher("login.jsp?usuarioNombre=" + user).forward(request, response);
        } else {
            // Si el usuario no existe, redirigir a "index.jsp" con un parámetro "noExistente"
            request.getRequestDispatcher("index.jsp?noExistente=" + "false").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static String verificarUsuario(int cedulaVerificada, String contraseñaVerificada, ServletContext context) throws IOException {
        ArrayList<Usuario> misUsuarios = new ArrayList<>();

        Archivos.leerArchivo(misUsuarios, context);

        for (Usuario usuario : misUsuarios) {
            if (usuario.getCedula() == cedulaVerificada && usuario.getContrasenia().equals(contraseñaVerificada)) {
                return usuario.getNombre();
            }
        }
        return null;
    }

}
