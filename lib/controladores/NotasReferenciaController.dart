import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaReferencia.dart';
import 'package:http/http.dart' as http;

class NotasReferenciaController {
  AuthController authController = AuthController();
  Future<List<NotaReferencia>> obtenerNotasReferencia() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia",
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
      return NotaReferencia.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener notas referencia de paciente: $e');
    }
  }

  registrarNotaReferencia(
      Map<String, TextEditingController> controllers) async {
    int idMedico = await authController.obtenerIdUsuario();
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
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(notaReferencia.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar nota de referencia: $e');
    }
  }

  Future<List<NotaReferencia>> obtenerNotasReferenciaPaciente(
      int idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia/paciente/$idPaciente",
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
      return NotaReferencia.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener notas referencia: $e');
    }
  }

  Future<NotaReferencia> obtenerNotaReferencia(int idNotaReferencia) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-notas-referencia/notas-referencia/$idNotaReferencia",
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
      return NotaReferencia.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener nota referencia por id: $e');
    }
  }
}
