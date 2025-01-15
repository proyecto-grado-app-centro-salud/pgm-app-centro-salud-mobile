import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/ConverterController.dart';
import 'package:proyecto_grado_flutter/controladores/PDFController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaReferencia.dart';
import 'package:http/http.dart' as http;

class NotasReferenciaController {
  AuthController authController = AuthController();
  final converterController = ConverterController();
  Future<Map<String, dynamic>> obtenerNotasReferencia(
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-notas-referencia/notas-referencia");
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
      Map<String, dynamic> notasPaginadas = jsonDecode(body);
      notasPaginadas['content'] = notasPaginadas['content']
          .map<NotaReferencia>((json) => NotaReferencia.fromJson(json))
          .toList();
      return notasPaginadas;
    } catch (e) {
      throw Exception('Error al obtener notas referencia de paciente: $e');
    }
  }

  registrarNotaReferencia(
      Map<String, TextEditingController> controllers) async {
    String idMedico = await authController.obtenerIdUsuario();
    NotaReferencia notaReferencia = NotaReferencia(
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        diagnosticoPresuntivo: controllers['diagnosticoPresuntivo']?.text ?? '',
        datosClinicos: controllers['datosClinicos']?.text ?? '',
        datosIngreso: controllers['datosIngreso']?.text ?? '',
        datosEgreso: controllers['datosEgreso']?.text ?? '',
        condicionesPacienteMomentoTransferencia:
            controllers['condicionesPacienteMomentoTransferencia']?.text ?? '',
        informeProcedimientosRealizados:
            controllers['informeProcedimientosRealizados']?.text ?? '',
        tratamientoEfectuado: controllers['tratamientoEfectuado']?.text ?? '',
        tratamientoPersistePaciente:
            controllers['tratamientoPersistePaciente']?.text ?? '',
        fechaVencimiento:
            DateTime.tryParse(controllers['fechaVencimiento']!.text) ?? null,
        advertenciasFactoresRiesgo:
            controllers['advertenciasFactoresRiesgo']?.text ?? '',
        comentarioAdicional: controllers['comentarioAdicional']?.text ?? '',
        monitoreo: controllers['monitoreo']?.text ?? '',
        informeTrabajoSocial: controllers['informeTrabajoSocial']?.text ?? '',
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(notaReferencia.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar nota de referencia: $e');
    }
  }

  obtenerNotasReferenciaPaciente(String idPaciente,
      [String? fechaInicio,
      String? fechaFin,
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
        'nombreMedico': nombreMedico,
        'nombreEspecialidad': nombreEspecialidad,
        "page": page,
        "size": size
      };
      final token = await authController.obtenerToken();
      final uri = converterController.obtenerUriConParametros(params,
          "https://${dotenv.env["API_URL"]!}/api/microservicio-notas-referencia/notas-referencia/paciente/$idPaciente");
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
      Map<String, dynamic> notasPaginadas = jsonDecode(body);
      notasPaginadas['content'] = notasPaginadas['content']
          .map<NotaReferencia>((json) => NotaReferencia.fromJson(json))
          .toList();
      return notasPaginadas;
    } catch (e) {
      throw Exception('Error al obtener notas referencia: $e');
    }
  }

  Future<NotaReferencia> obtenerNotaReferencia(int idNotaReferencia) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia/$idNotaReferencia",
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
      return NotaReferencia.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener nota referencia por id: $e');
    }
  }

  actualizarNotaReferencia(Map<String, TextEditingController> controllers,
      int idNotaReferencia) async {
    String idMedico = await authController.obtenerIdUsuario();
    NotaReferencia notaReferencia = NotaReferencia(
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        diagnosticoPresuntivo: controllers['diagnosticoPresuntivo']?.text ?? '',
        datosClinicos: controllers['datosClinicos']?.text ?? '',
        datosIngreso: controllers['datosIngreso']?.text ?? '',
        datosEgreso: controllers['datosEgreso']?.text ?? '',
        condicionesPacienteMomentoTransferencia:
            controllers['condicionesPacienteMomentoTransferencia']?.text ?? '',
        informeProcedimientosRealizados:
            controllers['informeProcedimientosRealizados']?.text ?? '',
        tratamientoEfectuado: controllers['tratamientoEfectuado']?.text ?? '',
        tratamientoPersistePaciente:
            controllers['tratamientoPersistePaciente']?.text ?? '',
        fechaVencimiento:
            DateTime.tryParse(controllers['fechaVencimiento']!.text) ?? null,
        advertenciasFactoresRiesgo:
            controllers['advertenciasFactoresRiesgo']?.text ?? '',
        comentarioAdicional: controllers['comentarioAdicional']?.text ?? '',
        monitoreo: controllers['monitoreo']?.text ?? '',
        informeTrabajoSocial: controllers['informeTrabajoSocial']?.text ?? '',
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia/$idNotaReferencia",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(notaReferencia.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actulizar nota de referencia: $e');
    }
  }

  final pdfController = PDFController();
  Future<void> obtenerPDFNotaReferencia(
      Map<String, String> notaReferencia) async {
    try {
      final token = await authController.obtenerToken();
      final response = await Dio().get(
          'http://${dotenv.env["API_URL"]}/api/microservicio-notas-referencia/notas-referencia/pdf',
          queryParameters: notaReferencia,
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = response.data;
        pdfController.descargarPDF("NotaReferencia", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
