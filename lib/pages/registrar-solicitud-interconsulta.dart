import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/controladores/SolicitudesInterconsultasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarSolicitudInterconsulta extends StatefulWidget {
  const RegistrarSolicitudInterconsulta({super.key});
  static const id = "registrar_solicitud_interconsulta";
  @override
  State<RegistrarSolicitudInterconsulta> createState() =>
      _RegistrarSolicitudInterconsultaState();
}

class _RegistrarSolicitudInterconsultaState
    extends State<RegistrarSolicitudInterconsulta> {
  final Map<String, TextEditingController> controllers = {
    'hospitalInterconsultado': TextEditingController(),
    'unidadInterconsultada': TextEditingController(),
    'queDeseaSaber': TextEditingController(),
    'sintomatologia': TextEditingController(),
    'tratamiento': TextEditingController(),
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController()
  };
  SolicitudesInterconsultasController solicitudesInterconsultasController =
      SolicitudesInterconsultasController();
  PacientesController pacientesController = PacientesController();
  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
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
                  'Detalle de solicitud interconsulta',
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
                etiquetaInputDocumento('Hospital interconsultado'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['hospitalInterconsultado']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Unidad interconsultada'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['unidadInterconsultada']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Que desea saber?'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                  context,
                  controllers['queDeseaSaber']!,
                  "",
                ),
                SizedBox(height: 5),
                etiquetaInputDocumento('Sintomatologia'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['sintomatologia']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Tratamiento'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['tratamiento']!, ""),
                botonFormularioDocumento("Registrar", () {
                  final formState1 = formKey.currentState;
                  if (formState1 != null && formState1.validate()) {
                    registrarSolicitudInterconsulta(context, controllers);
                  }
                }),
              ],
            ),
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

  Future<void> registrarSolicitudInterconsulta(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await solicitudesInterconsultasController
          .registrarSolicitudInterconsulta(controllers);
      mostrarMensajeExito(context);
    } catch (e) {
      print(e);
      mostrarMensajeError(context);
    }
  }
}
