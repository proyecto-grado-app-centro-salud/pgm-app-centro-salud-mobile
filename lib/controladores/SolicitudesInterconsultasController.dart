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
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';

class SolicitudesInterconsultasController {
  AuthController authController = AuthController();
  final converterController = ConverterController();
  Future<Map<String, dynamic>> obtenerSolicitudesInterconsultas(
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta");
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
      Map<String, dynamic> solicitudesInterconsultaPaginadas = jsonDecode(body);
      solicitudesInterconsultaPaginadas['content'] =
          solicitudesInterconsultaPaginadas['content']
              .map<SolicitudInterconsulta>(
                  (json) => SolicitudInterconsulta.fromJson(json))
              .toList();
      return solicitudesInterconsultaPaginadas;
    } catch (e) {
      throw Exception('Error al obtener solicitudesInterconsultas: $e');
    }
  }

  registrarSolicitudInterconsulta(
      Map<String, TextEditingController> controllers) async {
    String idMedico = await authController.obtenerIdUsuario();
    SolicitudInterconsulta solicitudInterconsulta = SolicitudInterconsulta(
        hospitalInterconsultado:
            controllers['hospitalInterconsultado']?.text ?? '',
        unidadInterconsultada: controllers['unidadInterconsultada']?.text ?? '',
        queDeseaSaber: controllers['queDeseaSaber']?.text ?? '',
        sintomatologia: controllers['sintomatologia']?.text ?? '',
        tratamiento: controllers['tratamiento']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(solicitudInterconsulta.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar solicitud interconsulta: $e');
    }
  }

  Future<Map<String, dynamic>> obtenerSolicitudesInterconsultaPaciente(
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta/paciente/$idPaciente");
      print(uri);
      // final uri = Uri.http(
      //   dotenv.env["API_URL"]!,
      //   "/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta/paciente/$idPaciente",
      // );
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
      Map<String, dynamic> solicitudesInterconsultaPaginadas = jsonDecode(body);
      solicitudesInterconsultaPaginadas['content'] =
          solicitudesInterconsultaPaginadas['content']
              .map<SolicitudInterconsulta>(
                  (json) => SolicitudInterconsulta.fromJson(json))
              .toList();
      return solicitudesInterconsultaPaginadas;
    } catch (e) {
      throw Exception(
          'Error al obtener solicitudesInterconsultas paciente: $e');
    }
  }

  Future<SolicitudInterconsulta> obtenerSolicitudInterconsulta(
      int idSolicitudInterconsulta) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta/$idSolicitudInterconsulta",
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
      return SolicitudInterconsulta.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener solicitud interconsulta por id: $e');
    }
  }

  actualizarSolicitudInterconsulta(
      Map<String, TextEditingController> controllers, int idSolicitud) async {
    final idMedico = await authController.obtenerIdUsuario();
    SolicitudInterconsulta solicitudInterconsulta = SolicitudInterconsulta(
        hospitalInterconsultado:
            controllers['hospitalInterconsultado']?.text ?? '',
        unidadInterconsultada: controllers['unidadInterconsultada']?.text ?? '',
        queDeseaSaber: controllers['queDeseaSaber']?.text ?? '',
        sintomatologia: controllers['sintomatologia']?.text ?? '',
        tratamiento: controllers['tratamiento']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta/$idSolicitud",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(solicitudInterconsulta.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar solicitud interconsulta: $e');
    }
  }

  final pdfController = PDFController();
  Future<void> obtenerPDFSolicitudInterconsulta(
      Map<String, String> solicitudInterconsulta) async {
    try {
      final token = await authController.obtenerToken();
      final response = await Dio().get(
          'http://${dotenv.env["API_URL"]}/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta/pdf',
          queryParameters: {"id": solicitudInterconsulta['id']},
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = response.data;
        pdfController.descargarPDF("SolicitudInterconsulta", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
