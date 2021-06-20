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
    <p id="titleText2">Lijstje</p>
    <h3>maak een nieuw account</h3>
    <c:if test="${error != null}">
    <p class="error">${error}</p>
    </c:if>
    <form class="form" action="login">
        <input name="regmail" class="input" type="text" placeholder="Mail" required>
        <br>
        <input name="regusername" class="input" type="text"  placeholder="gebruikersnaam" required>
        <br>
        <input name="regpassword" class="input" type="password" placeholder="wachtwoord" required>
        <br>
        <button type="submit" class="button">registreer</button>
    </form>
    <a href="login" >log in</a>
</main>
</body>

</html>