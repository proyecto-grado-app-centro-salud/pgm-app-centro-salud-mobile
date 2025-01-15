import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/ConverterController.dart';
import 'package:http/http.dart' as http;

class TurnosAtencionMedicaPublicController {
  final converterController = ConverterController();
  Future<dynamic> obtenerTurnosAtencion(
      [String? fechaInicio, String? fechaFin]) async {
    final Map<String, String?> params = {
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
    };
    final uri = converterController.obtenerUriConParametros(params,
        "https://${dotenv.env["API_URL"]!}/api/microservicio-gestion-informacion-centro-medico/horarios-atencion-medica");

    final response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) {
      throw Exception("Error obtener turnos");
    }
    final body = utf8.decode(response.bodyBytes);
    var turnosAtencionMedicaPeticion = (json.decode(body));
    return turnosAtencionMedicaPeticion;
  }
}
