package servlets;

import connection.FactoryProvider;
import dao.UserDao;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            // Recupérer les données :
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // Validation
            
            // user authentication
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            
            User user = userDao.getUserByEmailAndPassword(email, password);
            
            HttpSession httpSession = request.getSession();
                
            if(user == null) {
                httpSession.setAttribute("message", "L'email ou password incorrect !!");
                response.sendRedirect("login.jsp");
                return;
            }else {
                out.println("<h1>Welcome " + user.getUserName() + "</h1>");
                
                httpSession.setAttribute("current-user", user);
                
                if(user.getUserType().equals("admin")) {
                    response.sendRedirect("admin.jsp");
                }else if(user.getUserType().equals("normal")) {
                    response.sendRedirect("index.jsp");
                }else {
                    out.println("We have not identified user type yet");
                }
                
            }
            
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
