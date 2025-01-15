import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegistrarResultadoExamenComplementario extends StatefulWidget {
  const RegistrarResultadoExamenComplementario({super.key});
  static const id = "registrar-resultado-examen-complementario";
  @override
  State<RegistrarResultadoExamenComplementario> createState() =>
      _RegistrarResultadoExamenComplementarioState();
}

class _RegistrarResultadoExamenComplementarioState
    extends State<RegistrarResultadoExamenComplementario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _resumenController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  PlatformFile? _selectedFile;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  Future<void> _enviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      FormData formData = FormData.fromMap({
        'data': {
          'titulo': _tituloController.text,
          'resumen': _resumenController.text,
          'fecha': _fechaController.text,
        },
        'file': await MultipartFile.fromFile(_selectedFile!.path!,
            filename: _selectedFile!.name),
      });

      try {
        Dio dio = Dio();
        Response response = await dio.post(
            'http://${dotenv.env["API_URL"]}/api/microservicio-examenes-complementarios/v1.0/resultados-examen-complementario',
            data: formData);

        if (response.statusCode == 200) {
          print('Formulario enviado correctamente');
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    }
  }

  void _cancelarEdicion() {
    setState(() {
      _tituloController.clear();
      _resumenController.clear();
      _fechaController.clear();
      _selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario Resultado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título del resultado'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _resumenController,
                decoration: InputDecoration(labelText: 'Resumen del resultado'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaController,
                decoration: InputDecoration(labelText: 'Fecha del resultado'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  return null;
                },
              ),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.attach_file),
                      SizedBox(width: 10),
                      Text(_selectedFile != null
                          ? _selectedFile!.name
                          : 'Seleccionar archivo'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _enviarFormulario,
                child: Text('Actualizar Resultado'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                ),
              ),
              ElevatedButton(
                onPressed: _cancelarEdicion,
                child: Text('Cancelar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  primary: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
