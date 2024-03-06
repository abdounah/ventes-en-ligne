<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIMVente - Panier</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            .table tbody td {
                vartical-align: middle;
            }
            .btn-incre,.btn-decre {
                box-shadow: none;
                font-size: 25px;
            }
        </style>
        <script>
            
        </script>
    </head>
    <body style="padding-top: 26px;">
        <%@include file="components/navbar.jsp" %>
        <div class="container"style="margin-top: 26px;">
            <div class="d-flex py-3">
                <h3>Prix Total : 300000 UM</h3>
                <a class="mx-3 btn btn-primary" href="#">Payer</a>
            </div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Nom</th>
                        <th scope="col">Catégorie</th>
                        <th scope="col">Prix</th>
                        <th scope="col">Payer</th>
                        <th scope="col">Annuler</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Dell</td>
                        <td>laptop</td>
                        <td>130000UM</td>
                        <td>
                            <form action="" method="post" class="form-inline">
                                <input type="hidden" name="id" value="1" class="form-input"/>
                                <div class="form-group d-flex justify-content-between">
                                    <a class="btn btn-sm btn-incre" href=""><i class="fa fa-plus-square"></i></a>
                                    <input type="text" name="quantity" class="form-control" value="1" readonly/>
                                    <a class="btn btn-sm btn-decre" href=""><i class="fa fa-minus-square"></i></a>    
                                </div>
                            </form>
                        </td>
                        <td>
                            <a href="" class="btn btn-sm btn-danger">Supprimer</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>
