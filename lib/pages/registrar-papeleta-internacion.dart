import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarPapeletaInternacion extends StatefulWidget {
  const RegistrarPapeletaInternacion({super.key});

  @override
  State<RegistrarPapeletaInternacion> createState() =>
      _RegistrarPapeletaInternacionState();
}

class _RegistrarPapeletaInternacionState
    extends State<RegistrarPapeletaInternacion> {
  TextEditingController paciente = TextEditingController();
  TextEditingController historiaClinica = TextEditingController();
  TextEditingController fechaIngreso = TextEditingController();
  TextEditingController diagnostico = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 254, 250, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Detalle de papeleta de internacion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
              SizedBox(height: 5),
              etiquetaInputDocumento('Paciente'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(context, paciente, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Historia clinica'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(context, historiaClinica, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Diagnostico'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(context, diagnostico, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha de ingreso'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(context, fechaIngreso, ""),
              botonSiguienteFormularioDocumento(() {
                if (formKey.currentState?.validate() ?? false) {}
              }),
            ],
          ),
        ),
      ),
    );
  }
}
