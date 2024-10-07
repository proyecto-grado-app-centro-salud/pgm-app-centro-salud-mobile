import 'dart:convert';

import 'package:proyecto_grado_flutter/modelos/Imagen.dart';

class MedicoEspecialista {
  final int idUsuario;
  final List<Imagen> imagenes;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String ci;
  final String email;
  final String celular;
  final int aniosExperiencia;
  final List especialidades;
  final List<dynamic> turnosAtencionMedica;
  final String descripcion;

  MedicoEspecialista({
    required this.idUsuario,
    required this.imagenes,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.ci,
    required this.email,
    required this.celular,
    required this.aniosExperiencia,
    required this.especialidades,
    required this.turnosAtencionMedica,
    required this.descripcion,
  });

  factory MedicoEspecialista.fromJson(Map<String, dynamic> json) {
    return MedicoEspecialista(
      idUsuario: json['idUsuario'] ?? 0,
      imagenes: (json['imagenes'] as List<dynamic>?)
              ?.map((img) => Imagen.fromJson(img))
              .toList() ??
          [],
      nombres: json['nombres'] ?? '',
      apellidoPaterno: json['apellidoPaterno'] ?? '',
      apellidoMaterno: json['apellidoMaterno'] ?? '',
      ci: json['ci'] ?? '',
      email: json['email'] ?? '',
      celular: json['celular'] ?? '',
      aniosExperiencia: json['aniosExperiencia'] ?? 0,
      especialidades: (json['especialidades'] as List<dynamic>?) ?? [],
      turnosAtencionMedica: json['turnosAtencionMedica'] ?? [],
      descripcion: json['descripcion'] ?? '',
    );
  }

  static List<MedicoEspecialista> listFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => MedicoEspecialista.fromJson(json)).toList();
  }
}
