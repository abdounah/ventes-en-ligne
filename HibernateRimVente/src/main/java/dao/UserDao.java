package dao;

import entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class UserDao {

    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    // get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "FROM User WHERE userEmail =: e AND userPassword =: p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);

            user = (User) q.uniqueResult();

            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public int getTotalNumbersOfUsersNormal() {
        int totalNumbersOfUsersNormal = 0;

        try (Session session = this.factory.openSession()) { // Use try-with-resources for automatic session closure
            String query = "SELECT COUNT(*) FROM User WHERE userType = :t"; // Use COUNT(*) to get the count
            Query q = session.createQuery(query);
            q.setParameter("t", "normal");

            // Get the count as a Long
            Long count = (Long) q.uniqueResult();
            totalNumbersOfUsersNormal = count.intValue(); // Convert Long to int
        } catch (Exception e) {
            // Handle the exception appropriately, e.g., log it or throw a custom exception
            e.printStackTrace(); // Replace with appropriate error handling
        }

        return totalNumbersOfUsersNormal;
    }

}
