import 'dart:convert';

import 'package:proyecto_grado_flutter/modelos/Imagen.dart';

class Especialidad {
  final int idEspecialidad;
  final String nombre;
  final String descripcion;
  final DateTime fechaCreacion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<Imagen> imagenes;

  Especialidad({
    required this.idEspecialidad,
    required this.nombre,
    required this.descripcion,
    required this.fechaCreacion,
    required this.imagenes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    return Especialidad(
      idEspecialidad: json['id_especialidad'],
      nombre: json['nombre'],
      imagenes: (json['imagenes'] as List<dynamic>?)
              ?.map((img) => Imagen.fromJson(img))
              .toList() ??
          [],
      descripcion: json['descripcion'],
      fechaCreacion: DateTime.parse(json['fecha_creacion']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  static List<Especialidad> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => Especialidad.fromJson(json)).toList();
  }
}
