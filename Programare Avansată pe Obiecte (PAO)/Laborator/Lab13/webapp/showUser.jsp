<%@ page import="pao.unibuc.demo.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<a href='users'>Go back to user list</a>

<h2>Hello <%=((User)request.getAttribute("model")).getName()%>,
    your email address is <%=((User)request.getAttribute("model")).getEmail()%> </h2>

<%--<h2>Hello ${model.name}, your email address is ${model.email}</h2>--%>
<h3>Contacts</h3>
<c:forEach items = "${model.contacts}" var="name">
    <a href='showUser?name=${name}'>${name}</a><p>
</c:forEach>

</body>
</html>