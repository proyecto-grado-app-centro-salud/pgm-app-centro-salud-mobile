import 'dart:convert';

class SolicitudInterconsulta {
  final int? id;
  final String? hospitalInterconsultado;
  final String? unidadInterconsultada;
  final String? queDeseaSaber;
  final String? sintomatologia;
  final String? tratamiento;
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

  SolicitudInterconsulta({
    this.id,
    this.hospitalInterconsultado,
    this.unidadInterconsultada,
    this.queDeseaSaber,
    this.sintomatologia,
    this.tratamiento,
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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hospitalInterconsultado': hospitalInterconsultado,
      'unidadInterconsultada': unidadInterconsultada,
      'queDeseaSaber': queDeseaSaber,
      'sintomatologia': sintomatologia,
      'tratamiento': tratamiento,
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

  static List<SolicitudInterconsulta> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList
        .map((json) => SolicitudInterconsulta.fromJson(json))
        .toList();
  }
}
