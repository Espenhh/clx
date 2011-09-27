<%@ page import="java.security.CodeSource" %>
<%@ page import="java.net.URL" %>
<!DOCTYPE html>
<html>
<head>
    <title>clx - <%= request.getContextPath() %></title>
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
    String className = request.getParameter("c");
    if (className != null && className.length() > 0) {
        try {
            Class<?> c = Class.forName(className.trim());
            CodeSource codeSource = c.getProtectionDomain().getCodeSource();
            if (codeSource == null) {
                out.println(className);
                out.println("is a system class");
            } else {
                %><b>Location</b> <%= codeSource.getLocation().getFile() %><%
            }

    %><p><b>Classloader hierarchy</b></p><ul><%
    ClassLoader cl = c.getClassLoader();
    while (cl != null) {
        out.println("<li>");
        if ("org.apache.catalina.loader.StandardClassLoader".equals(cl.getClass().toString())) {
            System.out.println("jada");
        }
        out.println(cl);
        URL classUrl = cl.getResource(className.replace('.', '/') + ".class");
        if (classUrl != null) {
            out.print("<b>Location: " + classUrl + "</b>");
        }
        out.println("</li>");
        cl = cl.getParent();
    }
    %><li>(Bootstrap class loader)</ul><%
} catch (ClassNotFoundException e) {
            %><i>Class not found: <%= className %></i><%
        }
    }


%>
</div>

</body>
</html>
