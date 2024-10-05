import 'dart:convert';

class NotaReferencia {
  final int id;
  final String datosClinicos;
  final String datosIngreso;
  final String datosEgreso;
  final String condicionesPacienteMomentoTransferencia;
  final String informeProcedimientosRealizados;
  final String tratamientoEfectuado;
  final String tratamientoPersistePaciente;
  final String fechaVencimiento;
  final String advertenciasFactoresRiesgo;
  final String comentarioAdicional;
  final String monitoreo;
  final String informeTrabajoSocial;
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

  NotaReferencia({
    required this.id,
    required this.datosClinicos,
    required this.datosIngreso,
    required this.datosEgreso,
    required this.condicionesPacienteMomentoTransferencia,
    required this.informeProcedimientosRealizados,
    required this.tratamientoEfectuado,
    required this.tratamientoPersistePaciente,
    required this.fechaVencimiento,
    required this.advertenciasFactoresRiesgo,
    required this.comentarioAdicional,
    required this.monitoreo,
    required this.informeTrabajoSocial,
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
      fechaVencimiento: json['fechaVencimiento'] ?? '',
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

  static List<NotaReferencia> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => NotaReferencia.fromJson(json)).toList();
  }
}
