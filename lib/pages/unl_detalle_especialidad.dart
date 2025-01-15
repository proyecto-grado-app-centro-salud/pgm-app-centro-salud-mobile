import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/public/EspecialidadesPublicController.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/custom_principal_text_title.dart';
import 'package:proyecto_grado_flutter/widgets/image_container.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class UnlDetalleEspecialidad extends StatefulWidget {
  const UnlDetalleEspecialidad({super.key, required this.idEspecialidad});
  static const id = "unl_detalle_especialidad";
  final int idEspecialidad;

  @override
  State<UnlDetalleEspecialidad> createState() =>
      _UnlDetalleEspecialidadState(idEspecialidad: idEspecialidad);
}

class _UnlDetalleEspecialidadState extends State<UnlDetalleEspecialidad> {
  final int idEspecialidad;
  final EspecialidadesPublicController especialidadesPublicController =
      EspecialidadesPublicController();
  Especialidad? especialidad;
  String _errorMessage = "";
  _UnlDetalleEspecialidadState({required this.idEspecialidad});
  @override
  void initState() {
    print("Detalle especialidad");
    print(idEspecialidad);
    obtenerEspecialidad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colores.color4,
        title: Text("app consultas medicas"),
      ),
      body: (especialidad == null)
          ? obtenerIconoCarga(context)
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  CustomPrincipalTextTitle(label: especialidad!.nombre),
                  const Divider(),
                  ImageContainer(
                    width: displayWidth(context),
                    height: displayHeight(context) * 0.3,
                    imageUrl: especialidad!.imagenes[0].url,
                  ),
                  const Divider(),
                  Text(
                    especialidad!.descripcion,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colores.color5,
                    ),
                  ),
                ]),
              ),
            ),
    );
  }

  Future<void> obtenerEspecialidad() async {
    _errorMessage = "";
    try {
      final especialidadResponse = await especialidadesPublicController
          .obtenerEspecialidad(idEspecialidad);
      print(especialidadResponse);
      setState(() {
        especialidad = especialidadResponse;
      });
    } catch (e) {
      _errorMessage = 'Error al obtener especialidad';
    }
  }
}
