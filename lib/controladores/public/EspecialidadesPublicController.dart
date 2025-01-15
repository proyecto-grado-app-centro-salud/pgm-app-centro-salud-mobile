import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';

class EspecialidadesPublicController {
  Future<List<Especialidad>> obtenerEspecialidades() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-gestion-informacion-centro-medico/especialidades",
      );
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
      final body = utf8.decode(response.bodyBytes);
      List<Especialidad> especialidades = Especialidad.listFromString(body);
      return especialidades;
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

  obtenerEspecialidad(int idEspecialidad) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-gestion-informacion-centro-medico/especialidades/$idEspecialidad",
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
      final body = utf8.decode(response.bodyBytes);
      return Especialidad.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }
}
