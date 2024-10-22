import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/registrar-examen-complementario.dart';
import 'package:proyecto_grado_flutter/pages/registrar-historia-clinica.dart';
import 'package:proyecto_grado_flutter/pages/registrar-nota-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/registrar-nota-referencia.dart';
import 'package:proyecto_grado_flutter/pages/registrar-papeleta-internacion.dart';
import 'package:proyecto_grado_flutter/pages/registrar-receta.dart';
import 'package:proyecto_grado_flutter/pages/registrar-solicitud-interconsulta.dart';
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
        return MaterialPageRoute(
            builder: (_) => const RegistrarHistoriaClinica());
      case (RegistrarNotaEvolucion.id):
        return MaterialPageRoute(
            builder: (_) => const RegistrarNotaEvolucion());
      case (RegistrarExamenComplementario.id):
        return MaterialPageRoute(
            builder: (_) => const RegistrarExamenComplementario());
      case (RegistrarNotaReferencia.id):
        return MaterialPageRoute(
            builder: (_) => const RegistrarNotaReferencia());
      case (RegistrarPapeletaInternacion.id):
        return MaterialPageRoute(
            builder: (_) => const RegistrarPapeletaInternacion());
      // case (RegistrarReceta.id):
      //   return MaterialPageRoute(builder: (_) => const RegistrarReceta());
      // case (RegistrarSolicitudInterconsulta.id):
      //   return MaterialPageRoute(
      //       builder: (_) => const RegistrarSolicitudInterconsulta());
      default:
        return null;
    }
  }
}
