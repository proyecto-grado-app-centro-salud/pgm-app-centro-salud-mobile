import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/ExamenesComplementariosController.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActulizarExamenComplementarioView extends StatefulWidget {
  const ActulizarExamenComplementarioView(
      {super.key, required this.idExamenComplementario});
  static const id = "actualizar-examen-complementario";
  final int idExamenComplementario;
  @override
  State<ActulizarExamenComplementarioView> createState() =>
      _ActulizarExamenComplementarioViewState(
          idExamenComplementario: idExamenComplementario);
}

class _ActulizarExamenComplementarioViewState
    extends State<ActulizarExamenComplementarioView> {
  final int idExamenComplementario;
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
  ExamenComplementario? examenComplementario;
  final examenesComplementariosController = ExamenesComplementariosController();
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
    super.initState();
    obtenerExamenComplementario(idExamenComplementario);
    obtenerPacientes();
  }

  _ActulizarExamenComplementarioViewState(
      {required this.idExamenComplementario});
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
                  'Actualizar examen complementario',
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
                etiquetaInputDocumento('Fecha solicitud'),
                SizedBox(height: 5),
                inputDateFormFieldFormatoBorderBlack(
                    context,
                    controllers['fechaSolicitud']!,
                    "",
                    _onSelectFechaSolicitud),
                botonFormularioDocumento("Actualizar", () {
                  final formState1 = formKey.currentState;
                  if (formState1 != null && formState1.validate()) {
                    actualizarExamenComplementario(context, controllers);
                  }
                }),
                botonFormularioDocumento("Obtener pdf", () {
                  obtenerPDFExamenComplementario();
                })
              ],
            ),
          ),
        ),
      ),
    );
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

  Future<void> obtenerExamenComplementario(int idExamenComplementario) async {
    try {
      final examenResponse = await examenesComplementariosController
          .obtenerExamenComplementario(idExamenComplementario);
      setState(() {
        examenComplementario = examenResponse;
        establecerValoresEnControllersExamenComplementario(
            examenComplementario);
      });
    } catch (e) {
      print('Error al obtener el examen complementario: $e');
    }
  }

  Future<void> actualizarExamenComplementario(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await examenesComplementariosController.actualizarExamenComplementario(
          controllers, idExamenComplementario);
      mostrarMensajeExito(context, titulo: "Examen complementario actualizado");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  void obtenerPDFExamenComplementario() {
    try {
      Map<String, String> stringMap = {
        "id": examenComplementario!.id.toString(),
        "nombre": examenComplementario!.nombre.toString(),
        "descripcion": examenComplementario!.descripcion.toString(),
        "idHistoriaClinica": examenComplementario!.idHistoriaClinica.toString(),
        "idMedico": examenComplementario!.idMedico.toString(),
      };
      examenesComplementariosController
          .obtenerPDFExamenComplementario(stringMap);
    } catch (e) {
      print(e);
    }
  }

  void establecerValoresEnControllersExamenComplementario(
      ExamenComplementario? examenComplementario) {
    if (examenComplementario != null) {
      setState(() {
        controllers['nombre']?.text = examenComplementario.nombre ?? '';
        controllers['descripcion']?.text =
            examenComplementario.descripcion ?? '';
        controllers['resumenResultados']?.text =
            examenComplementario.resumenResultados ?? '';
        controllers['fechaResultado']?.text =
            examenComplementario.fechaResultado.toString();
        controllers['fechaSolicitud']?.text =
            examenComplementario.fechaSolicitud.toString();
        controllers['idPaciente']?.text =
            examenComplementario.idPaciente.toString();
        controllers['ciPaciente']?.text =
            examenComplementario.ciPropietario ?? '';
        controllers['idHistoriaClinica']?.text =
            examenComplementario.idHistoriaClinica.toString();
        controllers['diagnosticoPresuntivo']?.text =
            examenComplementario.diagnosticoPresuntivo ?? '';
      });
    }
  }
}
