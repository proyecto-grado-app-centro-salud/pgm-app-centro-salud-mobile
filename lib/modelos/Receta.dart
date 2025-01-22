import 'dart:convert';

class Receta {
  final int? id;
  final String? nombreGenericoMedicamentoPrescrito;
  final String? viaCuidadoEspecialesAdministracion;
  final String? concentracionDosificacion;
  final String? frecuenciaAdministracion24hrs;
  final String? duracionTratamiento;
  final DateTime? fechaVencimiento;
  final String? precaucionesEspeciales;
  final String? indicacionesEspeciales;
  final int? idHistoriaClinica;
  final String? diagnosticoPresuntivo;
  final double? cantidadRecetada;
  final double? cantidadDispensada;
  final String? idPaciente;
  final String? pacientePropietario;
  final String? ciPropietario;
  final String? idMedico;
  final String? nombreMedico;
  final int? idEspecialidad;
  final String? nombreEspecialidad;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Receta({
    this.id,
    this.nombreGenericoMedicamentoPrescrito,
    this.viaCuidadoEspecialesAdministracion,
    this.concentracionDosificacion,
    this.frecuenciaAdministracion24hrs,
    this.duracionTratamiento,
    this.fechaVencimiento,
    this.precaucionesEspeciales,
    this.indicacionesEspeciales,
    this.idHistoriaClinica,
    this.diagnosticoPresuntivo,
    this.cantidadRecetada,
    this.cantidadDispensada,
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

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'] ?? 0,
      nombreGenericoMedicamentoPrescrito:
          json['nombreGenericoMedicamentoPreescrito'] ?? '',
      viaCuidadoEspecialesAdministracion:
          json['viaCuidadoEspecialesAdministracion'] ?? '',
      concentracionDosificacion: json['concentracionDosificacion'] ?? '',
      frecuenciaAdministracion24hrs:
          json['frecuenciaAdministracion24hrs'] ?? '',
      duracionTratamiento: json['duracionTratamiento'] ?? '',
      fechaVencimiento: json['fechaVencimiento'] != null
          ? DateTime.parse(json['fechaVencimiento'])
          : null,
      precaucionesEspeciales: json['precaucionesEspeciales'] ?? '',
      indicacionesEspeciales: json['indicacionesEspeciales'] ?? '',
      cantidadRecetada: json['cantidadRecetada'] ?? 0,
      cantidadDispensada: json['cantidadDispensada'] ?? 0,
      idHistoriaClinica: json['idHistoriaClinica'] ?? 0,
      diagnosticoPresuntivo: json['diagnosticoPresuntivo'] ?? '',
      idPaciente: json['idPaciente'].toString() ?? "0",
      pacientePropietario: json['pacientePropietario'] ?? '',
      ciPropietario: json['ciPropietario'] ?? '',
      idMedico: json['idMedico'].toString() ?? "0",
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

  static List<Receta> listFromString(String list) {
    Map<String, dynamic> jsonList = jsonDecode(list);
    print(jsonList);
    List<dynamic> contentList = jsonList['content'];
    return contentList.map<Receta>((json) => Receta.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreGenericoMedicamentoPrescrito': nombreGenericoMedicamentoPrescrito,
      'viaCuidadoEspecialesAdministracion': viaCuidadoEspecialesAdministracion,
      'concentracionDosificacion': concentracionDosificacion,
      'frecuenciaAdministracion24hrs': frecuenciaAdministracion24hrs,
      'duracionTratamiento': duracionTratamiento,
      'fechaVencimiento': fechaVencimiento?.toIso8601String(),
      'precaucionesEspeciales': precaucionesEspeciales,
      'indicacionesEspeciales': indicacionesEspeciales,
      'cantidadRecetada': cantidadRecetada,
      'cantidadDispensada': cantidadDispensada,
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
}
