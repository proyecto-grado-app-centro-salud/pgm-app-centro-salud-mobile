import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<int> obtenerIdUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return int.parse(preferences.getString("id") ?? "0");
  }

  Future<List<String>> obtenerRolesUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("roles")!;
  }
}
