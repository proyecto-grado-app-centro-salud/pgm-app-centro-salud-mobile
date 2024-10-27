import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/ExamenesComplementariosController.dart';
import 'package:proyecto_grado_flutter/modelos/ExamenComplementario.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisExamenesComplementariosView extends StatefulWidget {
  const MisExamenesComplementariosView({super.key});

  @override
  State<MisExamenesComplementariosView> createState() =>
      _MisExamenesComplementariosViewState();
}

class _MisExamenesComplementariosViewState
    extends State<MisExamenesComplementariosView> {
  @override
  void initState() {
    super.initState();
    // TODO: Obtener idPaciente de token
    final idPaciente = 1;
    obtenerExamenesComplementariosPaciente(idPaciente);
  }

  final nombreDocumento = "Examen complementario";
  final urlImagenBanner = "assets/gestion-examenes-complementarios.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<ExamenComplementario> examenesComplementarios = [];
  obtenerExamenesComplementariosPaciente(int idPaciente) async {
    try {
      List<ExamenComplementario> examenes =
          await ExamenesComplementariosController()
              .obtenerExamenesComplementariosPaciente(idPaciente);
      setState(() {
        examenesComplementarios = examenes;
      });
    } catch (e) {
      print('Error al cargar examenes complementarios paciente: $e');
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
          examenesComplementarios,
          nombreDocumento,
          urlImagenBanner,
          diagnosticoPresuntivo,
          () => {}),
    );
  }
}
