<%--
  Created by IntelliJ IDEA.
  User: dev-sincerity
  Date: 2022/08/23
  Time: 12:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--header-->
<!--<div class="header_top">&lt;!&ndash;header_top&ndash;&gt;
<div class="container">
<div class="row">
<div class="col-sm-6">
<div class="contactinfo">
<ul class="nav nav-pills">
<li><a href="#"><i class="fa fa-phone"></i> +2 95 01 88 821</a></li>
<li><a href="#"><i class="fa fa-envelope"></i> info@domain.com</a></li>
</ul>
</div>
</div>
<div class="col-sm-6">
<div class="social-icons pull-right">
<ul class="nav navbar-nav">
<li><a href="#"><i class="fa fa-facebook"></i></a></li>
<li><a href="#"><i class="fa fa-twitter"></i></a></li>
<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
<li><a href="#"><i class="fa fa-dribbble"></i></a></li>
<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
</ul>
</div>
</div>
</div>
</div>
</div>--><!--/header_top-->

<div class="header-middle"><!--header-middle-->
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <div class="logo pull-left">
                    <a href="/market/main"><img src="/market/images/home/logo.png" alt="" /></a>
                </div>
                <!--<div class="btn-group pull-right">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                            USA
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="#">Canada</a></li>
                            <li><a href="#">UK</a></li>
                        </ul>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                            DOLLAR
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="#">Canadian Dollar</a></li>
                            <li><a href="#">Pound</a></li>
                        </ul>
                    </div>
                </div>-->
            </div>
            <div class="col-sm-8">
                <div class="shop-menu pull-right">
                    <ul class="nav navbar-nav">
                        <c:choose>
                            <c:when test="${ empty sessionScope.loginmember }">
                                <li><a href="/market/account/login"><i class="fa fa-lock"></i> 로그인</a></li>
                                <li><a href="/market/account/signup"><i class="fa fa-sign-in"></i> 회원가입</a></li>
                            </c:when>
                            <c:otherwise>
                                <%--<li><a href="#"><i class="fa fa-user"></i> 마이페이지</a></li>
                                <li><a href="#"><i class="fa fa-star"></i> 찜리스트</a></li>
                                <li><a href="checkout.html"><i class="fa fa-crosshairs"></i> 결제정보</a></li>
                                <li><a href="cart.html"><i class="fa fa-shopping-cart"></i> 장바구니</a></li>--%>
                                <li><a href="/market/account/logout"><i class="fa fa-unlock-alt"></i>로그아웃</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div><!--/header-middle-->

<div class="header-bottom"><!--header-bottom-->
    <div class="container">
        <div class="row">
            <div class="col-sm-9">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="mainmenu pull-left">
                    <ul class="nav navbar-nav collapse navbar-collapse">
                        <li><a href="/market" class="active">메인</a></li>
                        <li>카테고리1</li>
                        <li>카테고리2</li>
                        <li>카테고리3</li>
                        <li>카테고리4</li>
                        <li>카테고리5</li>
                        <!--<li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                            <ul role="menu" class="sub-menu">
                                <li><a href="shop.html">Products</a></li>
                                <li><a href="product-details.html">Product Details</a></li>
                                <li><a href="checkout.html">Checkout</a></li>
                                <li><a href="cart.html">Cart</a></li>
                                <li><a href="login.html">Login</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                            <ul role="menu" class="sub-menu">
                                <li><a href="blog.html">Blog List</a></li>
                                <li><a href="blog-single.html">Blog Single</a></li>
                            </ul>
                        </li>
                        <li><a href="404.html">404</a></li>
                        <li><a href="contact-us.html">Contact</a></li>-->
                    </ul>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="search_box pull-right">
                    <input type="text" placeholder="Search"/>
                </div>
            </div>
        </div>
    </div>
</div><!--/header-bottom-->
