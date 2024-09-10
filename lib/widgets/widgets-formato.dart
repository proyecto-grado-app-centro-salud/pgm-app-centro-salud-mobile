import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/home_page.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("token", "");
  ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "Logout!",
        text: "Logout exitoso",
        confirmButtonText: "Aceptar",
        onConfirm: () {
          Navigator.pop(context);
          Navigator.push(context, FadeRoute(page: const HomePage()));
        }),
  );
}

Widget inputFormato(
    BuildContext context, TextEditingController controlador, String hint) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // frame1Fyh (1:3)
    margin: EdgeInsets.fromLTRB(3.5 * fem, 3.5 * fem, 3.5 * fem, 3.5 * fem),
    width: double.infinity,
    height: 40 * fem,
    padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(10 * fem),
      boxShadow: [
        BoxShadow(
          color: Color(0x3f000000),
          offset: Offset(0 * fem, 4 * fem),
          blurRadius: 2 * fem,
        ),
      ],
    ),
    child: TextField(
      decoration: InputDecoration(hintText: hint),
      controller: controlador,
    ),
  );
}

Widget inputFormatoTextoOculto(
    BuildContext context, TextEditingController controlador, String hint) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // frame1Fyh (1:3)
    margin: EdgeInsets.fromLTRB(3.5 * fem, 3.5 * fem, 3.5 * fem, 3.5 * fem),
    width: double.infinity,
    height: 40 * fem,
    padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(10 * fem),
      boxShadow: [
        BoxShadow(
          color: Color(0x3f000000),
          offset: Offset(0 * fem, 4 * fem),
          blurRadius: 2 * fem,
        ),
      ],
    ),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
          suffixIcon: GestureDetector(onTap:(){},child: Icon(Icons.remove_red_eye))
      ),
      controller: controlador,
    ),
  );
}

Widget botonInfo(
    BuildContext context, String tituloBoton, VoidCallback onPressed) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    margin: EdgeInsets.all(10),
    height: 32 * fem,
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100 * fem,
          minHeight: double.infinity,
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              primary: Color(0xff007bff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              child: Text(
                tituloBoton,
                /*style: GoogleFonts.poppins(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * ffem / fem,
                  color: Color(0xffffffff),
                ),*/
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget titulo(BuildContext context, String titulo) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // loginn4X (1:10)
    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.5 * fem, 0 * fem),
    child: Text(
      titulo,
      /*style: GoogleFonts.poppins(
        fontSize: 24 * ffem,
        fontWeight: FontWeight.w400,
        height: 1.5 * ffem / fem,
        color: Color(0xffffffff),
      ),*/
    ),
  );
}
