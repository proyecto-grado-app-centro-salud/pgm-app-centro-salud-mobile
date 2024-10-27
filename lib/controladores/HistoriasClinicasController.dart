import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode, jsonEncode, utf8;

import 'package:proyecto_grado_flutter/services/documentos_service.dart';

class HistoriasClinicasController {
  Future<List<HistoriaClinica>> obtenerHistoriasClinicas() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas",
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
      return HistoriaClinica.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

  List<HistoriaClinica> filtrarHistoriasClinicas(
      List<HistoriaClinica> historiasClinicas,
      [String diagnosticoPresuntivo = '']) {
    List historiasClinicasRetornar = DocumentosService()
        .filtrarDocumentosPorDiagnosticoPresuntivo(
            historiasClinicas, diagnosticoPresuntivo);
    return HistoriaClinica.listFromString(
        jsonEncode(historiasClinicasRetornar));
  }

  Future<void> registrarHistoriaClinica(
      Map<String, TextEditingController> controllers) async {
    // TODO: obtener medico de token
    HistoriaClinica historiaClinica = HistoriaClinica(
        amnesis:
            controllers['condicionesActualesDeSaludOEnfermedad']?.text ?? '',
        antecedentesFamiliares:
            controllers['antecedentesFamiliares']?.text ?? '',
        antecedentesGinecoobstetricos:
            controllers['antecedentesGinecoobstetricos']?.text ?? '',
        antecedentesNoPatologicos:
            controllers['antecedentesNoPatologicos']?.text ?? '',
        antecedentesPatologicos:
            controllers['antecedentesPatologicos']?.text ?? '',
        antecedentesPersonales:
            controllers['antecedentesPersonales']?.text ?? '',
        diagnosticoPresuntivo: controllers['diagnosticoPresuntivo']?.text ?? '',
        diagnosticosDiferenciales:
            controllers['diagnosticosDiferenciales']?.text ?? '',
        examenFisico: controllers['examenFisico']?.text ?? '',
        examenFisicoEspecial: controllers['examenFisicoEspecial']?.text ?? '',
        propuestaBasicaDeConducta:
            controllers['propuestaBasicaDeConducta']?.text ?? '',
        tratamiento: controllers['tratamiento']?.text ?? '',
        idPaciente: int.tryParse(controllers['idPaciente']!.text) ?? 0,
        idEspecialidad: int.tryParse(controllers['idEspecialidad']!.text) ?? 0,
        idMedico: 1);
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(historiaClinica.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar historia clinica: $e');
    }
  }

  Future<List<HistoriaClinica>> obtenerHistoriasClinicasDePaciente(
      String idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas/paciente/$idPaciente",
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
      return HistoriaClinica.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener historias clinicas de paciente: $e');
    }
  }

  Future<HistoriaClinica> obtenerHistoriaClinica(int idHistoriaClinica) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas/$idHistoriaClinica",
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
      return HistoriaClinica.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

  actualizarHistoriaClinica(Map<String, TextEditingController> controllers,
      int idHistoriaClinica) async {
    HistoriaClinica historiaClinica = HistoriaClinica(
        amnesis:
            controllers['condicionesActualesDeSaludOEnfermedad']?.text ?? '',
        antecedentesFamiliares:
            controllers['antecedentesFamiliares']?.text ?? '',
        antecedentesGinecoobstetricos:
            controllers['antecedentesGinecoobstetricos']?.text ?? '',
        antecedentesNoPatologicos:
            controllers['antecedentesNoPatologicos']?.text ?? '',
        antecedentesPatologicos:
            controllers['antecedentesPatologicos']?.text ?? '',
        antecedentesPersonales:
            controllers['antecedentesPersonales']?.text ?? '',
        diagnosticoPresuntivo: controllers['diagnosticoPresuntivo']?.text ?? '',
        diagnosticosDiferenciales:
            controllers['diagnosticosDiferenciales']?.text ?? '',
        examenFisico: controllers['examenFisico']?.text ?? '',
        examenFisicoEspecial: controllers['examenFisicoEspecial']?.text ?? '',
        propuestaBasicaDeConducta:
            controllers['propuestaBasicaDeConducta']?.text ?? '',
        tratamiento: controllers['tratamiento']?.text ?? '',
        idPaciente: int.tryParse(controllers['idPaciente']!.text) ?? 0,
        idEspecialidad: int.tryParse(controllers['idEspecialidad']!.text) ?? 0,
        idMedico: 1);
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas/$idHistoriaClinica",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(historiaClinica.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar historia clinica: $e');
    }
  }
}
