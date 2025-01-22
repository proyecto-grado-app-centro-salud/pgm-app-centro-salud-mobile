import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<String> obtenerIdUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("id") ?? "";
  }

  Future<String> obtenerToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token") ?? "";
  }

  Future<List<String>> obtenerRolesUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> roles = preferences.getStringList("roles") ?? [];
    return roles;
  }

  Future<void> changePassword(
      String username, String confirmationCode, String newPassword) async {
    print(confirmationCode);
    try {
      final Map<String, String> requestBody = {
        'username': username,
        'nuevoPassword': newPassword,
        'codigoVerificacion': confirmationCode,
      };

      // final response = await http.post(
      //   Uri.https(
      //       '${dotenv.env["API_URL"]!}/api/microservicio-gestion-usuarios/v1.0/usuarios/cambiar-contrasenia'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode(requestBody),
      // );
      final response = await http.post(
          Uri.https(dotenv.env["API_URL"]!,
              "/api/microservicio-gestion-usuarios/v1.0/usuarios/cambiar-contrasenia"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(requestBody));
      if (response.statusCode == 200) {
        print("Cambio contraseña correcto");
      } else {
        throw Exception(
            'Error al cambiar la contraseña. Código de error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error al cambiar la contraseña: $error');
    }
  }

  Future<void> forgotPassword(String username) async {
    try {
      // final response = await http.get(
      //   Uri.https(
      //       '${dotenv.env["API_URL"]!}/api/microservicio-gestion-usuarios/v1.0/usuarios/codigo-verificacion/$username'),
      // );
      print(username);
      final response = await http.get(
          Uri.https(dotenv.env["API_URL"]!,
              "/api/microservicio-gestion-usuarios/v1.0/usuarios/codigo-verificacion/${username.trim()}"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        print('Código de verificación enviado');
      } else {
        throw Exception('Error al solicitar el código de verificación');
      }
    } catch (error) {
      throw Exception('Error al obtener el código de verificación: $error');
    }
  }
  // Future<String> obtenerEmail() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getString("email") ?? '';
  // }
}
