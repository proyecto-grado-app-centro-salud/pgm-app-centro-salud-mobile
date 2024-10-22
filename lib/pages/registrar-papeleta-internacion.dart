import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/controladores/PapeletasInternacionController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarPapeletaInternacion extends StatefulWidget {
  const RegistrarPapeletaInternacion({super.key});
  static const id = "registrar_papeleta_internacion";
  @override
  State<RegistrarPapeletaInternacion> createState() =>
      _RegistrarPapeletaInternacionState();
}

class _RegistrarPapeletaInternacionState
    extends State<RegistrarPapeletaInternacion> {
  TextEditingController paciente = TextEditingController();
  TextEditingController historiaClinica = TextEditingController();
  TextEditingController fechaIngreso = TextEditingController();
  TextEditingController diagnostico = TextEditingController();
  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'fechaIngreso': TextEditingController(),
    'diagnostico': TextEditingController()
  };
  List<Paciente> pacientes = [];
  List<HistoriaClinica> historiasClinicas = [];
  void _onSelectItemPaciente(Paciente item) {
    setState(() {
      controllers['ciPaciente']!.text = item.ci.toString();
      controllers['idPaciente']!.text = item.idUsuario.toString();
    });
  }

  void _onSelectItemHistoriaClinica(HistoriaClinica item) {
    setState(() {
      controllers['idHistoriaClinica']!.text = item.id.toString();
      controllers['diagnosticoPresuntivo']!.text =
          item.diagnosticoPresuntivo.toString();
    });
  }

  void _onSelectFechaIngreso(String date) {
    setState(() {
      controllers['fechaIngreso']!.text = date;
    });
  }

  PapeletasInternacionController papeletasInternacionController =
      PapeletasInternacionController();
  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  PacientesController pacientesController = PacientesController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    obtenerPacientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 254, 250, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Detalle de papeleta de internacion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
              SizedBox(height: 5),
              etiquetaInputDocumento('Paciente'),
              SizedBox(height: 5),
              inputListSuggestionsPacientes(context, pacientes,
                  controllers["ciPaciente"], _onSelectItemPaciente),
              (controllers['idPaciente']!.text != '')
                  ? botonFormularioDocumento("Buscar historias clinicas", () {
                      obtenerHistoriasClinicasDePaciente(
                          controllers['idPaciente']!.text);
                    })
                  : const SizedBox(),
              SizedBox(height: 5),
              etiquetaInputDocumento('Historia clinica'),
              SizedBox(height: 5),
              inputListSuggestionsHistoriasClinicas(
                  context,
                  historiasClinicas,
                  controllers["diagnosticoPresuntivo"],
                  _onSelectItemHistoriaClinica),
              SizedBox(height: 5),
              etiquetaInputDocumento('Diagnostico'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(context, diagnostico, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha de ingreso'),
              SizedBox(height: 5),
              inputDateFormFieldFormatoBorderBlack(context,
                  controllers['fechaIngreso']!, "", _onSelectFechaIngreso),
              botonFormularioDocumento("Registrar", () {
                if (formKey.currentState?.validate() ?? false) {
                  registrarPapeletaInternacion(context, controllers);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void obtenerPacientes() async {
    try {
      List<Paciente> pacientesRecibidos =
          await pacientesController.obtenerPacientes();
      setState(() {
        pacientes = pacientesRecibidos;
      });
    } catch (e) {
      print('Error al cargar pacientes: $e');
    }
  }

  void obtenerHistoriasClinicasDePaciente(String idPaciente) async {
    try {
      List<HistoriaClinica> historiasClinicasRecibidas =
          await historiasClinicasController
              .obtenerHistoriasClinicasDePaciente(idPaciente);
      setState(() {
        historiasClinicas = historiasClinicasRecibidas;
      });
    } catch (e) {
      print('Error al cargar historias clinicas: $e');
    }
  }

  Future<void> registrarPapeletaInternacion(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await papeletasInternacionController
          .registrarPapeletaInternacion(controllers);
      mostrarMensajeExito(context);
    } catch (e) {
      print(e);
      mostrarMensajeError(context);
    }
  }
}
