import 'package:proyecto_grado_flutter/modelos/OpcionesMenu.dart';

class OpcionesMenuController {
  List obtenerOpcionesMenuPorRol(List rolesUsuario) {
    List opciones = OpcionesMenu.opciones;
    return opciones.where((opcion) {
      return rolesUsuario.contains(opcion['rol']);
    }).toList();
  }
}
