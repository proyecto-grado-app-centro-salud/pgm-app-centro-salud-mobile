import 'dart:convert';

class SolicitudInterconsulta {
  final int id;
  final String hospitalInterconsultado;
  final String unidadInterconsultada;
  final String queDeseaSaber;
  final String sintomatologia;
  final String tratamiento;
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

  SolicitudInterconsulta({
    required this.id,
    required this.hospitalInterconsultado,
    required this.unidadInterconsultada,
    required this.queDeseaSaber,
    required this.sintomatologia,
    required this.tratamiento,
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

  factory SolicitudInterconsulta.fromJson(Map<String, dynamic> json) {
    return SolicitudInterconsulta(
      id: json['id'] ?? 0,
      hospitalInterconsultado: json['hospitalInterconsultado'] ?? '',
      unidadInterconsultada: json['unidadInterconsultada'] ?? '',
      queDeseaSaber: json['queDeseaSaber'] ?? '',
      sintomatologia: json['sintomatologia'] ?? '',
      tratamiento: json['tratamiento'] ?? '',
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

  static List<SolicitudInterconsulta> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList
        .map((json) => SolicitudInterconsulta.fromJson(json))
        .toList();
  }
}
