import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/image_container.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';

import '../modelos/Especialidades.dart';
import '../util/colores.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final EspecialidadesController controller = EspecialidadesController();
  List<Especialidad> especialidades = [];
  String _errorMessage="";
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
                    child: (_errorMessage.isEmpty)?Center(child:Text(_errorMessage)):ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: especialidades.length,
                      itemBuilder: (context, index) {
                        final newData = especialidades[index];
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
                                      '',
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: equipoMedico.length,
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
                                      '',
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Dr. "+newData["nombres"]+" "+newData["apellidoPaterno"],
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



  void obtenerEquipoMedico() {
    http.get(
        Uri.http(dotenv.env["API_URL"]!,
            "/api/microservicio-gestion-informacion-centro-medico/medicos"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }).then((response) async {
          setState(() {
            equipoMedico = jsonDecode(response.body);
          });
          print(equipoMedico);
    });
  }
  Future<void> obtenerEspecialidades() async {
    _errorMessage="";
    try{
      final especialidadesResponse = await controller.obtenerEspecialidades();
      setState(() {
        especialidades = especialidadesResponse;
      });
    }catch(e){
      _errorMessage = 'Error al obtener especialidades';
    }
  }
}
