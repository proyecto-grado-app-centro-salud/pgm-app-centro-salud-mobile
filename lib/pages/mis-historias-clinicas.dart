import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisHistoriasClinicasView extends StatefulWidget {
  const MisHistoriasClinicasView({super.key});

  @override
  State<MisHistoriasClinicasView> createState() =>
      _MisHistoriasClinicasViewState();
}

class _MisHistoriasClinicasViewState extends State<MisHistoriasClinicasView> {
  @override
  void initState() {
    super.initState();
    // TODO: Obtener idPaciente de token
    final idPaciente = 1;
    obtenerHistoriasClinicasPaciente(idPaciente);
  }

  final nombreDocumento = "Historia Clinica";
  final urlImagenBanner = "assets/gestion-historias-clinicas.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<HistoriaClinica> historiasClinicas = [];
  HistoriasClinicasController historiasClinicasController =
      new HistoriasClinicasController();
  obtenerHistoriasClinicasPaciente(int idPaciente) async {
    try {
      List<HistoriaClinica> historiasClinicasObtenidas =
          await historiasClinicasController
              .obtenerHistoriasClinicasDePaciente(idPaciente.toString());
      setState(() {
        historiasClinicas = historiasClinicasObtenidas;
      });
    } catch (e) {
      print('Error al cargar historias clinicas: $e');
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
          historiasClinicas,
          nombreDocumento,
          urlImagenBanner,
          diagnosticoPresuntivo,
          () => {}),
    );
  }
}
