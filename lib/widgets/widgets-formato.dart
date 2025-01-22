import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/MedicoEspecialista.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/pages/detalle-historia-clinica.dart';
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

void mostrarMensajeExito(BuildContext context,
    {String titulo = "Accion exitosa", String texto = ""}) {
  ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: titulo,
          text: texto,
          confirmButtonText: "Aceptar",
          onConfirm: () {
            Navigator.pop(context);
          }));
}

void mostrarMensajeError(BuildContext context,
    {String titulo = "Error al realizar la accion", String texto = ""}) {
  ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: titulo,
          text: texto,
          confirmButtonText: "Aceptar",
          onConfirm: () {
            Navigator.pop(context);
          }));
}

Widget cardInformacionDocumento(BuildContext context, documento, tipoDocumento,
    [Function(dynamic)? metodoEditar, Function(dynamic)? metodoVerDetalle]) {
  return Container(
    margin: EdgeInsets.all(10),
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
            // tipoDocumento.idHistoriaClinica ??
            //     campoFilaDocumento('idHistoriaClinica',
            //         documento.idHistoriaClinica.toString()),
            campoFilaDocumento('Diagnóstico presuntivo',
                documento.diagnosticoPresuntivo.toString()),
            campoFilaDocumento(
                'Paciente', documento.pacientePropietario.toString()),
            campoFilaDocumento('CI paciente', documento.idPaciente.toString()),
            campoFilaDocumento(
                'Fecha', DateFormat('dd-MM-yyyy').format(documento.updatedAt)),
            campoFilaDocumento(
                'Especialidad', documento.nombreEspecialidad.toString()),
            campoFilaDocumento(
                'Médico elaborador', documento.nombreMedico.toString()),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ((metodoEditar != null)
                  ? GestureDetector(
                      onTap: () {
                        metodoEditar(documento.id);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.edit,
                              color: Colores.color1,
                              size: 18,
                            ),
                          ),
                          Text('Editar',
                              style: TextStyle(
                                  color: Colores.color1, fontSize: 10)),
                        ],
                      ),
                    )
                  : const SizedBox()),
              const SizedBox(),
              ((metodoVerDetalle != null)
                  ? GestureDetector(
                      onTap: () {
                        metodoVerDetalle(documento.id);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            child: Icon(Icons.arrow_circle_right_outlined,
                                color: Colores.color1, size: 18),
                          ),
                          Text('Ver detalle',
                              style: TextStyle(
                                  color: Colores.color1, fontSize: 10)),
                        ],
                      ),
                    )
                  : const SizedBox()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget listadoElementos(BuildContext context, elementos,
    Function(dynamic) contenidoElemento, Function(dynamic) opcionesElemento) {
  return Container(
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: elementos.length,
      itemBuilder: (context, index) {
        dynamic elemento = elementos[index];
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(10, 74, 110, 1),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenidoElemento(elemento),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: opcionesElemento(elemento)),
              ),
            ],
          ),
        );
      },
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
    BuildContext context, TextEditingController controlador, String hint,
    {bool readOnly = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0xff000000)),
    ),
    child: TextField(
      readOnly: readOnly,
      decoration: InputDecoration(hintText: hint),
      controller: controlador,
      minLines: 1,
      maxLines: null,
    ),
  );
}

// inputListSuggestionsPacientes(BuildContext context, List<Paciente> suggestions,
//     controller, void Function(Paciente item) onSelectItemPaciente) {
//   return TypeAheadField(
//     controller: controller,
//     suggestionsCallback: (pattern) async {
//       return suggestions
//           .where((suggestion) =>
//               suggestion.ci.toLowerCase().contains(pattern.toLowerCase()))
//           .toList();
//     },
//     itemBuilder: (context, suggestion) {
//       return ListTile(
//         title: Text(suggestion.ci),
//       );
//     },
//     onSelected: (suggestion) {
//       onSelectItemPaciente(suggestion);
//     },
//   );
// }
inputListSuggestionsPacientes(BuildContext context, List<Paciente> suggestions,
    controller, void Function(Paciente item) onSelectItemPaciente,
    {Function(String?) validate = _defaultValidator}) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      filled: true,
      fillColor: Colores.color1,
      labelText: 'Seleccione una paciente',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      return validate(value);
    },
    readOnly: true,
    onTap: () async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Seleccione una paciente'),
            content: TypeAheadField(
              controller: controller,
              suggestionsCallback: (pattern) async {
                return suggestions
                    .where((suggestion) => suggestion.ci
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.ci),
                );
              },
              onSelected: (suggestion) {
                onSelectItemPaciente(suggestion);
              },
            ),
          );
        },
      );
    },
  );
}

