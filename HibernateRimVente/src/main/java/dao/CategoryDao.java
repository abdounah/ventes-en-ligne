package dao;

import entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public int saveCategory(Category cat) {
        Session openSession = this.factory.openSession();       
        Transaction beginTransaction = openSession.beginTransaction();        
        int catId = (int)openSession.save(cat);       
        beginTransaction.commit();        
        openSession.close();
        
        return catId;
    }
    
    public List<Category> getCategories() {
        Session s = this.factory.openSession();
        Query createQuery = s.createQuery("FROM Category");
        List<Category> list = createQuery.list();
        return list;
    }
    
    public Category getCategoryById(int catId) {
        Category cat = null;
        try {
            Session openSession = this.factory.openSession();
            cat = openSession.get(Category.class, catId);
            openSession.close();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return cat;
    }
    
    public int getTotalNumbersOfCategories() {
        int totalNumbersOfCategories = 0;

        try (Session session = this.factory.openSession()) { // Use try-with-resources for automatic session closure
            String query = "SELECT COUNT(*) FROM Category"; // Use COUNT(*) to get the count
            Query q = session.createQuery(query);

            // Get the count as a Long
            Long count = (Long) q.uniqueResult();
            totalNumbersOfCategories = count.intValue(); // Convert Long to int
        } catch (Exception e) {
            // Handle the exception appropriately, e.g., log it or throw a custom exception
            e.printStackTrace(); // Replace with appropriate error handling
        }

        return totalNumbersOfCategories;
    }
}
