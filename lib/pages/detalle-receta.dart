import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/RecetasController.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetalleRecetaView extends StatefulWidget {
  const DetalleRecetaView({super.key, required this.idReceta});
  final int idReceta;
  static const id = "detalle-receta";
  @override
  State<DetalleRecetaView> createState() =>
      _DetalleRecetaViewState(idReceta: idReceta);
}

class _DetalleRecetaViewState extends State<DetalleRecetaView> {
  final int idReceta;
  _DetalleRecetaViewState({required this.idReceta});
  void initState() {
    super.initState();
    obtenerReceta(idReceta);
  }

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
    'diagnosticoPresuntivo': TextEditingController(),
    'cantidadRecetada': TextEditingController(),
    'cantidadSuministrada': TextEditingController()
  };
  Receta? receta;
  RecetasController recetasController = RecetasController();
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
              inputFormatoBorderBlack(context, controllers['ciPaciente']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Historia clinica'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['diagnosticoPresuntivo']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento(
                  'Nombre generico de medicamento prescrito'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context,
                  controllers['nombreGenericoMedicamentoPrescrito']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento(
                  'Via y cuidados especiales de administracion'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context,
                  controllers['viaCuidadoEspecialesAdministracion']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Concentracion y dosificacion'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['concentracionDosificacion']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento(
                  'Frecuencia de administracion cada 24 horas'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['frecuenciaAdministracion24hrs']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Duracion de tratamiento'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['duracionTratamiento']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha de vencimiento'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['fechaVencimiento']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Precauciones especiales'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['precaucionesEspeciales']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Indicaciones especiales'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['indicacionesEspeciales']!, '',
                  readOnly: true),
              inputFormatoBorderBlack(
                  context, controllers['cantidadRecetada']!, "",
                  readOnly: true),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['cantidadSuministrada']!, "",
                  readOnly: true),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerReceta(int idReceta) async {
    try {
      final recetaResponse = await recetasController.obtenerReceta(idReceta);
      setState(() {
        receta = recetaResponse;
        establecerValoresEnControllersReceta(receta);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersReceta(Receta? receta) {
    if (receta != null) {
      setState(() {
        controllers['nombreGenericoMedicamentoPrescrito']?.text =
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
            "${receta.fechaVencimiento!.toLocal()}".split(' ')[0];
        controllers['precaucionesEspeciales']?.text =
            receta.precaucionesEspeciales ?? '';
        controllers['indicacionesEspeciales']?.text =
            receta.indicacionesEspeciales ?? '';
        controllers['cantidadDispensada']?.text =
            receta.cantidadDispensada.toString() ?? '0';
        controllers['cantidadRecetada']?.text =
            receta.cantidadRecetada.toString() ?? '0';
        controllers['ciPaciente']?.text = receta.ciPropietario ?? '';
        controllers['diagnosticoPresuntivo']?.text =
            receta.diagnosticoPresuntivo ?? '';
      });
    }
  }
}
