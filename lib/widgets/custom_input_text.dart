import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final TextEditingController controlador;
  final String hint;
  const CustomInputText(BuildContext context,
      {super.key, required this.controlador, required this.hint});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
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
}
