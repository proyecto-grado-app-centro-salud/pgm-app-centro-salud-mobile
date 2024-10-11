import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:http/http.dart' as http;

class ExamenesComplementariosController {
  obtenerExamenesComplementarios() async {
    // try {
    //   final uri = Uri.http(
    //     dotenv.env["API_URL"]!,
    //     "/api/microservicio-historias-clinicas/examenes-complementarios",
    //   );
    //   final response = await http.get(
    //     uri,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode != 200) {
    //     throw Exception('Error en la solicitud: ${response.statusCode}');
    //   }
    //   return ExamenComplementario.listFromString(response.body);
    // } catch (e) {
    //   throw Exception('Error al obtener especialidades: $e');
    // }
  }
}
