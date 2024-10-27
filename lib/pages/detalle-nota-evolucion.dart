import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/NotasEvolucionController.dart';
import 'package:proyecto_grado_flutter/modelos/NotaEvolucion.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class DetalleNotaEvolucionView extends StatefulWidget {
  const DetalleNotaEvolucionView({super.key, required this.idNotaEvolucion});
  final int idNotaEvolucion;
  @override
  State<DetalleNotaEvolucionView> createState() =>
      _DetalleNotaEvolucionViewState(idNotaEvolucion: idNotaEvolucion);
}

class _DetalleNotaEvolucionViewState extends State<DetalleNotaEvolucionView> {
  final int idNotaEvolucion;
  _DetalleNotaEvolucionViewState({required this.idNotaEvolucion});
  @override
  void initState() {
    super.initState();
    obtenerNotaEvolucion(idNotaEvolucion);
  }

  NotaEvolucion? notaEvolucion;
  NotasEvolucionController notasEvolucionController =
      NotasEvolucionController();
  final Map<String, TextEditingController> controllers = {
    'ciPaciente': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'cambiosResultadoTratamiento': TextEditingController(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: SingleChildScrollView(
        child: Container(
          color: Colores.color2,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Detalle de nota evolucion',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 12,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(height: 5),
              etiquetaInputDocumento('Paciente'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(context, controllers['ciPaciente']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Historia clinica'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['diagnosticoPresuntivo']!, '',
                  readOnly: true),
              SizedBox(height: 5),
              etiquetaInputDocumento('Cambios resultados del tratamiento'),
              SizedBox(height: 5),
              inputFormatoBorderBlack(
                  context, controllers['cambiosResultadoTratamiento']!, '',
                  readOnly: true),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerNotaEvolucion(int idNotaEvolucion) async {
    try {
      final notaEvolucionResponse =
          await notasEvolucionController.obtenerNotaEvolucion(idNotaEvolucion);
      setState(() {
        notaEvolucion = notaEvolucionResponse;
        establecerValoresEnControllersNotaEvolucion(notaEvolucion);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void establecerValoresEnControllersNotaEvolucion(
      NotaEvolucion? notaEvolucion) {
    if (notaEvolucion != null) {
      setState(() {
        controllers['ciPaciente']?.text = notaEvolucion.ciPropietario ?? '';
        controllers['diagnosticoPresuntivo']?.text =
            notaEvolucion.diagnosticoPresuntivo ?? '';
        controllers['cambiosResultadoTratamiento']?.text =
            notaEvolucion.cambiosPacienteResultadosTratamiento ?? '';
      });
    }
  }
}
