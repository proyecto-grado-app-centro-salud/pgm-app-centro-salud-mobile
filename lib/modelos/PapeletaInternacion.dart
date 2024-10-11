import 'dart:convert';

class PapeletaInternacion {
  final int id;
  final DateTime fechaIngreso;
  final String diagnostico;
  final int idHistoriaClinica;
  final String diagnosticoPresuntivo;
  final int idPaciente;
  final String pacientePropietario;
  final String ciPropietario;
  final int idMedico;
  final String nombreMedico;
  final int idEspecialidad;
  final String nombreEspecialidad;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  PapeletaInternacion({
    required this.id,
    required this.fechaIngreso,
    required this.diagnostico,
    required this.idHistoriaClinica,
    required this.diagnosticoPresuntivo,
    required this.idPaciente,
    required this.pacientePropietario,
    required this.ciPropietario,
    required this.idMedico,
    required this.nombreMedico,
    required this.idEspecialidad,
    required this.nombreEspecialidad,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PapeletaInternacion.fromJson(Map<String, dynamic> json) {
    return PapeletaInternacion(
      id: json['id'] ?? 0,
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
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
