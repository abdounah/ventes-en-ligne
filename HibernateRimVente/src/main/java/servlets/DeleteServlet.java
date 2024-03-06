package servlets;

import connection.FactoryProvider;
import entities.Product;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class DeleteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try {
                int pId = Integer.parseInt(request.getParameter("pId").trim());

                Session s = FactoryProvider.getFactory().openSession();
                Transaction tx = s.beginTransaction();
                
                Product product = (Product) s.get(Product.class, pId);
                s.delete(product);
                tx.commit();
                s.close();
                
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("messages", "Produit supprimer avec sucess...");
                response.sendRedirect("index.jsp");
            } catch (Exception e) {
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
