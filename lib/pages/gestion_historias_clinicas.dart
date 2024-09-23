import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class GestionHistoriasClinicasView extends StatefulWidget {
  const GestionHistoriasClinicasView({super.key});

  @override
  State<GestionHistoriasClinicasView> createState() =>
      _GestionHistoriasClinicasViewState();
}

class _GestionHistoriasClinicasViewState
    extends State<GestionHistoriasClinicasView> {
  TextEditingController diagnosticoPresuntivo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: Container(
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Colores.color2,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: displayWidth(context),
                height: displayHeight(context) * 0.3, // 28% of screen height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/gestion-historias-clinicas.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 0,
              child: Container(
                width: displayWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Colores.color2,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Gestion historias clínicas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Diagnóstico presuntivo',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colores.color5,
                        fontFamily: 'Inter',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    inputFormatoBorderBlack(context, diagnosticoPresuntivo, ""),
                    SizedBox(height: 10),
                    botonPrimario(context, "Buscar", () {}),
                    SizedBox(height: 10),
                    Text(
                      'Búsqueda avanzada',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colores.color5,
                        fontFamily: 'Inter',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    botonPrimario(context, "Registrar historia clínica", () {}),
                    SizedBox(height: 10),
                    cardInformacionDocumento(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
