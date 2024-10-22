import 'dart:convert';

class NotaReferencia {
  final int? id;
  final String? datosClinicos;
  final String? datosIngreso;
  final String? datosEgreso;
  final String? condicionesPacienteMomentoTransferencia;
  final String? informeProcedimientosRealizados;
  final String? tratamientoEfectuado;
  final String? tratamientoPersistePaciente;
  final DateTime? fechaVencimiento;
  final String? advertenciasFactoresRiesgo;
  final String? comentarioAdicional;
  final String? monitoreo;
  final String? informeTrabajoSocial;
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

  NotaReferencia({
    this.id,
    this.datosClinicos,
    this.datosIngreso,
    this.datosEgreso,
    this.condicionesPacienteMomentoTransferencia,
    this.informeProcedimientosRealizados,
    this.tratamientoEfectuado,
    this.tratamientoPersistePaciente,
    this.fechaVencimiento,
    this.advertenciasFactoresRiesgo,
    this.comentarioAdicional,
    this.monitoreo,
    this.informeTrabajoSocial,
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

  factory NotaReferencia.fromJson(Map<String, dynamic> json) {
    return NotaReferencia(
      id: json['id'] ?? 0,
      datosClinicos: json['datosClinicos'] ?? '',
      datosIngreso: json['datosIngreso'] ?? '',
      datosEgreso: json['datosEgreso'] ?? '',
      condicionesPacienteMomentoTransferencia:
          json['condicionesPacienteMomentoTransferencia'] ?? '',
      informeProcedimientosRealizados:
          json['informeProcedimientosRealizados'] ?? '',
      tratamientoEfectuado: json['tratamientoEfectuado'] ?? '',
      tratamientoPersistePaciente: json['tratamientoPersistePaciente'] ?? '',
      fechaVencimiento: json['fechaVencimiento'] != null
          ? DateTime.parse(json['fechaVencimiento'])
          : null,
      advertenciasFactoresRiesgo: json['advertenciasFactoresRiesgo'] ?? '',
      comentarioAdicional: json['comentarioAdicional'] ?? '',
      monitoreo: json['monitoreo'] ?? '',
      informeTrabajoSocial: json['informeTrabajoSocial'] ?? '',
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
      'datosClinicos': datosClinicos,
      'datosIngreso': datosIngreso,
      'datosEgreso': datosEgreso,
      'condicionesPacienteMomentoTransferencia':
          condicionesPacienteMomentoTransferencia,
      'informeProcedimientosRealizados': informeProcedimientosRealizados,
      'tratamientoEfectuado': tratamientoEfectuado,
      'tratamientoPersistePaciente': tratamientoPersistePaciente,
      'fechaVencimiento': fechaVencimiento?.toIso8601String(),
      'advertenciasFactoresRiesgo': advertenciasFactoresRiesgo,
      'comentarioAdicional': comentarioAdicional,
      'monitoreo': monitoreo,
      'informeTrabajoSocial': informeTrabajoSocial,
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

  static List<NotaReferencia> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => NotaReferencia.fromJson(json)).toList();
  }
}
