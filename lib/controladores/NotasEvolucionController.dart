import 'dart:convert';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/services/documentos_service.dart';

class NotasEvolucionController {
  AuthController authController = AuthController();
  Future<List<NotaEvolucion>> obtenerNotasEvolucion() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion",
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
      return NotaEvolucion.listFromString(body);
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
    int idMedico = await authController.obtenerIdUsuario();

    NotaEvolucion notaEvolucion = NotaEvolucion(
        cambiosPacienteResultadosTratamiento:
            controllers['cambiosPacienteResultadosTratamiento']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);

    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(notaEvolucion.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar la nota de evolución: $e');
    }
  }

  Future<List<NotaEvolucion>> obtenerNotasEvolucionPaciente(
      int idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion/paciente/$idPaciente",
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
      return NotaEvolucion.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener notas de evolucion de paciente: $e');
    }
  }

  Future<NotaEvolucion> obtenerNotaEvolucion(int idNotaEvolucion) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/notas-evolucion/$idNotaEvolucion",
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
      return NotaEvolucion.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener detalle nota de evolucion: $e');
    }
  }
}
