import 'dart:convert';

class Receta {
  final int id;
  final String nombreGenericoMedicamentoPrescrito;
  final String viaCuidadoEspecialesAdministracion;
  final String concentracionDosificacion;
  final String frecuenciaAdministracion24hrs;
  final String duracionTratamiento;
  final DateTime fechaVencimiento;
  final String precaucionesEspeciales;
  final String indicacionesEspeciales;
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

  Receta({
    required this.id,
    required this.nombreGenericoMedicamentoPrescrito,
    required this.viaCuidadoEspecialesAdministracion,
    required this.concentracionDosificacion,
    required this.frecuenciaAdministracion24hrs,
    required this.duracionTratamiento,
    required this.fechaVencimiento,
    required this.precaucionesEspeciales,
    required this.indicacionesEspeciales,
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

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'] ?? 0,
      nombreGenericoMedicamentoPrescrito:
          json['nombre_generico_medicamento_preescrito'] ?? '',
      viaCuidadoEspecialesAdministracion:
          json['via_cuidado_especiales_administracion'] ?? '',
      concentracionDosificacion: json['concentracion_dosificacion'] ?? '',
      frecuenciaAdministracion24hrs:
          json['frecuencia_administracion_24hrs'] ?? '',
      duracionTratamiento: json['duracion_tratamiento'] ?? '',
      fechaVencimiento: DateTime.parse(json['fecha_vencimiento']),
      precaucionesEspeciales: json['precauciones_especiales'] ?? '',
      indicacionesEspeciales: json['indicaciones_especiales'] ?? '',
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

  static List<Receta> listFromString(String list) {
    List jsonList = jsonDecode(list);
    return jsonList.map((json) => Receta.fromJson(json)).toList();
  }
}
