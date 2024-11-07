import 'dart:convert';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:http/http.dart' as http;

class ExamenesComplementariosController {
  AuthController authController = AuthController();
  obtenerExamenesComplementarios() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-examenes-complementarios/examenes-complementarios",
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
      print(response.body);
      final body = utf8.decode(response.bodyBytes);
      return ExamenComplementario.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

  registrarExamenComplementario(
      Map<String, TextEditingController> controllers) async {
    int idMedico = await authController.obtenerIdUsuario();
    ExamenComplementario examenComplementario = ExamenComplementario(
      idHistoriaClinica:
          int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
      idMedico: idMedico,
      nombre: controllers['nombre']?.text ?? '',
      descripcion: controllers['descripcion']?.text ?? '',
      resumenResultados: controllers['resumenResultados']?.text ?? '',
      fechaResultado:
          DateTime.tryParse(controllers['fechaResultado']!.text) ?? null,
      fechaSolicitud:
          DateTime.tryParse(controllers['fechaSolicitud']!.text) ?? null,
    );
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-examenes-complementarios/examenes-complementarios",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(examenComplementario.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar examen complementario: $e');
    }
  }

  obtenerExamenesComplementariosPaciente(int idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-examenes-complementarios/examenes-complementarios/paciente/$idPaciente",
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
      print(response.body);
      final body = utf8.decode(response.bodyBytes);
      return ExamenComplementario.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener examenes complementarios paciente: $e');
    }
  }

  Future<ExamenComplementario> obtenerExamenComplementario(
      int idExamenComplementario) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-examenes-complementarios/examenes-complementarios/$idExamenComplementario",
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
      return ExamenComplementario.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }
}
