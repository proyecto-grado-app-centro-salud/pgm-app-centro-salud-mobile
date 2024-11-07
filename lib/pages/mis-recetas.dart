import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/RecetasController.dart';
import 'package:proyecto_grado_flutter/modelos/Receta.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class MisRecetasView extends StatefulWidget {
  const MisRecetasView({super.key});
  static const id = "mis-recetas";
  @override
  State<MisRecetasView> createState() => _MisRecetasViewState();
}

class _MisRecetasViewState extends State<MisRecetasView> {
  @override
  void initState() {
    super.initState();
    _authController
        .obtenerIdUsuario()
        .then((idUsuario) => obtenerRecetasPaciente(idUsuario));
  }

  final _authController = AuthController();
  final nombreDocumento = "Receta";
  final urlImagenBanner = "assets/gestion-recetas.png";
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  List<Receta> recetas = [];
  RecetasController recetasController = new RecetasController();
  obtenerRecetasPaciente(int idPaciente) async {
    try {
      List<Receta> recetasObtenidas =
          await recetasController.obtenerRecetasPaciente(idPaciente);
      setState(() {
        recetas = recetasObtenidas;
      });
    } catch (e) {
      print('Error al cargar recetas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: obtenerVistaMisDocumentosExpedienteClinico(context, recetas,
          nombreDocumento, urlImagenBanner, diagnosticoPresuntivo, () => {}),
    );
  }
}
