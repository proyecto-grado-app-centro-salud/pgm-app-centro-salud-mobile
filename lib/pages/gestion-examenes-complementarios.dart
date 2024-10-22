import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/ExamenesComplementariosController.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:proyecto_grado_flutter/pages/registrar-examen-complementario.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionExamenesComplementariosView extends StatefulWidget {
  const GestionExamenesComplementariosView({super.key});

  @override
  State<GestionExamenesComplementariosView> createState() =>
      _GestionExamenesComplementariosViewState();
}

class _GestionExamenesComplementariosViewState
    extends State<GestionExamenesComplementariosView> {
  @override
  void initState() {
    super.initState();
    obtenerExamenesComplementarios();
  }

  final nombreDocumento = "Examen complementario";
  final urlImagenBanner = "assets/gestion-examenes-complementarios.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<ExamenComplementario> examenesComplementarios = [];
  obtenerExamenesComplementarios() async {
    try {
      List<ExamenComplementario> examenes =
          await ExamenesComplementariosController()
              .obtenerExamenesComplementarios();
      setState(() {
        examenesComplementarios = examenes;
      });
    } catch (e) {
      print('Error al cargar examenes complementarios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: gestionDocumentosExpedienteClinico(
          context,
          examenesComplementarios,
          nombreDocumento,
          urlImagenBanner,
          diagnosticoPresuntivo,
          () => {}, () {
        Navigator.pushNamed(context, RegistrarExamenComplementario.id);
      }),
    );
  }
}
