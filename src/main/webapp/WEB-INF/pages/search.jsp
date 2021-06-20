<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="nl">
<head>
    <link rel="stylesheet" href="../../resource/css/search.css">
    <meta charset="ISO-8859-1">
    <title>Home</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
</head>
<c:if test="${product != null}">
<div class="productadded animate__animated animate__fadeInDown animate__faster">
    <img alt="product" src="${product.getPicture()}">
    <div class="popuptextdiv">
        <span class="popuptext">${product.getName()}</span>
        <span class="popupprice">${product.getPrice()}</span>
        <c:if test="${product.getOldPrice() > 0}">
            <span class="popupold">${product.getOldPrice()}</span>
            <script>
            var price = document.getElementsByClassName("popupprice")[0]
            price.classList.remove("popupprice")
            price.classList.add("popuppricebonus")
            </script>
        </c:if>
    </div>
    <br>
    <span class="toegevoegd">product toegevoegd</span>
    <script>
        var popup = document.getElementsByClassName("productadded")[0]
        popup.style.display = "inline-flex"
        window.setTimeout(function () {popup.style.display = "none"}, 2000)
    </script>
    </c:if>
</div>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand">Lijstje</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link " aria-current="page" href="home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="https://www.ah.nl/bonus" target="_blank">Kortingen</a>
                    </li>
                </ul>
            <a class="logout" aria-current="page" href="logout">log uit <i class="fa fa-sign-out" aria-hidden="true"></i></a>
            </div>
        </div>
    </nav>
    <main>
        <h1 class="title">zoek naar producten</h1>
        <div class="toppage">
            <div class="topleft">
    <form class="searchbar" action="">
    <input class="searchbarinput" type="text" name="search">
        <button class="searchbutton" type="submit"><i class="fa fa-search"></i></button>
    </form>
            <a class="back" href="manual">maak een product</a>
            </div>
            <a class="back" href="list">terug <i class="fa fa-shopping-cart"></i></a>
        </div>
    <div class="all-products">
<c:forEach items="${products}" var="p">
    <div id="${p.getName()}" class="info">
    <img alt="Product" src="${p.getPicture()}">
    <br>
        <p class="name">${p.getName()}</p>
        <p class="description">${p.getDescription()}</p>
        <div class="bottom-info">
            <div class="prices">
            <p id="${p.getId()}" class="price">${p.getPrice()}</p>
    <c:if test="${p.getOldPrice() > 0}">
        <p class="old-price"> ${p.getOldPrice()}</p>
        <script>
            document.getElementById("${p.getId()}").classList.remove("price")
            document.getElementById("${p.getId()}").classList.add("priceBonus")
        </script>
    </c:if>
            </div>
            <button class="addbutton" type="button" onclick="location.href='?product=${p.getId()}'">+</button>
        </div>
    </div>
</c:forEach>
    </div>
    </main>
</body>
</html>
<script>
    document.addEventListener("DOMContentLoaded", function (event) {
        var scrollpos = sessionStorage.getItem('scrollpos');
        if (scrollpos) {
            window.scrollTo(0, scrollpos);
            sessionStorage.removeItem('scrollpos');
        }
    });

    window.addEventListener("beforeunload", function (e) {
        sessionStorage.setItem('scrollpos', window.scrollY);
    });
</script>



