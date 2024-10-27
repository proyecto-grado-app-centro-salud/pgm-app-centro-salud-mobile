import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/NotasReferenciaController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaReferencia.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetalleNotaReferenciaView extends StatefulWidget {
  const DetalleNotaReferenciaView({super.key, required this.idNotaReferencia});
  final int idNotaReferencia;
  @override
  State<DetalleNotaReferenciaView> createState() =>
      _DetalleNotaReferenciaViewState(idNotaReferencia: idNotaReferencia);
}

class _DetalleNotaReferenciaViewState extends State<DetalleNotaReferenciaView> {
  final int idNotaReferencia;
  _DetalleNotaReferenciaViewState({required this.idNotaReferencia});
  @override
  void initState() {
    super.initState();
    obtenerNotaReferecia(idNotaReferencia);
  }

  NotaReferencia? notaReferencia;
  NotasReferenciaController notasReferenciaController =
      NotasReferenciaController();
  final Map<String, TextEditingController> controllers = {
    'ciPaciente': TextEditingController(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: SingleChildScrollView(
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
              inputFormatoBorderBlack(context, controllers['ciPaciente']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Historia clinica'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['diagnosticoPresuntivo']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Datos ingreso'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['datosIngreso']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Datos egreso'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['datosEgreso']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento(
                  'Condiciones paciente momento transferencia'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context,
                  controllers['condicionesPacienteMomentoTransferencia']!, '',
                  readOnly: true),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerNotaReferecia(int idNotaReferencia) async {
    try {
      final notaReferenciaResponse = await notasReferenciaController
          .obtenerNotaReferencia(idNotaReferencia);
      setState(() {
        notaReferencia = notaReferenciaResponse;
        establecerValoresEnControllersNotaReferencia(notaReferencia);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersNotaReferencia(
      NotaReferencia? notaReferencia) {
    if (notaReferencia != null) {
      setState(() {
        controllers['ciPaciente']?.text = notaReferencia.ciPropietario ?? '';
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
            "${notaReferencia.fechaVencimiento!.toLocal()}".split(' ')[0];
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
}
