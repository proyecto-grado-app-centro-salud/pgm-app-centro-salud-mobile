import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/NotasEvolucionController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisNotasEvolucionView extends StatefulWidget {
  const MisNotasEvolucionView({super.key});
  static const id = "mis-notas-evolucion";
  @override
  State<MisNotasEvolucionView> createState() => _MisNotasEvolucionViewState();
}

class _MisNotasEvolucionViewState extends State<MisNotasEvolucionView> {
  void initState() {
    authController
        .obtenerIdUsuario()
        .then((idUsuario) => obtenerNotasEvolucionPaciente(idUsuario));
    super.initState();
  }

  AuthController authController = AuthController();
  final nombreDocumento = "Historia Clinica";
  final urlImagenBanner = "assets/gestion-historias-clinicas.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<NotaEvolucion> notasEvolucion = [];
  NotasEvolucionController notasEvolucionController =
      new NotasEvolucionController();
  obtenerNotasEvolucionPaciente(int idPaciente) async {
    try {
      List<NotaEvolucion> notasEvolucionObtenidas =
          await notasEvolucionController
              .obtenerNotasEvolucionPaciente(idPaciente);
      setState(() {
        notasEvolucion = notasEvolucionObtenidas;
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
      body: obtenerVistaMisDocumentosExpedienteClinico(context, notasEvolucion,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () => {}),
    );
  }
}
