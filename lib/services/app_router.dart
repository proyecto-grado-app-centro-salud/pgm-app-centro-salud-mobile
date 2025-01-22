import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-examen-complementario.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-historia-clinica.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-nota-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-nota-referencia.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-papeleta-internacion.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-receta.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-resultado-examen-complementario.dart';
import 'package:proyecto_grado_flutter/pages/actualizar-solicitud-interconsulta.dart';
import 'package:proyecto_grado_flutter/pages/detalle-examen-complementario.dart';
import 'package:proyecto_grado_flutter/pages/detalle-historia-clinica.dart';
import 'package:proyecto_grado_flutter/pages/detalle-nota-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/detalle-nota-referencia.dart';
import 'package:proyecto_grado_flutter/pages/detalle-papeleta-internacion.dart';
import 'package:proyecto_grado_flutter/pages/detalle-receta.dart';
import 'package:proyecto_grado_flutter/pages/detalle-solicitud-interconsulta.dart';
import 'package:proyecto_grado_flutter/pages/gestion-consultas-medicas-medicos.dart';
import 'package:proyecto_grado_flutter/pages/gestion-examenes-complementarios.dart';
import 'package:proyecto_grado_flutter/pages/gestion-notas-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/gestion-notas-referencia.dart';
import 'package:proyecto_grado_flutter/pages/gestion-papeletas-internacion.dart';
import 'package:proyecto_grado_flutter/pages/gestion-recetas.dart';
import 'package:proyecto_grado_flutter/pages/gestion-solicitudes-interconsultas.dart';
import 'package:proyecto_grado_flutter/pages/gestion_fichas_medicas.dart';
import 'package:proyecto_grado_flutter/pages/gestion_historias_clinicas.dart';
import 'package:proyecto_grado_flutter/pages/mis-examenes-complementario.dart';
import 'package:proyecto_grado_flutter/pages/mis-historias-clinicas.dart';
import 'package:proyecto_grado_flutter/pages/mis-notas-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/mis-notas-referencia.dart';
import 'package:proyecto_grado_flutter/pages/mis-papeletas-internacion.dart';
import 'package:proyecto_grado_flutter/pages/mis-recetas.dart';
import 'package:proyecto_grado_flutter/pages/mis-solicitudes-interconsultas.dart';
import 'package:proyecto_grado_flutter/pages/my_profile.dart';
import 'package:proyecto_grado_flutter/pages/registrar-examen-complementario.dart';
import 'package:proyecto_grado_flutter/pages/registrar-historia-clinica.dart';
import 'package:proyecto_grado_flutter/pages/registrar-nota-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/registrar-nota-referencia.dart';
import 'package:proyecto_grado_flutter/pages/registrar-papeleta-internacion.dart';
import 'package:proyecto_grado_flutter/pages/registrar-receta.dart';
import 'package:proyecto_grado_flutter/pages/registrar-solicitud-interconsulta.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_especialidad.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_medico_especialista.dart';
import 'package:proyecto_grado_flutter/pages/unl_equipo_medico.dart';
import 'package:proyecto_grado_flutter/pages/unl_especialidades.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // USUARIO NO AUTENTICADO
      case (UnlEspecialidades.id):
        return MaterialPageRoute(builder: (_) => const UnlEspecialidades());
      case (UnlDetalleEspecialidad.id):
        final idEspecialidad = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                UnlDetalleEspecialidad(idEspecialidad: idEspecialidad));
      case (UnlEquipoMedico.id):
        return MaterialPageRoute(builder: (_) => const UnlEquipoMedico());
      case (UnlDetalleMedicoEspecialista.id):
        final idMedico = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => UnlDetalleMedicoEspecialista(idMedico: idMedico));
      // USUARIO MEDICO
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
      case (RegistrarReceta.id):
        return MaterialPageRoute(builder: (_) => const RegistrarReceta());
      case (RegistrarSolicitudInterconsulta.id):
        return MaterialPageRoute(
            builder: (_) => const RegistrarSolicitudInterconsulta());
      case (ActualizarHistoriaClinica.id):
        final idHistoriaClinica = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ActualizarHistoriaClinica(
                idHistoriaClinica: idHistoriaClinica));
      case (ActulizarExamenComplementarioView.id):
        final idExamenComplementario = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ActulizarExamenComplementarioView(
                idExamenComplementario: idExamenComplementario));
      case (ActualizarResultadoExamenComplementario.id):
        final resultadoExamen = routeSettings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => ActualizarResultadoExamenComplementario(
                resultadoExamen: resultadoExamen));
      case (ActualizarNotaEvolucionView.id):
        final idNotaEvolucion = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                ActualizarNotaEvolucionView(idNotaEvolucion: idNotaEvolucion));
      case (ActualizarNotaReferencia.id):
        final idNotaReferencia = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                ActualizarNotaReferencia(idNotaReferencia: idNotaReferencia));
      case (ActualizarPapeletaInternacion.id):
        final idPapeletaInternacion = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ActualizarPapeletaInternacion(
                idPapeletaInternacion: idPapeletaInternacion));
      case (ActualizarRecetaView.id):
        final idReceta = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ActualizarRecetaView(idReceta: idReceta));
      case (ActualizarSolicitudInterconsultaView.id):
        final idSolicitudInterconsulta = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ActualizarSolicitudInterconsultaView(
                idSolicitudInterconsulta: idSolicitudInterconsulta));
      case (DetalleHistoriaClinicaView.id):
        final idHistoriaClinica = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DetalleHistoriaClinicaView(
                idHistoriaClinica: idHistoriaClinica));
      case (DetalleExamenComplementarioView.id):
        final idExamenComplementario = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DetalleExamenComplementarioView(
                idExamenComplementario: idExamenComplementario));
      case (DetalleNotaEvolucionView.id):
        final idNotaEvolucion = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                DetalleNotaEvolucionView(idNotaEvolucion: idNotaEvolucion));
      case (DetalleNotaReferenciaView.id):
        final idNotaReferencia = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) =>
                DetalleNotaReferenciaView(idNotaReferencia: idNotaReferencia));
      case (DetallePapeletaInternacionView.id):
        final idPapeletaInternacion = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DetallePapeletaInternacionView(
                idPapeletaInternacion: idPapeletaInternacion));
      case (DetalleRecetaView.id):
        final idReceta = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DetalleRecetaView(idReceta: idReceta));
      case (DetalleSolicitudInterconsultaView.id):
        final idSolicitudInterconsulta = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DetalleSolicitudInterconsultaView(
                idSolicitudInterconsulta: idSolicitudInterconsulta));
      case (GestionHistoriasClinicasView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionHistoriasClinicasView());
      case (GestionExamenesComplementariosView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionExamenesComplementariosView());
      case (GestionNotasEvolucionView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionNotasEvolucionView());
      case (GestionNotasReferenciaView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionNotasReferenciaView());
      case (GestionPapeletasInternacionView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionPapeletasInternacionView());
      case (GestionRecetasView.id):
        return MaterialPageRoute(builder: (_) => const GestionRecetasView());
      case (GestionSolicitudesInterconsultaView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionSolicitudesInterconsultaView());
      case (GestionConsultasMedicasMedicosView.id):
        return MaterialPageRoute(
            builder: (_) => const GestionConsultasMedicasMedicosView());
      // USUARIO PACIENTE
      case (MyProfile.id):
        return MaterialPageRoute(builder: (_) => const MyProfile());
      case (GestionFichasMedicas.id):
        return MaterialPageRoute(builder: (_) => const GestionFichasMedicas());
      case (MisHistoriasClinicasView.id):
        return MaterialPageRoute(
            builder: (_) => const MisHistoriasClinicasView());
      case (MisNotasEvolucionView.id):
        return MaterialPageRoute(builder: (_) => const MisNotasEvolucionView());
      case (MisExamenesComplementariosView.id):
        return MaterialPageRoute(
            builder: (_) => const MisExamenesComplementariosView());
      case (MisNotasReferenciaView.id):
        return MaterialPageRoute(
            builder: (_) => const MisNotasReferenciaView());
      case (MisPapeletasInternacionView.id):
        return MaterialPageRoute(
            builder: (_) => const MisPapeletasInternacionView());
      case (MisRecetasView.id):
        return MaterialPageRoute(builder: (_) => const MisRecetasView());
      case (MisSolicitudesInterconsultasView.id):
        return MaterialPageRoute(
            builder: (_) => const MisSolicitudesInterconsultasView());
      default:
        return null;
    }
  }
}
