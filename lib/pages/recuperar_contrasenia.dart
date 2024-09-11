import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RecuperarContrasenia extends StatefulWidget {
  const RecuperarContrasenia({super.key});

  @override
  State<RecuperarContrasenia> createState() => _RecuperarContraseniaState();
}

class _RecuperarContraseniaState extends State<RecuperarContrasenia> {
  TextEditingController correo = TextEditingController();
  TextEditingController ci = TextEditingController();
  TextEditingController codigoVerificacion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(displayWidth(context) * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              const Center(
                child: Text(
                  'Recuperar contraseña',
                  style: TextStyle(
                    color: Colores.color5,
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 30),
              inputFormatoBorderBlack(context, correo, "correo"),
              SizedBox(height: 16),
              botonPrimario(context, "Obtener codigo de verificacion", () {
                _obtenerCodigoDeVerificacion();
              }),
              SizedBox(height: 8),
              const Center(
                child: Text(
                  'Código de verificación se enviara a correo electronico',
                  style: TextStyle(
                    color: Colores.color5,
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 24),
              inputFormatoBorderBlack(context, ci, "ci"),
              SizedBox(height: 16),
              inputFormatoBorderBlack(
                  context, codigoVerificacion, "codigo de verificacion"),
              SizedBox(height: 16),
              botonPrimario(context, "Recuperar contraseña", () {
                _recuperarContrasenia();
              }),
              SizedBox(height: 8),
              const Center(
                child: Text(
                  'Contraseña nueva se enviara a correo electronico',
                  style: TextStyle(
                    color: Colores.color5,
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _obtenerCodigoDeVerificacion() {}

  void _recuperarContrasenia() {}
}
