<%@page import="dao.ProductDao"%>
<%@page import="dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="entities.Category"%>
<%@page import="connection.FactoryProvider"%>
<%@page import="dao.CategoryDao"%>
<%@page import="entities.User"%>
<%
    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("message", "Tu es n'est pas connecté !");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "Tu es n'est pas admin !");
            response.sendRedirect("login.jsp");
            return;
        }
    }
    UserDao uDao = new UserDao(FactoryProvider.getFactory());
    CategoryDao cDao2 = new CategoryDao(FactoryProvider.getFactory());
    ProductDao pDao2 = new ProductDao(FactoryProvider.getFactory());
    
    int totalNumbersOfUsersNormal = uDao.getTotalNumbersOfUsersNormal();
    int totalNumbersOfCategories = cDao2.getTotalNumbersOfCategories();
    int totalNumbersOfProducts = pDao2.getTotalNumbersOfProducts();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIMVente - Admin</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            .admin .card:hover {
                background: #e2e2e2;
                cursor: pointer;
            }
        </style>
    </head>

    <body style="padding-top: 30px;">
        <%@include file="components/navbar.jsp" %>
        <div class="container admin" style="margin-top: 30px;">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>
            <!-- first row -->
            <div class="row mt-3">
                <div class="col-md-4">
                    <div class="card" style="border: 1px solid #2196f3;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 135px" class="img-fluid rounded-circle" src="img/team.png" alt="users_icon">
                            </div>
                            <h1><%= totalNumbersOfUsersNormal %></h1>
                            <h1 class="text-uppercase text-muted ">Les clients</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="border: 1px solid #2196f3;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 135px" class="img-fluid rounded-circle" src="img/options.png" alt="users_icon">
                            </div>
                            <h1><%= totalNumbersOfCategories %></h1>
                            <h1 class="text-uppercase text-muted ">Les catégories</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="border: 1px solid #2196f3;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 135px" class="img-fluid rounded-circle" src="img/responsive.png" alt="users_icon">
                            </div>
                            <h1><%= totalNumbersOfProducts %></h1>
                            <h1 class="text-uppercase text-muted">Les produits</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!-- second row -->
            <div class="row mt-3">
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal" style="border: 1px solid #2196f3;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 135px" class="img-fluid rounded-circle" src="img/plus.png" alt="users_icon">
                            </div>
                            <h1 class="text-uppercase text-muted">Ajouter une catégorie</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal" style="border: 1px solid #2196f3;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 135px" class="img-fluid rounded-circle" src="img/plus.png" alt="users_icon">
                            </div>
                            <h1 class="text-uppercase text-muted">Ajouter un produit</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- add category modal -->

        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header text-white" style="background: #2196f3;">
                        <h5 class="modal-title" id="exampleModalLabel">L'ajout d'une catégorie</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type='hidden' name='operation' value="addcategory" />
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="nom catégorie" required/>
                            </div>
                            <div class="form-group">
                                <textarea style="height: 300px;" class="form-control" name="catDesc" placeholder="description" required></textarea>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Ajouter</button>
                                <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Fermer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- end category modal -->

        <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
        
        <!-- Start Product modal -->

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">L'ajout d'un produit</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type='hidden' name='operation' value="addproduct" />
                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="nom produit" required/>
                            </div>
                            <div class="form-group">
                                <textarea style="height: 120px;" class="form-control" name="pDesc" placeholder="description" required></textarea>
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="prix" required/>
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="remise" required/>
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="quantité" required/>
                            </div>
                            
                            <%
                                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> list = cDao.getCategories();
                            %>
                            
                            <div class="form-group">
                                <select name="catId" class="form-control" id=''>
                                    <%
                                        for(Category c:list) {
                                    %>
                                    <option value="<%= c.getCategoryId() %>">
                                        <%= c.getCategoryTitle() %>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            
                            
                            <div class="form-group">
                                <label for="pPic">Choissisez une image</label><br>
                                <input type="file" id='pPic' class="form-control" name="pPic" required/>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Ajouter</button>
                                <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Fermer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Product modal -->
    </body>
</html>
