<%-- 
    Document   : student.courses
    Created on : Dec 18, 2023, 12:37:07 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Courses</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Lingua project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/styles/bootstrap4/bootstrap.min.css">
        <link href="assets/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/courses.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/courses_responsive.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/main_styles.css">
        <style>
            /* Ẩn dropdown content mặc định */
            .dropdown-content1 {
                display: none;
                position: absolute;
                /*                background-color: #212020;*/
                background: transparent;
                border-radius: 10px;
                min-width: 160px;
                box-shadow: 0 8px 16px 0 rgba(0,0,0,0.6);
                z-index: 2;
            }

            .dropdown1 {
                padding-left: 10px;
            }

            /* Hiển thị dropdown content khi hover */
            .dropdown1:hover .dropdown-content1 {
                display: block;
            }

            .dropdown-content1 li:hover {
                background-color: rgba(8, 8, 8 , 0.4); /* Màu nền khi hover */
            }
            #categoryName {
                width: calc(100% - 20px);
                margin-top: 10px;
            }
            #typecourseName {
                width: calc(100% - 20px);
                margin-top: 10px;
            }
            #typeForm {
                display: none;
            }
            #categoryForm {
                display: none;
            }
        </style>
    </head>
    <body>

        <div class="super_container">

            <!-- Header -->
            <c:set var="u" value="${user}"/>
            <header class="header">
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
                                            <li class="active"><a href="adminhome">Home</a></li>
                                            <li><a href="admincourses">Courses</a></li>
                                            <li><a href="adminuser">Users</a></li>
                                            <li><a href="adminorder">Orders</a></li>
                                            <li><a href="adminnews">News</a></li>
                                        </ul>
                                    </nav>
                                    <div class="header_content_right ml-auto text-right">
                                        <div class="header_search">
                                            <div class="search_form_container">
                                                <form action="adminsearch" method="GET" id="search_form" class="search_form trans_400">
                                                    <input type="search" name="keyword" class="header_search_input trans_400" placeholder="Type for Search" required="required">
                                                    <div class="search_button">
                                                        <button tyle="submit" style="background-color: transparent;border: none;cursor: pointer;"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
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
                        <li class="menu_mm"><a href="adminhome">Home</a></li>
                        <li class="menu_mm"><a href="admincourse">Courses</a></li>
                        <li class="menu_mm"><a href="adminuser">Users</a></li>
                        <li class="menu_mm"><a href="adminorder">Orders</a></li>
                        <li class="menu_mm"><a href="adminnews">News</a></li>
                    </ul>
                </nav>
            </div>
            <!-- Language -->
            <div class="language" style="padding-bottom: 0px">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="language_slider_container">
                                <div class="owl-carousel owl-theme language_slider">
                                    <c:forEach var="lc" items="${listcate}" varStatus="loop">
                                        <div class="owl-item language_item"style="padding-bottom: 230px; padding-top: 90px">
                                            <div class="dropdown1">
                                                <a href="admingroupbycate?cate=${lc.categoryname}">
                                                    <div class="flag" style="width: 80px; border-radius: 10px"><img src="assets/images/logobook.jpg" alt="" style="border-radius: 10px; background: transparent"></div>
                                                    <div class="lang_name" style="font-size: 15px">${lc.categoryname}</div>
                                                </a>
                                                <c:set var="typename" value="type${lc.categoryname}"/>
                                                <div class="dropdown-content1">
                                                    <ul style="background: transparent;">
                                                        <c:forEach var="tc" items="${sessionScope[typename]}" varStatus="loop">
                                                            <li style="padding: 5px; border-radius: 10px"><a href="admingroupbycatetype?cate=${lc.categoryname}&&type=${tc.typecoursename}" style="color: rgba(0,0,0,0.4); font-weight: bold">${tc.typecoursename}</a></li>
                                                            </c:forEach>
                                                        <div class="form-containertype" style="margin-bottom: 20px">
                                                            <form action="adminaddtypecourse" method="post">
                                                                <input type="hidden" name="cate" value="${lc.categoryid}"/>
                                                                <input type="text" id="typecourseName" name="typename" placeholder="Enter new typecourse" required autocomplete="off">
                                                                <input type="submit" value="Add"/>
                                                            </form>
                                                        </div>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="owl-item language_item"style="padding-bottom: 150px; padding-top: 90px">
                                        <div class="dropdown1">
                                            <div class="flag" style="width: 80px; border-radius: 10px" id="addCategoryBtn">
                                                <i class="fa fa-plus-square-o" style="font-size: 35px; color: black; padding-top: 10px"></i>
                                            </div>
                                            <div class="form-container" id="categoryForm">
                                                <form action="adminaddcategory" method="post">
                                                    <label for="categoryName">Category Name:</label>
                                                    <input type="text" id="categoryName" name="categoryName" required>
                                                    <button type="submit">Save</button>
                                                </form>
                                            </div>
                                        </div>
                                        <script>
                                            document.addEventListener('DOMContentLoaded', function () {
                                                const addCategoryBtn = document.getElementById('addCategoryBtn');
                                                const categoryForm = document.getElementById('categoryForm');
                                                addCategoryBtn.addEventListener('click', function () {
                                                    categoryForm.style.display = categoryForm.style.display === 'none' ? 'block' : 'none';
                                                });
                                            });
                                        </script>
                                    </div>
                                </div>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var dropdowns = document.getElementsByClassName("dropdown1");
                                        for (var i = 0; i < dropdowns.length; i++) {
                                            dropdowns[i].addEventListener("mouseover", function () {
                                                this.getElementsByClassName("dropdown-content1")[0].style.display = "block";
                                            });

                                            dropdowns[i].addEventListener("mouseout", function () {
                                                this.getElementsByClassName("dropdown-content1")[0].style.display = "none";
                                            });
                                        }
                                    });
                                </script>

                                <div class="lang_nav lang_prev"><i class="fa fa-angle-left" aria-hidden="true"></i></div>
                                <div class="lang_nav lang_next"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Courses -->
            <div class="courses" style="padding-top: 0px">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <h2 class="section_title text-center">All courses</h2>
                        </div>

                    </div>
                    <div class="row courses_row">

                        <!-- Course -->
                        <c:forEach var="c" items="${courses}" varStatus="loop">
                            <div class="col-lg-4 course_col">
                                <div class="course">
                                    <div class="course_image"><a href="admincoursedetail?id=${c.courseid}"><img src="assets/images/${c.linkimg}" alt=""></a></div>
                                    <div class="course_body">
                                        <div class="course_title"><a href="admincoursedetail?id=${c.courseid}">${c.title}</a></div>
                                        <div class="course_info">
                                            <ul>
                                                <li><a href="#">${c.userid.fullname}</a></li>
                                                <li><a href="#">${c.typecourseid.typecoursename}</a></li>
                                            </ul>
                                        </div>
                                        <div class="course_text">
                                            <p>${c.description}</p>
                                        </div>
                                    </div>
                                    <div class="course_footer d-flex flex-row align-items-center justify-content-start">
                                        <div class="course_students"><i class="fa fa-user" aria-hidden="true"></i><span>10</span></div>
                                        <div class="course_mark course_free trans_200"><a href="studentcheckout">${c.price}$</a></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="row">
                        <div class="col">
                            <div class="load_more_button"><a href="#">load more</a></div>
                        </div>
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
        <script src="assets/js/courses.js"></script>
    </body>
</html>
