import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto_grado_flutter/controladores/TurnosAtencionMedicaController.dart';
import 'package:proyecto_grado_flutter/controladores/public/TurnosAtencionMedicaPublicController.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class _AttentionScheduleState extends State<AttentionSchedule> {
  TextEditingController fechaInicio = TextEditingController();
  TextEditingController fechaFin = TextEditingController();
  void initState() {
    super.initState();
    DateTime maniana = DateTime.now().add(Duration(days: 1));
    fechaInicio.text =
        '${maniana.year}-${maniana.month.toString().padLeft(2, '0')}-${maniana.day.toString().padLeft(2, '0')}';

    DateTime nextSunday = DateTime.now()
        .add(Duration(days: 7 - DateTime.now().weekday))
        .add(Duration(days: 7));
    fechaFin.text =
        '${nextSunday.year}-${nextSunday.month.toString().padLeft(2, '0')}-${nextSunday.day.toString().padLeft(2, '0')}';

    obtenerTurnosAtencion(fechaInicio.text, fechaFin.text, 1);
  }

  void _onSelectFechaInicio(String date) {
    setState(() {
      fechaInicio!.text = date;
    });
  }

  void _onSelectFechaFin(String date) {
    setState(() {
      fechaFin!.text = date;
    });
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
                child: Text(
                  "Horarios de atencion",
                  style: TextStyle(fontSize: 24, color: Colores.color4),
                ),
              ),
              Column(
                children: [
                  inputDateFormFieldFormatoBorderBlack(
                      context, fechaInicio, "", _onSelectFechaInicio),
                  inputDateFormFieldFormatoBorderBlack(
                      context, fechaFin, "", _onSelectFechaFin),
                  botonPrimario(
                      context,
                      "Buscar turnos",
                      () => {
                            obtenerTurnosAtencion(
                                fechaInicio.text, fechaFin.text)
                          }),
                  Container(
                      height: displayHeight(context) * 0.6,
                      child: ListView.builder(
                          itemCount: turnosAtencionMedica.length,
                          itemBuilder: (context, index) {
                            final turnoAtencionMedica =
                                turnosAtencionMedica[index];
                            return Center(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                                  turnoAtencionMedica['fecha'],
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
                                                  '${turnoAtencionMedica['horaInicio']} ${turnoAtencionMedica['horaFin']}',
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
                                                  turnoAtencionMedica[
                                                      'nombreMedico'],
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
                                                  turnoAtencionMedica[
                                                      'nombreEspecialidad'],
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
            ],
          ),
        ));
  }

  final turnosAtencionPublicController = TurnosAtencionMedicaPublicController();
  Future<void> obtenerTurnosAtencion(
      [String? fechaInicio, String? fechaFin, int? page]) async {
    try {
      dynamic turnosAtencionMedicaPeticion =
          await turnosAtencionPublicController.obtenerTurnosAtencion(
              fechaInicio, fechaFin);
      print(turnosAtencionMedicaPeticion);
      setState(() {
        turnosAtencionMedica = turnosAtencionMedicaPeticion;
      });
    } catch (e) {
      print(e);
    }
  }
}

class AttentionSchedule extends StatefulWidget {
  const AttentionSchedule({super.key});

  @override
  State<AttentionSchedule> createState() => _AttentionScheduleState();
}
