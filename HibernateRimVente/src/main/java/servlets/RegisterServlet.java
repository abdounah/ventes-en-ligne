package servlets;

import connection.FactoryProvider;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try {
                String userName = request.getParameter("nom");
                String userEmail = request.getParameter("email");
                String userPassword = request.getParameter("password");
                String userTelephone = request.getParameter("tel");
                String userAddresse = request.getParameter("addresse");
                
                // Validations
                if(userName.isEmpty()) {
                    out.println("Name is empty");
                    return;
                }
                
                // Creating user object to store data 
                User user = new  User(userName, userEmail, userPassword, userTelephone, "default.jpg", userAddresse, "normal");
                
                Session hibernateSession = FactoryProvider.getFactory().openSession();
                
                Transaction tx = hibernateSession.beginTransaction();
                
                int userId = (int) hibernateSession.save(user);
                
                tx.commit();
                hibernateSession.close();
                
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "L'enregistrement terminée avec succées, l'ID = "+userId);
                response.sendRedirect("register.jsp");
                return;
            }catch(Exception e) {
                e.printStackTrace();
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
