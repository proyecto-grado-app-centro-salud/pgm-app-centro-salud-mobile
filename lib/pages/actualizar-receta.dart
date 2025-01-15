import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/controladores/RecetasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActualizarRecetaView extends StatefulWidget {
  const ActualizarRecetaView({super.key, required this.idReceta});

  static const id = "actualizar-receta";
  final int idReceta;

  @override
  State<ActualizarRecetaView> createState() =>
      _ActualizarRecetaViewState(idReceta: idReceta);
}

class _ActualizarRecetaViewState extends State<ActualizarRecetaView> {
  final int idReceta;
  _ActualizarRecetaViewState({required this.idReceta});
  final Map<String, TextEditingController> controllers = {
    'nombreGenericoMedicamentoPreescrito': TextEditingController(),
    'viaCuidadoEspecialesAdministracion': TextEditingController(),
    'concentracionDosificacion': TextEditingController(),
    'frecuenciaAdministracion24hrs': TextEditingController(),
    'duracionTratamiento': TextEditingController(),
    'fechaVencimiento': TextEditingController(),
    'precaucionesEspeciales': TextEditingController(),
    'indicacionesEspeciales': TextEditingController(),
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'cantidadRecetada': TextEditingController(),
    'cantidadDispensada': TextEditingController()
  };
  Receta? receta;
  final _recetasController = RecetasController();

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
    obtenerReceta(idReceta);
    obtenerPacientes();
    super.initState();
  }

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
                  'Actualizacion receta',
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
                    'Nombre generico de medicamento prescrito'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(context,
                    controllers['nombreGenericoMedicamentoPreescrito']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento(
                    'Via y cuidados especiales de administracion'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(context,
                    controllers['viaCuidadoEspecialesAdministracion']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Concentracion y dosificacion'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['concentracionDosificacion']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento(
                    'Frecuencia de administracion cada 24 horas'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['frecuenciaAdministracion24hrs']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Duracion de tratamiento'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['duracionTratamiento']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Fecha de vencimiento'),
                SizedBox(height: 5),
                inputDateFormFieldFormatoBorderBlack(
                    context,
                    controllers['fechaVencimiento']!,
                    "",
                    _onSelectFechaVencimiento),
                SizedBox(height: 5),
                etiquetaInputDocumento('Precauciones especiales'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['precaucionesEspeciales']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Indicaciones especiales'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['indicacionesEspeciales']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Cantidad recetada'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['cantidadRecetada']!, ""),
                SizedBox(height: 5),
                etiquetaInputDocumento('Cantidad dispensada'),
                SizedBox(height: 5),
                inputFormFieldFormatoBorderBlack(
                    context, controllers['cantidadDispensada']!, ""),
                SizedBox(height: 5),
                botonFormularioDocumento("Actualizar", () {
                  final formState1 = formKey.currentState;
                  if (formState1 != null && formState1.validate()) {
                    actualizarReceta(context, controllers);
                  }
                }),
                botonPrimario(
                    context, "Obtener pdf", () => {obtenerPDFReceta()})
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectFechaVencimiento(String date) {
    setState(() {
      controllers['fechaVencimiento']!.text = date;
    });
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

  Future<void> obtenerReceta(int idReceta) async {
    try {
      final recetaResponse = await _recetasController.obtenerReceta(idReceta);
      setState(() {
        receta = recetaResponse;
        establecerValoresEnControllersReceta(receta);
      });
    } catch (e) {
      print('Error al obtener la receta: $e');
    }
  }

  Future<void> actualizarReceta(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await _recetasController.actualizarReceta(controllers, idReceta);
      mostrarMensajeExito(context, titulo: "Actualizacion receta exitoso");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  void establecerValoresEnControllersReceta(Receta? receta) {
    if (receta != null) {
      setState(() {
        controllers['nombreGenericoMedicamentoPreescrito']?.text =
            receta.nombreGenericoMedicamentoPrescrito ?? '';
        controllers['viaCuidadoEspecialesAdministracion']?.text =
            receta.viaCuidadoEspecialesAdministracion ?? '';
        controllers['concentracionDosificacion']?.text =
            receta.concentracionDosificacion ?? '';
        controllers['frecuenciaAdministracion24hrs']?.text =
            receta.frecuenciaAdministracion24hrs ?? '';
        controllers['duracionTratamiento']?.text =
            receta.duracionTratamiento ?? '';
        controllers['fechaVencimiento']?.text =
            receta.fechaVencimiento?.toString() ?? '';
        controllers['precaucionesEspeciales']?.text =
            receta.precaucionesEspeciales ?? '';
        controllers['indicacionesEspeciales']?.text =
            receta.indicacionesEspeciales ?? '';
        controllers['cantidadDispensada']?.text =
            receta.cantidadDispensada.toString() ?? '0';
        controllers['cantidadRecetada']?.text =
            receta.cantidadRecetada.toString() ?? '0';
        controllers['idPaciente']?.text = receta.idPaciente.toString();
        controllers['ciPaciente']?.text = receta.ciPropietario ?? '';
        controllers['idHistoriaClinica']?.text =
            receta.idHistoriaClinica.toString();
        controllers['diagnosticoPresuntivo']?.text =
            receta.diagnosticoPresuntivo ?? '';
      });
    }
  }

  obtenerPDFReceta() {
    try {
      Map<String, String> stringMap = {
        "id": receta!.id.toString(),
        "nombreGenericoMedicamentoPreescrito":
            receta!.nombreGenericoMedicamentoPrescrito.toString(),
        "viaCuidadoEspecialesAdministracion":
            receta!.viaCuidadoEspecialesAdministracion.toString(),
        "concentracionDosificacion":
            receta!.concentracionDosificacion.toString(),
        "frecuenciaAdministracion24hrs":
            receta!.frecuenciaAdministracion24hrs.toString(),
        "duracionTratamiento": receta!.duracionTratamiento.toString(),
        "cantidadDispensada": receta!.cantidadDispensada.toString(),
        "cantidadRecetada": receta!.cantidadRecetada.toString(),
        "precaucionesEspeciales": receta!.precaucionesEspeciales.toString(),
        "indicacionesEspeciales": receta!.indicacionesEspeciales.toString(),
        "idPaciente": receta!.idPaciente.toString(),
        "ciPaciente": receta!.ciPropietario.toString(),
        "idHistoriaClinica": receta!.idHistoriaClinica.toString(),
        "diagnosticoPresuntivo": receta!.diagnosticoPresuntivo.toString()
      };
      _recetasController.obtenerPDFReceta(stringMap);
    } catch (e) {
      print(e);
    }
  }
}
