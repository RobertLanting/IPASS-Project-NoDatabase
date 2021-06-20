<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="nl">
<head>
    <link rel="stylesheet" href="../../resource/css/manual.css">
    <meta charset="ISO-8859-1">
    <title>Home</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
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
    <div class="inputside">
    <h1 class="title">maak je eigen product</h1>
    <form>
    <input name="name" class="input" type="text" placeholder="naam">
    <br>
    <input name="description" class="input" type="text" placeholder="beschrijving">
    <br>
    <input name="price" class="input" min="0" type="number" placeholder="prijs" step="0.01">
    <br>
    <button type="submit" class="button">maak</button>
    </form>
        <button class="backbutton" onclick="location.href='search'">terug</button>
    </div>
    <div class="resultside">
    <c:forEach items="${products}" var="p">
    <div id="${p.getName()}" class="info">
        <button class="trash" onclick="location.href='manual?trashid=${p.getId()}'"><i class="fa fa-trash fa-2" style="cursor: pointer"></i></button>
        <p class="name">${p.getName()}</p>
        <p class="description">${p.getDescription()}</p>
        <div class="bottom-info">
            <div class="prices">
                <p id="${p.getId()}" class="price">${p.getPrice()}</p>
            </div>
            <button class="addbutton" type="button" onclick="location.href='?product=${p.getId()}#${p.getName()}'">+</button>
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