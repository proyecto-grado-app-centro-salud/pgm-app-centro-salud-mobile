import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/services/documentos_service.dart';

class NotasEvolucionController {
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
}
