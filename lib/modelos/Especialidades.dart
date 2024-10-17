import 'dart:convert';

import 'package:proyecto_grado_flutter/modelos/Imagen.dart';

class Especialidad {
  final int idEspecialidad;
  final String nombre;
  final String descripcion;
  final DateTime? fechaCreacion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<Imagen> imagenes;

  Especialidad({
    required this.idEspecialidad,
    required this.nombre,
    required this.descripcion,
    this.fechaCreacion,
    required this.imagenes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    final List<Imagen> imagenes = (json['imagenes'] as List<dynamic>?)
            ?.map((img) => Imagen.fromJson(img))
            .toList() ??
        [];
    return Especialidad(
      idEspecialidad: json['idEspecialidad'] ?? 0,
      nombre: json['nombre'] ?? '',
      imagenes: imagenes.isNotEmpty
          ? imagenes
          : [
              Imagen.fromJson({
                "url":
                    'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg'
              })
            ],
      descripcion: json['descripcion'] ?? '',
      fechaCreacion: json['fechaCreacion'] != null
          ? DateTime.parse(json['fechaCreacion'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  static List<Especialidad> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => Especialidad.fromJson(json)).toList();
  }
}
