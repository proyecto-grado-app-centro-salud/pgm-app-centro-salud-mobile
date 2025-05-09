import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:http/http.dart' as http;

class PacientesController {
  final authController = AuthController();
  Future<List<Paciente>> obtenerPacientes() async {
    try {
      final token = await authController.obtenerToken();
      print(token);
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-gestion-usuarios/pacientes",
      );
      // final uri=Uri.parse(url);
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
      final body = utf8.decode(response.bodyBytes);
      List<Paciente> pacientes = Paciente.listFromString(body);
      return pacientes;
    } catch (e) {
      throw Exception('Error al obtener pacientes: $e');
    }
  }
}
