import 'dart:convert';
import 'dart:typed_data';

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

class RecetasController {
  final authController = AuthController();
  final converterController = ConverterController();
  Future<Map<String, dynamic>> obtenerRecetas(
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-recetas/recetas");

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
      Map<String, dynamic> recetasPaginadas = jsonDecode(body);
      recetasPaginadas['content'] = recetasPaginadas['content']
          .map<Receta>((json) => Receta.fromJson(json))
          .toList();
      return recetasPaginadas;
    } catch (e) {
      throw Exception('Error al obtener recetas: $e');
    }
  }

  registrarReceta(Map<String, TextEditingController> controllers) async {
    final idMedico = await authController.obtenerIdUsuario();
    Receta receta = Receta(
        nombreGenericoMedicamentoPrescrito:
            controllers['nombreGenericoMedicamentoPreescrito']?.text ?? '',
        viaCuidadoEspecialesAdministracion:
            controllers['viaCuidadoEspecialesAdministracion']?.text ?? '',
        concentracionDosificacion:
            controllers['concentracionDosificacion']?.text ?? '',
        frecuenciaAdministracion24hrs:
            controllers['frecuenciaAdministracion24hrs']?.text ?? '',
        duracionTratamiento: controllers['duracionTratamiento']?.text ?? '',
        fechaVencimiento:
            DateTime.tryParse(controllers['fechaVencimiento']!.text) ?? null,
        precaucionesEspeciales:
            controllers['precaucionesEspeciales']?.text ?? '',
        indicacionesEspeciales:
            controllers['indicacionesEspeciales']?.text ?? '',
        cantidadRecetada:
            double.parse(controllers['cantidadRecetada']!.text) ?? 0,
        cantidadDispensada:
            double.parse(controllers['cantidadDispensada']!.text) ?? 0,
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(receta.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar receta: $e');
    }
  }

  Future<Map<String, dynamic>> obtenerRecetasPaciente(String idPaciente,
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
          "https://${dotenv.env["API_URL"]!}/api/microservicio-recetas/recetas/paciente/$idPaciente");

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
      Map<String, dynamic> recetasPaginadas = jsonDecode(body);
      recetasPaginadas['content'] = recetasPaginadas['content']
          .map<Receta>((json) => Receta.fromJson(json))
          .toList();
      return recetasPaginadas;
    } catch (e) {
      throw Exception('Error al obtener recetas paciente: $e');
    }
  }

  Future<Receta> obtenerReceta(int idReceta) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas/$idReceta",
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
      return Receta.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener receta por id: $e');
    }
  }

  actualizarReceta(
      Map<String, TextEditingController> controllers, int idReceta) async {
    String idMedico = await authController.obtenerIdUsuario();
    Receta receta = Receta(
        nombreGenericoMedicamentoPrescrito:
            controllers['nombreGenericoMedicamentoPreescrito']?.text ?? '',
        viaCuidadoEspecialesAdministracion:
            controllers['viaCuidadoEspecialesAdministracion']?.text ?? '',
        concentracionDosificacion:
            controllers['concentracionDosificacion']?.text ?? '',
        frecuenciaAdministracion24hrs:
            controllers['frecuenciaAdministracion24hrs']?.text ?? '',
        duracionTratamiento: controllers['duracionTratamiento']?.text ?? '',
        cantidadRecetada:
            double.parse(controllers['cantidadRecetada']!.text) ?? 0,
        cantidadDispensada:
            double.parse(controllers['cantidadDispensada']!.text) ?? 0,
        fechaVencimiento:
            DateTime.tryParse(controllers['fechaVencimiento']!.text) ?? null,
        precaucionesEspeciales:
            controllers['precaucionesEspeciales']?.text ?? '',
        indicacionesEspeciales:
            controllers['indicacionesEspeciales']?.text ?? '',
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas/$idReceta",
      );
      final token = await authController.obtenerToken();
      final response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(receta.toJson()));
      if (response.statusCode != 200) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al actualizar receta: $e');
    }
  }

  final pdfController = PDFController();
  Future<void> obtenerPDFReceta(Map<String, String> receta) async {
    try {
      final token = await authController.obtenerToken();
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas/pdf",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(receta));
      if (response.statusCode == 200) {
        Uint8List pdfBytes = response.bodyBytes;
        if (pdfBytes.isEmpty) {
          throw Exception('El archivo PDF está vacío');
        }
        final bytes = pdfBytes;
        pdfController.descargarPDF("Receta", bytes);
      } else {
        throw Exception('Error al obtener el PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
