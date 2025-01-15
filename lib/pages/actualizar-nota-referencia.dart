import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/NotasReferenciaController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/NotaReferencia.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActualizarNotaReferencia extends StatefulWidget {
  const ActualizarNotaReferencia({super.key, required this.idNotaReferencia});
  static const id = "actualizar-nota-referencia";
  final int idNotaReferencia;
  @override
  State<ActualizarNotaReferencia> createState() =>
      _ActualizarNotaReferenciaState(idNotaReferencia: idNotaReferencia);
}

class _ActualizarNotaReferenciaState extends State<ActualizarNotaReferencia> {
  int idNotaReferencia;
  _ActualizarNotaReferenciaState({required this.idNotaReferencia});
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
  NotaReferencia? notaReferencia;
  final _notasReferenciaController = NotasReferenciaController();

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
    obtenerNotaReferencia(widget.idNotaReferencia);
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
              'Actualizacion de nota de referencia',
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
            })
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
              botonFormularioDocumento("Actualizar", () {
                final formState1 = formKey.currentState;
                if (formState1 != null && formState1.validate()) {
                  actualizarNotaReferencia(context, controllers);
                }
              }),
            ]),
            botonPrimario(
                context, "Obtener pdf", () => {obtenerPDFNotaReferencia()})
          ],
        ),
      ),
    );
  }

  void _onSelectFechaVencimiento(String date) {
    setState(() {
      controllers['fechaVencimiento']!.text = date;
    });
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

  Future<void> actualizarNotaReferencia(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await _notasReferenciaController.actualizarNotaReferencia(
          controllers, idNotaReferencia);
      mostrarMensajeExito(context,
          titulo: "Actualizacion nota referencia exitoso");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  Future<void> obtenerNotaReferencia(int idNotaReferencia) async {
    try {
      final notaReferenciaResponse = await _notasReferenciaController
          .obtenerNotaReferencia(idNotaReferencia);
      setState(() {
        notaReferencia = notaReferenciaResponse;
        establecerValoresEnControllersNotaReferencia(notaReferencia);
      });
    } catch (e) {
      print('Error al obtener la nota de referencia: $e');
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

  void establecerValoresEnControllersNotaReferencia(
      NotaReferencia? notaReferencia) {
    if (notaReferencia != null) {
      setState(() {
        controllers['idPaciente']?.text = notaReferencia.idPaciente.toString();
        controllers['ciPaciente']?.text = notaReferencia.ciPropietario ?? '';
        controllers['idHistoriaClinica']?.text =
            notaReferencia.idHistoriaClinica.toString();
        controllers['diagnosticoPresuntivo']?.text =
            notaReferencia.diagnosticoPresuntivo ?? '';
        controllers['datosClinicos']?.text = notaReferencia.datosClinicos ?? '';
        controllers['datosIngreso']?.text = notaReferencia.datosIngreso ?? '';
        controllers['datosEgreso']?.text = notaReferencia.datosEgreso ?? '';
        controllers['condicionesPacienteMomentoTransferencia']?.text =
            notaReferencia.condicionesPacienteMomentoTransferencia ?? '';
        controllers['informeProcedimientosRealizados']?.text =
            notaReferencia.informeProcedimientosRealizados ?? '';
        controllers['tratamientoEfectuado']?.text =
            notaReferencia.tratamientoEfectuado ?? '';
        controllers['tratamientoPersistePaciente']?.text =
            notaReferencia.tratamientoPersistePaciente ?? '';
        controllers['fechaVencimiento']?.text =
            notaReferencia.fechaVencimiento.toString();
        controllers['advertenciasFactoresRiesgo']?.text =
            notaReferencia.advertenciasFactoresRiesgo ?? '';
        controllers['comentarioAdicional']?.text =
            notaReferencia.comentarioAdicional ?? '';
        controllers['monitoreo']?.text = notaReferencia.monitoreo ?? '';
        controllers['informeTrabajoSocial']?.text =
            notaReferencia.informeTrabajoSocial ?? '';
      });
    }
  }

  obtenerPDFNotaReferencia() {
    try {
      Map<String, String> stringMap = {
        "id": notaReferencia!.id.toString(),
        "idPaciente": notaReferencia!.idPaciente.toString(),
        "ciPaciente": notaReferencia!.ciPropietario.toString(),
        "idHistoriaClinica": notaReferencia!.idHistoriaClinica.toString(),
        "diagnosticoPresuntivo":
            notaReferencia!.diagnosticoPresuntivo.toString(),
        "datosClinicos": notaReferencia!.datosClinicos.toString(),
        "datosIngreso": notaReferencia!.datosIngreso.toString(),
        "datosEgreso": notaReferencia!.datosEgreso.toString(),
        "condicionesPacienteMomentoTransferencia":
            notaReferencia!.condicionesPacienteMomentoTransferencia.toString(),
        "informeProcedimientosRealizados":
            notaReferencia!.informeProcedimientosRealizados.toString(),
        "tratamientoEfectuado": notaReferencia!.tratamientoEfectuado.toString(),
        "tratamientoPersistePaciente":
            notaReferencia!.tratamientoPersistePaciente.toString(),
        "advertenciasFactoresRiesgo":
            notaReferencia!.advertenciasFactoresRiesgo.toString(),
        "comentarioAdicional": notaReferencia!.comentarioAdicional.toString(),
        "monitoreo": notaReferencia!.monitoreo.toString(),
        "informeTrabajoSocial": notaReferencia!.informeTrabajoSocial.toString()
      };
      _notasReferenciaController.obtenerPDFNotaReferencia(stringMap);
    } catch (e) {
      print(e);
    }
  }
}
