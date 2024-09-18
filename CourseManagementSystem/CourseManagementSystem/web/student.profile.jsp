<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Profile</title>
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
        <link rel="stylesheet" type="text/css" href="assets/styles/regular.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/regular_responsive.css">
        <style>
            .regular {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .regular_content {
                text-align: center;
            }
            .regular_title {
                background-color: #3498db;
                width: 100px;
                height: 100px;
                border-radius: 50%;
                overflow: hidden;
                margin: 0 auto;
            }
            .regular_title img {
                width: 100%;
                height: auto;
            }
            #changeAvatarBtn {
                margin-top: 10px;
                cursor: pointer;
                color: #3498db;
            }
            #avatarInput {
                display: none;
            }
            .regular_text {
                margin-top: 20px;
                text-align: left;
            }
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
    </head>
    <body>

        <div class="super_container">

            <!-- Header -->
            <c:set var="u" value="${user}" />
            <header class="header">

                <!-- Header Content -->
                <div class="header_container">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="header_content d-flex flex-row align-items-center justify-content-start">
                                    <div class="logo_container mr-auto">
                                        <a href="#" style="box-shadow: 0px 0px 10px 0px rgba(213, 164, 164, 1)">
                                            <img class="logoimg" src="assets/images/logo.jpg" alt="">
                                        </a>
                                       
                                    </div>
                                    <nav class="main_nav_contaner">
                                        <ul class="main_nav">
                                            <li class="active"><a href="studenthome">Home</a></li>
                                            <li><a href="studentcourses">Courses</a></li>
                                            <li><a href="studentinstructor">Instructor</a></li>
                                            <li><a href="studentnews">News</a></li>
                                            <li><a href="studenthelp">Help</a></li>
                                        </ul>
                                    </nav>
                                    <div class="header_content_right ml-auto text-right">
                                        <div class="header_search">
                                            <div class="search_form_container">
                                                <form action="studentsearch" method="GET" id="search_form" class="search_form trans_400">
                                                    <input type="search" name="keyword" class="header_search_input trans_400" placeholder="Type for Search" required="required">
                                                    <div class="search_button">
                                                        <button tyle="submit" style="background-color: transparent;border: none;cursor: pointer;"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Hamburger -->


                                        <div class="hamburger menu_mm">
                                            <i class="fa fa-bars menu_mm" aria-hidden="true"></i>
                                        </div>

                                    </div><div class="user" id="userDropdown">
                                        <a href="#" onclick="toggleDropdown(event)">
                                            <i class="fa fa-user" aria-hidden="true"></i>
                                        </a>
                                        <div class="dropdown-content">
                                            <div class="dropdown-item-container">
                                                <a href="studentviewcart?userid=${u.userid}" class="dropdown-item"><i class="fa fa-shopping-cart"></i> Cart</a>
                                            </div>
                                            <div class="dropdown-item-container">
                                                <a href="studentmycourse?userid=${u.userid}" class="dropdown-item"><i class="fa fa-folder-open-o"></i> My Courses</a>
                                            </div>
                                            <div class="dropdown-item-container">
                                                <a href="studentcalendar" class="dropdown-item"><i class="fa fa-calendar"></i> Calendar</a>
                                            </div>
                                            <div class="dropdown-item-container">
                                                <a href="studentprofile" class="dropdown-item"><i class="fa fa-id-card-o"></i> Profile</a>
                                            </div>
                                            <div class="dropdown-item-container">
                                                <a href="logout" class="dropdown-item"><i class="fa fa-sign-out"></i> Log out</a>
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        function toggleDropdown(event) {
                                            event.stopPropagation();
                                            var dropdownContent = document.querySelector('.dropdown-content');
                                            var user = document.querySelector('.user');
                                            if (user.classList.contains('open')) {
                                                user.classList.remove('open');
                                            } else {
                                                user.classList.add('open');
                                            }
                                        }
                                        document.addEventListener('click', function (event) {
                                            var user = document.querySelector('.user');
                                            var dropdownContent = document.querySelector('.dropdown-content');

                                            if (user.classList.contains('open') && !user.contains(event.target)) {
                                                user.classList.remove('open');
                                            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </header>

            <!-- Menu -->

            <div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
                <div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
                <div class="search">
                    <form action="#" class="header_search_form menu_mm">
                        <input type="search" class="search_input menu_mm" placeholder="Search" required="required">
                        <button class="header_search_button d-flex flex-column align-items-center justify-content-center menu_mm">
                            <i class="fa fa-search menu_mm" aria-hidden="true"></i>
                        </button>
                    </form>
                </div>
                <nav class="menu_nav">
                    <ul class="menu_mm">
                        <li class="menu_mm"><a href="studenthome">Home</a></li>
                        <li class="menu_mm"><a href="studentcourse">Courses</a></li>
                        <li class="menu_mm"><a href="studentinstructor">Instructor</a></li>
                        <li class="menu_mm"><a href="studentnews">News</a></li>
                        <li class="menu_mm"><a href="studenthelp">Help</a></li>
                    </ul>
                </nav>
            </div>

            <!-- Home -->
            <!-- Regular -->
            <div class="regular">
                <div class="container" >
                    <div class="row">
                        <div class="col">
                            <div class="regular_content" style="margin-top: 130px;background-color: #e7e7e7; border: solid 2px #a79c9c">
                                <div class="regular_title" style="border: solid 2px black">
                                    <img id="avatarPreview" src="assets/images/${u.avatar}" alt="Avatar" class="img-fluid">
                                </div>
                                <div>
                                    <i id="changeAvatarBtn" class="fa fa-camera" onclick="openFileInput()"></i>
                                    <input type="file" id="avatarInput" accept="image/*" onchange="previewImage(event)">
                                </div>
                                <div id="layout-page" style="text-align: left">
                                    <p>Name: ${u.fullname}</p>
                                    <p>Username: ${u.username}</p>
                                    <p>Password: ${u.password}</p>
                                    <p>Email: ${u.email}</p>
                                    <button style="margin-bottom: 20px; margin-top: 10px; margin-left: 375px"><a href="changeinformation" style="padding: 5px">Change information</a></button>
                                </div>
                                <div id="layout-page" class="col-md-12 col-sm-12 col-xs-12">
                                    <span class="header-page clearfix">
                                        <p style="padding-top: 10px; text-align: center;">Courses purchased</p>
                                    </span>
                                    <table>
                                        <tbody>
                                            <c:forEach var="lbd" items="${listbd}">
                                                <tr>
                                                    <td class="image">
                                                        <div class="product_image">
                                                            <a href="coursedetail?id=${lbd.courseid}&&userid=${u.userid}"><img src="assets/images/${lbd.linkimg}"alt="#" /></a>
                                                        </div>
                                                    </td>
                                                    <td class="item">
                                                        <a href="coursedetail?id=${lbd.courseid}&&userid=${u.userid}"><strong>${lbd.title}</strong></a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    function openFileInput() {
                        document.getElementById("avatarInput").click();
                    }

                    function previewImage(event) {
                        var avatarPreview = document.getElementById("avatarPreview");
                        avatarPreview.src = URL.createObjectURL(event.target.files[0]);
                    }
                </script>
            </div>
            <!-- Footer -->
            <footer class="footer">
                <div class="copyright">
                    <div class="container">
                        <div class="cr" style="text-align: center">
                            @2023
                        </div>
                    </div>
                </div>
            </footer>
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