import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/modelos/HistoriasClinicas.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class ActualizarHistoriaClinica extends StatefulWidget {
  const ActualizarHistoriaClinica({super.key, required this.idHistoriaClinica});
  static const id = "actualizar-historia-clinica";
  final int idHistoriaClinica;
  @override
  State<ActualizarHistoriaClinica> createState() =>
      _ActualizarHistoriaClinicaState(idHistoriaClinica: idHistoriaClinica);
}

class _ActualizarHistoriaClinicaState extends State<ActualizarHistoriaClinica> {
  final int idHistoriaClinica;
  _ActualizarHistoriaClinicaState({required this.idHistoriaClinica});
  @override
  void initState() {
    super.initState();
    obtenerHistoriaClinica(idHistoriaClinica);
    obtenerPacientes();
    obtenerEspecialidades();
  }

  final Map<String, TextEditingController> controllers = {
    'idPaciente': TextEditingController(),
    'ciPaciente': TextEditingController(),
    'idEspecialidad': TextEditingController(),
    'nombreEspecialidad': TextEditingController(),
    'antecedentesPersonales': TextEditingController(),
    'antecedentesFamiliares': TextEditingController(),
    'antecedentesNoPatologicos': TextEditingController(),
    'antecedentesPatologicos': TextEditingController(),
    'antecedentesGinecoobstetricos': TextEditingController(),
    'condicionesActualesDeSaludOEnfermedad': TextEditingController(),
    'diagnosticoPresuntivo': TextEditingController(),
    'diagnosticosDiferenciales': TextEditingController(),
    'examenFisico': TextEditingController(),
    'examenFisicoEspecial': TextEditingController(),
    'propuestaBasicaDeConducta': TextEditingController(),
    'tratamiento': TextEditingController(),
  };
  HistoriaClinica? historiaClinica;
  HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  PacientesController pacientesController = PacientesController();
  EspecialidadesController especialidadesController =
      EspecialidadesController();
  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKeyForm1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      backgroundColor: Colores.color2,
      body: Form(
        key: formKeyForm1,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            formularioPrimeraPagina(context),
            formularioSegundaPagina(context)
          ],
        ),
      ),
    );
  }

  List<Paciente> pacientes = [];
  List<Especialidad> especialidades = [];

  void _onSelectItemPaciente(Paciente item) {
    setState(() {
      controllers['idPaciente']!.text = item.idUsuario.toString();
      controllers['ciPaciente']!.text = item.ci.toString();
    });
  }

  void _onSelectItemEspecialidad(Especialidad item) {
    setState(() {
      controllers['nombreEspecialidad']!.text = item.nombre.toString();
      controllers['idEspecialidad']!.text = item.idEspecialidad.toString();
    });
  }

  Widget formularioPrimeraPagina(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colores.color2,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Actualizar historia clínica',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 5),
            etiquetaInputDocumento('Paciente'),
            SizedBox(height: 5),
            inputListSuggestionsPacientes(context, pacientes,
                controllers["ciPaciente"], _onSelectItemPaciente),
            etiquetaInputDocumento('Especialidad'),
            SizedBox(height: 5),
            inputListSuggestionsEspecialidades(context, especialidades,
                controllers["nombreEspecialidad"], _onSelectItemEspecialidad),
            SizedBox(height: 5),
            etiquetaInputDocumento('Condiciones actuales estado de salud'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(context,
                controllers['condicionesActualesDeSaludOEnfermedad']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Antecedentes familiares'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['antecedentesFamiliares']!, ""),
            SizedBox(height: 5),
            // etiquetaInputDocumento('Antecedentes ginecoobstericos'),
            // SizedBox(height: 5),
            // inputFormFieldFormatoBorderBlack(
            //     context, controllers['antecedentesGinecoobstetricos']!, ""),
            // SizedBox(height: 5),
            etiquetaInputDocumento('Antecedentes no patológicos'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['antecedentesNoPatologicos']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Antecedentes patológicos'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['antecedentesPatologicos']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Antecedentes personales'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['antecedentesPersonales']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Diagnostico presuntivo'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['diagnosticoPresuntivo']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Diagnosticos diferenciales'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['diagnosticosDiferenciales']!, ""),
            SizedBox(height: 5),
            Row(
              children: [
                botonFormularioDocumento("Siguiente", () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget formularioSegundaPagina(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colores.color2,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            etiquetaInputDocumento('Examen físico general'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['examenFisico']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Examen físico especial'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['examenFisicoEspecial']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Propuesta basica de conducta'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['propuestaBasicaDeConducta']!, ""),
            SizedBox(height: 5),
            etiquetaInputDocumento('Tratamiento'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['tratamiento']!, ""),
            SizedBox(height: 5),
            Row(
              children: [
                botonFormularioDocumento("Anterior", () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }),
                botonFormularioDocumento("Enviar", () {
                  final formState1 = formKeyForm1.currentState;
                  if (formState1 != null && formState1.validate()) {
                    actualizarHistoriaClinica(context, controllers);
                  }
                })
              ],
            ),
            botonFormularioDocumento("Obtener pdf", () {
              obtenerPDFHistoriaClinica();
            })
          ],
        ),
      ),
    );
  }

  Future<void> obtenerHistoriaClinica(int idHistoriaClinica) async {
    try {
      final historiaClinicaResponse = await historiasClinicasController
          .obtenerHistoriaClinica(idHistoriaClinica);
      setState(() {
        historiaClinica = historiaClinicaResponse;
        establecerValoresEnControllersHistoriaClinica(historiaClinica);
      });
    } catch (e) {
      throw Exception('Error obtener examen complementario $e');
    }
  }

  void obtenerPacientes() async {
    try {
      List<Paciente> pacientesObtenidos =
          await pacientesController.obtenerPacientes();
      setState(() {
        pacientes = pacientesObtenidos;
      });
    } catch (e) {
      print('Error al cargar pacientes: $e');
    }
  }

  void obtenerEspecialidades() async {
    try {
      List<Especialidad> especialidadesObtenidos =
          await especialidadesController.obtenerEspecialidades();
      setState(() {
        especialidades = especialidadesObtenidos;
      });
    } catch (e) {
      print('Error al cargar especialidades: $e');
    }
  }

  void establecerValoresEnControllersHistoriaClinica(
      HistoriaClinica? historiaClinica) {
    if (historiaClinica != null) {
      setState(() {
        controllers['idHistoriaClinica']?.text = historiaClinica.id.toString();
        controllers['idPaciente']?.text = historiaClinica.idPaciente.toString();
        controllers['ciPaciente']?.text = historiaClinica.ciPropietario ?? '';
        controllers['idEspecialidad']?.text =
            historiaClinica.idEspecialidad.toString();
        controllers['nombreEspecialidad']?.text =
            historiaClinica.nombreEspecialidad ?? '';
        controllers['antecedentesPersonales']?.text =
            historiaClinica.antecedentesPersonales;
        controllers['antecedentesFamiliares']?.text =
            historiaClinica.antecedentesFamiliares;
        controllers['antecedentesNoPatologicos']?.text =
            historiaClinica.antecedentesNoPatologicos;
        controllers['antecedentesPatologicos']?.text =
            historiaClinica.antecedentesPatologicos;
        controllers['antecedentesGinecoobstetricos']?.text =
            historiaClinica.antecedentesGinecoobstetricos;
        controllers['condicionesActualesDeSaludOEnfermedad']?.text =
            historiaClinica.amnesis;
        controllers['diagnosticoPresuntivo']?.text =
            historiaClinica.diagnosticoPresuntivo;
        controllers['diagnosticosDiferenciales']?.text =
            historiaClinica.diagnosticosDiferenciales;
        controllers['examenFisico']?.text = historiaClinica.examenFisico;
        controllers['examenFisicoEspecial']?.text =
            historiaClinica.examenFisicoEspecial;
        controllers['propuestaBasicaDeConducta']?.text =
            historiaClinica.propuestaBasicaDeConducta;
        controllers['tratamiento']?.text = historiaClinica.tratamiento;
      });
    }
  }

  Future<void> actualizarHistoriaClinica(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await historiasClinicasController.actualizarHistoriaClinica(
          controllers, idHistoriaClinica);
      mostrarMensajeExito(context,
          titulo: "Actualizacion historia clinica exitoso");
    } catch (e) {
      mostrarMensajeError(context);
    }
  }

  void obtenerPDFHistoriaClinica() {
    try {
      Map<String, String> stringMap = {
        "id": historiaClinica!.id.toString(),
        "amnesis": historiaClinica!.amnesis.toString(),
        "antecedentesFamiliares":
            historiaClinica!.antecedentesFamiliares.toString(),
        "antecedentesGinecoobstetricos":
            historiaClinica!.antecedentesGinecoobstetricos.toString(),
        "antecedentesNoPatologicos":
            historiaClinica!.antecedentesNoPatologicos.toString(),
        "antecedentesPatologicos":
            historiaClinica!.antecedentesPatologicos.toString(),
        "antecedentesPersonales":
            historiaClinica!.antecedentesPersonales.toString(),
        "diagnosticoPresuntivo":
            historiaClinica!.diagnosticoPresuntivo.toString(),
        "diagnosticosDiferenciales":
            historiaClinica!.diagnosticosDiferenciales.toString(),
        "examenFisico": historiaClinica!.examenFisico.toString(),
        "examenFisicoEspecial":
            historiaClinica!.examenFisicoEspecial.toString(),
        "propuestaBasicaDeConducta":
            historiaClinica!.propuestaBasicaDeConducta.toString(),
        "tratamiento": historiaClinica!.tratamiento.toString(),
        "idEspecialidad": historiaClinica!.idEspecialidad.toString(),
        "idPaciente": historiaClinica!.idPaciente.toString(),
        "idMedico": historiaClinica!.idMedico.toString()
      };
      historiasClinicasController.obtenerPDFHistoriaClinica(stringMap);
    } catch (e) {
      print(e);
    }
  }
}
