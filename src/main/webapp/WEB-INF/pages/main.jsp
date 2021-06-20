<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="nl">
<head>
    <link rel="stylesheet" href="../../resource/css/main.css">
    <meta charset="ISO-8859-1">
    <title>Home</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
</head>
<body>
<div class="bg" id="background">
    <div class="form-popup animate__animated animate__zoomIn animate__faster" style="--animate-duration: 0.5s !important;" id="myForm">
        <form action="home" class="form-container">
            <input type="text" placeholder="kies naam" name="name" required>
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
                    <a class="nav-link active" aria-current="page" href="">Home</a>
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

    <div class="hometop">
        <h1 class="welcome">welkom ${name}</h1>
        <button class="buttonhome" onclick="openForm()">nieuw lijstje</button>
    </div>

<c:forEach items="${lists}" var="l">
    <div class="lists">
        <a class="link" href="list?id=${l.getId()}">${l.getName()}
            <h2 class="amount">${l.amountItems()} Producten</h2>

        </a>
        <button class="trash" onclick="location.href='home?id=${l.getId()}'"><i class="fa fa-trash fa-2" style="cursor: pointer"></i></button>
    </div>
</c:forEach>
</main>

</body>
<script>
    function openForm() {
        document.getElementById("myForm").style.display = "block";
        document.getElementById("background").style.display = "block";

    }

    function closeForm() {
        document.getElementById("myForm").style.display = "none";
        document.getElementById("background").style.display = "none";
    }

        if (window.location.href.indexOf("home") === -1) {
        location.href = "home"
    }

</script>
</html>