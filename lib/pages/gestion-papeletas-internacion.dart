import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/PapeletasInternacionController.dart';
import 'package:proyecto_grado_flutter/modelos/PapeletaInternacion.dart';
import 'package:proyecto_grado_flutter/pages/registrar-papeleta-internacion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionPapeletasInternacionView extends StatefulWidget {
  const GestionPapeletasInternacionView({super.key});
  @override
  State<GestionPapeletasInternacionView> createState() =>
      _GestionPapeletasInternacionViewState();
}

class _GestionPapeletasInternacionViewState
    extends State<GestionPapeletasInternacionView> {
  @override
  void initState() {
    super.initState();
    obtenerPapeletasInternacion();
  }

  final nombreDocumento = "Papeleta Internacion";
  final urlImagenBanner = "assets/gestion-papeletas-internacion.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<PapeletaInternacion> papeletasInternacion = [];
  obtenerPapeletasInternacion() async {
    try {
      List<PapeletaInternacion> papeletasInternacionObtenidas =
          await PapeletasInternacionController().obtenerPapeletasInternacion();
      setState(() {
        papeletasInternacion = papeletasInternacionObtenidas;
      });
    } catch (e) {
      print('Error al cargar papeletas internacion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: gestionDocumentosExpedienteClinico(context, papeletasInternacion,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () {}, () {
        Navigator.pushNamed(context, RegistrarPapeletaInternacion.id);
      }),
    );
  }
}
