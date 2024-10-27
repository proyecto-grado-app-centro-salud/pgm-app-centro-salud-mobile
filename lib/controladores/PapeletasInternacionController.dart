import 'dart:convert';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';

class PapeletasInternacionController {
  Future<List<PapeletaInternacion>> obtenerPapeletasInternacion() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-papeletas-internacion/papeletas-internacion",
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
      return PapeletaInternacion.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener papeletas internacion: $e');
    }
  }

  registrarPapeletaInternacion(
      Map<String, TextEditingController> controllers) async {
    PapeletaInternacion papeletaInternacion = PapeletaInternacion(
        fechaIngreso:
            DateTime.tryParse(controllers['fechaIngreso']!.text) ?? null,
        diagnostico: controllers['diagnostico']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: 1);
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-papeletas-internacion/papeletas-internacion",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(papeletaInternacion.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar papeleta internacion: $e');
    }
  }

  Future<List<PapeletaInternacion>> obtenerPapeletasInternacionPaciente(
      int idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-papeletas-internacion/papeletas-internacion/paciente/$idPaciente",
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
      return PapeletaInternacion.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener papeletas internacion de paciente: $e');
    }
  }

  obtenerPapeletaInternacion(int idPapeletaInternacion) {}
}
