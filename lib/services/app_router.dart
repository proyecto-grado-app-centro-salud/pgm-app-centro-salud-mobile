import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_especialidad.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case (UnlDetalleEspecialidad.id):
        final idEspecialidad = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                UnlDetalleEspecialidad(idEspecialidad: idEspecialidad));
      default:
        return null;
    }
  }
}
