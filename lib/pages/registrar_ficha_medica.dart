import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../util/colores.dart';
import '../widgets/new-drawer.dart';

class RegistrarFichaMedica extends StatefulWidget {
  const RegistrarFichaMedica({super.key});

  @override
  State<RegistrarFichaMedica> createState() => _RegistrarFichaMedicaState();
}

class _RegistrarFichaMedicaState extends State<RegistrarFichaMedica> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTurnosAtencion();

  }

  /*List turnosAtencionMedica = [
    [1, "A12", "turno mañana", "medico1", "ginecologia"],
    [2, "A15", "turno mañana", "medico3", "neurologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"],
    [3, "B12", "turno tarde", "medico3", "traumatologia"]
  ];*/
  List turnosAtencionMedica =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colores.color4,
          title: Text("app consultas medicas")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Turnos de atencion",
              style: TextStyle(color: Colores.color4, fontSize: 24),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: turnosAtencionMedica.length,
                  itemBuilder: (context, index) {
                    final turnoAtencionMedica = turnosAtencionMedica[index];
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
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(turnoAtencionMedica[5],
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
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(turnoAtencionMedica[2],
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
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(turnoAtencionMedica[3],
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
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(turnoAtencionMedica[4],
                                          style: const TextStyle(
                                              color: Colors.white))),
                                ],
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: ElevatedButton(
                                          child: Text("Solicitar ficha"),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colores.color3),
                                              textStyle:
                                                  MaterialStateProperty.all(
                                                      TextStyle(
                                                          color:
                                                              Colors.white))),
                                          onPressed: () {
                                            registrarFichaMedica(
                                                turnoAtencionMedica[0]);
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
    );
  }

  void obtenerTurnosAtencion() {
    http.get(
        Uri.http(dotenv.env["API_URL"]!,
            "/api/microservicio-gestion-informacion-centro-medico/horarios-atencion-medica"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }).then((response) async {
          setState(() {
            var turnosAtencionMedicaPeticion = (json.decode(response.body));
            turnosAtencionMedica = turnosAtencionMedicaPeticion;
          });

    });
  }

  void registrarFichaMedica(int idTurnoAtencion) {
    int idPaciente = 1;
    String email="mariafernanda82917483@gmail.com";
    http.post(
        Uri.http(dotenv.env["API_URL"]!,
            "/api/microservicio-fichas-medicas/fichas-medicas"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "idTurnoAtencionMedica":idTurnoAtencion,
          "email":email
        })).then((response) async {
      if (response.statusCode == 200) {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Registrado!",
                text: "Registrado correctamente"));
      } else {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: "Error!",
                text: "Error al registrar ficha"));
      }
    });
  }
}
