import 'package:flutter/material.dart';
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

class OpcionesMenu {
  static List opciones = [
    {
      'title': 'Mi perfil',
      'description': 'Verificar detalles de tu perfil de usuario',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MyProfile.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Gestión de Fichas Médicas',
      'description':
          'Administra tus fichas médicas de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionFichasMedicas.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Historias Clínicas',
      'description':
          'Consulta tus historias clínicas de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281656224-5f45b0172d34?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisHistoriasClinicasView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Exámenes Complementarios',
      'description':
          'Consulta tus exámenes complementarios de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281656224-5f45b0172d34?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisExamenesComplementariosView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Interconsultas',
      'description': 'Consulta tus interconsultas de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281656224-5f45b0172d34?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisSolicitudesInterconsultasView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Notas de Referencia',
      'description':
          'Consulta tus notas de referencia de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisNotasReferenciaView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Recetas',
      'description': 'Consulta tus recetas de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisRecetasView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Notas de Evolución',
      'description':
          'Consulta tus notas de evolución de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisNotasEvolucionView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Mis Papeletas de Internación',
      'description':
          'Consulta tus papeletas de internación de manera fácil y rápida.',
      'image':
          'url("https://images.unsplash.com/photo-1580281656224-5f45b0172d34?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': MisPapeletasInternacionView.id,
      'icono': Icons.local_hospital,
      'rol': "PACIENTE"
    },
    {
      'title': 'Gestión de Historias Clínicas',
      'description':
          'Administra historias clínicas de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionHistoriasClinicasView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de Exámenes Complementarios',
      'description':
          'Administra exámenes complementarios de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionExamenesComplementariosView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de Interconsultas',
      'description': 'Administra interconsultas de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionSolicitudesInterconsultaView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de Notas de Referencia',
      'description':
          'Administra notas de referencia de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionNotasReferenciaView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de Recetas',
      'description': 'Administra recetas de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionRecetasView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de Notas de Evolución',
      'description':
          'Administra notas de evolución de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionNotasEvolucionView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de Papeletas de Internación',
      'description':
          'Administra papeletas de internación de manera eficiente y segura.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionPapeletasInternacionView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
    {
      'title': 'Gestión de consultas médicas a atender',
      'description':
          'Administra las consultas médicas que solicitaron y debes atender.',
      'image':
          'url("https://images.unsplash.com/photo-1580281657521-7805f5a4e552?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1lZGljYWwlMjByZWNvcmR8fDB8fHx8MTY4NzgzODc3Ng&ixlib=rb-1.2.1&q=80&w=400")',
      'route': GestionConsultasMedicasMedicosView.id,
      'icono': Icons.local_hospital,
      'rol': "MEDICO"
    },
  ];
}
