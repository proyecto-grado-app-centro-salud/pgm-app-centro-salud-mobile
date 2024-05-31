import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/registrar_ficha_medica.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';

class GestionFichasMedicas extends StatefulWidget {
  const GestionFichasMedicas({super.key});

  @override
  State<GestionFichasMedicas> createState() => _GestionFichasMedicasState();
}

class _GestionFichasMedicasState extends State<GestionFichasMedicas> {
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
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colores.color3),textStyle:MaterialStateProperty.all(TextStyle(color: Colors.white))),
                      child: Text(
                        "Registrar ficha medica",
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, FadeRoute(page: RegistrarFichaMedica()));
                      },
                    )
                  ],
                ),
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
                                            alignment: AlignmentDirectional.centerEnd,
                                            child: IconButton(
                                              icon: Icon(Icons.delete,color: Colors.white),
                                              onPressed: () {},
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
}
