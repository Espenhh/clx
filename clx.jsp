<%@ page import="java.security.CodeSource" %>
<!DOCTYPE html>
<html>
<head>
    <title>clx - <%= request.getServletContext().getContextPath() %></title>
</head>
<body style="font-family: Georgia, sans-serif">
<div style="background-image: -webkit-linear-gradient(top, #dcdcdc, #fff); background-image: -moz-linear-gradient(top, #dcdcdc, #fff); overflow: auto; width: 100%; border-radius: 10px">
<h1 style="font-size: 5em; float: left; margin: 10px 40px 0 20px;">clx</h1>

<div style="float: left; margin: 3em 0;">
<form method="get">
    <input name="c" value="${param.c}" size="60" style="border: solid 1px #bababa; font-size: 12pt;">
    <input type="submit" value="search" style="font-size: 14pt; vertical-align: baseline; -webkit-appearance: button;">
</form>
</div>
</div>

<div style="margin-left: 10px">
<%
    String p = request.getParameter("c");
    if (p != null && p.length() > 0) {
        try {
            Class<?> c = Class.forName(p.trim());
            CodeSource codeSource = c.getProtectionDomain().getCodeSource();
            if (codeSource == null) {
                out.println(p);
                out.println("is a system class");
            } else {
                %><b>Location</b> <%= codeSource.getLocation().getFile() %><%
            }

            %><p><b>Classloader hierarchy</b></p><ul><%
    ClassLoader cl = c.getClassLoader();
    while (cl != null) {
        out.println("<li>");
        out.println(cl);
        out.println("</li>");
        cl = cl.getParent();
    }
    %><li>(Bootstrap class loader)</ul><%
} catch (ClassNotFoundException e) {
            %><i>Class not found: <%= p %></i><%
        }
    }


%>
</div>

</body>
</html>
