import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/PapeletasInternacionController.dart';
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetallePapeletaInternacionView extends StatefulWidget {
  const DetallePapeletaInternacionView(
      {super.key, required this.idPapeletaInternacion});
  final int idPapeletaInternacion;
  static const id = "detalle-papeleta-internacion";
  @override
  State<DetallePapeletaInternacionView> createState() =>
      _DetallePapeletaInternacionViewState(
          idPapeletaInternacion: idPapeletaInternacion);
}

class _DetallePapeletaInternacionViewState
    extends State<DetallePapeletaInternacionView> {
  final int idPapeletaInternacion;
  _DetallePapeletaInternacionViewState({required this.idPapeletaInternacion});
  @override
  void initState() {
    super.initState();
    obtenerPapeletaInternacion(idPapeletaInternacion);
  }

  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idHistoriaClinica': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'fechaIngreso': TextEditingController(),
    'diagnostico': TextEditingController()
  };
  PapeletaInternacion? papeletaInternacion;
  PapeletasInternacionController papeletasInternacionController =
      PapeletasInternacionController();
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
                'Detalle de papeleta de internacion',
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
              etiquetaInputDocumento('Diagnostico'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['diagnostico']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha de ingreso'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['fechaIngreso']!, '',
                  readOnly: true),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerPapeletaInternacion(int idPapeletaInternacion) async {
    try {
      final papeletaInternacionResponse = await papeletasInternacionController
          .obtenerPapeletaInternacion(idPapeletaInternacion);
      setState(() {
        papeletaInternacion = papeletaInternacionResponse;
        establecerValoresEnControllersNotaPapeletaInternacion(
            papeletaInternacion);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersNotaPapeletaInternacion(
      PapeletaInternacion? papeletaInternacion) {
    if (papeletaInternacion != null) {
      setState(() {
        controllers['ciPaciente']?.text =
            papeletaInternacion.ciPropietario ?? '';
        controllers['diagnosticoPresuntivo']?.text =
            papeletaInternacion.diagnosticoPresuntivo ?? '';
        controllers['fechaIngreso']?.text =
            "${papeletaInternacion.fechaIngreso!.toLocal()}".split(' ')[0];
        controllers['diagnostico']?.text =
            papeletaInternacion.diagnostico ?? '';
      });
    }
  }
}
