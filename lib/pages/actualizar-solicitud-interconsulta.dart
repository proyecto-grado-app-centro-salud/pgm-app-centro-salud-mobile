import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/controladores/SolicitudesInterconsultasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActualizarSolicitudInterconsultaView extends StatefulWidget {
  const ActualizarSolicitudInterconsultaView(
      {super.key, required this.idSolicitudInterconsulta});

  static const id = "actualizar-solicitud-interconsulta";
  final int idSolicitudInterconsulta;
  @override
  State<ActualizarSolicitudInterconsultaView> createState() =>
      _ActualizarSolicitudInterconsultaViewState(
          idSolicitud: idSolicitudInterconsulta);
}

class _ActualizarSolicitudInterconsultaViewState
    extends State<ActualizarSolicitudInterconsultaView> {
  final int idSolicitud;
  _ActualizarSolicitudInterconsultaViewState({required this.idSolicitud});
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
  SolicitudInterconsulta? solicitudInterconsulta;
  final _solicitudesController = SolicitudesInterconsultasController();
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
    obtenerSolicitudInterconsulta(idSolicitud);
    obtenerPacientes();
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
                  'Actualizacion solicitud interconsulta',
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
                    actualizarSolicitudInterconsulta(context, controllers);
                  }
                }),
                botonPrimario(context, "Obtener pdf",
                    () => {obtenerPDFSolicitudInterconsulta()})
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

  Future<void> obtenerSolicitudInterconsulta(int idSolicitud) async {
    try {
      final solicitudResponse = await _solicitudesController
          .obtenerSolicitudInterconsulta(idSolicitud);
      setState(() {
        solicitudInterconsulta = solicitudResponse;
        establecerValoresEnControllersSolicitud(solicitudInterconsulta);
      });
    } catch (e) {
      print('Error al obtener la solicitud de interconsulta: $e');
    }
  }

  Future<void> actualizarSolicitudInterconsulta(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await _solicitudesController.actualizarSolicitudInterconsulta(
          controllers, idSolicitud);
      mostrarMensajeExito(context,
          titulo: "Actualizaacion solicitud de interconsulta exitoso");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  void establecerValoresEnControllersSolicitud(
      SolicitudInterconsulta? solicitudInterconsulta) {
    if (solicitudInterconsulta != null) {
      setState(() {
        controllers['hospitalInterconsultado']?.text =
            solicitudInterconsulta.hospitalInterconsultado ?? '';
        controllers['unidadInterconsultada']?.text =
            solicitudInterconsulta.unidadInterconsultada ?? '';
        controllers['queDeseaSaber']?.text =
            solicitudInterconsulta.queDeseaSaber ?? '';
        controllers['sintomatologia']?.text =
            solicitudInterconsulta.sintomatologia ?? '';
        controllers['tratamiento']?.text =
            solicitudInterconsulta.tratamiento ?? '';
        controllers['idPaciente']?.text =
            solicitudInterconsulta.idPaciente.toString();
        controllers['ciPaciente']?.text =
            solicitudInterconsulta.ciPropietario ?? '';
        controllers['idHistoriaClinica']?.text =
            solicitudInterconsulta.idHistoriaClinica.toString();
        controllers['diagnosticoPresuntivo']?.text =
            solicitudInterconsulta.diagnosticoPresuntivo ?? '';
      });
    }
  }

  obtenerPDFSolicitudInterconsulta() {
    try {
      Map<String, String> stringMap = {
        "id": solicitudInterconsulta!.id.toString(),
        "hospitalInterconsultado":
            solicitudInterconsulta!.hospitalInterconsultado.toString(),
        "unidadInterconsultada":
            solicitudInterconsulta!.unidadInterconsultada.toString(),
        "queDeseaSaber": solicitudInterconsulta!.queDeseaSaber.toString(),
        "sintomatologia": solicitudInterconsulta!.sintomatologia.toString(),
        "tratamiento": solicitudInterconsulta!.tratamiento.toString(),
        "idPaciente": solicitudInterconsulta!.idPaciente.toString(),
        "ciPaciente": solicitudInterconsulta!.ciPropietario.toString(),
        "idHistoriaClinica":
            solicitudInterconsulta!.idHistoriaClinica.toString(),
        "diagnosticoPresuntivo":
            solicitudInterconsulta!.diagnosticoPresuntivo.toString()
      };
      _solicitudesController.obtenerPDFSolicitudInterconsulta(stringMap);
    } catch (e) {
      print(e);
    }
  }
}
