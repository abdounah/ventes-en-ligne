<%@ page import="java.util.List" %>
<%@ page import="entities.Product" %>
<%@ page import="entities.Category" %>
<%@ page import="dao.ProductDao" %>
<%@ page import="dao.CategoryDao" %>
<%@ page import="connection.FactoryProvider" %>
<%@page import="entities.User"%>
<%
    User user1 = (User) session.getAttribute("current-user");
%>
<%@ page import="connection.Helper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIMVente - Home</title>
        <%@include file="components/common_css_js.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

        <style>
            #toast {
                min-width: 300px;
                position: fixed;
                bottom: 30px;
                left: 50%;
                margin-left: -120px;
                background: #333;
                padding: 15px;
                color: white;
                text-align: center;
                z-index: 1;
                font-size: 18px;
                visibility: hidden;
                box-shadow: 0px 0px 100px #000;
            }
            #toast.display {
                visibility: visible;
                animation: ease-in 0.5s;
            }


        </style>
        <script>
            function add_to_cart(pid, pname, price) {
                let cart = localStorage.getItem("cart");

                if (cart == null) {
                    let products = [];
                    let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
                    products.push(product);
                    localStorage.setItem("cart", JSON.stringify(products));
                    showToast("Le produit ajoutée au panier avec succée");
                } else {
                    let pcart = JSON.parse(cart);

                    let oldProduct = pcart.find((item) => {
                        return item.productId == pid; // Add the return statement here
                    });

                    if (oldProduct) {
                        oldProduct.productQuantity = oldProduct.productQuantity + 1;
                        pcart.map((item) => {
                            if (item.productId == oldProduct.productId) {
                                item.productQuantity = oldProduct.productQuantity;
                            }
                        });
                        localStorage.setItem("cart", JSON.stringify(pcart));
                        showToast("La quantité du produit "+ oldProduct.productName +" incrementée, le nauveau quantité = "+oldProduct.productQuantity);
                    } else {
                        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
                        pcart.push(product);
                        localStorage.setItem("cart", JSON.stringify(pcart));
                        showToast("Le produit ajoutée au panier avec succée");
                    }
                }
                updateCart();
            }
            function updateCart() {
                console.log("Updating cart...");

                // Get the cart items from local storage
                const cartString = localStorage.getItem("cart");
                let cart;

                // Parse the JSON string, handling potential errors gracefully
                try {
                    cart = JSON.parse(cartString);
                } catch (error) {
                    console.error("Error parsing cart:", error);
                    cart = []; // Set an empty array if parsing fails
                }

                console.log("Cart after parsing:", cart);

                // Check if the cart is empty
                if (!cart || cart.length === 0) {
                    console.log("Cart is empty.");
                    const cartItemsElement = document.querySelector(".cart-items");
                    cartItemsElement.textContent = "(0)";

                    const cartBodyElement = document.querySelector(".cart-body");
                    cartBodyElement.innerHTML = "<h3>vide</h3>";

                    const checkoutButtonElement = document.querySelector(".checkout-btn");
                    checkoutButtonElement.classList.add("disabled");
                } else {
                    const cartItemsElement = document.querySelector(".cart-items");
                    cartItemsElement.textContent = cart.length;
                    const cartBodyElement = document.querySelector(".cart-body");
                    const checkoutButtonElement = document.querySelector(".checkout-btn");
                    checkoutButtonElement.classList.remove("disabled");
                    console.log("1");
                    let table = `
            <table class='table'>
                <thead class='thead-light'>
                    <tr>
                        <th>Nom</th>
                        <th>Prix</th>
                        <th>Quantité</th>
                        <th>Prix total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                
        `;
                    console.log("2");
                    // Iterate through each item in the cart and add a row for each
                    let totalPriceGlobal = 0;
                    cart.map((item) => {
                        console.log("3");
                        const totalPrice = item.productQuantity * item.productPrice;
                        console.log(totalPrice);

                        // Ajoutez les lignes HTML générées à la variable table.
                        table += "<tr>" +
                                "<td>" + item.productName + "</td>" +
                                "<td>" + item.productPrice + "</td>" +
                                "<td>" + item.productQuantity + "</td>" +
                                "<td>" + totalPrice + "</td>" +
                                "<td><button onclick='deleteItemFromCart(" + item.productId + ")' class='btn btn-danger btn-sm'>Remove</button></td>" +
                                "</tr>";
                        totalPriceGlobal += totalPrice;
                        console.log("4");
                    });

                    table += "<tr>" + "<td colspan='5' class='text-center font-weight-bold'> Prix Total : " + totalPriceGlobal + "</td>" + "</tr>";

                    table = table + `
                
            </table>
        `;
                    console.log("5");
                    cartBodyElement.innerHTML = table;
                    console.log("6");
                    // Add logic to update cart items, total price, etc. based on your specific requirements
                }
            }


            function deleteItemFromCart(pid) {
                let cart = JSON.parse(localStorage.getItem('cart'));

                let newCart = cart.filter((item) => {
                    return item.productId !== pid; // Ajoutez le return ici
                });

                localStorage.setItem('cart', JSON.stringify(newCart));
                showToast("Le produit supprimer au panier avec succée");
                updateCart();
            }


            $(document).ready(function () {
                updateCart();
            });

            function showToast(content) {
                var toastElement = document.getElementById("toast");

                if (toastElement) {
                    toastElement.classList.add("display");
                    toastElement.innerHTML = content;

                    setTimeout(function () {
                        toastElement.classList.remove("display");
                    }, 2000);
                }
            }

        </script>
    </head>
    <body style="padding-top: 26px;">
        <nav class="navbar navbar-expand-lg navbar-dark" 
             style=" background: #2196f3; position: fixed;
             top: 0;
             width: 100%;

             z-index: 1000; ">

            <div class="container">
                <a class="navbar-brand" href="index.jsp">RimVente</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="index.jsp">Accueil <span class="sr-only">(current)</span></a>
                        </li>
                    </ul>
                    <ul class="navbar-nav ml-auto">

                        <%
                            if (user1 == null) {

                        %>

                        <li class="nav-item active">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="register.jsp">Register</a>
                        </li>

                        <%                } else {
                        %>
                        <%
                            if (user1.getUserType().trim().equals("normal")) {
                        %>
                        <li class="nav-item active">
                            <a class="nav-link" href="#" data-toggle="modal" data-target="#cart"><i class="fa fa-cart-plus" style="font-size: 30px;line-height: 30px;"></i><span class="ml-0 cart-items"></span></a>
                        </li>
                        <%
                            }
                        %>
                        <li class="nav-item active">
                            <a class="nav-link" href="#!"><%= user1.getUserName()%></a>
                        </li>

                        <li class="nav-item active">
                            <a class="nav-link" href="LogoutServlet">Logout</a>
                        </li>

                        <%
                            }
                        %>


                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-fluid" style="margin-top: 26px;">
            <div class="row mx-2">
                <%                String cat = request.getParameter("category");
                    if (cat == null) {
                        cat = "all";
                    }

                    ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> products = cat.equals("all") ? pDao.getAllProducts() : pDao.getProductsByCategory(Integer.parseInt(cat.trim()));

                    // Nombre maximum de produits par page
                    int productsPerPage = 4;

                    // Nombre total de pages
                    int totalPages = (int) Math.ceil((double) products.size() / productsPerPage);

                    // Page actuelle (par défaut à 1 si le paramètre page n'est pas fourni ou est vide)
                    int currentPage;
                    String pageParam = request.getParameter("page");
                    if (pageParam != null && !pageParam.isEmpty()) {
                        currentPage = Math.max(1, Integer.parseInt(pageParam));
                    } else {
                        currentPage = 1;
                    }

                    // Index de départ pour la pagination
                    int startIndex = (currentPage - 1) * productsPerPage;

                    // Sous-liste de produits pour la page actuelle
                    List<Product> productsForPage = products.subList(startIndex, Math.min(startIndex + productsPerPage, products.size()));
                %>

                <!-- Show categories -->
                <div class="col-md-4">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action<%= cat.equals("all") ? " active" : ""%>">
                            Les produits
                        </a>

                        <%
                            for (Category category : new CategoryDao(FactoryProvider.getFactory()).getCategories()) {
                        %>
                        <a href="index.jsp?category=<%= category.getCategoryId()%>" class="list-group-item list-group-item-action<%= cat.equals(String.valueOf(category.getCategoryId())) ? " active" : ""%>">
                            <%= category.getCategoryTitle()%>
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>

                <!-- Show products with pagination -->
                <div class="col-md-8">
                    <div class="row mt-4">
                        <% for (Product product : productsForPage) {%>
                        <div class="col-md-6 mb-3">
                            <div class="card" style="width: 100%;">
                                <div class="container text-center">
                                    <img class="card-img-top mt-1" style="max-height: 200px; max-width: 100%; width: auto;" src="img/products/<%= product.getpPhoto()%>" alt="Card image cap">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title"><%= product.getpName()%></h5>
                                    <p class="card-text"><%= Helper.get10Words(product.getpDesc())%></p>
                                    <% if(user1 == null) { %>
                                    <div style="">
                                            <button class="mt-3 btn btn-success" disabled="true"><del><%= product.getpPrice()%> UM</del><span class="" style="font-size: 10px; font-style: italic;"> <%= product.getpDiscount()%>% remise </span> <%= product.getPriceAplyingDiscount()%> UM</button>
                                    </div>
                                    <% }else { %>
                                        <% if(user1.getUserType().trim().equals("normal")) { %>
                                            <div style="">
                                                <button onclick="add_to_cart(<%= product.getpId()%>, '<%= product.getpName()%>',<%= product.getPriceAplyingDiscount()%>)" class="mt-3 mr-3 btn btn-outline-primary">Ajouter au panier</button>
                                                <button class="mt-3 btn btn-success" disabled="true"><del><%= product.getpPrice()%> UM</del><span class="" style="font-size: 10px; font-style: italic;"> <%= product.getpDiscount()%>% remise </span> <%= product.getPriceAplyingDiscount()%> UM</button>
                                            </div>
                                        <% }else { %>
                                            <div style="">
                                                <a href="components/modifier.jsp?pId=<%= product.getpId()%>" class="mt-3 mr-3 btn btn-outline-success">Modifier</a>
                                                <a href="DeleteServlet?pId=<%= product.getpId()%>" class="mt-3 btn btn-outline-danger" disabled="true">Supprimer</a>
                                            </div>
                                        <% } } %>
                                        
                                    
                                </div>       
                            </div>
                        </div>
                        <% }%>
                        <%
                            if (products.size() == 0) {
                        %>
                        <img src="img/tenor.gif" />
                        <%
                            }
                        %>
                    </div>

                    <!-- Pagination -->
                    <div class="container text-center">
                        <nav aria-label="Page navigation" class="d-flex justify-content-center">
                            <ul class="pagination">
                                <% for (int i = 1; i <= totalPages; i++) {%>
                                <li class="page-item<%= i == currentPage ? " active" : ""%>">
                                    <a class="page-link" href="index.jsp?category=<%= cat%>&page=<%= i%>"><%= i%></a>
                                </li>
                                <% }%>
                            </ul>
                        </nav>
                    </div>

                </div>
            </div> 
        </div>
        <!-- Modal -->
        <div class="modal fade" id="cart" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Votre panier</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="cart-body">

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                        <button type="button" class="btn btn-primary checkout-btn">Payer</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="toast"></div>
    </body>
</html>
