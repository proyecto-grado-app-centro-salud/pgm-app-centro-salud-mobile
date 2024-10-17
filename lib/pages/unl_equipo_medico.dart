import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/controladores/MedicosController.dart';
import 'package:proyecto_grado_flutter/modelos/MedicoEspecialista.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_medico_especialista.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:proyecto_grado_flutter/widgets/custom_principal_text_title.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class UnlEquipoMedico extends StatefulWidget {
  const UnlEquipoMedico({super.key});
  static const id = "unl_equipo_medico";
  @override
  State<UnlEquipoMedico> createState() => _UnlEquipoMedicoState();
}

class _UnlEquipoMedicoState extends State<UnlEquipoMedico> {
  List<MedicoEspecialista> equipoMedico = [];
  final MedicosController medicosController = MedicosController();
  void initState() {
    super.initState();
    obtenerEquipoMedico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colores.color4,
        title: const Text("App consultas medicas"),
      ),
      body: Container(
          color: Colores.color2,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: CustomPrincipalTextTitle(
                    label: '${LocaleData.equipoMedico.getString(context)}'),
              ),
              Expanded(
                flex: 9,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: equipoMedico.length,
                  itemBuilder: (context, index) {
                    final medicoEspecialista = equipoMedico[index];
                    return cardMedico(context, medicoEspecialista, () {
                      print("Click " + medicoEspecialista.idUsuario.toString());
                      Navigator.pushNamed(
                          context, UnlDetalleMedicoEspecialista.id,
                          arguments: medicoEspecialista.idUsuario);
                    });
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<void> obtenerEquipoMedico() async {
    try {
      final equipoMedicoResponse =
          await medicosController.obtenerEquipoMedico();
      setState(() {
        equipoMedico = equipoMedicoResponse;
      });
    } catch (e) {}
  }
}
