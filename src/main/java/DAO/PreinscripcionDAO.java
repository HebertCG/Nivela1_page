package DAO;

import SQL.conecct;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import modelo.Preinscripcion;

public class PreinscripcionDAO {

    public int getIdPorDni(String dni) {
        String sql = "SELECT id FROM preinscripcion WHERE dni = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Preinscripcion obtenerPorId(int id) {
        String sql = "SELECT * FROM preinscripcion WHERE id = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Preinscripcion p = new Preinscripcion();
                p.setId(rs.getInt("id"));
                p.setNombres(rs.getString("nombre"));
                p.setApellidos(rs.getString("apellido"));
                p.setDni(rs.getString("dni"));
                p.setMontoTotal(rs.getDouble("monto_total"));
                p.setMontoPagado(rs.getDouble("monto_pagado"));
                p.setSaldoPendiente(rs.getDouble("saldo_pendiente"));
                p.setModalidadPago(rs.getString("modalidad_pago"));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Verifica si ya existe un registro con el mismo DNI
     * Email y nombre pueden repetirse (hermanos usando mismo email)
     */
    public boolean existeDuplicado(String dni, String correo, String nombre, String apellido) {
        String sql = "SELECT COUNT(*) FROM preinscripcion WHERE dni=?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }

    }

    /**
     * Verifica si ya existe un número de operación registrado
     * Este debe ser ÚNICO para evitar fraudes
     */
    public boolean existeNumeroOperacion(String numeroOperacion) {
        if (numeroOperacion == null || numeroOperacion.trim().isEmpty()) {
            return false; // NULL no cuenta como duplicado
        }

        String sql = "SELECT COUNT(*) FROM preinscripcion WHERE referencia_pago = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, numeroOperacion.trim());
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return true; // Por seguridad, rechazar en caso de error
        }
    }

