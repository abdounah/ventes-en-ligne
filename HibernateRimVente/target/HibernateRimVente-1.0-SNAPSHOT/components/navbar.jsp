<%@page import="entities.User"%>
<%
    User user1 = (User) session.getAttribute("current-user");
%>

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
