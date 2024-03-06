package dao;

import java.util.List;

import org.hibernate.SessionFactory;



import entities.Cart;
import entities.CartLine;
//import net.kzn.shoppingbackend.dto.OrderDetail;

public class CartLineDAOImpl {

    private SessionFactory factory;
    
    public CartLine getByCartAndProduct(int cartId, int productId) {
        String query = "FROM CartLine WHERE cartId = :cartId AND product.pId = :productId";
        try {

            return factory.getCurrentSession()
                    .createQuery(query, CartLine.class)
                    .setParameter("cartId", cartId)
                    .setParameter("productId", productId)
                    .getSingleResult();

        } catch (Exception ex) {
            return null;
        }

    }

    
    public boolean add(CartLine cartLine) {
        try {
            factory.getCurrentSession().persist(cartLine);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    
    public boolean update(CartLine cartLine) {
        try {
            factory.getCurrentSession().update(cartLine);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    
    public boolean remove(CartLine cartLine) {
        try {
            factory.getCurrentSession().delete(cartLine);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    
    public List<CartLine> list(int cartId) {
        String query = "FROM CartLine WHERE cartId = :cartId";
        return factory.getCurrentSession()
                .createQuery(query, CartLine.class)
                .setParameter("cartId", cartId)
                .getResultList();
    }

    public CartLine get(int id) {
        return factory.getCurrentSession().get(CartLine.class, Integer.valueOf(id));
    }

   
    public boolean updateCart(Cart cart) {
        try {
            factory.getCurrentSession().update(cart);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    
    public List<CartLine> listAvailable(int cartId) {
        String query = "FROM CartLine WHERE cartId = :cartId AND available = :available";
        return factory.getCurrentSession()
                .createQuery(query, CartLine.class)
                .setParameter("cartId", cartId)
                .setParameter("available", true)
                .getResultList();
    }

   
//    public boolean addOrderDetail(OrderDetail orderDetail) {
//        try {
//            factory.getCurrentSession().persist(orderDetail);
//            return true;
//        } catch (Exception ex) {
//            return false;
//        }
//    }

}
