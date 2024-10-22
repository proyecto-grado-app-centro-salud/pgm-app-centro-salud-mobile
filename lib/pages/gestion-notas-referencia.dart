import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/NotasReferenciaController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaReferencia.dart';
import 'package:proyecto_grado_flutter/pages/registrar-nota-referencia.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionNotasReferenciaView extends StatefulWidget {
  const GestionNotasReferenciaView({super.key});

  @override
  State<GestionNotasReferenciaView> createState() =>
      _GestionNotasReferenciaViewState();
}

class _GestionNotasReferenciaViewState
    extends State<GestionNotasReferenciaView> {
  @override
  @override
  void initState() {
    super.initState();
    obtenerNotasReferencia();
  }

  final nombreDocumento = "Nota referencia";
  final urlImagenBanner = "assets/gestion-notas-referencia.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<NotaReferencia> notasReferencia = [];
  obtenerNotasReferencia() async {
    try {
      List<NotaReferencia> notas =
          await NotasReferenciaController().obtenerNotasReferencia();
      setState(() {
        notasReferencia = notas;
      });
    } catch (e) {
      print('Error al cargar notas referencia: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: gestionDocumentosExpedienteClinico(context, notasReferencia,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () {}, () {
        Navigator.pushNamed(context, RegistrarNotaReferencia.id);
      }),
    );
  }
}
