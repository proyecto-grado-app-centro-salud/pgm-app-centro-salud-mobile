import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/ConverterController.dart';
import 'package:proyecto_grado_flutter/controladores/PDFController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/services/documentos_service.dart';

class NotasEvolucionController {
  AuthController authController = AuthController();
  final converterController = ConverterController();
  Future<Map<String, dynamic>> obtenerNotasEvolucion(
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-historias-clinicas/notas-evolucion");
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
      final body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> notasEvolucionPaginadas = jsonDecode(body);
      notasEvolucionPaginadas['content'] = notasEvolucionPaginadas['content']
          .map<NotaEvolucion>((json) => NotaEvolucion.fromJson(json))
          .toList();
      return notasEvolucionPaginadas;
    } catch (e) {
      throw Exception('Error al obtener notas de evolucion: $e');
    }
  }

  List<NotaEvolucion> filtrarNotaEvolucion(List notasEvolucion,
      [String diagnosticoPresuntivo = '']) {
    print(notasEvolucion);
    List notasEvolucionRetornar = DocumentosService()
        .filtrarDocumentosPorDiagnosticoPresuntivo(
            notasEvolucion, diagnosticoPresuntivo);
    print(notasEvolucionRetornar);
    return notasEvolucionRetornar.cast<NotaEvolucion>();
  }

  Future<void> registrarNotaEvolucion(
      Map<String, TextEditingController> controllers) async {
    String idMedico = await authController.obtenerIdUsuario();

    NotaEvolucion notaEvolucion = NotaEvolucion(
        cambiosPacienteResultadosTratamiento:
            controllers['cambiosPacienteResultadosTratamiento']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);

    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(notaEvolucion.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar la nota de evolución: $e');
    }
  }

  obtenerNotasEvolucionPaciente(String idPaciente,
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-historias-clinicas/notas-evolucion/paciente/$idPaciente");

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
      Map<String, dynamic> notasEvolucionPaginadas = jsonDecode(body);
      notasEvolucionPaginadas['content'] = notasEvolucionPaginadas['content']
          .map<NotaEvolucion>((json) => NotaEvolucion.fromJson(json))
          .toList();
      return notasEvolucionPaginadas;
    } catch (e) {
      throw Exception('Error al obtener notas de evolucion de paciente: $e');
    }
  }

  Future<NotaEvolucion> obtenerNotaEvolucion(int idNotaEvolucion) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion/$idNotaEvolucion",
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
      return NotaEvolucion.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener detalle nota de evolucion: $e');
    }
  }

  actualizarNotaEvolucion(Map<String, TextEditingController> controllers,
      int idNotaEvolucion) async {
    String idMedico = await authController.obtenerIdUsuario();

    NotaEvolucion notaEvolucion = NotaEvolucion(
        cambiosPacienteResultadosTratamiento:
            controllers['cambiosPacienteResultadosTratamiento']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);

    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion/$idNotaEvolucion",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(notaEvolucion.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar la nota de evolución: $e');
    }
  }

  final pdfController = PDFController();
  Future<void> obtenerPDFNotaEvolucion(
      Map<String, String> notaEvolucion) async {
    try {
      final token = await authController.obtenerToken();
      final response = await Dio().get(
          'http://${dotenv.env["API_URL"]}/api/microservicio-historias-clinicas/notas-evolucion/pdf',
          queryParameters: {"id": notaEvolucion['id']},
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = response.data;
        pdfController.descargarPDF("NotaEvolucion", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
