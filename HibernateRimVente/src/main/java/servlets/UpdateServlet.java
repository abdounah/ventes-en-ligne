package servlets;

import connection.FactoryProvider;
import dao.CategoryDao;
import entities.Category;
import entities.Product;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;

@MultipartConfig
public class UpdateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int pId = Integer.parseInt(request.getParameter("pId").trim());
            String pName = request.getParameter("pName");
            String pDesc = request.getParameter("pDesc");
            int pPrice = Integer.parseInt(request.getParameter("pPrice"));
            int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
            int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
            int catId = Integer.parseInt(request.getParameter("catId"));
            Part part = request.getPart("pPic");

            // get category by id
            CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
            Category category = categoryDao.getCategoryById(catId);

            Session s = FactoryProvider.getFactory().openSession();
            Transaction tx = s.beginTransaction();

            Product product = s.get(Product.class, pId);

            product.setpName(pName);
            product.setpDesc(pDesc);
            product.setpPrice(pPrice);
            product.setpDiscount(pDiscount);
            product.setpQuantity(pQuantity);
            product.setpPhoto(part.getSubmittedFileName());

            tx.commit();
            s.close();

            // find the path to upload image
            String path = request.getRealPath("img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
            System.out.println(path);

            try {
                FileOutputStream fos = new FileOutputStream(path);
                InputStream is = part.getInputStream();

                // reading data
                byte[] data = new byte[is.available()];
                is.read(data);

                fos.write(data);
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("message", "Produit modifier avec succée");
            response.sendRedirect("index.jsp");
            return;
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
