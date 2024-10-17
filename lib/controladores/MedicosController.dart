import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/MedicoEspecialista.dart';
import 'package:http/http.dart' as http;

class MedicosController {
  Future<List<MedicoEspecialista>> obtenerEquipoMedico() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-gestion-usuarios/medicos",
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
      List<MedicoEspecialista> medicos =
          MedicoEspecialista.listFromString(body);
      return medicos;
    } catch (e) {
      throw Exception('Error al obtener equipo medico: $e');
    }
  }

  Future<MedicoEspecialista> obtenerMedico(int idMedico) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        '/api/microservicio-gestion-usuarios/medicos/$idMedico',
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
      return MedicoEspecialista.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener equipo medico: $e');
    }
  }
}
