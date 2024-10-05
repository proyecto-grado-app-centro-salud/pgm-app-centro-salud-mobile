import 'dart:convert';

class NotaEvolucion {
  final int id;
  final String cambiosPacienteResultadosTratamiento;
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

  NotaEvolucion({
    required this.id,
    required this.cambiosPacienteResultadosTratamiento,
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

  factory NotaEvolucion.fromJson(Map<String, dynamic> json) {
    return NotaEvolucion(
      id: json['id'],
      cambiosPacienteResultadosTratamiento:
          json['cambiosPacienteResultadosTratamiento'],
      idHistoriaClinica: json['idHistoriaClinica'],
      diagnosticoPresuntivo: json['diagnosticoPresuntivo'],
      idPaciente: json['idPaciente'],
      pacientePropietario: json['pacientePropietario'],
      ciPropietario: json['ciPropietario'],
      idMedico: json['idMedico'],
      nombreMedico: json['nombreMedico'],
      idEspecialidad: json['idEspecialidad'],
      nombreEspecialidad: json['nombreEspecialidad'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  static List<NotaEvolucion> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => NotaEvolucion.fromJson(json)).toList();
  }
}
