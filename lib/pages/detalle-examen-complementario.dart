import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/ExamenesComplementariosController.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetalleExamenComplementarioView extends StatefulWidget {
  const DetalleExamenComplementarioView(
      {super.key, required this.idExamenComplementario});
  final int idExamenComplementario;
  static const id = "detalle-examen-complementario";
  @override
  State<DetalleExamenComplementarioView> createState() =>
      _DetalleExamenComplementarioViewState(
          idExamenComplementario: idExamenComplementario);
}

class _DetalleExamenComplementarioViewState
    extends State<DetalleExamenComplementarioView> {
  final int idExamenComplementario;
  _DetalleExamenComplementarioViewState({required this.idExamenComplementario});
  final Map<String, TextEditingController> controllers = {
    'nombre': TextEditingController(),
    'descripcion': TextEditingController(),
    'resumenResultados': TextEditingController(),
    'fechaResultado': TextEditingController(),
    'fechaSolicitud': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController()
  };
  @override
  void initState() {
    super.initState();
    obtenerExamenComplementario(idExamenComplementario);
  }

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
                'Detalle de examen complementario',
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
              etiquetaInputDocumento('Nombre examen complementario'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['nombre']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Descripcion'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['descripcion']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Resumen de resultados'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['resumenResultados']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha resultado'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['fechaResultado']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha solicitud'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['fechaSolicitud']!, '',
                  readOnly: true),
            ],
          ),
        ),
      ),
    );
  }

  ExamenComplementario? examenComplementario;
  ExamenesComplementariosController examenesComplementariosController =
      ExamenesComplementariosController();
  Future<void> obtenerExamenComplementario(int idExamenComplementario) async {
    try {
      final examenComplementarioResponse =
          await examenesComplementariosController
              .obtenerExamenComplementario(idExamenComplementario);
      setState(() {
        examenComplementario = examenComplementarioResponse;
        establecerValoresEnControllersExamenComplementario(
            examenComplementario);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersExamenComplementario(
      ExamenComplementario? examenComplementario) {
    if (examenComplementario != null) {
      setState(() {
        controllers['nombre']?.text = examenComplementario.nombre;
        controllers['descripcion']?.text = examenComplementario.descripcion;
        controllers['resumenResultados']?.text =
            examenComplementario.resumenResultados;
        controllers['fechaResultado']?.text =
            "${examenComplementario.fechaResultado?.toLocal()}".split(' ')[0];
        controllers['fechaSolicitud']?.text =
            "${examenComplementario.fechaSolicitud?.toLocal()}".split(' ')[0];
        controllers['ciPaciente']?.text =
            examenComplementario.ciPropietario ?? '';
        controllers['diagnosticoPresuntivo']?.text =
            examenComplementario.diagnosticoPresuntivo ?? '';
      });
    }
  }
}
