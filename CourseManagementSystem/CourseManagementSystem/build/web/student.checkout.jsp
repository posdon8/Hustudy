<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Check out</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Lingua project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/styles/bootstrap4/bootstrap.min.css">
        <link href="assets/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/animate.css">
        <link href="assets/plugins/video-js/video-js.css" rel="stylesheet" type="text/css">
        <style>
            #layout-page {
                background-color: #fff;
                border: 1px solid #ddd;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .header-page h1 {
                font-size: 24px;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 15px;
                text-align: left;
            }

            th.image, td.image {
                width: 120px;
            }

            th.qty, td.qty {
                width: 80px;
            }

            th.price, td.price {
                width: 120px;
            }

            th.remove, td.remove {
                width: 80px;
            }

            .product_image img {
                max-width: 100%;
                height: auto;
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .product_image img:hover {
                transform: scale(1.1);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .summary {
                font-weight: bold;
                background-color: #f9f9f9;
            }

            .summary td {
                text-align: center;
            }

            .inner-left,
            .inner-right {
                padding: 0 15px;
            }

            .checkout-buttons,
            .buttons {
                margin-top: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .note-display {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                margin-top: 10px;
                line-height: 1.6;
                white-space: pre-line; /* Hi?n th? các ký t? xu?ng dòng (\n) */
            }

            .buttons button {
                display: inline-block;
                padding: 15px;
                margin-right: 15px;
                background-color: #333;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .buttons button:hover {
                background-color: #555;
            }

            .continue-shop {
                margin-top: 20px;
            }

            .continue-shop a {
                color: #333;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
                font-weight: bold;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="assets/styles/regular.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/regular_responsive.css">

    </head>
    <body>

        <div class="super_container">

            <!-- Header -->
            <c:set var="u" value="${user}"/>
            <!-- Regular -->
            <div class="regular">
                <div class="container">
                    <div class="row">
                        <div id="layout-page" class="col-md-12 col-sm-12 col-xs-12">
                            <span class="header-page clearfix">
                                <h1 style="padding-top: 10px; text-align: center; color: #f73b3b">Successfully purchase !</h1>
                            </span>
                            <form action="aftercheckout" method="get">
                                <input type="hidden" name="id" value="${u.userid}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th class="image">&nbsp;</th>
                                            <th class="item">Course Name</th>
                                            <th class="price">Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="ca" items="${listcart}" varStatus="loop">
                                            <tr>
                                                <td class="image">
                                                    <div class="product_image">
                                                        <a href="#"><img src="assets/images/${ca.courseid.linkimg}"alt="#" /></a>
                                                    </div>
                                                </td>
                                                <td class="item">
                                                    <a href="/products/dong-ho-nam-skmei-kim-xanh-duong"><strong>${ca.courseid.title}</strong></a>
                                                </td>
                                                <td class="price" style="color: #e32828">${ca.courseid.price}$</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:set var="o" value="${orders}"/>
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-12 inner-left inner-right">
                                        <div class="checkout-buttons clearfix">
                                            <label for="note">Note </label>
                                            <div id="note" class="note-display">${o.note}</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-12 cart-buttons inner-right inner-left">
                                        <div class="checkout-buttons clearfix">
                                            <table>
                                                <tr>
                                                    <td><label>Code Bill : </label></td>
                                                    <td><label>${o.orderid} </label></td>
                                                </tr>
                                                <tr>
                                                    <td><label>Customer Name : </label></td>
                                                    <td><label>${o.userid.fullname} </label></td>
                                                </tr>
                                                <tr>
                                                    <td><label>Course : </label></td>
                                                    <td>
                                                        <c:forEach var="cart" items="${listcart}" varStatus="loop">
                                                            <label>${cart.courseid.title} </label>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><label>Totalamount : </label></td>
                                                    <td><label>${o.totalamount}$ </label></td>
                                                </tr>
                                                <tr>
                                                    <td><label>Order Date : </label></td>
                                                    <td><label>${o.orderdate} </label></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                                <div style="text-align: center; margin-top: 20px;">
                                    <button type="submit" style="background-color: #514949; border-radius: 13px; color: white; padding: 10px;">HomePage</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer -->
            <!--            <footer class="footer">
                            <div class="copyright">
                                <div class="container" style="text-align: center;">
                                    <div class="cr" style="font-size: 15px; padding-top: 10px">
                                        @2023
                                    </div>
                                </div>
                            </div>
                        </footer>-->
        </div>

        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/styles/bootstrap4/popper.js"></script>
        <script src="assets/styles/bootstrap4/bootstrap.min.js"></script>
        <script src="assets/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
        <script src="assets/plugins/easing/easing.js"></script>
        <script src="assets/plugins/parallax-js-master/parallax.min.js"></script>
        <script src="assets/js/regular.js"></script>
    </body>
</html>