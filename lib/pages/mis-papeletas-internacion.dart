import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/PapeletasInternacionController.dart';
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisPapeletasInternacionView extends StatefulWidget {
  const MisPapeletasInternacionView({super.key});

  @override
  State<MisPapeletasInternacionView> createState() =>
      _MisPapeletasInternacionViewState();
}

class _MisPapeletasInternacionViewState
    extends State<MisPapeletasInternacionView> {
  @override
  void initState() {
    super.initState();
    // TODO: Obtener idPaciente de token
    final idPaciente = 1;
    obtenerPapeletasInternacionPaciente(idPaciente);
  }

  final nombreDocumento = "Papeleta de Internacion";
  final urlImagenBanner = "assets/gestion-papeletas-internacion.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<PapeletaInternacion> papeletasInternacion = [];
  PapeletasInternacionController papeletasInternacionController =
      new PapeletasInternacionController();
  obtenerPapeletasInternacionPaciente(int idPaciente) async {
    try {
      List<PapeletaInternacion> papeletasInternacionObtenidas =
          await papeletasInternacionController
              .obtenerPapeletasInternacionPaciente(idPaciente);
      setState(() {
        papeletasInternacion = papeletasInternacionObtenidas;
      });
    } catch (e) {
      print('Error al cargar notas de evolucion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: obtenerVistaMisDocumentosExpedienteClinico(
          context,
          papeletasInternacion,
          nombreDocumento,
          urlImagenBanner,
          diagnosticoPresuntivo,
          () => {}),
    );
  }
}
