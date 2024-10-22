import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/NotasReferenciaController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarNotaReferencia extends StatefulWidget {
  const RegistrarNotaReferencia({super.key});
  static const id = "registrar_nota_referencia";
  @override
  State<RegistrarNotaReferencia> createState() =>
      _RegistrarNotaReferenciaState();
}

class _RegistrarNotaReferenciaState extends State<RegistrarNotaReferencia> {
  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'datosClinicos': TextEditingController(),
    'datosIngreso': TextEditingController(),
    'datosEgreso': TextEditingController(),
    'condicionesPacienteMomentoTransferencia': TextEditingController(),
    'informeProcedimientosRealizados': TextEditingController(),
    'tratamientoEfectuado': TextEditingController(),
    'tratamientoPersistePaciente': TextEditingController(),
    'fechaVencimiento': TextEditingController(),
    'advertenciasFactoresRiesgo': TextEditingController(),
    'comentarioAdicional': TextEditingController(),
    'monitoreo': TextEditingController(),
    'informeTrabajoSocial': TextEditingController(),
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

  final PageController _pageController = PageController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: Form(
        key: formKey,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            formularioPrimeraPagina(context),
            formularioSegundaPagina(context)
          ],
        ),
      ),
    );
  }

  Widget formularioPrimeraPagina(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 254, 250, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Detalle de nota de referencia',
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
            etiquetaInputDocumento('Datos ingreso'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['datosIngreso']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Datos egreso'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['datosEgreso']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento(
                'Condiciones paciente momento transferencia'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(context,
                controllers['condicionesPacienteMomentoTransferencia']!, ""),
            SizedBox(height: 5),
            botonFormularioDocumento("Siguiente", () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget formularioSegundaPagina(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 254, 250, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            etiquetaInputDocumento('Informe procedimientos realizados'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['informeProcedimientosRealizados']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Tratamiento efectuado'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['tratamientoEfectuado']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Tratamiento persiste paciente'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['tratamientoPersistePaciente']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Fecha de vencimiento'),
            SizedBox(height: 5),
            inputDateFormFieldFormatoBorderBlack(
                context,
                controllers['fechaVencimiento']!,
                "",
                _onSelectFechaVencimiento),
            SizedBox(height: 5),
            Row(children: [
              botonFormularioDocumento("Anterior", () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }),
              botonFormularioDocumento("Registrar", () {
                final formState1 = formKey.currentState;
                if (formState1 != null && formState1.validate()) {
                  registrarNotaReferencia(context, controllers);
                }
              }),
            ])
          ],
        ),
      ),
    );
  }

  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  PacientesController pacientesController = PacientesController();
  NotasReferenciaController notasReferenciaController =
      NotasReferenciaController();
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

  Future<void> registrarNotaReferencia(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await notasReferenciaController.registrarNotaReferencia(controllers);
      mostrarMensajeExito(context);
    } catch (e) {
      mostrarMensajeError(context);
    }
  }
}
