import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/modelos/MedicoEspecialista.dart';
import 'package:proyecto_grado_flutter/pages/unl_home_page.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/size.dart';
import 'package:proyecto_grado_flutter/util/transiciones.dart';
import 'package:proyecto_grado_flutter/widgets/image_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {
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

Widget cardInformacionDocumento(documento, tipoDocumento) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromRGBO(10, 74, 110, 1),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            campoFilaDocumento(tipoDocumento, documento.id.toString()),
            tipoDocumento.idHistoriaClinica ??
                campoFilaDocumento('idHistoriaClinica',
                    documento.idHistoriaClinica.toString()),
            campoFilaDocumento('Diagnóstico presuntivo',
                documento.diagnosticoPresuntivo.toString()),
            campoFilaDocumento(
                'Paciente', documento.pacientePropietario.toString()),
            campoFilaDocumento(
                'CI paciente', documento.ciPropietario.toString()),
            campoFilaDocumento(
                'Fecha creación', documento.createdAt.toString()),
            campoFilaDocumento(
                'Especialidad', documento.nombreEspecialidad.toString()),
            campoFilaDocumento(
                'Médico elaborador', documento.nombreMedico.toString()),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(width: 10),
            botonIcono('assets/iconos/editar.svg'),
            SizedBox(width: 10),
            botonIcono('assets/iconos/adelante.svg'),
          ],
        ),
      ],
    ),
  );
}

campoFilaDocumento(String campo, String valor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          campo,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          valor,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

Widget botonIcono(String ruta) {
  return Container(
    color: Colors.white,
    width: 22,
    height: 20,
    child: SvgPicture.asset(
      ruta,
      fit: BoxFit.fitWidth,
    ),
  );
}

Widget inputFormato(
    BuildContext context, TextEditingController controlador, String hint) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // frame1Fyh (1:3)
    margin: EdgeInsets.fromLTRB(3.5 * fem, 3.5 * fem, 3.5 * fem, 3.5 * fem),
    width: double.infinity,
    height: 40 * fem,
    padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(10 * fem),
      boxShadow: [
        BoxShadow(
          color: Color(0x3f000000),
          offset: Offset(0 * fem, 4 * fem),
          blurRadius: 2 * fem,
        ),
      ],
    ),
    child: TextField(
      decoration: InputDecoration(hintText: hint),
      controller: controlador,
    ),
  );
}

Widget inputFormatoBorderBlack(
    BuildContext context, TextEditingController controlador, String hint) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // frame1Fyh (1:3)
    margin: EdgeInsets.fromLTRB(3.5 * fem, 3.5 * fem, 3.5 * fem, 3.5 * fem),
    width: double.infinity,
    height: 40 * fem,
    padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(10 * fem),
      border: Border.all(color: Color(0xff000000)),
    ),
    child: TextField(
      decoration: InputDecoration(hintText: hint),
      controller: controlador,
    ),
  );
}

Widget inputFormatoTextoOculto(
    BuildContext context, TextEditingController controlador, String hint) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // frame1Fyh (1:3)
    margin: EdgeInsets.fromLTRB(3.5 * fem, 3.5 * fem, 3.5 * fem, 3.5 * fem),
    width: double.infinity,
    height: 40 * fem,
    padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(10 * fem),
      boxShadow: [
        BoxShadow(
          color: Color(0x3f000000),
          offset: Offset(0 * fem, 4 * fem),
          blurRadius: 2 * fem,
        ),
      ],
    ),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: hint,
          suffixIcon:
              GestureDetector(onTap: () {}, child: Icon(Icons.remove_red_eye))),
      controller: controlador,
    ),
  );
}

Widget botonInfo(
    BuildContext context, String tituloBoton, VoidCallback onPressed) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    margin: EdgeInsets.all(10),
    height: 32 * fem,
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100 * fem,
          minHeight: double.infinity,
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              primary: Color(0xff007bff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              child: Text(
                tituloBoton,
                /*style: GoogleFonts.poppins(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * ffem / fem,
                  color: Color(0xffffffff),
                ),*/
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget botonPrimario(
    BuildContext context, String tituloBoton, VoidCallback onPressed) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    margin: EdgeInsets.all(10),
    width: double.infinity,
    height: 32 * fem,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        primary: Color(0xff28AFB0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        child: Text(
          tituloBoton,
        ),
      ),
    ),
  );
}

Widget titulo(BuildContext context, String titulo) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return Container(
    // loginn4X (1:10)
    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.5 * fem, 0 * fem),
    child: Text(
      titulo,
      /*style: GoogleFonts.poppins(
        fontSize: 24 * ffem,
        fontWeight: FontWeight.w400,
        height: 1.5 * ffem / fem,
        color: Color(0xffffffff),
      ),*/
    ),
  );
}

Widget gestionDocumentosExpedienteClinico(
    BuildContext context,
    List documentos,
    String nombreDocumento,
    String urlImagenBanner,
    TextEditingController diagnosticoPresuntivo) {
  return Container(
    width: displayWidth(context),
    decoration: BoxDecoration(
      color: Colores.color2,
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: displayWidth(context),
            height: displayHeight(context) * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(urlImagenBanner),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 180,
          left: 0,
          child: Container(
            width: displayWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              color: Colores.color2,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Gestion ${nombreDocumento.toLowerCase()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colores.color5,
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Diagnóstico presuntivo',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colores.color5,
                    fontFamily: 'Inter',
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                inputFormatoBorderBlack(context, diagnosticoPresuntivo, ""),
                SizedBox(height: 10),
                botonPrimario(context, "Buscar", () {}),
                SizedBox(height: 10),
                // Text(
                //   'Búsqueda avanzada',
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //     color: Colores.color5,
                //     fontFamily: 'Inter',
                //     fontSize: 12,
                //   ),
                // ),
                // SizedBox(height: 10),
                botonPrimario(context,
                    'Registrar ${nombreDocumento.toLowerCase()}', () {}),
                SizedBox(height: 10),
                SingleChildScrollView(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: documentos.length,
                  itemBuilder: (context, index) {
                    return cardInformacionDocumento(
                        documentos[index], nombreDocumento);
                  },
                )),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cardEspecialidad(BuildContext context, Especialidad especialidad,
    [VoidCallback? metodoClick]) {
  metodoClick ??= () {};
  return Container(
    width: 220,
    margin: const EdgeInsets.only(right: 10),
    child: InkWell(
      onTap: metodoClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(
            width: 220,
            imageUrl: '',
          ),
          const SizedBox(height: 10),
          Text(
            especialidad.nombre,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, height: 1.5),
          ),
        ],
      ),
    ),
  );
}

Widget cardMedico(BuildContext context, MedicoEspecialista medico) {
  return Container(
    width: 220,
    margin: const EdgeInsets.only(right: 10),
    child: InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(
            width: 220,
            imageUrl: '',
          ),
          const SizedBox(height: 10),
          Text(
            "Dr. ${medico.nombres} ${medico.apellidoPaterno}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, height: 1.5),
          ),
        ],
      ),
    ),
  );
}
