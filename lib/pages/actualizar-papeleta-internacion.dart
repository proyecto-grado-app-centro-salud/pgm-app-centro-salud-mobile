import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/controladores/PapeletasInternacionController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActualizarPapeletaInternacion extends StatefulWidget {
  const ActualizarPapeletaInternacion(
      {super.key, required this.idPapeletaInternacion});

  static const id = "actualizar-papeleta-internacion";
  final int idPapeletaInternacion;

  @override
  State<ActualizarPapeletaInternacion> createState() =>
      _ActualizarPapeletaInternacionState(
          idPapeletaInternacion: idPapeletaInternacion);
}

class _ActualizarPapeletaInternacionState
    extends State<ActualizarPapeletaInternacion> {
  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'fechaIngreso': TextEditingController(),
    'diagnostico': TextEditingController()
  };
  PapeletaInternacion? papeletaInternacion;
  final _papeletasInternacionController = PapeletasInternacionController();

  List<Paciente> pacientes = [];
  List<HistoriaClinica> historiasClinicas = [];
  final _historiasClinicasController = HistoriasClinicasController();
  final _pacientesController = PacientesController();
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  @override
  void initState() {
    super.initState();
    obtenerPapeletaInternacion(widget.idPapeletaInternacion);
    obtenerPacientes();
  }

  final int idPapeletaInternacion;
  _ActualizarPapeletaInternacionState({required this.idPapeletaInternacion});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const NavDrawer(),
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
                  'Actualizacion papeleta de internacion',
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
                inputFormFieldFormatoBorderBlack(
                    context, controllers['diagnostico']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Fecha de ingreso'),
                SizedBox(height: 5),
                inputDateFormFieldFormatoBorderBlack(context,
                    controllers['fechaIngreso']!, "", _onSelectFechaIngreso),
                botonFormularioDocumento("Registrar", () {
                  if (formKey.currentState?.validate() ?? false) {
                    actualizarPapeletaInternacion(context, controllers);
                  }
                }),
                botonPrimario(context, "Obtener pdf",
                    () => {obtenerPDFPapeletaInternacion()})
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectFechaIngreso(String date) {
    setState(() {
      controllers['fechaIngreso']!.text = date;
    });
  }

  Future<void> actualizarPapeletaInternacion(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await _papeletasInternacionController.actualizarPapeletaInternacion(
          controllers, idPapeletaInternacion);
      mostrarMensajeExito(context,
          titulo: "Actualizacion papeleta de internacion exitoso");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  void obtenerPapeletaInternacion(int idPapeletaInternacion) async {
    try {
      final papeletaInternacionResponse = await _papeletasInternacionController
          .obtenerPapeletaInternacion(idPapeletaInternacion);
      setState(() {
        papeletaInternacion = papeletaInternacionResponse;
        establecerValoresEnControllersPapeletaInternacion(papeletaInternacion);
      });
    } catch (e) {
      print('Error al obtener la papeleta de internación: $e');
    }
  }

  void obtenerPacientes() async {
    try {
      List<Paciente> pacientesObtenidos =
          await _pacientesController.obtenerPacientes();
      setState(() {
        pacientes = pacientesObtenidos;
      });
    } catch (e) {
      print('Error al cargar pacientes: $e');
    }
  }

  void obtenerHistoriasClinicasDePaciente(String idPaciente) async {
    try {
      final historiasClinicaPaginadas = await _historiasClinicasController
          .obtenerHistoriasClinicasDePaciente(idPaciente);
      setState(() {
        historiasClinicas = historiasClinicaPaginadas['content'];
      });
    } catch (e) {
      print('Error al cargar historias clinicas: $e');
    }
  }

  void establecerValoresEnControllersPapeletaInternacion(
      PapeletaInternacion? papeletaInternacion) {
    if (papeletaInternacion != null) {
      setState(() {
        controllers['idPaciente']?.text =
            papeletaInternacion.idPaciente.toString();
        controllers['ciPaciente']?.text =
            papeletaInternacion.ciPropietario ?? '';
        controllers['idHistoriaClinica']?.text =
            papeletaInternacion.idHistoriaClinica.toString();
        controllers['diagnosticoPresuntivo']?.text =
            papeletaInternacion.diagnosticoPresuntivo ?? '';
        controllers['fechaIngreso']?.text =
            papeletaInternacion.fechaIngreso?.toString() ?? '';
        controllers['diagnostico']?.text =
            papeletaInternacion.diagnostico ?? '';
      });
    }
  }

  obtenerPDFPapeletaInternacion() {
    try {
      Map<String, String> stringMap = {
        "id": papeletaInternacion!.id.toString(),
        "idPaciente": papeletaInternacion!.idPaciente.toString(),
        "ciPaciente": papeletaInternacion!.ciPropietario.toString(),
        "idHistoriaClinica": papeletaInternacion!.idHistoriaClinica.toString(),
        "diagnosticoPresuntivo":
            papeletaInternacion!.diagnosticoPresuntivo.toString(),
        "diagnostico": papeletaInternacion!.diagnostico.toString()
      };
      _papeletasInternacionController.obtenerPDFPapeletaInternacion(stringMap);
    } catch (e) {
      print(e);
    }
  }
}
