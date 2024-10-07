import 'dart:convert';

class Especialidad {
  final int idEspecialidad;
  final String nombre;
  final String descripcion;
  final DateTime fechaCreacion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  
  Especialidad({
    required this.idEspecialidad,
    required this.nombre,
    required this.descripcion,
    required this.fechaCreacion,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    return Especialidad(
      idEspecialidad: json['id_especialidad'],
      nombre: json['nombre'],
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
