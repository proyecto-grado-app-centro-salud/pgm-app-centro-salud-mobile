import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/pages/detalle-historia-clinica.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisHistoriasClinicasView extends StatefulWidget {
  const MisHistoriasClinicasView({super.key});
  static const id = "mis-historias-clinicas";
  @override
  State<MisHistoriasClinicasView> createState() =>
      _MisHistoriasClinicasViewState();
}

class _MisHistoriasClinicasViewState extends State<MisHistoriasClinicasView> {
  @override
  void initState() {
    authController.obtenerIdUsuario().then((idUsuario) =>
        {print(idUsuario), obtenerHistoriasClinicasPaciente(idUsuario)});
    super.initState();
  }

  AuthController authController = AuthController();
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
          () => {}, (idDocumento) {
        Navigator.push(
            context,
            FadeRoute(
                page: DetalleHistoriaClinicaView(
                    idHistoriaClinica: idDocumento)));
      }),
    );
  }
}
