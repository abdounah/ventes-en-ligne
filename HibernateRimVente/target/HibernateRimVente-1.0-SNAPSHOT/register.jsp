<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIMVente - Register</title>

        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body style="padding-top: 29px;">
        <%@include file="components/navbar.jsp" %>

        <div class="container-fluid" style="margin-top: 29px;">
            <div class="row mt-1">
                <div class="col-md-6 offset-md-3">
                    
                    <div class="card">
                        <%@include file="components/message.jsp" %>
                        <div class="card-body ">
                            <h3 class="text-center">Sign up</h3>
                            <form action="RegisterServlet" method="post">
                                <div class="form-group">
                                    <label for="nom">Nom</label>
                                    <input name="nom" type="text" class="form-control" id="nom" aria-describedby="nameHelp" placeholder="Entrer votre nom">
                                </div>

                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input name="email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Entrer votre email">
                                </div>

                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input name="password" type="password" class="form-control" id="password" aria-describedby="passwordHelp" placeholder="*****">
                                </div>

                                <div class="form-group">
                                    <label for="telephone">Telephone</label>
                                    <input name="tel" type="number" class="form-control" id="telephone" aria-describedby="phoneHelp">
                                </div>

                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <textarea name="addresse" style="height: 80px;" class="form-control" placeholder="Entrer votre address"></textarea>
                                </div>

                                <div class="container text-center">
                                    <button class="btn btn-outline-success">Enregistrer</button>
                                    <button type="reset" class="btn btn-outline-warning">Annuler</button>
                                </div>
                                <a href="login.jsp" class="mt-2">Allez vers login</a>
                            </form>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
    </body>
</html>
