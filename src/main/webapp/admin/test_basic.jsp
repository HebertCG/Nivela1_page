<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Test Page</title>
    </head>

    <body>
        <h1>Test Sidebar Inclusion</h1>
        <%@ include file="sidebar-admin.jsp" %>
            <hr>
            <h1>Test Topbar Inclusion</h1>
            <%@ include file="topbar-admin.jsp" %>
    </body>

    </html>