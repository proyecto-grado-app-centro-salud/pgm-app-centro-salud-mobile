import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/image_container.dart';

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
  final EspecialidadesController especialidadesController =
      EspecialidadesController();
  late Especialidad especialidad;
  String _errorMessage = "";
  _UnlDetalleEspecialidadState({required this.idEspecialidad});
  @override
  void initState() {
    super.initState();
    obtenerEspecialidad();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Center(child: CustomTextTitle(label: especialidad.nombre)),
        const SizedBox(height: 10),
        ImageContainer(
          width: displayWidth(context),
          height: displayHeight(context) * 0.3,
          imageUrl: especialidad.imagenes[0].url,
        ),
        Text(
          especialidad.descripcion,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ]),
    );
  }

  void obtenerEspecialidad() {
    _errorMessage = "";
    try {
      final especialidadResponse =
          especialidadesController.obtenerEspecialidad(idEspecialidad);
      setState(() {
        especialidad = especialidadResponse;
      });
    } catch (e) {
      _errorMessage = 'Error al obtener especialidad';
    }
  }
}
