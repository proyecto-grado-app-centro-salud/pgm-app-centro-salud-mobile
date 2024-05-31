import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/colores.dart';
import '../widgets/new-drawer.dart';

class RegistrarFichaMedica extends StatefulWidget {
  const RegistrarFichaMedica({super.key});

  @override
  State<RegistrarFichaMedica> createState() => _RegistrarFichaMedicaState();
}

class _RegistrarFichaMedicaState extends State<RegistrarFichaMedica> {
  List turnosAtencionMedica = [
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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colores.color4,
          title: Text("app consultas medicas")),
      body: Container(
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
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: ElevatedButton(
                                      child: Text("Registrar"),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colores.color3),textStyle:MaterialStateProperty.all(TextStyle(color: Colors.white))),
                                      onPressed: () {},
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      )),
                );
              })),
    );
  }
}
