import 'dart:convert';

import 'package:proyecto_grado_flutter/modelos/Imagen.dart';

class Paciente {
  final String idUsuario;
  final List<Imagen> imagenes;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String ci;
  final String email;
  final String celular;
  final String descripcion;
  String sexo = "";

  Paciente(
      {required this.idUsuario,
      required this.imagenes,
      required this.nombres,
      required this.apellidoPaterno,
      required this.apellidoMaterno,
      required this.ci,
      required this.email,
      required this.celular,
      required this.descripcion,
      required this.sexo});

  factory Paciente.fromJson(Map<String, dynamic> json) {
    final List<Imagen> imagenes = (json['imagenes'] as List<dynamic>?)
            ?.map((img) => Imagen.fromJson(img))
            .toList() ??
        [];
    return Paciente(
        idUsuario: json['idUsuario'] ?? "",
        imagenes: imagenes.isNotEmpty
            ? imagenes
            : [
                Imagen.fromJson({
                  "url":
                      'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg'
                })
              ],
        nombres: json['nombres'] ?? '',
        apellidoPaterno: json['apellidoPaterno'] ?? '',
        apellidoMaterno: json['apellidoMaterno'] ?? '',
        ci: json['ci'] ?? '',
        email: json['email'] ?? '',
        celular: json['celular'] ?? '',
        descripcion: json['descripcion'] ?? '',
        sexo: json['sexo'] ?? '');
  }

  static List<Paciente> listFromString(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Paciente.fromJson(json)).toList();
  }
}
