import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/NotasEvolucionController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionNotasEvolucionView extends StatefulWidget {
  const GestionNotasEvolucionView({super.key});

  @override
  State<GestionNotasEvolucionView> createState() =>
      _GestionNotasEvolucionViewState();
}

class _GestionNotasEvolucionViewState extends State<GestionNotasEvolucionView> {
  @override
  void initState() {
    super.initState();
    obtenerNotasEvolucion();
  }

  final nombreDocumento = "Nota evolucion";
  final urlImagenBanner = "assets/gestion-notas-evolucion.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<NotaEvolucion> notasEvolucion = [];
  obtenerNotasEvolucion() async {
    try {
      List<NotaEvolucion> notas =
          await NotasEvolucionController().obtenerNotasEvolucion();
      setState(() {
        notasEvolucion = notas;
      });
    } catch (e) {
      print('Error al cargar notas evolucion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: gestionDocumentosExpedienteClinico(context, notasEvolucion,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo),
    );
  }
}
