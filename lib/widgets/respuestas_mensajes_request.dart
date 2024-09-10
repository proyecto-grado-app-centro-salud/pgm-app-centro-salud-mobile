import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class RespuestasMensajesRequest {
  static void showError(BuildContext context, String message,{String title="!Error"}) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: title,
        text: message,
      ),
    );
  }
}
