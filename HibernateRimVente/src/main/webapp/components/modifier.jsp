<%@page import="entities.Product"%>
<%@page import="org.hibernate.Session"%>
<%@page import="entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="connection.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIMVente - Modifier</title>
        <%@include file="common_css_js.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body style="padding-top: 26px;">
        <%@include file="navbar.jsp" %>
        <%            int pId = Integer.parseInt(request.getParameter("pId").trim());
            Session s = FactoryProvider.getFactory().openSession();
            Product product = (Product) s.get(Product.class, pId);
        %>
        <div style="margin-top: 35px;" class="container">
            <form  action="../UpdateServlet" method="post" enctype="multipart/form-data">
                <input name="pId" type="hidden"
                       value="<%= product.getpId()%>"/>
                <input type='hidden' name='operation' value="addproduct" />
                <div class="form-group">
                    <input type="text" class="form-control" name="pName" placeholder="nom produit" value="<%= product.getpName()%>" required/>
                </div>
                <div class="form-group">
                    <textarea style="height: 120px;" class="form-control" name="pDesc" placeholder="description" required><%= product.getpDesc()%></textarea>
                </div>
                <div class="form-group">
                    <input type="number" class="form-control" name="pPrice" value="<%= product.getpPrice()%>" placeholder="prix" required/>
                </div>
                <div class="form-group">
                    <input type="number" class="form-control" name="pDiscount" value="<%= product.getpDiscount()%>" placeholder="remise" required/>
                </div>
                <div class="form-group">
                    <input type="number" class="form-control" name="pQuantity" value="<%= product.getpQuantity()%>" placeholder="quantité" required/>
                </div>

                <%
                    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> list = cDao.getCategories();
                %>

                <div class="form-group">
                    <select name="catId" class="form-control" id=''>
                        <%
                            for (Category c : list) {
                        %>
                        <option value="<%= c.getCategoryId()%>">
                            <%= c.getCategoryTitle()%>
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
                    <button class="btn btn-outline-success">Modifier</button>
                    <button type="reset" class="btn btn-outline-secondary" data-dismiss="modal">Annuller</button>
                </div>
            </form>
        </div>
    </body>
</html>
