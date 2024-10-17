import 'dart:convert';

class Imagen {
  int idImagen;
  String nombre;
  String tipo;
  String url;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Imagen({
    required this.idImagen,
    required this.nombre,
    required this.tipo,
    required this.url,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Imagen.fromJson(Map<String, dynamic> json) {
    return Imagen(
      idImagen: json['idImagen'] ?? 0,
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
      url: json['url'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
