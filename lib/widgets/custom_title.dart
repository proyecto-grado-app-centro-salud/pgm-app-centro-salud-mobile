import 'package:flutter/cupertino.dart';
//import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  String titulo;
  CustomTitle({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
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
}
