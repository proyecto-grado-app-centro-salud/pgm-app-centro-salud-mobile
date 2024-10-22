import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/registrar-historia-clinica.dart';
import 'package:proyecto_grado_flutter/pages/registrar-nota-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_especialidad.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_medico_especialista.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case (UnlDetalleEspecialidad.id):
        final idEspecialidad = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                UnlDetalleEspecialidad(idEspecialidad: idEspecialidad));
      case (UnlDetalleMedicoEspecialista.id):
        final idMedico = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => UnlDetalleMedicoEspecialista(idMedico: idMedico));
      case (RegistrarHistoriaClinica.id):
        return MaterialPageRoute(builder: (_) => RegistrarHistoriaClinica());
      case (RegistrarNotaEvolucion.id):
        return MaterialPageRoute(builder: (_) => RegistrarNotaEvolucion());
      default:
        return null;
    }
  }
}
