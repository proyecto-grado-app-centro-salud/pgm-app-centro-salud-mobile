import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/menu.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';
import 'package:proyecto_grado_flutter/widgets/custom_title.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

import '../util/colores.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();
  _signInWithEmailAndPassword() {
    Navigator.pop(context);
    Navigator.push(context, FadeRoute(page: const Menu()));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text("app consultas medicas"),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colores.color4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // autogroup9lrmh9Z (SzumoG97sj7oBw6zwN9LRm)
                width: 452 * fem,
                height: 200 * fem,
                margin: EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                ),
                child: Container(
                  // frame3Aoq (1:5)
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    // imagen1jrw (1:9)
                    child: SizedBox(
                      width: 271 * fem,
                      height: 150 * fem,
                      child: Image.asset(
                        "assets/hospital.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(31 * fem, 0 * fem, 30 * fem, 0 * fem),
                padding: EdgeInsets.fromLTRB(
                    30.5 * fem, 23 * fem, 30 * fem, 13 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Iniciar sesion",
                        style: TextStyle(color: Colors.white),
                    ),
                    //CustomTitle(titulo: "Iniciar sesion"),
                    SizedBox(
                      height: 8 * fem,
                    ),
                    inputFormato(context, usuario, "correo"),
                    SizedBox(
                      height: 12 * fem,
                    ),
                    inputFormatoTextoOculto(context, password, "contraseña"),
                    Container(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          botonInfo(context, "LOGIN", () {
                            _signInWithEmailAndPassword();
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
