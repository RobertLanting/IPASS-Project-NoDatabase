<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="nl">
<head>
    <link rel="stylesheet" href="../../resource/css/start.css">
    <meta charset="ISO-8859-1">
    <title>Start</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
</head>
<body>
<main>
<h1 id="titleText">Lijstje</h1>
    <form class="form" action="">
        <input name="username" class="input" type="text" placeholder="gebruikersnaam" required>
        <br>
        <input name="password" class="input" type="password" placeholder="wachtwoord" required>
        <br>
    <button type="submit" class="button">log in</button>
    </form>
    <a href="register" >registreer</a>
</main>
</body>

<script>
    if (window.location.href.indexOf("login") === -1) {
        location.href = "login"
    }
</script>

</html>