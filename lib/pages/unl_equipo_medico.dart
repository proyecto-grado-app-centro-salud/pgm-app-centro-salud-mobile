import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/modelos/MedicoEspecialista.dart';
import 'package:proyecto_grado_flutter/pages/unl_detalle_medico_especialista.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:proyecto_grado_flutter/widgets/custom_text_litle.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class UnlEquipoMedico extends StatefulWidget {
  const UnlEquipoMedico({super.key});
  static const id = "unl_equipo_medico";
  @override
  State<UnlEquipoMedico> createState() => _UnlEquipoMedicoState();
}

class _UnlEquipoMedicoState extends State<UnlEquipoMedico> {
  List<MedicoEspecialista> equipoMedico = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextTitle(
                  label: '${LocaleData.equipoMedico.getString(context)}'),
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: equipoMedico.length,
                itemBuilder: (context, index) {
                  final medicoEspecialista = equipoMedico[index];
                  return cardMedico(context, medicoEspecialista, () {
                    Navigator.pushNamed(
                        context, UnlDetalleMedicoEspecialista.id,
                        arguments: medicoEspecialista.idUsuario);
                  });
                },
              ),
            ),
          ],
        ));
  }
}
