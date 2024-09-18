<%-- 
    Document   : student.index
    Created on : Dec 17, 2023, 2:31:05 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>CourseManagementSystem</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Lingua project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/styles/bootstrap4/bootstrap.min.css">
        <link href="assets/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/responsive.css">
    </head>
    <body>
        <div class="super_container">
            <!-- Header -->
            <c:set var="u" value="${user}"/>
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
                                        <li class="active"><a href="lecturerhome">Home</a></li>
                                        <li><a href="lecturercourses?lit=${u.userid}">My Courses</a></li>
                                        <li><a href="lecturernews">News</a></li>
                                        <li><a href="lecturerhelp">Help</a></li>
                                    </ul>
                                </nav>
                                <div class="header_content_right ml-auto text-right">
                                    <div class="header_search">
                                        <div class="search_form_container">
                                            <form action="lecturersearch" method="GET" id="search_form" class="search_form trans_400">
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
                    <li class="menu_mm"><a href="lecturerhome">Home</a></li>
                    <li class="menu_mm"><a href="lecturercourse">My Courses</a></li>
                    <li class="menu_mm"><a href="lecturernews">News</a></li>
                    <li class="menu_mm"><a href="lecturerhelp">Help</a></li>
                </ul>
            </nav>
        </div>

        <!-- body -->
        <div class="language">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="lang_nav lang_prev"><i class="fa fa-angle-left" aria-hidden="true"></i></div>
                        <div class="lang_nav lang_next"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
                    </div>
                </div>
            </div>
        </div>

            <!-- Courses -->

            <div class="courses">
                <div class="courses_background"></div>
                <div class="container">
                    <c:set var="ltro" value="${own}"/>
                    <div class="row">
                        <div class="col">
                            <h2 class="section_title text-center">My courses</h2>
                            <a href="lectureraddcourse"><i class="fa fa-plus-circle" style="font-size: 50px; color: rgb(105, 45, 45)"></i></a>
                        </div>
                    </div>    
                    <div class="row courses_row">
                        <c:forEach var="co" items="${gblown}" varStatus="loop">
                            <div class="col-lg-4 course_col">
                                <div class="course">
                                    <div class="course_image"><a href="lecturercoursedetail?id=${co.courseid}"><img src="assets/images/${co.linkimg}" alt=""></a></div>
                                    <div class="course_body">
                                        <div class="course_title"><a href="lecturercoursedetail?id=${co.courseid}">${co.title}</a></div>
                                        <div class="course_info">
                                            <ul>
                                                <li><a href="#">${co.userid.fullname}</a></li>
                                                <li><a href="#">${co.typecourseid.typecoursename}</a></li>
                                            </ul>
                                        </div>
                                        <div class="course_text">
                                            <p>${co.description}</p>
                                        </div>
                                    </div>
                                    <c:set var="name" value="total${co.courseid}"/>
                                    <c:set var="enroll" value="${sessionScope[name]}"/>
                                    <div class="course_footer d-flex flex-row align-items-center justify-content-start">
                                        <div class="course_students"><i class="fa fa-user" aria-hidden="true"></i><span>${enroll}</span></div>
                                        <div class="course_mark course_free trans_200"><a href="#">${co.price}$</a></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Footer -->

            <footer class="footer">
                <div class="copyright">
                    <div class="container">
                        <div class="cr">
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
        <script src="assets/js/custom.js"></script>
    </body>
</html>
