import 'dart:convert';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';

class SolicitudesInterconsultasController {
  Future<List<SolicitudInterconsulta>>
      obtenerSolicitudesInterconsultas() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsultas/solicitudes-interconsultas",
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
      return SolicitudInterconsulta.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener solicitudesInterconsultas: $e');
    }
  }

  registrarSolicitudInterconsulta(
      Map<String, TextEditingController> controllers) async {
    SolicitudInterconsulta solicitudInterconsulta = SolicitudInterconsulta(
        hospitalInterconsultado:
            controllers['hospitalInterconsultado']?.text ?? '',
        unidadInterconsultada: controllers['unidadInterconsultada']?.text ?? '',
        queDeseaSaber: controllers['queDeseaSaber']?.text ?? '',
        sintomatologia: controllers['sintomatologia']?.text ?? '',
        tratamiento: controllers['tratamiento']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: 1);
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsulta/solicitudes-interconsulta",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(solicitudInterconsulta.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar solicitud interconsulta: $e');
    }
  }

  Future<List<SolicitudInterconsulta>> obtenerSolicitudesInterconsultaPaciente(
      int idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsultas/solicitudes-interconsultas/paciente/$idPaciente",
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
      return SolicitudInterconsulta.listFromString(body);
    } catch (e) {
      throw Exception(
          'Error al obtener solicitudesInterconsultas paciente: $e');
    }
  }

  Future<SolicitudInterconsulta> obtenerSolicitudInterconsulta(
      int idSolicitudInterconsulta) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-solicitudes-interconsultas/solicitudes-interconsultas/$idSolicitudInterconsulta",
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
      return SolicitudInterconsulta.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener solicitud interconsulta por id: $e');
    }
  }
}
