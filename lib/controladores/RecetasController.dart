import 'dart:convert';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';

class RecetasController {
  AuthController authController = AuthController();
  Future<List<Receta>> obtenerRecetas() async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas",
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
      return Receta.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener recetas: $e');
    }
  }

  registrarReceta(Map<String, TextEditingController> controllers) async {
    int idMedico = await authController.obtenerIdUsuario();
    Receta receta = Receta(
        nombreGenericoMedicamentoPrescrito:
            controllers['nombreGenericoMedicamentoPrescrito']?.text ?? '',
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
        idHistoriaClinica:
            int.tryParse(controllers['idHistoriaClinica']!.text) ?? 0,
        idMedico: idMedico);
    try {
      final uri = Uri.https(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas",
      );
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(receta.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al registrar receta: $e');
    }
  }

  Future<List<Receta>> obtenerRecetasPaciente(int idPaciente) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas/paciente/$idPaciente",
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
      return Receta.listFromString(body);
    } catch (e) {
      throw Exception('Error al obtener recetas paciente: $e');
    }
  }

  Future<Receta> obtenerReceta(int idReceta) async {
    try {
      final uri = Uri.http(
        dotenv.env["API_URL"]!,
        "/api/microservicio-recetas/recetas/$idReceta",
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
      return Receta.fromJson(jsonDecode(body));
    } catch (e) {
      throw Exception('Error al obtener receta por id: $e');
    }
  }
}
