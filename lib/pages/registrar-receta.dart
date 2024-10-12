import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarReceta extends StatefulWidget {
  const RegistrarReceta({super.key});

  @override
  State<RegistrarReceta> createState() => _RegistrarRecetaState();
}

class _RegistrarRecetaState extends State<RegistrarReceta> {
  TextEditingController paciente = TextEditingController();
  TextEditingController historiaClinica = TextEditingController();
  TextEditingController nombreGenericoMedicamentoPrescrito =
      TextEditingController();
  TextEditingController viaCuidadoEspecialesAdministracion =
      TextEditingController();
  TextEditingController concentracionDosificacion = TextEditingController();
  TextEditingController frecuenciaAdministracion24hrs = TextEditingController();
  TextEditingController duracionTratamiento = TextEditingController();
  TextEditingController fechaVencimiento = TextEditingController();
  TextEditingController precaucionesEspeciales = TextEditingController();
  TextEditingController indicacionesEspeciales = TextEditingController();

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
                'Detalle de receta',
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
                  'Nombre generico de medicamento prescrito'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, nombreGenericoMedicamentoPrescrito, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento(
                  'Via y cuidados especiales de administracion'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, viaCuidadoEspecialesAdministracion, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Concentracion y dosificacion'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, concentracionDosificacion, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento(
                  'Frecuencia de administracion cada 24 horas'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, frecuenciaAdministracion24hrs, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Duracion de tratamiento'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, duracionTratamiento, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Fecha de vencimiento'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(context, fechaVencimiento, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Precauciones especiales'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, precaucionesEspeciales, ""),
              SizedBox(height: 5),
              etiquetaInputDocumento('Indicaciones especiales'),
              SizedBox(height: 5),
              inputFormFieldFormatoBorderBlack(
                  context, indicacionesEspeciales, ""),
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
