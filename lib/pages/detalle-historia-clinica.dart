import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetalleHistoriaClinicaView extends StatefulWidget {
  const DetalleHistoriaClinicaView(
      {super.key, required this.idHistoriaClinica});
  static const id = "detalle-historia-clinica";
  final int idHistoriaClinica;
  @override
  State<DetalleHistoriaClinicaView> createState() =>
      _DetalleHistoriaClinicaViewState(idHistoriaClinica: idHistoriaClinica);
}

class _DetalleHistoriaClinicaViewState
    extends State<DetalleHistoriaClinicaView> {
  final int idHistoriaClinica;
  _DetalleHistoriaClinicaViewState({required this.idHistoriaClinica});
  @override
  void initState() {
    super.initState();
    obtenerHistoriaClinica(idHistoriaClinica);
  }

  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idEspecialidad': TextEditingController(),
    'nombreEspecialidad': TextEditingController(),
    'antecedentesPersonales': TextEditingController(),
    'antecedentesFamiliares': TextEditingController(),
    'antecedentesNoPatologicos': TextEditingController(),
    'antecedentesPatologicos': TextEditingController(),
    'antecedentesGinecoobstetricos': TextEditingController(),
    'condicionesActualesDeSaludOEnfermedad': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'diagnosticosDiferenciales': TextEditingController(),
    'examenFisico': TextEditingController(),
    'examenFisicoEspecial': TextEditingController(),
    'propuestaBasicaDeConducta': TextEditingController(),
    'tratamiento': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: NavDrawer(),
        backgroundColor: Colores.color2,
        body: SingleChildScrollView(
          child: Container(
            color: Colores.color2,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Detalle de historia clínica',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                etiquetaInputDocumento('Paciente'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(context, controllers['ciPaciente']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Especialidad'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['nombreEspecialidad']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Condiciones actuales estado de salud'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(context,
                    controllers['condicionesActualesDeSaludOEnfermedad']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Antecedentes familiares'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['antecedentesFamiliares']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                // etiquetaInputDocumento('Antecedentes ginecoobstericos'),
                // SizedBox(height: 5),
                // inputFormatoBorderBlack(
                //     context, controllers['antecedentesGinecoobstetricos']!, '',
                //     readOnly: true),
                // SizedBox(height: 5),
                etiquetaInputDocumento('Antecedentes no patológicos'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['antecedentesNoPatologicos']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Antecedentes patológicos'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['antecedentesPatologicos']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Antecedentes personales'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['antecedentesPersonales']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Diagnostico presuntivo'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['diagnosticoPresuntivo']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Diagnosticos diferenciales'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['diagnosticosDiferenciales']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Examen físico general'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['examenFisico']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Examen físico especial'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['examenFisicoEspecial']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Propuesta basica de conducta'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['propuestaBasicaDeConducta']!, '',
                    readOnly: true),
                SizedBox(height: 5),
                etiquetaInputDocumento('Tratamiento'),
                SizedBox(height: 5),
                inputFormatoBorderBlack(
                    context, controllers['tratamiento']!, '',
                    readOnly: true),
                SizedBox(height: 5),
              ],
            ),
          ),
        ));
  }

  HistoriaClinica? historiaClinica;
  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  Future<void> obtenerHistoriaClinica(int idHistoriaClinica) async {
    try {
      final historiaClinicaResponse = await historiasClinicasController
          .obtenerHistoriaClinica(idHistoriaClinica);
      setState(() {
        historiaClinica = historiaClinicaResponse;
        establecerValoresEnControllersHistoriaClinica(historiaClinica);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersHistoriaClinica(
      HistoriaClinica? historiaClinica) {
    if (historiaClinica != null) {
      setState(() {
        controllers['ciPaciente']?.text = historiaClinica.ciPropietario ?? '';
        controllers['nombreEspecialidad']?.text =
            historiaClinica.nombreEspecialidad ?? '';
        controllers['antecedentesPersonales']?.text =
            historiaClinica.antecedentesPersonales;
        controllers['antecedentesFamiliares']?.text =
            historiaClinica.antecedentesFamiliares;
        controllers['antecedentesNoPatologicos']?.text =
            historiaClinica.antecedentesNoPatologicos;
        controllers['antecedentesPatologicos']?.text =
            historiaClinica.antecedentesPatologicos;
        controllers['antecedentesGinecoobstetricos']?.text =
            historiaClinica.antecedentesGinecoobstetricos;
        controllers['condicionesActualesDeSaludOEnfermedad']?.text =
            historiaClinica.amnesis;
        controllers['diagnosticoPresuntivo']?.text =
            historiaClinica.diagnosticoPresuntivo;
        controllers['diagnosticosDiferenciales']?.text =
            historiaClinica.diagnosticosDiferenciales;
        controllers['examenFisico']?.text = historiaClinica.examenFisico;
        controllers['examenFisicoEspecial']?.text =
            historiaClinica.examenFisicoEspecial;
        controllers['propuestaBasicaDeConducta']?.text =
            historiaClinica.propuestaBasicaDeConducta;
        controllers['tratamiento']?.text = historiaClinica.tratamiento;
      });
    }
  }
}
