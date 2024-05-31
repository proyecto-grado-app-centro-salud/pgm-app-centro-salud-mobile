import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/gestion_fichas_medicas.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';

import '../widgets/new-drawer.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colores.color4,
          title: Text("app consultas medicas")),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(children: [
            Center(
                child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colores.color4,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.pop(context),
                        Navigator.push(context,
                            FadeRoute(page: const GestionFichasMedicas()))
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Gestion de fichas medicas",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )))
          ]),
        ),
      ),
    );
  }
}
