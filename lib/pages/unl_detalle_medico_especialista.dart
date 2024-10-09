import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class UnlDetalleMedicoEspecialista extends StatefulWidget {
  const UnlDetalleMedicoEspecialista({super.key});
  static const id = "unl_detalle_medico_especialista";
  @override
  State<UnlDetalleMedicoEspecialista> createState() =>
      _UnlDetalleMedicoEspecialistaState();
}

class _UnlDetalleMedicoEspecialistaState
    extends State<UnlDetalleMedicoEspecialista> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
        color: Color.fromRGBO(255, 254, 250, 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Dr. Nombre Ficticio',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.normal,
              height: 1,
            ),
          ),
          SizedBox(height: 26),
          Container(
            width: screenWidth * 0.8,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/Austindistel7bmdiiqz_j4unsplashremovebgpreview1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              cardCaracteristica('Medico psiquiatra'),
              cardCaracteristica('Medico neurologo'),
              cardCaracteristica('Medico cardiologo'),
            ],
          ),
          SizedBox(height: 26),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s...',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.normal,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