// inputListSuggestionsEspecialidades(
//     BuildContext context,
//     List<Especialidad> suggestions,
//     controller,
//     void Function(Especialidad item) onSelectItemEspecialidad) {
//   return TypeAheadField(
//     controller: controller,
//     suggestionsCallback: (pattern) async {
//       return suggestions
//           .where((suggestion) =>
//               suggestion.nombre.toLowerCase().contains(pattern.toLowerCase()))
//           .toList();
//     },
//     itemBuilder: (context, suggestion) {
//       return ListTile(
//         title: Text(suggestion.nombre),
//       );
//     },
//     onSelected: (suggestion) {
//       onSelectItemEspecialidad(suggestion);
//     },
//   );
// }

inputListSuggestionsEspecialidades(
    BuildContext context,
    List<Especialidad> suggestions,
    controller,
    void Function(Especialidad item) onSelectItemEspecialidad,
    {Function(String?) validate = _defaultValidator}) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      filled: true,
      fillColor: Colores.color1,
      labelText: 'Seleccione una especialidad',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      return validate(value);
    },
    readOnly: true,
    onTap: () async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Seleccione una especialidad'),
              content: TypeAheadField(
                controller: controller,
                suggestionsCallback: (pattern) async {
                  return suggestions
                      .where((suggestion) => suggestion.nombre
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.nombre),
                  );
                },
                onSelected: (suggestion) {
                  onSelectItemEspecialidad(suggestion);
                },
              ));
        },
      );
    },
  );
}

// inputListSuggestionsHistoriasClinicas(
//     BuildContext context,
//     List<HistoriaClinica> suggestions,
//     controller,
//     void Function(HistoriaClinica item) onSelectItemHistoriaClinica) {
//   return TypeAheadField(
//     controller: controller,
//     suggestionsCallback: (pattern) async {
//       return suggestions
//           .where((suggestion) => suggestion.diagnosticoPresuntivo
//               .toLowerCase()
//               .contains(pattern.toLowerCase()))
//           .toList();
//     },
//     itemBuilder: (context, suggestion) {
//       return ListTile(
//         title: Text(suggestion.diagnosticoPresuntivo),
//       );
//     },
//     onSelected: (suggestion) {
//       onSelectItemHistoriaClinica(suggestion);
//     },
//   );
// }

inputListSuggestionsHistoriasClinicas(
    BuildContext context,
    List<HistoriaClinica> suggestions,
    controller,
    void Function(HistoriaClinica item) onSelectItemHistoriaClinica,
    {Function(String?) validate = _defaultValidator}) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      filled: true,
      fillColor: Colores.color1,
      labelText: 'Seleccione una historia clinica',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      return validate(value);
    },
    readOnly: true,
    onTap: () async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Seleccione una historia clinica'),
              content: TypeAheadField(
                controller: controller,
                suggestionsCallback: (pattern) async {
                  return suggestions
                      .where((suggestion) => suggestion.diagnosticoPresuntivo
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.diagnosticoPresuntivo),
                  );
                },
                onSelected: (suggestion) {
                  onSelectItemHistoriaClinica(suggestion);
                },
              ));
        },
      );
    },
  );
}

Widget inputFormFieldFormatoBorderBlack(
    BuildContext context, TextEditingController controlador, String hint,
    {Function(String?) validate = _defaultValidator}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(0),
    margin: EdgeInsets.all(0),
    // decoration: BoxDecoration(
    //   color: Color(0xffffffff),
    //   borderRadius: BorderRadius.circular(10),
    //   border: Border.all(color: Color(0xff000000)),
    // ),
    child: TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colores.color1,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      controller: controlador,
      minLines: 1,
      maxLines: null,
      validator: (value) {
        return validate(value);
      },
    ),
  );
}
// Widget inputFormFieldObscureFormatoBorderBlack(
//     BuildContext context, TextEditingController controlador, String hint,
//     {Function(String?) validate = _defaultValidator,bool visible=false}) {
//   return Container(
//     width: double.infinity,
//     padding: EdgeInsets.all(0),
//     margin: EdgeInsets.all(0),
//     child: TextFormField(

//       obscureText: visible,
//       decoration: InputDecoration(
//           hintText: hint,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//           ),
//       controller: controlador,
//       minLines: 1,
//       maxLines: null,
//       validator: (value) {
//         return validate(value);
//       },
//     ),
//   );
// }

