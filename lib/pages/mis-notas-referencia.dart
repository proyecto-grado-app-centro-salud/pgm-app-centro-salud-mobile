import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/NotasReferenciaController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaReferencia.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisNotasReferenciaView extends StatefulWidget {
  const MisNotasReferenciaView({super.key});

  @override
  State<MisNotasReferenciaView> createState() => _MisNotasReferenciaViewState();
}

class _MisNotasReferenciaViewState extends State<MisNotasReferenciaView> {
  @override
  void initState() {
    super.initState();
    // TODO: Obtener idPaciente de token
    final idPaciente = 1;
    obtenerNotasReferenciaPaciente(idPaciente);
  }

  final nombreDocumento = "Nota de Referencia";
  final urlImagenBanner = "assets/gestion-notas-referencia.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<NotaReferencia> notasEvolucion = [];
  NotasReferenciaController notasReferenciaController =
      new NotasReferenciaController();
  obtenerNotasReferenciaPaciente(int idPaciente) async {
    try {
      List<NotaReferencia> notasReferenciaObtenidas =
          await notasReferenciaController
              .obtenerNotasReferenciaPaciente(idPaciente);
      setState(() {
        notasEvolucion = notasReferenciaObtenidas;
      });
    } catch (e) {
      print('Error al cargar notas de referencia paciente: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: obtenerVistaMisDocumentosExpedienteClinico(context, notasEvolucion,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () => {}),
    );
  }
}
