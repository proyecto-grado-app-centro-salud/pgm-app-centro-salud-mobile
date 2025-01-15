import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/controladores/public/EspecialidadesPublicController.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_especialidad.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class UnlEspecialidades extends StatefulWidget {
  const UnlEspecialidades({super.key});
  static const id = "unl-especialidades";
  @override
  State<UnlEspecialidades> createState() => _UnlEspecialidadesState();
}

class _UnlEspecialidadesState extends State<UnlEspecialidades> {
  List<Especialidad> especialidades = [];
  final EspecialidadesPublicController especialidadesPublicController =
      EspecialidadesPublicController();
  String _errorMessage = "";
  void initState() {
    super.initState();
    obtenerEspecialidades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colores.color4,
        title: Text("Especialidades"),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: CustomTextTitle(
                    label: '${LocaleData.especialidades.getString(context)}'),
              ),
              Expanded(
                flex: 9,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: especialidades.length,
                  itemBuilder: (context, index) {
                    final especialidad = especialidades[index];
                    return cardEspecialidad(context, especialidad, () {
                      Navigator.pushNamed(context, UnlDetalleEspecialidad.id,
                          arguments: especialidad.idEspecialidad);
                    }, double.infinity);
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<void> obtenerEspecialidades() async {
    _errorMessage = "";
    try {
      final especialidadesResponse =
          await especialidadesPublicController.obtenerEspecialidades();
      setState(() {
        especialidades = especialidadesResponse;
      });
    } catch (e) {
      _errorMessage = 'Error al obtener especialidades';
    }
  }
}
