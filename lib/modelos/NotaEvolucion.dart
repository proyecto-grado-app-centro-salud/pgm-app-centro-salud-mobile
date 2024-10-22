import 'dart:convert';

class NotaEvolucion {
  final int? id;
  final String? cambiosPacienteResultadosTratamiento;
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

  NotaEvolucion({
    this.id,
    this.cambiosPacienteResultadosTratamiento,
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

  factory NotaEvolucion.fromJson(Map<String, dynamic> json) {
    return NotaEvolucion(
      id: json['id'] ?? 0,
      cambiosPacienteResultadosTratamiento:
          json['cambiosPacienteResultadosTratamiento'] ?? '',
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cambiosPacienteResultadosTratamiento':
          cambiosPacienteResultadosTratamiento,
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

  static List<NotaEvolucion> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => NotaEvolucion.fromJson(json)).toList();
  }
}
