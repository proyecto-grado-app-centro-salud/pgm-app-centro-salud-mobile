import 'dart:convert';

class PapeletaInternacion {
  final int? id;
  final DateTime? fechaIngreso;
  final String? diagnostico;
  final int? idHistoriaClinica;
  final String? diagnosticoPresuntivo;
  final int? idPaciente;
  final String? pacientePropietario;
  final String? ciPropietario;
  final int? idMedico;
  final String? nombreMedico;
  final int? idEspecialidad;
  final String? nombreEspecialidad;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  PapeletaInternacion({
    this.id,
    this.fechaIngreso,
    this.diagnostico,
    this.idHistoriaClinica,
    this.diagnosticoPresuntivo,
    this.idPaciente,
    this.pacientePropietario,
    this.ciPropietario,
    this.idMedico,
    this.nombreMedico,
    this.idEspecialidad,
    this.nombreEspecialidad,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fechaIngreso': fechaIngreso?.toIso8601String(),
      'diagnostico': diagnostico,
      'idHistoriaClinica': idHistoriaClinica,
      'diagnosticoPresuntivo': diagnosticoPresuntivo,
      'idPaciente': idPaciente,
      'pacientePropietario': pacientePropietario,
      'ciPropietario': ciPropietario,
      'idMedico': idMedico,
      'nombreMedico': nombreMedico,
      'idEspecialidad': idEspecialidad,
      'nombreEspecialidad': nombreEspecialidad,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory PapeletaInternacion.fromJson(Map<String, dynamic> json) {
    return PapeletaInternacion(
      id: json['id'] ?? 0,
      fechaIngreso: json['fechaIngreso'] != null
          ? DateTime.parse(json['fechaIngreso'])
          : null,
      diagnostico: json['diagnostico'] ?? '',
      idHistoriaClinica: json['idHistoriaClinica'] ?? 0,
      diagnosticoPresuntivo: json['diagnosticoPresuntivo'] ?? '',
      idPaciente: json['idPaciente'] ?? 0,
      pacientePropietario: json['pacientePropietario'] ?? '',
      ciPropietario: json['ciPropietario'] ?? '',
      idMedico: json['idMedico'] ?? 0,
      nombreMedico: json['nombreMedico'] ?? '',
      idEspecialidad: json['idEspecialidad'] ?? 0,
      nombreEspecialidad: json['nombreEspecialidad'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  static List<PapeletaInternacion> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => PapeletaInternacion.fromJson(json)).toList();
  }
}
