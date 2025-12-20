package DAO;

import SQL.conecct;
import modelo.Pago;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para gestionar pagos de preinscripciones
 */
public class PagoDAO {

    /**
     * Registra un pago en la base de datos
     */
    public boolean registrarPago(Pago pago) {
        String sql = "INSERT INTO pagos (id_preinscripcion, numero_cuota, monto, " +
                "metodo_pago, referencia_pago, comprobante_pago, registrado_por, notas) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pago.getIdPreinscripcion());
            ps.setInt(2, pago.getNumeroCuota());
            ps.setDouble(3, pago.getMonto());
            ps.setString(4, pago.getMetodoPago());
            ps.setString(5, pago.getReferenciaPago());
            ps.setString(6, pago.getComprobantePago());
            ps.setString(7, pago.getRegistradoPor());
            ps.setString(8, pago.getNotas());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lista todos los pagos de una preinscripción
     */
    public List<Pago> listarPagosPorPreinscripcion(int idPreinscripcion) {
        List<Pago> pagos = new ArrayList<>();
        String sql = "SELECT * FROM pagos WHERE id_preinscripcion = ? ORDER BY fecha_pago DESC";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idPreinscripcion);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pago pago = new Pago();
                pago.setId(rs.getInt("id"));
                pago.setIdPreinscripcion(rs.getInt("id_preinscripcion"));
                pago.setNumeroCuota(rs.getInt("numero_cuota"));
                pago.setMonto(rs.getDouble("monto"));
                pago.setMetodoPago(rs.getString("metodo_pago"));
                pago.setReferenciaPago(rs.getString("referencia_pago"));
                pago.setComprobantePago(rs.getString("comprobante_pago"));
                pago.setFechaPago(rs.getTimestamp("fecha_pago"));
                pago.setRegistradoPor(rs.getString("registrado_por"));
                pago.setNotas(rs.getString("notas"));
                pagos.add(pago);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pagos;
    }

    /**
     * Obtiene el total pagado de una preinscripción
     */
    public double obtenerTotalPagado(int idPreinscripcion) {
        String sql = "SELECT SUM(monto) as total FROM pagos WHERE id_preinscripcion = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idPreinscripcion);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0.0;
    }

    /**
     * Verifica si existe un pago para una cuota específica
     */
    public boolean existePagoCuota(int idPreinscripcion, int numeroCuota) {
        String sql = "SELECT COUNT(*) as total FROM pagos WHERE id_preinscripcion = ? AND numero_cuota = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idPreinscripcion);
            ps.setInt(2, numeroCuota);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total") > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
