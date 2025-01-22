import 'dart:convert';

class ExamenComplementario {
  final int? id;
  final String nombre;
  final String descripcion;
  final String resumenResultados;
  final DateTime? fechaResultado;
  final DateTime? fechaSolicitud;
  final String? enlaceArchivoResultado;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int idHistoriaClinica;
  final String? diagnosticoPresuntivo;
  final String? idPaciente;
  final String? pacientePropietario;
  final String? ciPropietario;
  final String idMedico;
  final String? nombreMedico;
  final int? idEspecialidad;
  final String? nombreEspecialidad;
  ExamenComplementario({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.resumenResultados,
    this.fechaResultado,
    this.fechaSolicitud,
    this.enlaceArchivoResultado,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.idHistoriaClinica,
    this.diagnosticoPresuntivo,
    this.idPaciente,
    this.pacientePropietario,
    this.ciPropietario,
    required this.idMedico,
    this.nombreMedico,
    this.idEspecialidad,
    this.nombreEspecialidad,
  });

  factory ExamenComplementario.fromJson(Map<String, dynamic> json) {
    return ExamenComplementario(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      resumenResultados: json['resumenResultados'] ?? '',
      fechaResultado: json['fechaResultado'] != null
          ? DateTime.parse(json['fechaResultado'])
          : null,
      fechaSolicitud: json['fechaSolicitud'] != null
          ? DateTime.parse(json['fechaSolicitud'])
          : null,
      enlaceArchivoResultado: json['enlaceArchivoResultado'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      idHistoriaClinica: json['idHistoriaClinica'] ?? 0,
      diagnosticoPresuntivo: json['diagnosticoPresuntivo'] ?? '',
      idPaciente: json['idPaciente'].toString() + "" ?? "0",
      pacientePropietario: json['pacientePropietario'] ?? '',
      ciPropietario: json['ciPropietario'] ?? '',
      idMedico: json['idMedico'].toString() + "" ?? "0",
      nombreMedico: json['nombreMedico'] ?? '',
      idEspecialidad: json['idEspecialidad'] ?? 0,
      nombreEspecialidad: json['nombreEspecialidad'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'resumenResultados': resumenResultados,
      'fechaResultado': fechaResultado?.toIso8601String(),
      'fechaSolicitud': fechaSolicitud?.toIso8601String(),
      'enlaceArchivoResultado': enlaceArchivoResultado,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'idHistoriaClinica': idHistoriaClinica,
      'diagnosticoPresuntivo': diagnosticoPresuntivo,
      'idPaciente': idPaciente,
      'pacientePropietario': pacientePropietario,
      'ciPropietario': ciPropietario,
      'idMedico': idMedico,
      'nombreMedico': nombreMedico,
      'idEspecialidad': idEspecialidad,
      'nombreEspecialidad': nombreEspecialidad,
    };
  }

  static List<ExamenComplementario> listFromString(String list) {
    Map<String, dynamic> jsonList = jsonDecode(list);
    print(jsonList);
    List<dynamic> contentList = jsonList['content'];
    return contentList
        .map<ExamenComplementario>(
            (json) => ExamenComplementario.fromJson(json))
        .toList();
  }
}
