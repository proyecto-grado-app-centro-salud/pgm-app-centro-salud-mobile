import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/PDFController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode, jsonEncode, utf8;
import 'package:proyecto_grado_flutter/services/documentos_service.dart';

class HistoriasClinicasController {
  final pdfController = PDFController();
  AuthController authController = AuthController();
  Future<Map<String, dynamic>> obtenerHistoriasClinicas(
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
      final uri = obtenerUriConParametros(params,
          "https://${dotenv.env["API_URL"]!}/api/microservicio-historias-clinicas/historias-clinicas");
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
      Map<String, dynamic> historiasClinicaPaginadas = jsonDecode(body);
      historiasClinicaPaginadas['content'] =
          historiasClinicaPaginadas['content']
              .map<HistoriaClinica>((json) => HistoriaClinica.fromJson(json))
              .toList();
      return historiasClinicaPaginadas;
      //return HistoriaClinica.listFromString(body);
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
    String idMedico = await authController.obtenerIdUsuario();
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
        idPaciente: controllers['idPaciente']!.text ?? "0",
        idEspecialidad: int.tryParse(controllers['idEspecialidad']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(historiaClinica.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar historia clinica: $e');
    }
  }

  Future<Map<String, dynamic>> obtenerHistoriasClinicasDePaciente(
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
      final uri = obtenerUriConParametros(params,
          "https://${dotenv.env["API_URL"]!}/api/microservicio-historias-clinicas/historias-clinicas/paciente/$idPaciente");

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
      Map<String, dynamic> historiasClinicaPaginadas = jsonDecode(body);
      print(body);

      historiasClinicaPaginadas['content'] =
          historiasClinicaPaginadas['content']
              .map<HistoriaClinica>((json) => HistoriaClinica.fromJson(json))
              .toList();
      return historiasClinicaPaginadas;
    } catch (e) {
      throw Exception('Error al obtener historias clinicas de paciente: $e');
    }
  }

  Future<HistoriaClinica> obtenerHistoriaClinica(int idHistoriaClinica) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas/$idHistoriaClinica",
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
      return HistoriaClinica.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener especialidades: $e');
    }
  }

  actualizarHistoriaClinica(Map<String, TextEditingController> controllers,
      int idHistoriaClinica) async {
    String idMedico = await authController.obtenerIdUsuario();
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
        idPaciente: controllers['idPaciente']!.text ?? "0",
        idEspecialidad: int.tryParse(controllers['idEspecialidad']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-historias-clinicas/historias-clinicas/$idHistoriaClinica",
      );
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(historiaClinica.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar historia clinica: $e');
    }
  }

  obtenerUriConParametros(Map<String, String?> params, url) {
    final filteredParams = Map.fromEntries(
      params.entries.where((entry) => entry.value != null && entry.value != ''),
    );
    final uri = Uri.parse(url).replace(queryParameters: filteredParams);

    return uri;
  }

  Future<void> obtenerPDFHistoriaClinica(
      Map<String, String> historiaClinica) async {
    try {
      final token = await authController.obtenerToken();
      final response = await Dio().get(
          'http://${dotenv.env["API_URL"]}/api/microservicio-historias-clinicas/historias-clinicas/pdf',
          queryParameters: historiaClinica,
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = response.data;
        pdfController.descargarPDF("HistoriaClinica", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
