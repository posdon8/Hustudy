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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
                <div style="padding-left: 300px; padding-bottom: 30px">
                    <p style="font-size: 20px">Số học sinh trên hệ thống : ${totals}</p>
                    <p style="font-size: 20px">Số giảng viên trên hệ thống : ${totall}</p>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <h2 class="section_title text-center">Số khóa học bán được theo tháng</h2>
                        </div>
                    </div>
                    <div>
                        <div style="width: 1000px ;height: 500px; padding-left: 100px">
                            <canvas id="myChart"></canvas>
                        </div>
                        <c:set var="lcs" value="${lcs}"/>
                        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                        <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const ctx = document.getElementById('myChart').getContext('2d');
                                            new Chart(ctx, {
                                                type: 'bar',
                                                data: {
                                                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                                                    datasets: [{
                                                            label: 'Số lượng',
                                                            data: [${lcs[0]},${lcs[1]},${lcs[2]},${lcs[3]},${lcs[4]},${lcs[5]},${lcs[6]},${lcs[7]},${lcs[8]},${lcs[9]},${lcs[10]},${lcs[11]}],
                                                            borderWidth: 1
                                                        }]
                                                },
                                                options: {
                                                    scales: {
                                                        y: {
                                                            beginAtZero: true
                                                        }
                                                    }
                                                }
                                            });
                                        });
                        </script>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <h2 class="section_title text-center">Số tiền thu được theo tháng</h2>
                        </div>
                    </div>
                    <div>
                        <div style="width: 1000px ;height: 500px; padding-left: 100px">
                            <canvas id="myChart1"></canvas>
                        </div>
                        <c:set var="lct" value="${lct}"/>
                        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                        <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const ctx = document.getElementById('myChart1').getContext('2d');
                                            new Chart(ctx, {
                                                type: 'bar',
                                                data: {
                                                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                                                    datasets: [{
                                                            label: '$',
                                                            data: [${lct[0]},${lct[1]},${lct[2]},${lct[3]},${lct[4]},${lct[5]},${lct[6]},${lct[7]},${lct[8]},${lct[9]},${lct[10]},${lct[11]}],
                                                            borderWidth: 1
                                                        }]
                                                },
                                                options: {
                                                    scales: {
                                                        y: {
                                                            beginAtZero: true
                                                        }
                                                    }
                                                }
                                            });
                                        });
                        </script>
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