    public void guardar(Preinscripcion p) {
        int idExistente = getIdPorDni(p.getDni());
        try (Connection con = conecct.getConnection()) {
            if (idExistente == 0) {
                // INSERT NUEVO
                String sqlPre = "INSERT INTO preinscripcion "
                        + "(nombre, apellido, dni, email, direccion, colegio, carrera, estado) "
                        + "VALUES (?,?,?,?,?,?,?, 'pendiente')";
                PreparedStatement ps = con.prepareStatement(sqlPre, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, p.getNombres());
                ps.setString(2, p.getApellidos());
                ps.setString(3, p.getDni());
                ps.setString(4, p.getCorreo());
                ps.setString(5, p.getDireccion());
                ps.setString(6, p.getColegio());
                ps.setString(7, p.getCarrera());
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    idExistente = rs.getInt(1);
                }
            } else {
                // UPDATE EXISTENTE â†’ vuelve a pendiente
                String sqlUpd = "UPDATE preinscripcion SET "
                        + "nombre=?, apellido=?, email=?, direccion=?, colegio=?, carrera=?, estado='pendiente' "
                        + "WHERE id = ?";
                PreparedStatement psUpd = con.prepareStatement(sqlUpd);
                psUpd.setString(1, p.getNombres());
                psUpd.setString(2, p.getApellidos());
                psUpd.setString(3, p.getCorreo());
                psUpd.setString(4, p.getDireccion());
                psUpd.setString(5, p.getColegio());
                psUpd.setString(6, p.getCarrera());
                psUpd.setInt(7, idExistente);
                psUpd.executeUpdate();
            }

            // ahora telÃ©fono (siempre upsert tambiÃ©n)
            String sqlTelCheck = "SELECT COUNT(*) FROM telefono WHERE id_preinscripcion = ?";
            PreparedStatement psCheck = con.prepareStatement(sqlTelCheck);
            psCheck.setInt(1, idExistente);
            ResultSet rs2 = psCheck.executeQuery();
            boolean telExiste = false;
            if (rs2.next())
                telExiste = rs2.getInt(1) > 0;

            if (telExiste) {
                String sqlTelUpd = "UPDATE telefono SET numero = ? WHERE id_preinscripcion = ?";
                PreparedStatement psTelUpd = con.prepareStatement(sqlTelUpd);
                psTelUpd.setString(1, p.getTelefono());
                psTelUpd.setInt(2, idExistente);
                psTelUpd.executeUpdate();
            } else {
                String sqlTelIns = "INSERT INTO telefono (id_preinscripcion, numero) VALUES (?,?)";
                PreparedStatement psTelIns = con.prepareStatement(sqlTelIns);
                psTelIns.setInt(1, idExistente);
                psTelIns.setString(2, p.getTelefono());
                psTelIns.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public String obtenerEstadoPorDni(String dni) {
        String sql = "SELECT estado FROM preinscripcion WHERE dni=?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getString("estado");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "no_encontrado";
    }

    public List<Preinscripcion> listarPorEstado(String estadoBuscado) {
        List<Preinscripcion> lista = new ArrayList<>();
        String sql = "SELECT * FROM preinscripcion WHERE estado = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estadoBuscado);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Preinscripcion p = new Preinscripcion();
                p.setId(rs.getInt("id"));
                p.setNombres(rs.getString("nombre"));
                p.setApellidos(rs.getString("apellido"));
                p.setCorreo(rs.getString("email"));
                p.setDni(rs.getString("dni"));
                p.setDireccion(rs.getString("direccion"));
                p.setColegio(rs.getString("colegio"));
                p.setCarrera(rs.getString("carrera"));
                p.setEstado(rs.getString("estado"));
                p.setIntentos(rs.getInt("intentos"));
                p.setNombreApoderado(rs.getString("nombre_apoderado"));
                p.setApellidoApoderado(rs.getString("apellido_apoderado"));
                p.setTelefonoApoderado(rs.getString("telefono_apoderado"));
                p.setMetodoPago(rs.getString("metodo_pago"));
                p.setReferenciaPago(rs.getString("referencia_pago"));
                p.setComprobantePago(rs.getString("comprobante_pago"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void actualizarEstado(String dni, String nuevoEstado) {
        String sql = "UPDATE preinscripcion SET estado = ? WHERE dni = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setString(2, dni);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getIntentos(String dni) {
        String sql = "SELECT intentos FROM preinscripcion WHERE dni = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt("intentos");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void incrementarIntentos(String dni) {
        String sql = "UPDATE preinscripcion SET intentos = intentos + 1 WHERE dni = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void resetIntentos(String dni) {
        String sql = "UPDATE preinscripcion SET intentos = 0 WHERE dni = ?";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertarUsuarioDesdePreinscripcion(Preinscripcion pre, String password) {
        String sql = "INSERT INTO usuarios "
                + "(correo, password, nombre, apellido, carrera, id_rol, estado) "
                + "VALUES (?, ?, ?, ?, ?, 3, 1)";
        try (Connection con = conecct.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            String correoGenerado = "u" + pre.getDni() + "@academiaA1.com";

            ps.setString(1, correoGenerado);
            ps.setString(2, password);
            ps.setString(3, pre.getNombres());
            ps.setString(4, pre.getApellidos());
            ps.setString(5, pre.getCarrera());
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error al insertar alumno desde preinscripciÃ³n: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public int insertarPublica(String nombre, String apellido, String dni,
            String email, String direccion, String colegio, String carrera, String grado,
            String nombreApoderado, String apellidoApoderado, String emailApoderado,
            String telefono1Apoderado, String telefono2Apoderado,
            String modalidadPago, String metodoPago, String referenciaPago, String comprobantePago)
            throws SQLException {

        // Calcular montos según grado y modalidad
        util.PreciosPreinscripcion precios = new util.PreciosPreinscripcion();
        double[] montos = precios.calcularMontos(grado, modalidadPago);
        double montoTotal = montos[0];
        double primeraCuota = montos[1];

        // Calcular saldo pendiente
        double saldoPendiente = montoTotal - primeraCuota;

        // Determinar estado de pago
        String estadoPago = modalidadPago.equals("contado") ? "completo" : "pendiente";

        // Fecha límite para 2da cuota (30 enero 2026)
        java.sql.Date fechaLimite = modalidadPago.equals("cuotas") ? java.sql.Date.valueOf("2026-01-30") : null;

        String sql = "INSERT INTO preinscripcion (nombre, apellido, dni, email, direccion, colegio, carrera, grado, " +
                "nombre_apoderado, apellido_apoderado, email_apoderado, telefono_apoderado, telefono2_apoderado, " +
                "modalidad_pago, metodo_pago, referencia_pago, comprobante_pago, " +
                "monto_total, monto_pagado, saldo_pendiente, estado_pago, fecha_limite_2da_cuota, " +
                "estado, origen, intentos, seccion_id, intereses, escaneo_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pendiente', 'online', 0, NULL, NULL, NULL)";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Debug: Ver qué valor de comprobante llega al DAO
            System.out.println("🔍 DEBUG DAO - comprobantePago recibido: '" + comprobantePago + "'");

            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, dni);
            ps.setString(4, email);
            ps.setString(5, direccion);
            ps.setString(6, colegio);
            ps.setString(7, carrera);
            ps.setString(8, grado);
            ps.setString(9, nombreApoderado);
            ps.setString(10, apellidoApoderado);
            ps.setString(11, emailApoderado);
            ps.setString(12, telefono1Apoderado);
            ps.setString(13, telefono2Apoderado);
            ps.setString(14, modalidadPago);
            ps.setString(15, metodoPago);
            ps.setString(16, referenciaPago);
            ps.setString(17, comprobantePago);
            ps.setDouble(18, montoTotal);
            ps.setDouble(19, primeraCuota);
            ps.setDouble(20, saldoPendiente);
            ps.setString(21, estadoPago);
            ps.setDate(22, fechaLimite);

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                // Obtener el ID generado
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

            return 0;

        } catch (SQLException e) {
            // Temporalmente desactivado para pruebas
            // if (e.getErrorCode() == 1062) {
            // return -1; // Duplicado
            // }
            System.err.println("ERROR SQL en insertarPublica: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public boolean insertarManual(String nombre, String apellido, String dni,
            String email, String direccion, String colegio, String carrera, String grado,
            String nombreApoderado, String apellidoApoderado, String emailApoderado,
            String telefono1Apoderado, String telefono2Apoderado,
            String modalidadPago, String metodoPago, String referenciaPago, String estadoInicial)
            throws SQLException {

        // Calcular montos según grado y modalidad
        double[] montos = util.PreciosPreinscripcion.calcularMontos(grado, modalidadPago);
        double montoTotal = montos[0];
        double primeraCuota = montos[1];
        double saldoPendiente = montoTotal - primeraCuota;
        String estadoPago = modalidadPago.equals("contado") ? "completo" : "pendiente";
        java.sql.Date fechaLimite = modalidadPago.equals("cuotas") ? java.sql.Date.valueOf("2026-01-30") : null;

        String sql = "INSERT INTO preinscripcion (nombre, apellido, dni, email, direccion, colegio, carrera, grado, " +
                "nombre_apoderado, apellido_apoderado, email_apoderado, telefono_apoderado, telefono2_apoderado, " +
                "modalidad_pago, metodo_pago, referencia_pago, comprobante_pago, " +
                "monto_total, monto_pagado, saldo_pendiente, estado_pago, fecha_limite_2da_cuota, " +
                "estado, origen, intentos) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NULL, ?, ?, ?, ?, ?, ?, 'manual', 0)";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, dni);
            ps.setString(4, email);
            ps.setString(5, direccion);
            ps.setString(6, colegio);
            ps.setString(7, carrera);
            ps.setString(8, grado);
            ps.setString(9, nombreApoderado);
            ps.setString(10, apellidoApoderado);
            ps.setString(11, emailApoderado);
            ps.setString(12, telefono1Apoderado);
            ps.setString(13, telefono2Apoderado);
            ps.setString(14, modalidadPago);
            ps.setString(15, metodoPago);
            ps.setString(16, referenciaPago);
            ps.setDouble(17, montoTotal);
            ps.setDouble(18, primeraCuota);
            ps.setDouble(19, saldoPendiente);
            ps.setString(20, estadoPago);
            ps.setDate(21, fechaLimite);
            ps.setString(22, estadoInicial); // Estado dinámico basado en método de pago

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                return false;
            }
            throw e;
        }
    }

    public List<Preinscripcion> listarTodas() {
        List<Preinscripcion> lista = new ArrayList<>();
        String sql = "SELECT id, fecha_registro, nombre, apellido, dni, email, direccion, colegio, carrera, grado, " +
                "nombre_apoderado, apellido_apoderado, email_apoderado, telefono_apoderado, telefono2_apoderado, " +
                "modalidad_pago, metodo_pago, referencia_pago, comprobante_pago, " +
                "monto_total, monto_pagado, saldo_pendiente, estado_pago, " +
                "estado, origen, intentos FROM preinscripcion ORDER BY id DESC";

        System.out.println("=== DEBUG LISTAR TODAS ===");
        System.out.println("SQL ejecutado: " + sql);

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Preinscripcion p = new Preinscripcion();
                p.setId(rs.getInt("id"));
                p.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                p.setNombres(rs.getString("nombre"));
                p.setApellidos(rs.getString("apellido"));
                p.setDni(rs.getString("dni"));
                p.setCorreo(rs.getString("email"));
                p.setDireccion(rs.getString("direccion"));
                p.setColegio(rs.getString("colegio"));
                p.setCarrera(rs.getString("carrera"));
                p.setGrado(rs.getString("grado"));
                p.setEstado(rs.getString("estado"));
                p.setOrigen(rs.getString("origen"));
                p.setIntentos(rs.getInt("intentos"));

                // Datos del apoderado
                p.setNombreApoderado(rs.getString("nombre_apoderado"));
                p.setApellidoApoderado(rs.getString("apellido_apoderado"));
                p.setTelefonoApoderado(rs.getString("telefono_apoderado"));

                // Datos de pago
                p.setModalidadPago(rs.getString("modalidad_pago"));
                p.setMetodoPago(rs.getString("metodo_pago"));
                p.setReferenciaPago(rs.getString("referencia_pago"));
                p.setComprobantePago(rs.getString("comprobante_pago"));
                p.setMontoTotal(rs.getDouble("monto_total"));
                p.setMontoPagado(rs.getDouble("monto_pagado"));
                p.setSaldoPendiente(rs.getDouble("saldo_pendiente"));
                p.setEstadoPago(rs.getString("estado_pago"));

                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    /**
     * Lista preinscripciones con saldo pendiente (deudores)
     * 
     * @param filtro "todos", "vencidos", "porvencer"
     */
    public List<Preinscripcion> listarDeudores(String filtro) {
        List<Preinscripcion> lista = new ArrayList<>();
        String sql = "SELECT * FROM preinscripcion WHERE modalidad_pago = 'cuotas' AND saldo_pendiente > 0";

        if ("vencidos".equals(filtro)) {
            sql += " AND fecha_limite_2da_cuota < CURDATE()";
        } else if ("porvencer".equals(filtro)) {
            sql += " AND fecha_limite_2da_cuota BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";
        }

        sql += " ORDER BY fecha_limite_2da_cuota ASC";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Preinscripcion p = new Preinscripcion();
                p.setId(rs.getInt("id"));
                p.setNombres(rs.getString("nombre"));
                p.setApellidos(rs.getString("apellido"));
                p.setDni(rs.getString("dni"));
                p.setCorreo(rs.getString("email"));
                p.setGrado(rs.getString("grado"));
                p.setCarrera(rs.getString("carrera"));
                p.setModalidadPago(rs.getString("modalidad_pago"));
                p.setMontoTotal(rs.getDouble("monto_total"));
                p.setMontoPagado(rs.getDouble("monto_pagado"));
                p.setSaldoPendiente(rs.getDouble("saldo_pendiente"));
                p.setEstadoPago(rs.getString("estado_pago"));
                p.setFechaLimite2daCuota(rs.getDate("fecha_limite_2da_cuota"));
                p.setNombreApoderado(rs.getString("nombre_apoderado"));
                p.setApellidoApoderado(rs.getString("apellido_apoderado"));
                p.setTelefonoApoderado(rs.getString("telefono_apoderado"));
                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    /**
     * Actualiza el monto pagado y saldo pendiente después de un pago
     */
    public void actualizarPago(int id, double montoPagado) {
        String sql = "UPDATE preinscripcion SET " +
                "monto_pagado = monto_pagado + ?, " +
                "saldo_pendiente = saldo_pendiente - ?, " +
                "estado_pago = CASE WHEN (saldo_pendiente - ?) <= 0 THEN 'completo' ELSE estado_pago END " +
                "WHERE id = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, montoPagado);
            ps.setDouble(2, montoPagado);
            ps.setDouble(3, montoPagado);
            ps.setInt(4, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Corrige la modalidad de pago y recalcula montos
     */
    public void corregirModalidadPago(int id, String nuevaModalidad, String grado) {
        // Importar la clase utility
        util.PreciosPreinscripcion precios = new util.PreciosPreinscripcion();
        double[] montos = precios.calcularMontos(grado, nuevaModalidad);

        double nuevoMontoTotal = montos[0];
        double nuevoPrimeraCuota = montos[1];

        String sql = "UPDATE preinscripcion SET " +
                "modalidad_pago = ?, " +
                "monto_total = ?, " +
                "saldo_pendiente = ? - monto_pagado " +
                "WHERE id = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nuevaModalidad);
            ps.setDouble(2, nuevoMontoTotal);
            ps.setDouble(3, nuevoMontoTotal);
            ps.setInt(4, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Obtiene datos financieros completos con métricas y filtros
     * 
     * @param filtroEstado "todos", "pagados", "deudores"
     * @param grado        null para todos, o grado específico
     * @return Map con "preinscripciones", "totalEsperado", "totalRecaudado",
     *         "totalPendiente"
     */
    public Map<String, Object> obtenerDatosFinancieros(String filtroEstado, String grado) {
        Map<String, Object> resultado = new HashMap<>();
        List<Preinscripcion> lista = new ArrayList<>();

        // Construir SQL con filtros
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, fecha_registro, nombre, apellido, dni, email, direccion, colegio, carrera, grado, ");
        sql.append("nombre_apoderado, apellido_apoderado, email_apoderado, telefono_apoderado, telefono2_apoderado, ");
        sql.append("modalidad_pago, metodo_pago, referencia_pago, comprobante_pago, ");
        sql.append("monto_total, monto_pagado, saldo_pendiente, estado_pago, fecha_limite_2da_cuota, ");
        sql.append("estado, origen, intentos FROM preinscripcion WHERE estado = 'aceptado'");

        // Filtro por estado de pago
        if ("pagados".equals(filtroEstado)) {
            sql.append(" AND saldo_pendiente = 0");
        } else if ("deudores".equals(filtroEstado)) {
            sql.append(" AND saldo_pendiente > 0");
        }

        // Filtro por grado
        if (grado != null && !grado.isEmpty()) {
            sql.append(" AND grado = ?");
        }

        sql.append(" ORDER BY fecha_registro DESC");

        double totalEsperado = 0;
        double totalRecaudado = 0;
        double totalPendiente = 0;

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            // Setear parámetro de grado si existe
            if (grado != null && !grado.isEmpty()) {
                ps.setString(1, grado);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Preinscripcion p = new Preinscripcion();
                p.setId(rs.getInt("id"));
                p.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                p.setNombres(rs.getString("nombre"));
                p.setApellidos(rs.getString("apellido"));
                p.setDni(rs.getString("dni"));
                p.setCorreo(rs.getString("email"));
                p.setDireccion(rs.getString("direccion"));
                p.setColegio(rs.getString("colegio"));
                p.setCarrera(rs.getString("carrera"));
                p.setGrado(rs.getString("grado"));
                p.setEstado(rs.getString("estado"));
                p.setOrigen(rs.getString("origen"));
                p.setIntentos(rs.getInt("intentos"));

                // Datos del apoderado
                p.setNombreApoderado(rs.getString("nombre_apoderado"));
                p.setApellidoApoderado(rs.getString("apellido_apoderado"));
                p.setEmailApoderado(rs.getString("email_apoderado"));
                p.setTelefonoApoderado(rs.getString("telefono_apoderado"));
                p.setTelefono2Apoderado(rs.getString("telefono2_apoderado"));

                // Datos de pago
                p.setModalidadPago(rs.getString("modalidad_pago"));
                p.setMetodoPago(rs.getString("metodo_pago"));
                p.setReferenciaPago(rs.getString("referencia_pago"));
                p.setComprobantePago(rs.getString("comprobante_pago"));
                p.setMontoTotal(rs.getDouble("monto_total"));
                p.setMontoPagado(rs.getDouble("monto_pagado"));
                p.setSaldoPendiente(rs.getDouble("saldo_pendiente"));
                p.setEstadoPago(rs.getString("estado_pago"));
                p.setFechaLimite2daCuota(rs.getDate("fecha_limite_2da_cuota"));

                // Acumular totales
                totalEsperado += rs.getDouble("monto_total");
                totalRecaudado += rs.getDouble("monto_pagado");
                totalPendiente += rs.getDouble("saldo_pendiente");

                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        resultado.put("preinscripciones", lista);
        resultado.put("totalEsperado", totalEsperado);
        resultado.put("totalRecaudado", totalRecaudado);
        resultado.put("totalPendiente", totalPendiente);

        return resultado;
    }

    /**
     * Actualiza los datos de pago de una preinscripción
     * Permite al admin corregir: montos, método y modalidad de pago
     */
    public boolean actualizarDatosPago(int id, double montoTotal, double montoPagado,
            String metodoPago, String modalidadPago) {
        String sql = "UPDATE preinscripcion SET " +
                "monto_total = ?, " +
                "monto_pagado = ?, " +
                "saldo_pendiente = ? - ?, " +
                "metodo_pago = ?, " +
                "modalidad_pago = ? " +
                "WHERE id = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, montoTotal);
            ps.setDouble(2, montoPagado);
            ps.setDouble(3, montoTotal);
            ps.setDouble(4, montoPagado);
            ps.setString(5, metodoPago);
            ps.setString(6, modalidadPago);
            ps.setInt(7, id);

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
