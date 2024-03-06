package servlets;

import connection.FactoryProvider;
import dao.CategoryDao;
import dao.ProductDao;
import entities.Category;
import entities.Product;
import java.io.File;
import java.io.FileInputStream;
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

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String op = request.getParameter("operation");
            if (op.trim().equals("addcategory")) {
                // add category
                // recupérer les données du catégorie
                String titreCategorie = request.getParameter("catTitle");
                String descriptionCategorie = request.getParameter("catDesc");

                Category category = new Category();
                category.setCategoryTitle(titreCategorie);
                category.setCategoryDesc(titreCategorie);

                // add category to db
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

//                out.println("Catégorie enregistrée");
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Catégorie" + catId + "enregistrée avec succée");
                response.sendRedirect("admin.jsp");
                return;
            } else if (op.trim().equals("addproduct")) {
                // add product
                // recupérer les données du produit
                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDesc");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("pPic");

                Product product = new Product();
                product.setpName(pName);
                product.setpDesc(pDesc);
                product.setpPrice(pPrice);
                product.setpDiscount(pDiscount);
                product.setpQuantity(pQuantity);
                product.setpPhoto(part.getSubmittedFileName());

                // get category by id
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                Category category = categoryDao.getCategoryById(catId);

                // set product category
                product.setCategory(category);

                // product save...
                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                productDao.saveProduct(product);

                // image upload
                
                // find the path to upload image
                String path = request.getRealPath("img")+File.separator+"products"+File.separator+part.getSubmittedFileName();
                System.out.println(path);
                
                try {
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();

                    // reading data
                    byte[] data = new byte[is.available()];
                    is.read(data);

                    fos.write(data);
                    fos.close();
                }catch(Exception e) {
                   e.printStackTrace();
                }
                
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Produit enregistrée avec succée");
                response.sendRedirect("admin.jsp");
                return;

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
