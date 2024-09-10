import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class MensajeError extends StatelessWidget {
  final String titulo;
  final String detalle;
  const MensajeError({super.key, this.titulo="!Error",required this.detalle});

  @override
  Widget build(BuildContext context) {
    return  ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: titulo,
            text: detalle));
  }
}
