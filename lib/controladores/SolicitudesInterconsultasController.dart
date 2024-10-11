import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';

class SolicitudesInterconsultasController {
  Future<List<SolicitudInterconsulta>>
      obtenerSolicitudesInterconsultas() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsultas/solicitudes-interconsultas",
      );
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
      return SolicitudInterconsulta.listFromString(response.body);
    } catch (e) {
      throw Exception('Error al obtener solicitudesInterconsultas: $e');
    }
  }
}
