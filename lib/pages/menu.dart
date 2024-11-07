import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/OpcionesMenuController.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

import '../widgets/new-drawer.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<String> roles = [];
  List opcionesMenu = [];
  @override
  void initState() {
    obtenerRolesUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colores.color4,
          title: Text("app consultas medicas")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return opcionMenu(context, opcionesMenu[index]['title'], () {
              Navigator.pushNamed(context, opcionesMenu[index]['route']);
            });
          },
          itemCount: opcionesMenu.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  final _authController = AuthController();
  OpcionesMenuController opcionesMenuController = OpcionesMenuController();
  Future<void> obtenerRolesUsuario() async {
    List<String> rolesObtenidos = await _authController.obtenerRolesUsuario();
    List opcionesMenuObtenidos =
        opcionesMenuController.obtenerOpcionesMenuPorRol(rolesObtenidos);
    setState(() {
      roles = rolesObtenidos;
      opcionesMenu = opcionesMenuObtenidos;
    });
  }
}
