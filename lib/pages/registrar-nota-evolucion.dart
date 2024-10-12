import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarNotaEvolucion extends StatefulWidget {
  const RegistrarNotaEvolucion({super.key});

  @override
  State<RegistrarNotaEvolucion> createState() => _RegistrarNotaEvolucionState();
}

class _RegistrarNotaEvolucionState extends State<RegistrarNotaEvolucion> {
  final formKey = GlobalKey<FormState>();
  TextEditingController paciente = TextEditingController();
  TextEditingController historiaClinica = TextEditingController();
  TextEditingController cambiosResultadoTratamiento = TextEditingController();
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
                'Detalle de nota de evolucion',
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
              etiquetaInputDocumento(
                  'Cambios del paciente por resultados del tratamiento'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, cambiosResultadoTratamiento, ""),
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
