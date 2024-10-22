import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/RecetasController.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/pages/registrar-receta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionRecetasView extends StatefulWidget {
  const GestionRecetasView({super.key});

  @override
  State<GestionRecetasView> createState() => _GestionRecetasViewState();
}

class _GestionRecetasViewState extends State<GestionRecetasView> {
  @override
  void initState() {
    super.initState();
    obtenerRecetas();
  }

  final nombreDocumento = "Recetas";
  final urlImagenBanner = "assets/gestion-recetas.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<Receta> recetas = [];
  obtenerRecetas() async {
    try {
      List<Receta> notas = await RecetasController().obtenerRecetas();
      setState(() {
        recetas = notas;
      });
    } catch (e) {
      print('Error al cargar recetas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: gestionDocumentosExpedienteClinico(context, recetas,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () {}, () {
        Navigator.pushNamed(context, RegistrarReceta.id);
      }),
    );
  }
}
