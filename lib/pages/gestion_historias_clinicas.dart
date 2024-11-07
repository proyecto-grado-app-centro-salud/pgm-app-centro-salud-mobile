import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-historia-clinica.dart';
import 'package:proyecto_grado_flutter/pages/registrar-historia-clinica.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionHistoriasClinicasView extends StatefulWidget {
  const GestionHistoriasClinicasView({super.key});
  static const id = "gestion-historias-clinicas";
  @override
  State<GestionHistoriasClinicasView> createState() =>
      _GestionHistoriasClinicasViewState();
}

class _GestionHistoriasClinicasViewState
    extends State<GestionHistoriasClinicasView> {
  @override
  void initState() {
    super.initState();
    obtenerHistoriasClinicas();
  }

  final nombreDocumento = "Historia clinica";
  final urlImagenBanner = "assets/gestion-historias-clinicas.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<HistoriaClinica> historiasClinicas = [];
  List<HistoriaClinica> historiasClinicasAux = [];
  obtenerHistoriasClinicas() async {
    try {
      List<HistoriaClinica> historias =
          await HistoriasClinicasController().obtenerHistoriasClinicas();
      setState(() {
        historiasClinicasAux = historias;
        historiasClinicas = historias;
      });
    } catch (e) {
      print('Error al cargar historias clínicas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        drawer: NavDrawer(),
        backgroundColor: Colores.color2,
        body: gestionDocumentosExpedienteClinico(context, historiasClinicas,
            nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () {}, () {
          Navigator.pushNamed(context, RegistrarHistoriaClinica.id);
        }, (idDocumento) {
          Navigator.pushNamed(context, ActualizarHistoriaClinica.id,
              arguments: idDocumento);
        }));
  }
}