String? _defaultValidator(String? value) {
  return null;
}

Widget inputDateFormFieldFormatoBorderBlack(
    BuildContext context,
    TextEditingController textEditingController,
    String hint,
    void Function(String date) onSelectedDate,
    [DateTime? firstDate,
    DateTime? lastDate]) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0xff000000)),
    ),
    child: TextFormField(
      validator: _defaultValidator,
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colores.color1,
        labelText: 'Fecha',
        hintText: 'Selecciona una fecha',
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () =>
              _selectDate(context, onSelectedDate, firstDate, lastDate),
        ),
      ),
      readOnly: true,
    ),
  );
}

Future<void> _selectDate(
    BuildContext context, void Function(String date) onSelectedDate,
    [DateTime? firstDate, DateTime? lastDate]) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: (firstDate == null) ? DateTime.now() : firstDate,
    firstDate: (firstDate == null) ? DateTime(2000) : firstDate,
    lastDate: (lastDate == null) ? DateTime(2101) : lastDate,
  );
  if (picked != null && picked != DateTime.now()) {
    onSelectedDate("${picked.toLocal()}".split(' ')[0]);
  }
}

Widget inputFormatoTextoOculto(
    BuildContext context, TextEditingController controlador, String hint) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  bool visible = false;
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
      obscureText: visible,
      decoration: InputDecoration(
          hintText: hint,
          suffixIcon: GestureDetector(
              child: GestureDetector(child: Icon(Icons.remove_red_eye)))),
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

