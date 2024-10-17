import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/controladores/MedicosController.dart';
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
  final EspecialidadesController especialidadesController =
      EspecialidadesController();
  final MedicosController medicosController = MedicosController();
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: AssetImage("assets/banner-home.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [Text("Jose Gutierrez")],
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
                      onPressed: () {},
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
                        return cardEspecialidad(context, especialidad);
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
                      onPressed: () {},
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
                        return cardMedico(context, medico);
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: [
                    CustomTextTitle(
                        label:
                            '${LocaleData.informacionProcesoObtencionFichaMedicaPresencial.getString(context)}'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
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
                      itemCount: procesoPeticionFichaPresencial.length,
                      itemBuilder: (context, index) {
                        final newData = equipoMedico[index];
                        return Container(
                          width: 220,
                          margin: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageContainer(
                                  width: 220,
                                  imageUrl:
                                      '$_endPoint/storage/default_image.png',
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  newData.nombre,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerEquipoMedico() async {
    _errorMessage = "";
    try {
      final medicosResponse = await medicosController.obtenerEquipoMedico();
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
          await especialidadesController.obtenerEspecialidades();
      setState(() {
        especialidades = especialidadesResponse;
      });
    } catch (e) {
      _errorMessage = 'Error al obtener especialidades';
    }
  }
}
