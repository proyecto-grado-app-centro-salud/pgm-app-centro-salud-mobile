import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/SolicitudesInterconsultasController.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetalleSolicitudInterconsultaView extends StatefulWidget {
  const DetalleSolicitudInterconsultaView(
      {super.key, required this.idSolicitudInterconsulta});
  final int idSolicitudInterconsulta;
  static const id = "detalle-solicitud-interconsulta";
  @override
  State<DetalleSolicitudInterconsultaView> createState() =>
      _DetalleSolicitudInterconsultaViewState(
          idSolicitudInterconsulta: idSolicitudInterconsulta);
}

class _DetalleSolicitudInterconsultaViewState
    extends State<DetalleSolicitudInterconsultaView> {
  final int idSolicitudInterconsulta;
  _DetalleSolicitudInterconsultaViewState(
      {required this.idSolicitudInterconsulta});
  @override
  void initState() {
    super.initState();
    obtenerSolicitudInterconsulta(idSolicitudInterconsulta);
  }

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
  SolicitudesInterconsultasController solicitudesInterconsultasController =
      SolicitudesInterconsultasController();
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
                'Detalle de solicitud interconsulta',
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
              etiquetaInputDocumento('Hospital interconsultado'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['hospitalInterconsultado']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Unidad interconsultada'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['unidadInterconsultada']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Que desea saber?'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['queDeseaSaber']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Sintomatologia'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['sintomatologia']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Tratamiento'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['tratamiento']!, '',
                  readOnly: true),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerSolicitudInterconsulta(
      int idSolicitudInterconsulta) async {
    try {
      final solicitudInterconsultaResponse =
          await solicitudesInterconsultasController
              .obtenerSolicitudInterconsulta(idSolicitudInterconsulta);
      setState(() {
        solicitudInterconsulta = solicitudInterconsultaResponse;
        establecerValoresEnControllersSolicitudInterconsulta(
            solicitudInterconsulta);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersSolicitudInterconsulta(
      SolicitudInterconsulta? solicitudInterconsulta) {
    if (solicitudInterconsulta != null) {
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
      controllers['ciPaciente']?.text =
          solicitudInterconsulta.ciPropietario ?? '';
      controllers['diagnosticoPresuntivo']?.text =
          solicitudInterconsulta.diagnosticoPresuntivo ?? '';
    }
  }
}
