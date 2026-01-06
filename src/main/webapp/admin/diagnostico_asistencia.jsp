<%@page import="java.sql.*" %>
    <%@page import="SQL.conecct" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Diagnostico DB</title>
                <style>
                    table {
                        border-collapse: collapse;
                        width: 100%;
                    }

                    th,
                    td {
                        border: 1px solid black;
                        padding: 5px;
                    }
                </style>
            </head>

            <body>
                <h1>Diagnostico: asistencia_registros</h1>

                <h3>1. Estructura</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Col</th>
                            <th>Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% Connection conn=null; Statement stmt=null; ResultSet rs=null; try {
                            conn=conecct.getConnection(); stmt=conn.createStatement(); rs=stmt.executeQuery("DESCRIBE
                            asistencia_registros"); while(rs.next()) { %>
                            <tr>
                                <td>
                                    <%= rs.getString(1) %>
                                </td>
                                <td>
                                    <%= rs.getString(2) %>
                                </td>
                            </tr>
                            <% } } catch(Exception e) { out.println("<tr>
                                <td colspan='2'>Error: " + e.toString() + "</td>
                                </tr>");
                                } finally {
                                if(rs!=null) rs.close();
                                if(stmt!=null) stmt.close();
                                if(conn!=null) conn.close();
                                }
                                %>
                    </tbody>
                </table>

                <h3>2. Datos (Ultimos 10)</h3>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Est_ID</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Presente</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% try { conn=conecct.getConnection(); stmt=conn.createStatement(); rs=stmt.executeQuery("SELECT
                            * FROM asistencia_registros ORDER BY fecha_clase DESC, id DESC LIMIT 10"); while(rs.next())
                            { %>
                            <tr>
                                <td>
                                    <%= rs.getString("id") %>
                                </td>
                                <td>
                                    <%= rs.getString("estudiante_id") %>
                                </td>
                                <td>
                                    <%= rs.getString("fecha_clase") %>
                                </td>
                                <td><b>
                                        <%= rs.getString("estado") %>
                                    </b></td>
                                <td>
                                    <%= rs.getString("presente") %>
                                </td>
                            </tr>
                            <% } } catch(Exception e) { out.println("<tr>
                                <td colspan='5'>Error: " + e.toString() + "</td>
                                </tr>");
                                } finally {
                                if(rs!=null) rs.close();
                                if(stmt!=null) stmt.close();
                                if(conn!=null) conn.close();
                                }
                                %>
                    </tbody>
                </table>
            </body>

            </html>