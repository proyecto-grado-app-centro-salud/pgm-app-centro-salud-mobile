import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/AuthController.dart';
import 'package:proyecto_grado_flutter/controladores/OpcionesMenuController.dart';
import 'package:proyecto_grado_flutter/pages/gestion-papeletas-internacion.dart';
import 'package:proyecto_grado_flutter/pages/gestion-recetas.dart';
import 'package:proyecto_grado_flutter/pages/gestion-solicitudes-interconsultas.dart';
import 'package:proyecto_grado_flutter/pages/mis-historias-clinicas.dart';
import 'package:proyecto_grado_flutter/pages/unl_horarios_atencion.dart';
import 'package:proyecto_grado_flutter/pages/gestion-examenes-complementarios.dart';
import 'package:proyecto_grado_flutter/pages/gestion-notas-evolucion.dart';
import 'package:proyecto_grado_flutter/pages/gestion-notas-referencia.dart';
import 'package:proyecto_grado_flutter/pages/gestion_fichas_medicas.dart';
import 'package:proyecto_grado_flutter/pages/gestion_historias_clinicas.dart';
import 'package:proyecto_grado_flutter/pages/unl_equipo_medico.dart';
import 'package:proyecto_grado_flutter/pages/unl_especialidades.dart';
import 'package:proyecto_grado_flutter/pages/unl_home_page.dart';
import 'package:proyecto_grado_flutter/pages/login.dart';
import 'package:proyecto_grado_flutter/pages/menu.dart';
import 'package:proyecto_grado_flutter/pages/my_profile.dart';
import 'package:proyecto_grado_flutter/pages/recuperar_contrasenia.dart';
import 'package:proyecto_grado_flutter/pages/registrar_ficha_medica.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late SharedPreferences preferences;
  List<String> roles = [];
  List opcionesMenu = [];
  @override
  void initState() {
    obtenerToken();
    obtenerOpcionesMenu();
    super.initState();
  }

  Future<void> obtenerToken() async {
    print("Obtener token");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("token"));
    if (preferences.getString("token")!.isNotEmpty) {
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
    preferences.clear();
    preferences.setString("token", "");
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Logout!",
          text: "Logout exitoso",
          confirmButtonText: "Aceptar",
          onConfirm: () {
            if (mounted) {
              Navigator.push(context, FadeRoute(page: const HomePage()));
            }
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
                  width: displayWidth(context),
                  height: displayHeight(context),
                  child: Image.asset(
                    "assets/hospital.jpg",
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
                        context, FadeRoute(page: const UnlEspecialidades()))
                  }),
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
            leading: Icon(Icons.people),
            title: Text('Equipo medico'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, FadeRoute(page: const UnlEquipoMedico()))
            },
          ),
          (logeado)
              ? Column(
                  children: opcionesMenu.map((especialidad) {
                    return ListTile(
                      leading: Icon(especialidad['icono']),
                      title: Text(especialidad['title']),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, especialidad['route']);
                      },
                    );
                  }).toList(),
                )
              : const SizedBox(),
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
              : ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Cerrar sesion'),
                  onTap: () => {
                    logout(),
                    Navigator.pop(context),
                    Navigator.push(context, FadeRoute(page: const HomePage()))
                  },
                ),
          // ListTile(
          //   leading: Icon(Icons.account_circle_outlined),
          //   title: Text('Mi perfil'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context, FadeRoute(page: const MyProfile()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.book),
          //   title: Text('Gestion de fichas medicas'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const GestionFichasMedicas()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Iniciar sesion'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context, FadeRoute(page: const Login()))
          //   },
          // ),
          (logeado)
              ? ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Menu'),
                  onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(context, FadeRoute(page: const Menu()))
                  },
                )
              : const SizedBox(),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Mi perfil'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context, FadeRoute(page: const MyProfile()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Recuperar contraseña'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const RecuperarContrasenia()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Registrar ficha medica'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const RegistrarFichaMedica()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de historias clinicas'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context,
          //         FadeRoute(page: const GestionHistoriasClinicasView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de notas evolucion'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const GestionNotasEvolucionView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de notas referencia'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const GestionNotasReferenciaView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de examenes complementarios'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context,
          //         FadeRoute(page: const GestionExamenesComplementariosView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de solicitudes de interconsulta'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context,
          //         FadeRoute(page: const GestionSolicitudesInterconsultaView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de papeletas de internacion'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(context,
          //         FadeRoute(page: const GestionPapeletasInternacionView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Gestion de recetas'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const GestionRecetasView()))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Ver mis historias clinicas'),
          //   onTap: () => {
          //     Navigator.pop(context),
          //     Navigator.push(
          //         context, FadeRoute(page: const MisHistoriasClinicasView()))
          //   },
          // ),
          // (opcionesMenu.isNotEmpty)
          //     ? ListTile(
          //         leading: Icon(Icons.logout),
          //         title: Text('Logout'),
          //         onTap: () => {logout()},
          //       )
          //     : const SizedBox(),
          // (opcionesMenu.isEmpty)
          //     ? ListTile(
          //         leading: Icon(Icons.login),
          //         title: Text('Iniciar sesion'),
          //         onTap: () => {
          //           Navigator.pop(context),
          //           Navigator.push(context, FadeRoute(page: const Login()))
          //         },
          //       )
          //     : const SizedBox(),
          // (!logeado)
          //     ? Column(
          //         children: [
          //           ListTile(
          //             leading: Icon(Icons.login),
          //             title: Text('Iniciar sesion'),
          //             onTap: () => {
          //               Navigator.pop(context),
          //               Navigator.push(context, FadeRoute(page: const Login()))
          //             },
          //           ),
          //         ],
          //       )
          //     : Column(
          //         children: [
          //           ListTile(
          //             leading: Icon(Icons.account_circle_outlined),
          //             title: Text('Mi perfil'),
          //             onTap: () => {
          //               Navigator.pop(context),
          //               Navigator.push(
          //                   context, FadeRoute(page: const MyProfile()))
          //             },
          //           ),
          //           ListTile(
          //             leading: Icon(Icons.book),
          //             title: Text('Gestion de fichas medicas'),
          //             onTap: () => {
          //               Navigator.pop(context),
          //               Navigator.push(context,
          //                   FadeRoute(page: const GestionFichasMedicas()))
          //             },
          //           ),
          //           ListTile(
          //             leading: Icon(Icons.logout),
          //             title: Text('Logout'),
          //             onTap: () => {logout()},
          //           ),
          //         ],
          //       ),
          /*ListTile(
            leading: Icon(Icons.book),
            title: Text('Gestion de fichas medicas'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context,
                  FadeRoute(page: const GestionFichasMedicas()))
            },
          ),*/
        ],
      ),
    );
  }

  final _authController = AuthController();

  final _opcionesMenuController = OpcionesMenuController();
  Future<void> obtenerOpcionesMenu() async {
    List<String> rolesObtenidos = await _authController.obtenerRolesUsuario();
    List opcionesMenuObtenidos =
        _opcionesMenuController.obtenerOpcionesMenuPorRol(rolesObtenidos);
    setState(() {
      roles = rolesObtenidos;
      opcionesMenu = opcionesMenuObtenidos;
    });
  }
}
