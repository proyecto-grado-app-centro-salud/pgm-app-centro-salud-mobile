import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/attention_schedules.dart';
import 'package:proyecto_grado_flutter/pages/doctor_team.dart';
import 'package:proyecto_grado_flutter/pages/gestion_fichas_medicas.dart';
import 'package:proyecto_grado_flutter/pages/home_page.dart';
import 'package:proyecto_grado_flutter/pages/login.dart';
import 'package:proyecto_grado_flutter/pages/medical_recort_managment.dart';
import 'package:proyecto_grado_flutter/pages/my_profile.dart';
import 'package:proyecto_grado_flutter/pages/specialities.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  void initState() {
    super.initState();
    print("Abriendo drawerstate");

    obtenerToken();
  }

  Future<void> obtenerToken() async {
    print("Obtener token");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("token"));
    if (preferences.getString("token") != "") {
      setState(() {
        logeado = true;
      });
    }
    print(logeado);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", "");
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Logout!",
          text: "Logout exitoso",
          confirmButtonText: "Aceptar",
          onConfirm: () {
            Navigator.pop(context);
            Navigator.push(context, FadeRoute(page: const HomePage()));
          }),
    );
  }

  bool logeado = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colores.color4,
            ),
            child: Center(
              child: Container(
                  width: 75,
                  height: 75,
                  child: Image.asset(
                    "assets/icono_cocawi.png",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Pagina principal'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, FadeRoute(page: const HomePage()))
            },
          ),
          ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('Especialidades'),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context, FadeRoute(page: const Specialities()))
                  }),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Equipo medico'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, FadeRoute(page: const DoctorTeam()))
            },
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Horarios de atencion'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
                  context, FadeRoute(page: const AttentionSchedule()))
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Gestion de fichas medicas'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context,
                  FadeRoute(page: const GestionFichasMedicas()))
            },
          ),
          (!logeado)
              ? Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.login),
                      title: Text('Iniciar sesion'),
                      onTap: () => {
                        Navigator.pop(context),
                        Navigator.push(context, FadeRoute(page: const Login()))
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_circle_outlined),
                      title: Text('Mi perfil'),
                      onTap: () => {
                        Navigator.pop(context),
                        Navigator.push(
                            context, FadeRoute(page: const MyProfile()))
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Gestion de fichas medicas'),
                      onTap: () => {
                        Navigator.pop(context),
                        Navigator.push(context,
                            FadeRoute(page: const GestionFichasMedicas()))
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () => {logout()},
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
