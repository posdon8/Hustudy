<%-- 
    Document   : student.coursedetail.jsp
    Created on : Dec 18, 2023, 4:44:27 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Course</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Lingua project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/styles/bootstrap4/bootstrap.min.css">
        <link href="assets/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/course.css">
        <link rel="stylesheet" type="text/css" href="assets/styles/course_responsive.css">
        <style>
            .screen-reader{
                width: var(--screenReaderWidth, 1px) !important;
                height: var(--screenReaderHeight, 1px) !important;
                padding: var(--screenReaderPadding, 0) !important;
                border: var(--screenReaderBorder, none) !important;

                position: var(--screenReaderPosition, absolute) !important;
                clip: var(--screenReaderClip, rect(1px, 1px, 1px, 1px)) !important;
                overflow: var(--screenReaderOverflow, hidden) !important;
            }
            .rating{
                --uiRatingColor: var(--ratingColor, #eee);
                --uiRatingColorActive: var(--ratingColorActive, #ffcc00);

                display: var(--ratingDisplay, flex);
                font-size: var(--ratingSize, 1rem);
                color: var(--uiRatingColor);
            }

            .rating__control:nth-of-type(1):focus ~ .rating__item:nth-of-type(1)::before,
            .rating__control:nth-of-type(2):focus ~ .rating__item:nth-of-type(2)::before,
            .rating__control:nth-of-type(3):focus ~ .rating__item:nth-of-type(3)::before,
            .rating__control:nth-of-type(4):focus ~ .rating__item:nth-of-type(4)::before,
            .rating__control:nth-of-type(5):focus ~ .rating__item:nth-of-type(5)::before{
                content: "";
                box-shadow: 0 0 0 var(--ratingOutlineWidth, 4px) var(--uiRatingColorActive);

                position: absolute;
                top: -.15em;
                right: 0;
                bottom: -.15em;
                left: 0;
                z-index: -1;
            }

            .rating__item{
                cursor: pointer;
                position: relative;
            }

            .rating__item{
                padding-left: .25em;
                padding-right: .25em;
            }

            .rating__star{
                display: block;
                width: 1em;
                height: 1em;

                fill: currentColor;
                stroke: var(--ratingStroke, #222);
                stroke-width: var(--ratingStrokeWidth, 1px);
            }

            .rating:hover,
            .rating__control:nth-of-type(1):checked ~ .rating__item:nth-of-type(1),
            .rating__control:nth-of-type(2):checked ~ .rating__item:nth-of-type(-n+2),
            .rating__control:nth-of-type(3):checked ~ .rating__item:nth-of-type(-n+3),
            .rating__control:nth-of-type(4):checked ~ .rating__item:nth-of-type(-n+4),
            .rating__control:nth-of-type(5):checked ~ .rating__item:nth-of-type(-n+5){
                color: var(--uiRatingColorActive);
            }

            .rating__item:hover ~ .rating__item{
                color: var(--uiRatingColor);
            }
            .rating{
                --ratingSize: 2rem;
                --ratingColor: #eee;
                --ratingColorActive: #ffcc00;
            }
        </style>
    </head>
    <body>

        <div class="super_container">
            <c:set var="u" value="${user}"/>

            <!-- Header -->

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

            <div class="home" style="height: 150px;">
                <div class="breadcrumbs_container">
                    <div class="container">
                        <div class="row" style="margin-bottom: 10px;">
                            <button class="btn btn-primary btn-login" style="background-color: #251b1b; border: 2px;" onclick="goBack()"><i class="fa fa-arrow-circle-o-left">Back</i></button>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function goBack() {
                    window.history.back();
                }
            </script>

            <!-- Intro -->

            <c:set var="c" value="${courses}"/>
            <div class="intro">
                <div class="intro_background parallax-window" data-parallax="scroll" data-image-src="assets/images/${c.linkimg}" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="intro_container d-flex flex-column align-items-start justify-content-end">
                                <div class="intro_content">
                                    <div class="intro_price">${c.price}$</div>
                                    <div class="rating_r rating_r_${avgrate} intro_rating"><i></i><i></i><i></i><i></i><i></i></div>
                                    <div class="intro_title">${c.title}</div>
                                    <div class="intro_meta">
                                        <div class="intro_image"><img src="assets/images/${c.userid.avatar}" alt=""></div>
                                        <div class="intro_instructors"><a href="instructors.html">${c.userid.fullname}</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>		
            </div>

            <!-- Course -->

            <div class="course">
                <div class="course_top"></div>
                <div class="container">
                    <div class="row row-lg-eq-height">

                        <!-- Panels -->
                        <div class="col-lg-9">
                            <div class="tab_panels">

                                <!-- Tabs -->
                                <div class="course_tabs_container">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-lg-9">
                                                <div class="tabs d-flex flex-row align-items-center justify-content-start">
                                                    <div class="tab active">description</div>
                                                    <div class="tab">curriculum</div>
                                                    <div class="tab">reviews</div>
                                                    <div class="tab">members</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>		
                                </div>

                                <!-- Description -->
                                <div class="tab_panel description active">
                                    <div class="panel_title">About this course</div>
                                    <div class="panel_text">
                                        <p>${c.description}</p>
                                    </div>

                                    <!-- Instructors -->
                                    <div class="instructors">
                                        <div class="panel_title">Instructor</div>
                                        <div class="row instructors_row">

                                            <!-- Instructor -->
                                            <div class="col-lg-4 col-md-6">
                                                <div class="instructor d-flex flex-row align-items-center justify-content-start">
                                                    <div class="instructor_image"><div><img src="assets/images/${c.userid.avatar}" alt=""></div></div>
                                                    <div class="instructor_content">
                                                        <div class="instructor_name"><a href="instructors.html">${c.userid.fullname}</a></div>
                                                        <div class="instructor_title">Lecturer</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <!-- Curriculum -->
                                <div class="tab_panel curriculum">
                                    <div class="panel_title">Syllabus</div>
                                    <div class="curriculum_items">
                                        <c:forEach var="ll" items="${listlesson}" varStatus="loop">
                                            <div class="cur_item">
                                                <div class="cur_item_content">
                                                    <div class="cur_item_title">${ll.lessonname}</div>
                                                    <div class="cur_contents">
                                                        <ul>
                                                            <li>
                                                                <i class="fa fa-folder" aria-hidden="true"></i>
                                                                <c:set var="lname" value="listdoc${ll.lessonname}"/>
                                                                <ul>
                                                                    <c:forEach var="dc" items="${sessionScope[lname]}" varStatus="loop">
                                                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                                                            <i class="fa fa-file" aria-hidden="true"></i><span><a href="${dc.slideurl}" download>${dc.slideurl}</a></span>
                                                                        </li>
                                                                    </c:forEach>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="tab_panel reviews">
                                    Review 
                                    <c:forEach var="lr" items="${listreview}" varStatus="loop">
                                        <div class="review">
                                            <div class="review_title_container d-flex flex-row align-items-start justify-content-start">
                                                <div class="review_title d-flex flex-row align-items-center justify-content-center">
                                                    <div class="review_author_image"><div><img src="assets/images/${lr.userid.avatar}" alt=""></div></div>
                                                    <div class="review_author">
                                                        <div class="review_author_name"><a href="#">${lr.userid.fullname}</a></div>
                                                    </div>
                                                </div>
                                                <div class="review_stars ml-auto"><div class="rating_r rating_r_${lr.rating} review_rating"><i></i><i></i><i></i><i></i><i></i></div></div>
                                            </div>
                                            <div class="review_text">
                                                <p>${lr.comment}</p>
                                            </div>
                                        </div> 
                                    </c:forEach>
                                    <form action="addreview" method="get">
                                        <div class="review">
                                            <div class="review_title_container d-flex flex-row align-items-start justify-content-start">
                                                <div class="review_title d-flex flex-row align-items-center justify-content-center">
                                                    <div class="review_author_image">
                                                        <div><img src="assets/images/${u.avatar}" alt=""></div>
                                                    </div>
                                                    <div class="review_author">
                                                        <div class="review_author_name"><a href="#">${u.fullname}</a></div>
                                                    </div>
                                                </div>
                                                <div class="review_stars ml-auto">
                                                    <input type="hidden" name="courseid" value="${c.courseid}"/>
                                                    <input type="hidden" name="userid" value="${u.userid}"/>
                                                    <div class="rating">
                                                        <input type="radio" name="rating-star2" class="rating__control screen-reader" value="1" id="rc6">
                                                        <input type="radio" name="rating-star2" class="rating__control screen-reader" value="2" id="rc7">
                                                        <input type="radio" name="rating-star2" class="rating__control screen-reader" value="3" id="rc8">
                                                        <input type="radio" name="rating-star2" class="rating__control screen-reader" value="4" id="rc9">
                                                        <input type="radio" name="rating-star2" class="rating__control screen-reader" value="5" id="rc10">
                                                        <label for="rc6" class="rating__item">
                                                            <svg class="rating__star">
                                                            <use xlink:href="#star"></use>
                                                            </svg>
                                                            <span class="screen-reader">1</span>
                                                        </label>
                                                        <label for="rc7" class="rating__item">
                                                            <svg class="rating__star">
                                                            <use xlink:href="#star"></use>
                                                            </svg>
                                                            <span class="screen-reader">2</span>
                                                        </label>
                                                        <label for="rc8" class="rating__item">
                                                            <svg class="rating__star">
                                                            <use xlink:href="#star"></use>
                                                            </svg>
                                                            <span class="screen-reader">3</span>
                                                        </label>
                                                        <label for="rc9" class="rating__item">
                                                            <svg class="rating__star">
                                                            <use xlink:href="#star"></use>
                                                            </svg>
                                                            <span class="screen-reader">4</span>
                                                        </label>
                                                        <label for="rc10" class="rating__item">
                                                            <svg class="rating__star">
                                                            <use xlink:href="#star"></use>
                                                            </svg>
                                                            <span class="screen-reader">5</span>
                                                        </label>	
                                                    </div>    
                                                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none">
                                                    <symbol id="star" viewBox="0 0 26 28">
                                                        <path d="M26 10.109c0 .281-.203.547-.406.75l-5.672 5.531 1.344 7.812c.016.109.016.203.016.313 0 .406-.187.781-.641.781a1.27 1.27 0 0 1-.625-.187L13 21.422l-7.016 3.687c-.203.109-.406.187-.625.187-.453 0-.656-.375-.656-.781 0-.109.016-.203.031-.313l1.344-7.812L.39 10.859c-.187-.203-.391-.469-.391-.75 0-.469.484-.656.875-.719l7.844-1.141 3.516-7.109c.141-.297.406-.641.766-.641s.625.344.766.641l3.516 7.109 7.844 1.141c.375.063.875.25.875.719z"/>
                                                    </symbol>
                                                    </svg>
                                                    <div class="review_text">
                                                        <textarea style="display: flex" id="comment" name="comment" rows="5" cols="50" required></textarea>
                                                    </div>
                                                    <button style="margin-top: 10px" type="submit">Comment</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <script>
                                        let selectedStars = 0;

                                        function handleStarClick(value) {
                                            selectedStars = value;
                                            const stars = document.querySelectorAll('.rating i');

                                            stars.forEach((star, index) => {
                                                if (index <= value - 1) {
                                                    star.classList.add('selected');
                                                } else {
                                                    star.classList.remove('selected');
                                                }
                                            });
                                        }
                                    </script>

                                </div>

                                <!-- Members -->
                                <div class="tab_panel members">
                                    <div class="panel_title">Members</div>
                                    <div class="members_list d-flex flex-row flex-wrap align-items-start justify-content-start">
                                        <c:forEach var="lm" items="${listmember}" varStatus="loop">
                                            <div class="member">
                                                <div class="member_image"><img src="assets/images/${lm.avatar}" alt=""></div>
                                                <div class="member_title"><a href="#">${lm.fullname}</a></div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-3">
                            <div class="sidebar">
                                <div class="sidebar_background"></div>
                                <div class=" sidebar_top" style="background-color: #f1f1f1;"><a href="#"></a></div>
                                <div class="sidebar_content">

                                    <!-- Features -->
                                    <div class="sidebar_section features">
                                        <div class="sidebar_title">Course Features</div>
                                        <div class="features_content">
                                            <ul class="features_list">

                                                <!-- Feature -->
                                                <li class="d-flex flex-row align-items-start justify-content-start">
                                                    <div class="feature_title"><i class="fa fa-clock-o" aria-hidden="true"></i><span>The course</span></div>
                                                    <div class="feature_text ml-auto">30 Lessons</div>
                                                </li>

                                                <!-- Feature -->
                                                <li class="d-flex flex-row align-items-start justify-content-start">
                                                    <div class="feature_title"><i class="fa fa-bell" aria-hidden="true"></i><span>Lectures</span></div>
                                                    <div class="feature_text ml-auto">1</div>
                                                </li>

                                                <!-- Feature -->
                                                <li class="d-flex flex-row align-items-start justify-content-start">
                                                    <div class="feature_title"><i class="fa fa-id-badge" aria-hidden="true"></i><span>Tests</span></div>
                                                    <div class="feature_text ml-auto">2</div>
                                                </li>

                                                <!-- Feature -->
                                                <li class="d-flex flex-row align-items-start justify-content-start">
                                                    <div class="feature_title"><i class="fa fa-thumbs-up" aria-hidden="true"></i><span>Pass Percentage</span></div>
                                                    <div class="feature_text ml-auto">60</div>
                                                </li>

                                                <!-- Feature -->
                                                <li class="d-flex flex-row align-items-start justify-content-start">
                                                    <div class="feature_title"><i class="fa fa-thumbs-down" aria-hidden="true"></i><span>Max Retakes</span></div>
                                                    <div class="feature_text ml-auto">5</div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Cert -->
                                    <div class="sidebar_section cert">
                                        <div class="sidebar_title">Certification</div>
                                        <div class="cert_image"><img src="assets/images/cert.jpg" alt=""></div>
                                    </div>
                                </div>
                            </div>
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
        <script src="assets/plugins/parallax-js-master/parallax.min.js"></script>
        <script src="assets/plugins/progressbar/progressbar.min.js"></script>
        <script src="assets/js/course.js"></script>
    </body>
</html>
