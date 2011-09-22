<%@ page import="java.security.CodeSource" %>
<!DOCTYPE html>
<html>
<head>
    <title>clx - <%= request.getServletContext().getContextPath() %></title>
</head>
<body>
<h1>clx</h1>

<form method="get">
    <input name="c" value="${param.c}" size="60">
    <input type="submit" value="Search">
</form>

<%
    String p = request.getParameter("c");
    if (p != null) {
        try {
            Class<?> c = Class.forName(p.trim());
            CodeSource codeSource = c.getProtectionDomain().getCodeSource();
            if (codeSource == null) {
                %><%= p %> is a system class<%
            } else {
                %><p>Found in</p>
    <p><%= codeSource.getLocation().getFile() %></p><%
            }
        } catch (ClassNotFoundException e) {
            %><i>Class not found: <%= p %></i><%
        }
    }

%>

</body>
</html>
