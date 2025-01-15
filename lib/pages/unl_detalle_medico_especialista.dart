import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/MedicosController.dart';
import 'package:proyecto_grado_flutter/controladores/public/MedicosPublicController.dart';
import 'package:proyecto_grado_flutter/modelos/MedicoEspecialista.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class UnlDetalleMedicoEspecialista extends StatefulWidget {
  const UnlDetalleMedicoEspecialista({super.key, required this.idMedico});
  static const id = "unl_detalle_medico_especialista";
  final String idMedico;
  @override
  State<UnlDetalleMedicoEspecialista> createState() =>
      _UnlDetalleMedicoEspecialistaState(idMedico: idMedico);
}

class _UnlDetalleMedicoEspecialistaState
    extends State<UnlDetalleMedicoEspecialista> {
  final String idMedico;
  _UnlDetalleMedicoEspecialistaState({required this.idMedico});
  final MedicosPublicController medicosPublicController =
      MedicosPublicController();
  MedicoEspecialista? medicoEspecialista;
  @override
  void initState() {
    super.initState();
    obtenerMedico(idMedico);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colores.color4,
        title: Text("app consultas medicas"),
      ),
      body: (medicoEspecialista == null)
          ? obtenerIconoCarga(context)
          : SingleChildScrollView(
              child: Container(
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${medicoEspecialista!.nombres} ${medicoEspecialista!.apellidoPaterno}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: screenWidth * 0.8,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '${medicoEspecialista!.imagenes[0].url}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // ListView.builder(
                    //   itemBuilder: (context, index) {
                    //     cardCaracteristica(
                    //         medicoEspecialista?.especialidades[index].nombre);
                    //   },
                    //   itemCount: medicoEspecialista?.especialidades.length,
                    // ),
                    SizedBox(height: 20),
                    Text(
                      '${medicoEspecialista!.descripcion}',
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
              ),
            ),
    );
  }

  String _errorMessage = "";
  Future<void> obtenerMedico(String idMedico) async {
    _errorMessage = "";
    try {
      final medicoResponse =
          await medicosPublicController.obtenerMedico(idMedico);
      print("Medico obtenido");
      print(medicoResponse);
      setState(() {
        medicoEspecialista = medicoResponse;
      });
    } catch (e) {
      print(e);
      _errorMessage = 'Error al obtener medico';
    }
  }
}
