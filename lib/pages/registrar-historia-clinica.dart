import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/controladores/EspecialidadesController.dart';
import 'package:proyecto_grado_flutter/controladores/HistoriasClinicasController.dart';
import 'package:proyecto_grado_flutter/controladores/PacientesController.dart';
import 'package:proyecto_grado_flutter/modelos/Especialidades.dart';
import 'package:proyecto_grado_flutter/modelos/Paciente.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/widgets/new-drawer.dart';
import 'package:proyecto_grado_flutter/widgets/widgets-formato.dart';

class RegistrarHistoriaClinica extends StatefulWidget {
  const RegistrarHistoriaClinica({super.key});
  static const id = "registrar_historia_clinica";
  @override
  State<RegistrarHistoriaClinica> createState() =>
      _RegistrarHistoriaClinicaState();
}

class _RegistrarHistoriaClinicaState extends State<RegistrarHistoriaClinica> {
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

  final PacientesController pacientesController = PacientesController();
  final HistoriasClinicasController historiasClinicasController =
      HistoriasClinicasController();
  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKeyForm1 = GlobalKey<FormState>();
  @override
  void initState() {
    obtenerPacientes();
    obtenerEspecialidades();
    super.initState();
  }

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
        ));
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
                'Detalle de historia clínica 8349lkdjsa',
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
            etiquetaInputDocumento('Antecedentes ginecoobstericos'),
            SizedBox(height: 5),
            inputFormFieldFormatoBorderBlack(
                context, controllers['antecedentesGinecoobstetricos']!, ""),
            SizedBox(height: 5),
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
                    registrarHistoriaClinica(context, controllers);
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  int paginaActual = 0;

  void obtenerPacientes() async {
    try {
      List<Paciente> pacientesObtenidos =
          await PacientesController().obtenerPacientes();
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
          await EspecialidadesController().obtenerEspecialidades();
      setState(() {
        especialidades = especialidadesObtenidos;
      });
    } catch (e) {
      print('Error al cargar especialidades: $e');
    }
  }

  Future<void> registrarHistoriaClinica(BuildContext context,
      Map<String, TextEditingController> controllers) async {
    try {
      await historiasClinicasController.registrarHistoriaClinica(controllers);
      mostrarMensajeExito(context);
    } catch (e) {
      mostrarMensajeError(context);
    }
  }
}
