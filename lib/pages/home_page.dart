import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/image_container.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';

import '../util/colores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _counter = 0;
  List especialidades = [];
  List equipoMedico = [];
  List procesoPeticionFichaPresencial = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                        label: '${LocaleData.especialidades.getString(context)}'),
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
}
