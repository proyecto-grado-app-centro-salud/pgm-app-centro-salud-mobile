import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:http/http.dart' as http;

class _AttentionScheduleState extends State<AttentionSchedule> {
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTurnosAtencion();

  }
  List turnosAtencionMedica = [
    /*[1, "A12", "turno mañana", "medico1", "ginecologia"],
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
    [3, "B12", "turno tarde", "medico3", "traumatologia"]*/
  ];
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
                child: Text("Horarios de atencion",style: TextStyle(fontSize: 24,color: Colores.color4),),
              ),
              Container(
                  height: 600,
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
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(turnoAtencionMedica[1],
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
                                                  fontWeight:
                                                      FontWeight.bold))),
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
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(turnoAtencionMedica[4],
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      })),
            ],
          ),
        ));
  }

  void obtenerTurnosAtencion() {
    http.get(
      Uri.http(dotenv.env["API_URL"]!,'/api/microservicio-gestion-informacion-centro-medico/horarios-atencion-medica'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    ).then((response)async{
      setState(() {
        turnosAtencionMedica=jsonDecode(response.body);
      });
    });
  }
}

class AttentionSchedule extends StatefulWidget {
  const AttentionSchedule({super.key});

  @override
  State<AttentionSchedule> createState() => _AttentionScheduleState();
}
