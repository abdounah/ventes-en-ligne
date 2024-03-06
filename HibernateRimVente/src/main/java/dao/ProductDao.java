package dao;

import entities.Cart;
import entities.Product;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product product) {
        boolean isSaved = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(product);

            tx.commit();
            session.close();

            isSaved = true;

        } catch (Exception e) {
            e.printStackTrace();
            isSaved = false;
        }
        return isSaved;
    }

    public List<Product> getAllProducts() {
        Session session = this.factory.openSession();
        Query query = session.createQuery("FROM Product");
        List<Product> list = query.list();

        return list;

    }

    public List<Product> getProductsByCategory(int cId) {
        Session session = this.factory.openSession();
        Query query = session.createQuery("FROM Product AS p WHERE p.category.categoryId =: id");
        query.setParameter("id", cId);
        List<Product> list = query.list();

        return list;

    }

    public int getTotalNumbersOfProducts() {
        int totalNumbersOfProducts = 0;

        try (Session session = this.factory.openSession()) { // Use try-with-resources for automatic session closure
            String query = "SELECT COUNT(*) FROM Product"; // Use COUNT(*) to get the count
            Query q = session.createQuery(query);

            // Get the count as a Long
            Long count = (Long) q.uniqueResult();
            totalNumbersOfProducts = count.intValue(); // Convert Long to int
        } catch (Exception e) {
            // Handle the exception appropriately, e.g., log it or throw a custom exception
            e.printStackTrace(); // Replace with appropriate error handling
        }

        return totalNumbersOfProducts;
    }

    public Product get(int productId) {
        try {
            return factory
                    .getCurrentSession()
                    .get(Product.class, Integer.valueOf(productId));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
