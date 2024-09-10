import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../modelos/Especialidades.dart';

class EspecialidadesController {

  Future<List<Especialidad>> obtenerEspecialidades() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-gestion-informacion-centro-medico/especialidades",
      );
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode!=200){
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
      return Especialidad.listFromString(response.body);
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

}