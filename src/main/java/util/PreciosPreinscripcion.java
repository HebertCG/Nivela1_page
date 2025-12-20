package util;

/**
 * Clase utility para calcular precios de preinscripción según grado y modalidad
 * de pago
 */
public class PreciosPreinscripcion {

    // Constantes de precios
    private static final double PRECIO_CONTADO_BASICO = 400.0;
    private static final double PRECIO_CONTADO_AVANZADO = 500.0;

    private static final double PRECIO_CUOTAS_BASICO = 500.0;
    private static final double PRECIO_CUOTAS_AVANZADO = 600.0;

    private static final double PRIMERA_CUOTA_BASICO = 300.0;
    private static final double PRIMERA_CUOTA_AVANZADO = 400.0;

    private static final double SEGUNDA_CUOTA = 200.0;

    /**
     * Calcula los montos según grado y modalidad
     * 
     * @param grado     El grado del estudiante
     * @param modalidad "contado" o "cuotas"
     * @return Array con [monto_total, primera_cuota, segunda_cuota]
     */
    public static double[] calcularMontos(String grado, String modalidad) {
        if (grado == null || modalidad == null) {
            return new double[] { 0, 0, 0 };
        }

        boolean esAvanzado = "4to Sec - 5to Sec".equals(grado);

        if ("contado".equalsIgnoreCase(modalidad)) {
            double montoTotal = esAvanzado ? PRECIO_CONTADO_AVANZADO : PRECIO_CONTADO_BASICO;
            return new double[] { montoTotal, montoTotal, 0 };
        } else if ("cuotas".equalsIgnoreCase(modalidad)) {
            double montoTotal = esAvanzado ? PRECIO_CUOTAS_AVANZADO : PRECIO_CUOTAS_BASICO;
            double primeraCuota = esAvanzado ? PRIMERA_CUOTA_AVANZADO : PRIMERA_CUOTA_BASICO;
            return new double[] { montoTotal, primeraCuota, SEGUNDA_CUOTA };
        }

        return new double[] { 0, 0, 0 };
    }

    /**
     * Obtiene el monto total según grado y modalidad
     */
    public static double getMontoTotal(String grado, String modalidad) {
        return calcularMontos(grado, modalidad)[0];
    }

    /**
     * Obtiene el monto de la primera cuota
     */
    public static double getPrimeraCuota(String grado, String modalidad) {
        return calcularMontos(grado, modalidad)[1];
    }

    /**
     * Obtiene el monto de la segunda cuota
     */
    public static double getSegundaCuota(String grado, String modalidad) {
        return calcularMontos(grado, modalidad)[2];
    }

    /**
     * Verifica si un grado es válido
     */
    public static boolean esGradoValido(String grado) {
        return "6to Prim - 1ro Sec".equals(grado) ||
                "2do Sec - 3ro Sec".equals(grado) ||
                "4to Sec - 5to Sec".equals(grado);
    }

    /**
     * Obtiene la fecha límite para la segunda cuota (30 de enero 2026)
     */
    public static java.sql.Date getFechaLimiteSegundaCuota() {
        return java.sql.Date.valueOf("2026-01-30");
    }

    /**
     * Obtiene descripción de precios para un grado
     */
    public static String getDescripcionPrecios(String grado) {
        if (!esGradoValido(grado)) {
            return "";
        }

        double[] contado = calcularMontos(grado, "contado");
        double[] cuotas = calcularMontos(grado, "cuotas");

        return String.format(
                "Contado: S/. %.2f | Cuotas: S/. %.2f (1ra: S/. %.2f + 2da: S/. %.2f)",
                contado[0], cuotas[0], cuotas[1], cuotas[2]);
    }
}
