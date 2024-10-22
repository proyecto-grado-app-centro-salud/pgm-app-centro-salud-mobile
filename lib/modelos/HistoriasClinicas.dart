import 'dart:convert';

class HistoriaClinica {
  final int? id;
  final String amnesis;
  final String antecedentesFamiliares;
  final String antecedentesGinecoobstetricos;
  final String antecedentesNoPatologicos;
  final String antecedentesPatologicos;
  final String antecedentesPersonales;
  final String diagnosticoPresuntivo;
  final String diagnosticosDiferenciales;
  final String examenFisico;
  final String examenFisicoEspecial;
  final String propuestaBasicaDeConducta;
  final String tratamiento;
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

  HistoriaClinica({
    this.id,
    required this.amnesis,
    required this.antecedentesFamiliares,
    required this.antecedentesGinecoobstetricos,
    required this.antecedentesNoPatologicos,
    required this.antecedentesPatologicos,
    required this.antecedentesPersonales,
    required this.diagnosticoPresuntivo,
    required this.diagnosticosDiferenciales,
    required this.examenFisico,
    required this.examenFisicoEspecial,
    required this.propuestaBasicaDeConducta,
    required this.tratamiento,
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

  factory HistoriaClinica.fromJson(Map<String, dynamic> json) {
    return HistoriaClinica(
      id: json['id'] ?? 0,
      amnesis: json['amnesis'] ?? '',
      antecedentesFamiliares: json['antecedentesFamiliares'] ?? '',
      antecedentesGinecoobstetricos:
          json['antecedentesGinecoobstetricos'] ?? '',
      antecedentesNoPatologicos: json['antecedentesNoPatologicos'] ?? '',
      antecedentesPatologicos: json['antecedentesPatologicos'] ?? '',
      antecedentesPersonales: json['antecedentesPersonales'] ?? '',
      diagnosticoPresuntivo: json['diagnosticoPresuntivo'] ?? '',
      diagnosticosDiferenciales: json['diagnosticosDiferenciales'] ?? '',
      examenFisico: json['examenFisico'] ?? '',
      examenFisicoEspecial: json['examenFisicoEspecial'] ?? '',
      propuestaBasicaDeConducta: json['propuestaBasicaDeConducta'] ?? '',
      tratamiento: json['tratamiento'] ?? '',
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

  static List<HistoriaClinica> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => HistoriaClinica.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amnesis': amnesis,
      'antecedentesFamiliares': antecedentesFamiliares,
      'antecedentesGinecoobstetricos': antecedentesGinecoobstetricos,
      'antecedentesNoPatologicos': antecedentesNoPatologicos,
      'antecedentesPatologicos': antecedentesPatologicos,
      'antecedentesPersonales': antecedentesPersonales,
      'diagnosticoPresuntivo': diagnosticoPresuntivo,
      'diagnosticosDiferenciales': diagnosticosDiferenciales,
      'examenFisico': examenFisico,
      'examenFisicoEspecial': examenFisicoEspecial,
      'propuestaBasicaDeConducta': propuestaBasicaDeConducta,
      'tratamiento': tratamiento,
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
}
