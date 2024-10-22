import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/ExamenesComplementariosController.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarExamenComplementario extends StatefulWidget {
  const RegistrarExamenComplementario({super.key});
  static const id = "registrar_examen_complementario";
  @override
  State<RegistrarExamenComplementario> createState() =>
      _RegistrarExamenComplementarioState();
}

class _RegistrarExamenComplementarioState
    extends State<RegistrarExamenComplementario> {
  final Map<String, TextEditingController> controllers = {
    'nombre': TextEditingController(),
    'descripcion': TextEditingController(),
    'resumenResultados': TextEditingController(),
    'fechaResultado': TextEditingController(),
    'fechaSolicitud': TextEditingController(),
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController()
  };
  ExamenesComplementariosController examenesComplementariosController =
      ExamenesComplementariosController();
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

  void _onSelectFechaResultado(String date) {
    setState(() {
      controllers['fechaResultado']!.text = date;
    });
  }

  void _onSelectFechaSolicitud(String date) {
    setState(() {
      controllers['fechaSolicitud']!.text = date;
    });
  }

  @override
  void initState() {
    obtenerPacientes();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 254, 250, 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Detalle de examen complementario',
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
                etiquetaInputDocumento('Nombre examen complementario'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['nombre']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Descripcion'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['descripcion']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Resumen de resultados'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                  context,
                  controllers['resumenResultados']!,
                  "",
                ),
                SizedBox(height: 5),
                etiquetaInputDocumento('Fecha resultado'),
                SizedBox(height: 5),
                inputDateFormFieldFormatoBorderBlack(
                    context,
                    controllers['fechaResultado']!,
                    "",
                    _onSelectFechaResultado),
                SizedBox(height: 5),
                etiquetaInputDocumento('Fecha solicitud'),
                SizedBox(height: 5),
                inputDateFormFieldFormatoBorderBlack(
                    context,
                    controllers['fechaSolicitud']!,
                    "",
                    _onSelectFechaSolicitud),
                botonFormularioDocumento("Registrar", () {
                  final formState1 = formKey.currentState;
                  if (formState1 != null && formState1.validate()) {
                    registrarExamenComplementario(context, controllers);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  PacientesController pacientesController = PacientesController();
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

  Future<void> registrarExamenComplementario(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await examenesComplementariosController
          .registrarExamenComplementario(controllers);
      mostrarMensajeExito(context);
    } catch (e) {
      print(e);
      mostrarMensajeError(context);
    }
  }
}
