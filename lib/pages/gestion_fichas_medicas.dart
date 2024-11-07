import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/pages/registrar_ficha_medica.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:http/http.dart' as http;

class GestionFichasMedicas extends StatefulWidget {
  const GestionFichasMedicas({super.key});
  static const id = "gestion-fichas-medicas";
  @override
  State<GestionFichasMedicas> createState() => _GestionFichasMedicasState();
}

class _GestionFichasMedicasState extends State<GestionFichasMedicas> {
  dynamic fichasMedicas = [];
  AuthController authController = new AuthController();
  @override
  void initState() {
    authController
        .obtenerIdUsuario()
        .then((idUsuario) => obtenerFichasMedicasPaciente(idUsuario));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            backgroundColor: Colores.color4,
            title: Text("app consultas medicas")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                        child: Text("Gestion mis fichas medicas",
                            style: TextStyle(
                                color: Colores.color4,
                                fontWeight: FontWeight.bold))),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colores.color3),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white))),
                      child: Text(
                        "Registrar ficha medica",
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context, FadeRoute(page: RegistrarFichaMedica()));
                      },
                    )
                  ],
                ),
              ),
              Container(
                  height: 600,
                  child: ListView.builder(
                      itemCount: fichasMedicas.length,
                      itemBuilder: (context, index) {
                        final fichaMedica = fichasMedicas[index];
                        return Center(
                          child: Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colores.color4,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Expanded(
                                          flex: 1,
                                          child: Text("Fecha:",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              fichaMedica[
                                                      'fechaTurnoAtencionMedica'] ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Expanded(
                                          flex: 1,
                                          child: Text("Turno:",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              '${fichaMedica['horaInicio']} ${fichaMedica['horaFin']}' ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Expanded(
                                          flex: 1,
                                          child: Text("Medico:",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              fichaMedica['nombreMedico'] ?? "",
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Expanded(
                                          flex: 1,
                                          child: Text("Especialidad:",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              fichaMedica[
                                                      'nombreEspecialidad'] ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Expanded(
                                          flex: 1,
                                          child: Text("Numero de ficha medica:",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              fichaMedica['numeroFicha']
                                                      ?.toString() ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      /*Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {},
                                          )),*/
                                      Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.white),
                                              onPressed: () {
                                                eliminarFichaMedicas(
                                                    fichaMedica[
                                                        'idConsultaMedica']);
                                              },
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              )),
                        );
                      })),
            ],
          ),
        ));
    ;
  }

  void obtenerFichasMedicasPaciente(idPaciente) {
    http.get(
        Uri.http(dotenv.env["API_URL"]!,
            "/api/microservicio-fichas-medicas/fichas-medicas/detalle/paciente/${idPaciente}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }).then((response) async {
      final body = utf8.decode(response.bodyBytes);
      var fichasMedicasPeticion = (json.decode(body));
      setState(() {
        print(fichasMedicasPeticion);
        fichasMedicas = fichasMedicasPeticion;
      });
    });
  }

  void eliminarFichaMedicas(int idFichaMedica) async {
    http.delete(
        Uri.https(dotenv.env["API_URL"]!,
            "/api/microservicio-fichas-medicas/fichas-medicas/${idFichaMedica}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }).then((response) async {
      int idPaciente = await authController.obtenerIdUsuario();
      obtenerFichasMedicasPaciente(idPaciente);
      if (response.statusCode == 200) {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Eliminado!",
                text: "Eliminado correctamente"));
      } else {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: "Error!",
                text: "Error al eliminar ficha"));
      }
    });
  }
}
