import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/ConverterController.dart';
import 'package:proyecto_grado_flutter/controladores/PDFController.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:http/http.dart' as http;

class ExamenesComplementariosController {
  final converterController = ConverterController();
  final authController = AuthController();
  Future<Map<String, dynamic>> obtenerExamenesComplementarios(
      [String? fechaInicio,
      String? fechaFin,
      String? ciPaciente,
      String? nombreMedico,
      String? nombreEspecialidad,
      String? diagnosticoPresuntivo,
      String? page,
      String? size]) async {
    try {
      final token = await authController.obtenerToken();
      final Map<String, String?> params = {
        'diagnosticoPresuntivo': diagnosticoPresuntivo,
        'fechaInicio': fechaInicio,
        'fechaFin': fechaFin,
        'ciPaciente': ciPaciente,
        'nombreMedico': nombreMedico,
        'nombreEspecialidad': nombreEspecialidad,
        "page": page,
        "size": size
      };
      final uri = converterController.obtenerUriConParametros(params,
          "https://${dotenv.env["API_URL"]!}/api/microservicio-examenes-complementarios/examenes-complementarios");
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
      print(response.body);
      final body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> examenesPaginadas = jsonDecode(body);
      examenesPaginadas['content'] = examenesPaginadas['content']
          .map<ExamenComplementario>(
              (json) => ExamenComplementario.fromJson(json))
          .toList();
      return examenesPaginadas;
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

  registrarExamenComplementario(
      Map<String, TextEditingController> controllers) async {
    final token = await authController.obtenerToken();
    String idMedico = await authController.obtenerIdUsuario();
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
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(examenComplementario.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar examen complementario: $e');
    }
  }

  Future<Map<String, dynamic>> obtenerExamenesComplementariosPaciente(
      String idPaciente,
      [String? fechaInicio,
      String? fechaFin,
      String? nombreMedico,
      String? nombreEspecialidad,
      String? diagnosticoPresuntivo,
      String? page,
      String? size]) async {
    try {
      final token = await authController.obtenerToken();
      final Map<String, String?> params = {
        'diagnosticoPresuntivo': diagnosticoPresuntivo,
        'fechaInicio': fechaInicio,
        'fechaFin': fechaFin,
        'nombreMedico': nombreMedico,
        'nombreEspecialidad': nombreEspecialidad,
        "page": page,
        "size": size
      };
      final uri = converterController.obtenerUriConParametros(params,
          "https://${dotenv.env["API_URL"]!}/api/microservicio-examenes-complementarios/examenes-complementarios/paciente/$idPaciente");
      print(uri);
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
      print(response.body);
      final body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> examenesPaginados = jsonDecode(body);
      examenesPaginados['content'] = examenesPaginados['content']
          .map<ExamenComplementario>(
              (json) => ExamenComplementario.fromJson(json))
          .toList();
      return examenesPaginados;
    } catch (e) {
      throw Exception('Error al obtener examenes complementarios paciente: $e');
    }
  }

  Future<ExamenComplementario> obtenerExamenComplementario(
      int idExamenComplementario) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-examenes-complementarios/examenes-complementarios/$idExamenComplementario",
      );
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
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

  actualizarExamenComplementario(Map<String, TextEditingController> controllers,
      int idExamenComplementario) async {
    final token = await authController.obtenerToken();
    String idMedico = await authController.obtenerIdUsuario();
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
        "/api/microservicio-examenes-complementarios/examenes-complementarios/$idExamenComplementario",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(examenComplementario.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar examen complementario: $e');
    }
  }

  final pdfController = PDFController();
  Future<void> obtenerPDFExamenComplementario(
      Map<String, String> examenComplementario) async {
    try {
      final token = await authController.obtenerToken();
      final response = await Dio().get(
          'http://${dotenv.env["API_URL"]}/api/microservicio-examenes-complementarios/examenes-complementarios/pdf',
          queryParameters: examenComplementario,
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = response.data;
        pdfController.descargarPDF("ExamenComplementario", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static obtenerResultadosDeExamen(int idExamenComplementario) {}

  void eliminarResultadoExamenComplementario(idResultadoExamenComplementario) {}
}
