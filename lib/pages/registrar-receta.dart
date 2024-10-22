import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/controladores/RecetasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarReceta extends StatefulWidget {
  const RegistrarReceta({super.key});
  static const id = "registrar_receta";
  @override
  State<RegistrarReceta> createState() => _RegistrarRecetaState();
}

class _RegistrarRecetaState extends State<RegistrarReceta> {
  final Map<String, TextEditingController> controllers = {
    'nombreGenericoMedicamentoPrescrito': TextEditingController(),
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
    'diagnosticoPresuntivo': TextEditingController()
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

  void _onSelectFechaVencimiento(String date) {
    setState(() {
      controllers['fechaVencimiento']!.text = date;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                'Detalle de receta',
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
                  controllers['nombreGenericoMedicamentoPrescrito']!, ""),
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
              botonFormularioDocumento("Registrar", () {
                final formState1 = formKey.currentState;
                if (formState1 != null && formState1.validate()) {
                  registrarReceta(context, controllers);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  PacientesController pacientesController = PacientesController();
  RecetasController recetasController = RecetasController();
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

  Future<void> registrarReceta(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await recetasController.registrarReceta(controllers);
      mostrarMensajeExito(context);
    } catch (e) {
      print(e);
      mostrarMensajeError(context);
    }
  }
}
