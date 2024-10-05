import 'dart:convert';

class HistoriaClinica {
  final int id;
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

  HistoriaClinica({
    required this.id,
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

  factory HistoriaClinica.fromJson(Map<String, dynamic> json) {
    return HistoriaClinica(
      id: json['id'],
      amnesis: json['amnesis'],
      antecedentesFamiliares: json['antecedentesFamiliares'],
      antecedentesGinecoobstetricos: json['antecedentesGinecoobstetricos'],
      antecedentesNoPatologicos: json['antecedentesNoPatologicos'],
      antecedentesPatologicos: json['antecedentesPatologicos'],
      antecedentesPersonales: json['antecedentesPersonales'],
      diagnosticoPresuntivo: json['diagnosticoPresuntivo'],
      diagnosticosDiferenciales: json['diagnosticosDiferenciales'],
      examenFisico: json['examenFisico'],
      examenFisicoEspecial: json['examenFisicoEspecial'],
      propuestaBasicaDeConducta: json['propuestaBasicaDeConducta'],
      tratamiento: json['tratamiento'],
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

  static List<HistoriaClinica> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => HistoriaClinica.fromJson(json)).toList();
  }
}
