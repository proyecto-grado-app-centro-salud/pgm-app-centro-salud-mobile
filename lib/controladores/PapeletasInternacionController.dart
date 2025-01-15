import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/ConverterController.dart';
import 'package:proyecto_grado_flutter/controladores/PDFController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';

class PapeletasInternacionController {
  final authController = AuthController();
  final converterController = ConverterController();
  Future<Map<String, dynamic>> obtenerPapeletasInternacion(
      [String? fechaInicio,
      String? fechaFin,
      String? ciPaciente,
      String? nombreMedico,
      String? nombreEspecialidad,
      String? diagnosticoPresuntivo,
      String? page,
      String? size]) async {
    try {
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
      final token = await authController.obtenerToken();
      final uri = converterController.obtenerUriConParametros(params,
          "https://${dotenv.env["API_URL"]!}/api/microservicio-papeletas-internacion/papeletas-internacion");

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
      Map<String, dynamic> papeletasPaginadas = jsonDecode(body);
      papeletasPaginadas['content'] = papeletasPaginadas['content']
          .map<PapeletaInternacion>(
              (json) => PapeletaInternacion.fromJson(json))
          .toList();
      return papeletasPaginadas;
    } catch (e) {
      throw Exception('Error al obtener papeletas internacion: $e');
    }
  }

  registrarPapeletaInternacion(
      Map<String, TextEditingController> controllers) async {
    String idMedico = await authController.obtenerIdUsuario();
    PapeletaInternacion papeletaInternacion = PapeletaInternacion(
        fechaIngreso:
            DateTime.tryParse(controllers['fechaIngreso']!.text) ?? null,
        diagnostico: controllers['diagnostico']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-papeletas-internacion/papeletas-internacion",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(papeletaInternacion.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar papeleta internacion: $e');
    }
  }

  Future<Map<String, dynamic>> obtenerPapeletasInternacionPaciente(
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-papeletas-internacion/papeletas-internacion/paciente/$idPaciente");

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
      Map<String, dynamic> papeletasPaginadas = jsonDecode(body);
      papeletasPaginadas['content'] = papeletasPaginadas['content']
          .map<PapeletaInternacion>(
              (json) => PapeletaInternacion.fromJson(json))
          .toList();
      return papeletasPaginadas;
    } catch (e) {
      throw Exception('Error al obtener papeletas internacion de paciente: $e');
    }
  }

  Future<PapeletaInternacion> obtenerPapeletaInternacion(
      int idPapeletaInternacion) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-papeletas-internacion/papeletas-internacion/$idPapeletaInternacion",
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
      return PapeletaInternacion.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener papeleta internacion: $e');
    }
  }

  actualizarPapeletaInternacion(Map<String, TextEditingController> controllers,
      int idPapeletaInternacion) async {
    String idMedico = await authController.obtenerIdUsuario();
    PapeletaInternacion papeletaInternacion = PapeletaInternacion(
        fechaIngreso:
            DateTime.tryParse(controllers['fechaIngreso']!.text) ?? null,
        diagnostico: controllers['diagnostico']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-papeletas-internacion/papeletas-internacion/$idPapeletaInternacion",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(papeletaInternacion.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar papeleta internacion: $e');
    }
  }

  final pdfController = PDFController();
  Future<void> obtenerPDFPapeletaInternacion(
      Map<String, String> papeletaInternacion) async {
    try {
      final token = await authController.obtenerToken();
      final response = await Dio().get(
          'http://${dotenv.env["API_URL"]}/api/microservicio-papeletas-internacion/papeletas-internacion/pdf',
          queryParameters: papeletaInternacion,
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = response.data;
        pdfController.descargarPDF("PapeletaInternacion", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
