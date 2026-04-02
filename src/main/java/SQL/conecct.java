package SQL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class conecct {

    // 🔹 URL para desarrollo local (NetBeans + PostgreSQL local)
    private static final String URL = "jdbc:postgresql://localhost:5432/academia_a1?sslmode=disable";

    // 🔹 Credenciales locales de PostgreSQL
    private static final String USER = "postgres";
    private static final String PASS = "Hebertjose89";

    // 🔹 Método central de conexión
    public static Connection getConnection() throws SQLException {
        try {
            // Carga del driver JDBC de PostgreSQL
            Class.forName("org.postgresql.Driver");

            // Obtener variables de entorno (Heroku) o usar valores por defecto (Local)
            String dbUrl = System.getenv("JDBC_DATABASE_URL");
            String dbUser = System.getenv("JDBC_DATABASE_USERNAME");
            String dbPass = System.getenv("JDBC_DATABASE_PASSWORD");

            if (dbUrl == null || dbUrl.isEmpty()) {
                dbUrl = URL; // Fallback a local/hardcoded
            }
            if (dbUser == null || dbUser.isEmpty()) {
                dbUser = USER; // Fallback a local/hardcoded
            }
            if (dbPass == null || dbPass.isEmpty()) {
                dbPass = PASS; // Fallback a local/hardcoded
            }

            // Propiedades de conexión
            Properties props = new Properties();
            props.setProperty("user", dbUser);
            props.setProperty("password", dbPass);

            // ⚡ Configurar UTF-8 para evitar problemas con caracteres especiales (ñ, á, é,
            // etc.)
            props.setProperty("characterEncoding", "UTF-8");
            props.setProperty("useUnicode", "true");

            // Intentar conexión
            Connection conn = DriverManager.getConnection(dbUrl, props);
            System.out.println("✅ Conectado correctamente a PostgreSQL Docker");
            return conn;

        } catch (ClassNotFoundException e) {
            throw new SQLException("❌ No se encontró el driver PostgreSQL (agrega postgresql al classpath).", e);

        } catch (SQLException e) {
            // Mostrar detalles completos para diagnóstico
            System.err.println("❌ Error conectando a Base de Datos: " + e.getMessage());
            System.err.println("   SQLState = " + e.getSQLState());
            System.err.println("   Code     = " + e.getErrorCode());
            throw e; // volver a lanzar para que el servlet lo capture si es necesario
        }
    }
}
