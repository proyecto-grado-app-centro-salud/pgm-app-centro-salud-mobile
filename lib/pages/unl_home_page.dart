import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/controladores/MedicosController.dart';
import 'package:proyecto_grado_flutter/controladores/public/EspecialidadesPublicController.dart';
import 'package:proyecto_grado_flutter/controladores/public/MedicosPublicController.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_especialidad.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_medico_especialista.dart';
import 'package:proyecto_grado_flutter/pages/unl_equipo_medico.dart';
import 'package:proyecto_grado_flutter/pages/unl_especialidades.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/image_container.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

import '../modelos/Especialidades.dart';
import '../util/colores.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final EspecialidadesPublicController especialidadesPublicController =
      EspecialidadesPublicController();
  final MedicosPublicController medicosPublicController =
      MedicosPublicController();
  List<Especialidad> especialidades = [];
  String _errorMessage = "";
  List equipoMedico = [];
  List procesoPeticionFichaPresencial = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerEspecialidades();
    obtenerEquipoMedico();
    obtenerCiPaciente();
  }

  @override
  Widget build(BuildContext context) {
    //final _endPoint = dotenv.env['API_ENDPOINT'];
    final _endPoint = "http://localhost:8084/";

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colores.color4,
        title: Text("app consultas medicas"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: displayWidth(context),
                height: 180,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("assets/banner-home.jpg"),
                        fit: BoxFit.cover)),
                child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: double.infinity,
                    color: Color.fromARGB(120, 0, 0, 0),
                    child: Align(
                        child: Text(
                      "GESTION DE CONSULTAS EXTERNAS CENTROS DE SALUD",
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: Colores.color1,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
                    alignment: Alignment.centerLeft),
              ),
              Align(
                child: Text(
                  '¡Bienvenido de nuevo! Nos alegra verte otra vez.',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colores.color4,
                      fontWeight: FontWeight.w700),
                ),
                alignment: Alignment.centerLeft,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [Text(ci)],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: [
                    CustomTextTitle(
                        label:
                            '${LocaleData.especialidades.getString(context)}'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, UnlEspecialidades.id);
                      },
                      child: Text(
                        LocaleData.verTodo.getString(context),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colores.color4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: especialidades.length,
                      itemBuilder: (context, index) {
                        final especialidad = especialidades[index];
                        print(especialidad);
                        return cardEspecialidad(context, especialidad, () {
                          Navigator.pushNamed(
                              context, UnlDetalleEspecialidad.id,
                              arguments: especialidades[index].idEspecialidad);
                        });
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: [
                    CustomTextTitle(
                        label: '${LocaleData.equipoMedico.getString(context)}'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, UnlEquipoMedico.id);
                      },
                      child: Text(
                        LocaleData.verTodo.getString(context),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colores.color4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: equipoMedico.length,
                      itemBuilder: (context, index) {
                        final medico = equipoMedico[index];
                        return cardMedico(context, medico, () {
                          Navigator.pushNamed(
                              context, UnlDetalleMedicoEspecialista.id,
                              arguments: equipoMedico[index].idUsuario);
                        });
                      },
                    ),
                  )),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 10),
              //   child: Row(
              //     children: [
              //       CustomTextTitle(
              //           label:
              //               'Comunicados'),
              //       const Spacer(),
              //       TextButton(
              //         onPressed: () {},
              //         child: Text(
              //           LocaleData.verTodo.getString(context),
              //           style: const TextStyle(
              //             fontSize: 12,
              //             color: Colores.color4,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //     padding: const EdgeInsets.only(
              //       left: 20,
              //     ),
              //     child: SizedBox(
              //       height: 200,
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: procesoPeticionFichaPresencial.length,
              //         itemBuilder: (context, index) {
              //           final newData = equipoMedico[index];
              //           return Container(
              //             width: 220,
              //             margin: const EdgeInsets.only(right: 10),
              //             child: InkWell(
              //               onTap: () {
              //                 Navigator.pushNamed(
              //                     context, UnlDetalleMedicoEspecialista.id,
              //                     arguments: index);
              //               },
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   ImageContainer(
              //                     width: 220,
              //                     imageUrl:
              //                         '$_endPoint/storage/default_image.png',
              //                   ),
              //                   const SizedBox(height: 10),
              //                   Text(
              //                     newData.nombre,
              //                     overflow: TextOverflow.ellipsis,
              //                     maxLines: 1,
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .bodyLarge!
              //                         .copyWith(
              //                             fontWeight: FontWeight.bold,
              //                             height: 1.5),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerEquipoMedico() async {
    _errorMessage = "";
    try {
      final medicosResponse =
          await medicosPublicController.obtenerEquipoMedico();
      setState(() {
        equipoMedico = medicosResponse;
      });
    } catch (e) {
      _errorMessage = 'Error al obtener medicos';
    }
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

  String ci = "";
  final authController = new AuthController();
  Future<void> obtenerCiPaciente() async {
    try {
      ci = (await authController.obtenerIdUsuario()) as String;
    } catch (e) {
      print(e);
    }
  }
}
