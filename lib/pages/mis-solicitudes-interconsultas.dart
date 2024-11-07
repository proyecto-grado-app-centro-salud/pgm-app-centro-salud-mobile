import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/SolicitudesInterconsultasController.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisSolicitudesInterconsultasView extends StatefulWidget {
  const MisSolicitudesInterconsultasView({super.key});
  static const id = "mis-solicitudes-interconsultas";
  @override
  State<MisSolicitudesInterconsultasView> createState() =>
      _MisSolicitudesInterconsultasViewState();
}

class _MisSolicitudesInterconsultasViewState
    extends State<MisSolicitudesInterconsultasView> {
  @override
  void initState() {
    super.initState();
    _authController.obtenerIdUsuario().then(
        (idUsuario) => obtenerSolicitudesInterconsultaPaciente(idUsuario));
  }

  final _authController = AuthController();
  final nombreDocumento = "Solicitud de Interconsulta";
  final urlImagenBanner = "assets/gestion-recetas.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<SolicitudInterconsulta> solicitudesInterconsulta = [];
  SolicitudesInterconsultasController solicitudesInterconsultaController =
      SolicitudesInterconsultasController();
  obtenerSolicitudesInterconsultaPaciente(int idPaciente) async {
    try {
      List<SolicitudInterconsulta> solicitudesInterconsultasObtenidas =
          await solicitudesInterconsultaController
              .obtenerSolicitudesInterconsultaPaciente(idPaciente);
      setState(() {
        solicitudesInterconsulta = solicitudesInterconsultasObtenidas;
      });
    } catch (e) {
      print('Error al cargar solicitudes interconsutlas paiente: $e');
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
          solicitudesInterconsulta,
          nombreDocumento,
          urlImagenBanner,
          diagnosticoPresuntivo,
          () => {}),
    );
  }
}
