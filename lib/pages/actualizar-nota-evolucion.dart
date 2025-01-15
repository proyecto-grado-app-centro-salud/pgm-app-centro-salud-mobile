import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/NotasEvolucionController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActualizarNotaEvolucionView extends StatefulWidget {
  const ActualizarNotaEvolucionView({super.key, required this.idNotaEvolucion});
  static const id = "actualizar-nota-evolucion";
  final int idNotaEvolucion;
  @override
  State<ActualizarNotaEvolucionView> createState() =>
      _ActualizarNotaEvolucionViewState(idNotaEvolucion: idNotaEvolucion);
}

class _ActualizarNotaEvolucionViewState
    extends State<ActualizarNotaEvolucionView> {
  final int idNotaEvolucion;
  final _notasEvolucionController = NotasEvolucionController();
  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'cambiosPacienteResultadosTratamiento': TextEditingController(),
  };
  NotaEvolucion? notaEvolucion;
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
    obtenerNotaEvolucion(idNotaEvolucion);
    obtenerPacientes();
  }

  _ActualizarNotaEvolucionViewState({required this.idNotaEvolucion});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: Form(
        key: _formKey,
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
                  'Actualizar nota de evolucion',
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
                etiquetaInputDocumento(
                    'Cambios del paciente por resultados del tratamiento'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(context,
                    controllers["cambiosPacienteResultadosTratamiento"]!, ""),
                botonFormularioDocumento("Actualizar", () {
                  final formState1 = _formKey.currentState;
                  if (formState1 != null && formState1.validate()) {
                    actualizarNotaEvolucion(context, controllers);
                  }
                }),
                botonPrimario(
                    context, "Obtener pdf", () => {obtenerPDFNotaEvolucion()})
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

  Future<void> obtenerNotaEvolucion(int idNotaEvolucion) async {
    try {
      final notaEvolucionResponse =
          await _notasEvolucionController.obtenerNotaEvolucion(idNotaEvolucion);
      print(notaEvolucionResponse);
      setState(() {
        notaEvolucion = notaEvolucionResponse;
        establecerValoresEnControllersNotaEvolucion(notaEvolucion);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  Future<void> actualizarNotaEvolucion(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await _notasEvolucionController.actualizarNotaEvolucion(
          controllers, idNotaEvolucion);
      mostrarMensajeExito(context,
          titulo: "Actualizacion nota evolucion exitoso");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  void establecerValoresEnControllersNotaEvolucion(
      NotaEvolucion? notaEvolucion) {
    if (notaEvolucion != null) {
      setState(() {
        controllers['idHistoriaClinica']?.text = notaEvolucion.id.toString();
        controllers['idPaciente']?.text = notaEvolucion.idPaciente.toString();
        controllers['ciPaciente']?.text = notaEvolucion.ciPropietario ?? '';
        controllers['diagnosticoPresuntivo']?.text =
            notaEvolucion.diagnosticoPresuntivo ?? '';
        controllers['cambiosPacienteResultadosTratamiento']?.text =
            notaEvolucion.cambiosPacienteResultadosTratamiento ?? '';
      });
    }
  }

  obtenerPDFNotaEvolucion() {
    try {
      Map<String, String> stringMap = {
        "id": notaEvolucion!.id.toString(),
        "idPaciente": notaEvolucion!.idPaciente.toString(),
        "ciPaciente": notaEvolucion!.ciPropietario.toString(),
        "diagnosticoPresuntivo":
            notaEvolucion!.diagnosticoPresuntivo.toString(),
        "idHistoriaClinica": notaEvolucion!.idHistoriaClinica.toString(),
        "cambiosPacienteResultadosTratamiento":
            notaEvolucion!.cambiosPacienteResultadosTratamiento.toString()
      };
      _notasEvolucionController.obtenerPDFNotaEvolucion(stringMap);
    } catch (e) {
      print(e);
    }
  }
}
