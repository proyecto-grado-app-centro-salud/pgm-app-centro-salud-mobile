import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/SolicitudesInterconsultasController.dart';
import 'package:proyecto_grado_flutter/modelos/SolicitudInterconsulta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionSolicitudesInterconsultaView extends StatefulWidget {
  const GestionSolicitudesInterconsultaView({super.key});

  @override
  State<GestionSolicitudesInterconsultaView> createState() =>
      _GestionSolicitudesInterconsultaViewState();
}

class _GestionSolicitudesInterconsultaViewState
    extends State<GestionSolicitudesInterconsultaView> {
  @override
  void initState() {
    super.initState();
    obtenerSolicitudesInterconsulta();
  }

  final nombreDocumento = "Solicitud Interconsulta";
  final urlImagenBanner = "assets/gestion-solicitudes-interconsulta.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<SolicitudInterconsulta> solicitudesInterconsulta = [];

  obtenerSolicitudesInterconsulta() async {
    try {
      List<SolicitudInterconsulta> solicitudes =
          await SolicitudesInterconsultasController()
              .obtenerSolicitudesInterconsultas();
      setState(() {
        solicitudesInterconsulta = solicitudes;
      });
    } catch (e) {
      print('Error al cargar solicitudes de interconsulta: $e');
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
        solicitudesInterconsulta,
        nombreDocumento,
        urlImagenBanner,
        diagnosticoPresuntivo,
      ),
    );
  }
}
