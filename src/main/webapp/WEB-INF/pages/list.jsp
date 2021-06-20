<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="nl">
<head>
    <link rel="stylesheet" href="../../resource/css/list.css">
    <meta charset="ISO-8859-1">
    <title>Home</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
</head>
<body>
<div class="bg" id="background">
    <div class="form-popup animate__animated animate__zoomIn animate__faster" style="--animate-duration: 0.5s !important;" id="myForm">
        <form action="list" class="form-container">
            <input type="text" placeholder="geef gebruikersnaam" name="usernameadd" required>
            <div class="buttons">
                <button type="button" class="btn cancel" onclick="closeForm()">annuleer</button>
                <button type="submit" class="btn">voeg toe</button>
            </div>
        </form>
    </div>
</div>
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
    <div class="listtop">
        <div class="listtoptext">
<h1 class="listname">${userlist.getName()}</h1>
    <h2 class="listamount">${userlist.amountItems()} producten</h2>
        </div>
        <div class="listtopright">
            <div class="leavebuttons">
                <a class="leavelist" href="home?leavelist=true"><i class="fa fa-sign-out" aria-hidden="true"></i></a>
        <a class="removelist" href="home?removelist=${userlist.getId()}"><i class="fa fa-trash fa-2"></i></a>
            </div>
        <div class="addbuttons">
            <button class="button" onclick="openForm()">voeg gebruiker toe</button>
        <button class="button" onclick="location.href='search'">voeg product toe</button>
        </div>
        </div>
        </div>
    <div class="users">
        <c:forEach items="${userlist.getUsers()}" var="u">
            <div class="user">${u.getUsername()}
                <c:if test="${!user.getUsername().equals(u.getUsername())}">
                <form>
                    <a class="remove" href="list?usernameremove=${u.getUsername()}"><i class="fa fa-trash fa-2"></i></a>
                </form>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <div class="shoplist">
        <c:if test="${userlist.amountItems() == 0}">
            <h2 class="geenproducten">geen producten</h2>
        </c:if>
        <c:forEach items="${userlist.getProductlist()}" var="l">
            <div class="product">
                <div class="infoimage">
                <img alt="product" class="foto" src="${l.getProduct().getPicture()}" onerror="this.onerror=null;this.src='images/not_found.png'">
                <div class="productinfo">
                <p class="productname">${l.getProduct().getName()}</p>
                    <p class="productdescription">${l.getProduct().getDescription()}</p>
                </div>
                </div>
                <div class="amountproduct">
                    <a class="amountbutton" href="list?itemmin=${l.getProduct().getId()}">-</a>
                    <p class="amount">${l.getAmount()}</p>
                    <a class="amountbutton" href="list?itemplus=${l.getProduct().getId()}">+</a>
                </div>
                <a class="trashicon" href="list?trash=${l.getProduct().getId()}"><i class="fa fa-trash fa-2" style="width: 100%; height: 100%; cursor: pointer"></i></a>
                <div class="pricediv">
                <p id="${l.getProduct().getId()}" class="productprice">${l.getPrice()}</p>
                <c:if test="${l.getProduct().getOldPrice() > 0}">
                    <p class="productoldprice">${l.getOldPrice()}</p>
                    <script>
                        document.getElementById("${l.getProduct().getId()}").classList.remove("productprice")
                        document.getElementById("${l.getProduct().getId()}").classList.add("productpriceBonus")
                    </script>
                </c:if>
                </div>
            </div>
            <hr>
        </c:forEach>
        <div class="endlist">
            <c:if test="${userlist.getBonus() > 0}">
                <p class="priceBonus">voordeel ${userlist.getBonus()}</p>
            </c:if>
            <p class="price">totaal ${userlist.getTotalPrice()}</p>
        </div>
    </div>

</main>
</body>
</html>
<script>
    function openForm() {
        document.getElementById("myForm").style.display = "block";
        document.getElementById("background").style.display = "block";

    }

    function closeForm() {
        document.getElementById("myForm").style.display = "none";
        document.getElementById("background").style.display = "none";
    }

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