// Widget obtenerVistaMisDocumentosExpedienteClinico(
//     BuildContext context,
//     List documentos,
//     String nombreDocumento,
//     String urlImagenBanner,
//     TextEditingController diagnosticoPresuntivo,
//     [Function()? metodoBuscar,
//     Function(dynamic)? metodoVerDetalle]) {
//   return Container(
//     width: displayWidth(context),
//     decoration: BoxDecoration(
//       color: Colores.color2,
//     ),
//     child: Stack(
//       children: <Widget>[
//         Positioned(
//           top: 0,
//           left: 0,
//           child: Container(
//             width: displayWidth(context),
//             height: displayHeight(context) * 0.3,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(urlImagenBanner),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 180,
//           left: 0,
//           bottom: 10,
//           right: 10,
//           child: SingleChildScrollView(
//             child: Container(
//               width: displayWidth(context),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                   bottomLeft: Radius.circular(0),
//                   bottomRight: Radius.circular(0),
//                 ),
//                 color: Colores.color2,
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Center(
//                     child: Text(
//                       'Mis ${nombreDocumento.toLowerCase()}s',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colores.color5,
//                         fontFamily: 'Inter',
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   obtenerListadoDocumentosClinicos(
//                       context,
//                       nombreDocumento,
//                       diagnosticoPresuntivo,
//                       documentos,
//                       metodoBuscar,
//                       null,
//                       metodoVerDetalle)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget gestionDocumentosExpedienteClinico(
//     BuildContext context,
//     List documentos,
//     String nombreDocumento,
//     String urlImagenBanner,
//     TextEditingController diagnosticoPresuntivo,
//     [VoidCallback? metodoBuscar,
//     VoidCallback? metodoRegistrar,
//     Function(dynamic)? metodoEditar,
//     Function(dynamic)? metodoVerDetalle]) {
//   metodoRegistrar ??= () {};
//   return Container(
//     width: displayWidth(context),
//     decoration: BoxDecoration(
//       color: Colores.color2,
//     ),
//     child: Stack(
//       children: <Widget>[
//         Positioned(
//           top: 0,
//           left: 0,
//           child: Container(
//             width: displayWidth(context),
//             height: displayHeight(context) * 0.3,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(urlImagenBanner),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 180,
//           left: 0,
//           bottom: 0,
//           right: 0,
//           child: SingleChildScrollView(
//             child: Container(
//               width: displayWidth(context),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                   bottomLeft: Radius.circular(0),
//                   bottomRight: Radius.circular(0),
//                 ),
//                 color: Colores.color2,
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Center(
//                     child: Text(
//                       'Gestion ${nombreDocumento.toLowerCase()}',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colores.color5,
//                         fontFamily: 'Inter',
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   botonPrimario(
//                       context,
//                       'Registrar ${nombreDocumento.toLowerCase()}',
//                       metodoRegistrar),
//                   SizedBox(height: 5),
//                   obtenerListadoDocumentosClinicos(
//                       context,
//                       nombreDocumento,
//                       diagnosticoPresuntivo,
//                       documentos,
//                       metodoBuscar,
//                       metodoEditar,
//                       metodoVerDetalle)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
Widget obtenerVistaMisDocumentosExpedienteClinico(
    BuildContext context,
    List documentos,
    String nombreDocumento,
    String urlImagenBanner,
    Map<String, TextEditingController> parametros,
    [VoidCallback? metodoBuscar,
    Function(dynamic)? metodoVerDetalle]) {
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
          bottom: 0,
          right: 0,
          child: SingleChildScrollView(
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
                      'Mis documentos: $nombreDocumento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colores.color5,
                        fontFamily: 'Inter',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Column(children: [
                      Text(
                        'Diagnóstico presuntivo',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["diagnosticoPresuntivo"]!, ""),
                      SizedBox(height: 10),
                      Text(
                        'Nombre medico',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["nombreMedico"]!, ""),
                      SizedBox(height: 10),
                      Text(
                        'Nombre especialidad',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["nombreEspecialidad"]!, ""),
                      SizedBox(height: 10),
                      inputDateFormFieldFormatoBorderBlack(
                          context, parametros["fechaInicio"]!, "",
                          (String date) {
                        parametros["fechaInicio"]!.text = date;
                      }),
                      inputDateFormFieldFormatoBorderBlack(
                          context, parametros["fechaFin"]!, "", (String date) {
                        parametros["fechaFin"]!.text = date;
                      }),
                      botonPrimario(context, "Buscar", metodoBuscar!),
                      SizedBox(height: 10),
                    ]),
                  ),
                  Text(
                      "Numero de documentos encontrados ${parametros['numeroDocumentos']!.text}"),
                  obtenerListadoDocumentosClinicos(
                      context,
                      nombreDocumento,
                      TextEditingController(),
                      documentos,
                      () {},
                      null, (idDocumento) {
                    (metodoVerDetalle != null)
                        ? metodoVerDetalle(idDocumento)
                        : null;
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () {
                          int numeroPagina =
                              int.parse(parametros["numeroPagina"]!.text);
                          if (numeroPagina > 0) {
                            numeroPagina--;
                            parametros["numeroPagina"]!.text = '$numeroPagina';
                            metodoBuscar();
                          }
                        },
                        child: Text('Anterior',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () {
                          int numeroPagina =
                              int.parse(parametros["numeroPagina"]!.text);
                          numeroPagina++;
                          parametros["numeroPagina"]!.text = '$numeroPagina';
                          metodoBuscar();
                        },
                        child: Text('Siguiente',
                            style:
                                TextStyle(color: Colors.black)), // Texto negro
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gestionDocumentosExpedienteClinico(
    BuildContext context,
    List documentos,
    String nombreDocumento,
    String urlImagenBanner,
    Map<String, TextEditingController> parametros,
    [VoidCallback? metodoBuscar,
    VoidCallback? metodoRegistrar,
    Function(dynamic)? metodoEditar,
    Function(dynamic)? metodoVerDetalle]) {
  metodoRegistrar ??= () {};
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
          bottom: 0,
          right: 0,
          child: SingleChildScrollView(
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
                      'Gestion documentos: $nombreDocumento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colores.color5,
                        fontFamily: 'Inter',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  botonPrimario(
                      context, 'Registrar ${nombreDocumento.toLowerCase()}',
                      () {
                    if (metodoRegistrar != null) {
                      metodoRegistrar();
                    }
                  }),
                  SizedBox(height: 5),
                  Container(
                    child: Column(children: [
                      Text(
                        'Diagnóstico presuntivo',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["diagnosticoPresuntivo"]!, ""),
                      SizedBox(height: 10),
                      Text(
                        'CI propietario',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["ciPaciente"]!, ""),
                      SizedBox(height: 10),
                      Text(
                        'Nombre medico',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["nombreMedico"]!, ""),
                      SizedBox(height: 10),
                      Text(
                        'Nombre especialidad',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colores.color5,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      inputFormatoBorderBlack(
                          context, parametros["nombreEspecialidad"]!, ""),
                      SizedBox(height: 10),
                      inputDateFormFieldFormatoBorderBlack(
                          context, parametros["fechaInicio"]!, "",
                          (String date) {
                        parametros["fechaInicio"]!.text = date;
                      }),
                      inputDateFormFieldFormatoBorderBlack(
                          context, parametros["fechaFin"]!, "", (String date) {
                        parametros["fechaFin"]!.text = date;
                      }),
                      botonPrimario(context, "Buscar", metodoBuscar!),
                      SizedBox(height: 10),
                    ]),
                  ),
                  Text(
                      "Numero de documentos encontrados ${parametros['numeroDocumentos']!.text}"),
                  obtenerListadoDocumentosClinicos(
                      context,
                      nombreDocumento,
                      TextEditingController(),
                      documentos,
                      () {}, (idDocumento) {
                    (metodoEditar != null) ? metodoEditar(idDocumento) : null;
                  }, (idDocumento) {
                    (metodoVerDetalle != null)
                        ? metodoVerDetalle(idDocumento)
                        : null;
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () {
                          int numeroPagina =
                              int.parse(parametros["numeroPagina"]!.text);
                          if (numeroPagina > 0) {
                            numeroPagina--;
                            parametros["numeroPagina"]!.text = '$numeroPagina';
                            metodoBuscar();
                          }
                        },
                        child: Text('Anterior',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () {
                          int numeroPagina =
                              int.parse(parametros["numeroPagina"]!.text);
                          numeroPagina++;
                          parametros["numeroPagina"]!.text = '$numeroPagina';
                          metodoBuscar();
                        },
                        child: Text('Siguiente',
                            style:
                                TextStyle(color: Colors.black)), // Texto negro
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget obtenerListadoDocumentosClinicos(
    BuildContext context,
    String nombreDocumento,
    TextEditingController diagnosticoPresuntivo,
    List documentos,
    [Function()? metodoBuscar,
    Function(dynamic)? metodoEditar,
    Function(dynamic)? metodoVerDetalle]) {
  metodoBuscar ??= () {};
  return Column(
    children: [
      //   Text(
      //     'Diagnóstico presuntivo',
      //     textAlign: TextAlign.start,
      //     style: TextStyle(
      //       color: Colores.color5,
      //       fontFamily: 'Inter',
      //       fontSize: 12,
      //     ),
      //   ),
      //   SizedBox(height: 5),
      //   inputFormatoBorderBlack(context, diagnosticoPresuntivo, ""),
      //   SizedBox(height: 10),
      //   botonPrimario(context, "Buscar", metodoBuscar),
      //   SizedBox(height: 10),
      Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: documentos.length,
          itemBuilder: (context, index) {
            return cardInformacionDocumento(context, documentos[index],
                nombreDocumento, metodoEditar, metodoVerDetalle);
          },
        ),
      ),
    ],
  );
}

Widget cardEspecialidad(BuildContext context, Especialidad especialidad,
    [VoidCallback? metodoClick, double anchoCard = 220]) {
  metodoClick ??= () {};
  return Container(
    width: anchoCard,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colores.color4),
    child: InkWell(
      onTap: metodoClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(
            width: double.infinity,
            imageUrl: especialidad.imagenes[0].url,
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                especialidad.nombre,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: Colores.color1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cardMedico(BuildContext context, MedicoEspecialista medico,
    [VoidCallback? metodoClick]) {
  metodoClick ??= () {};
  return GestureDetector(
    onTap: metodoClick,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 1),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(medico.imagenes[0].url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '${medico.nombres} ${medico.apellidoPaterno}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Text(
              '${medico.email}',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Inter',
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget cardCaracteristica(String label) {
  return Container(
    width: 140,
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colores.color4,
    ),
    child: Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colores.color1,
          fontFamily: 'Inter',
          fontSize: 12,
          letterSpacing: 0,
          fontWeight: FontWeight.normal,
          height: 1,
        ),
      ),
    ),
  );
}

Widget etiquetaInputDocumento(String label) {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: Colores.color5,
            fontFamily: 'Inter',
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
        ),
        SizedBox(width: 5),
        iconoVerDetalleCampoDocumento(),
      ],
    ),
  );
}

Widget iconoVerDetalleCampoDocumento() {
  return Icon(Icons.remove_red_eye);
}

Widget obtenerIconoCarga(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget botonFormularioDocumento(String label, [VoidCallback? metodoClick]) {
  metodoClick ??= () {};
  return GestureDetector(
      onTap: metodoClick,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colores.color3,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(label, style: TextStyle(color: Colores.color1))));
}

Widget opcionMenu(
    BuildContext context, String titulo, VoidCallback metodoRedirecion) {
  return Center(
      child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colores.color4, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () => {metodoRedirecion()},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )));
}
