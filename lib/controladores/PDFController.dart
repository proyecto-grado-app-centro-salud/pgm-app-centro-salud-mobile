import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';

class PDFController {
  Future<void> descargarPDF(String nombre, Uint8List bytes) async {
    try {
      await _requestPermission();
      const downloadsFolderPath = '/storage/emulated/0/Download';
      Directory downloadDir = Directory(downloadsFolderPath);
      // final dir = await getExternalStorageDirectory();
      // final downloadDir = Directory('${dir?.path}/Download');

      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      final file = File('${downloadDir.path}/$nombre.pdf');
      await file.writeAsBytes(bytes);

      print("PDF descargado en: ${file.path}");

      await _mostrarNotificacion(file.path);
    } catch (e) {
      print("Error al descargar el PDF: $e");
    }
  }

  Future<void> _requestPermission() async {
    Permission.manageExternalStorage.request();
    Permission.storage.request();
    if (await Permission.manageExternalStorage.request().isGranted) {
      print("Permiso de almacenamiento concedido.");
    } else {
      print("Permiso denegado");
      await Permission.manageExternalStorage.request();
    }
    // var status = await Permission.storage.status;
    // if (status != PermissionStatus.granted) {
    //   status = await Permission.storage.request();
    // }
  }

  Future<void> _mostrarNotificacion(String filePath) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          // _abrirArchivo(response.payload!);
          _createAndOpenFile();
        }
      },
    );

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'descarga_pdf',
      'PDF Descargado',
      channelDescription: 'Notificación cuando un PDF se haya descargado',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      '¡Descarga Completa!',
      'El PDF se encuentra en la carpeta descargas de su dispositivo',
      notificationDetails,
      payload: filePath,
    );
  }

  // Future<void> _abrirArchivo(String filePath) async {
  //   try {
  //     final file = File(filePath);
  //     await _requestPermission();
  //     if (await file.exists()) {
  //       // final fileUri = Uri.parse(
  //       //     'content://com.example.proyecto_grado_flutter.fileprovider/Download/HistoriaClinica.pdf');
  //       // final Uri fileUri = Uri.parse("file://" + filePath);
  //       final String fileName =
  //           file.uri.pathSegments.last; // Nombre del archivo
  //       final Uri fileUri = Uri.parse(
  //           'content://com.example.proyecto_grado_flutter.fileprovider/Download/$fileName');
  //       if (await canLaunch(fileUri.toString())) {
  //         await launchUrl(fileUri);
  //       } else {
  //         print("No se puede abrir el archivo.");
  //       }
  //     } else {
  //       print("El archivo no existe en la ruta proporcionada.");
  //     }
  //   } on PlatformException catch (e) {
  //     print("Error al intentar abrir el archivo: $e");
  //   }
  // }
  Future<void> _createAndOpenFile() async {
    try {
      // Obtener el directorio de descargas
      // final directory = await getExternalStorageDirectory();
      // final downloadDirectory = Directory('${directory?.path}/Download');

      // // Crear la carpeta de descargas si no existe
      // if (!await downloadDirectory.exists()) {
      //   await downloadDirectory.create(recursive: true);
      // }

      // // Crear un archivo nuevo en la carpeta de descargas
      // final filePath = '${downloadDirectory.path}/NotaEvolucion.pdf';
      // final newFile = File(filePath);

      // // Escribir algo de contenido en el archivo (puedes personalizarlo)
      // await newFile.writeAsString('Este es un nuevo archivo PDF o de texto');

      // // Verificamos si el archivo fue creado correctamente
      // print("Archivo creado en: $filePath");

      // // Abrir el archivo utilizando open_file
      // final result = await OpenFile.open(filePath);
      // if (result.type == ResultType.done) {
      //   print("Archivo abierto con éxito.");
      // } else {
      //   print("Error al abrir el archivo: ${result.message}");
      // }
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withReadStream: true,
        allowMultiple: false,
        type: FileType.any,
      );

      if (result != null) {
        // Obtener la ruta del archivo
        String filePath = result.files.single.path!;
        // Uri contentUri = Uri.parse(
        //     'content://com.example.proyecto_grado_flutter.fileprovider' +
        //         filePath);
        Uri contentUri = Uri.parse(
            "com.example.proyecto_grado_flutter/data/user/0/Download/NotaEvolucion.pdf");

        // Intentar abrir el archivo con url_launcher
        await _openFile(contentUri.toString());
      }
    } catch (e) {
      print("Error al crear o abrir el archivo: $e");
    }
  }

  Future<void> _openFile(String contentUri) async {
    try {
      // Usar url_launcher para abrir el archivo usando content://
      if (await canLaunch(contentUri)) {
        await launch(contentUri);
      } else {
        print('No se puede abrir el archivo.');
      }
    } catch (e) {
      print('Error al abrir el archivo: $e');
    }
  }

  Future<void> _openDownloadsFolder() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withReadStream: true,
      allowMultiple: false,
      type: FileType.any,
      initialDirectory: '/storage/emulated/0/Download',
    );

    if (result != null) {
      print("Archivo seleccionado: ${result.files.single.path}");
      String filePath = result.files.single.path!;
      _launchFile(filePath);
      // final response = await OpenFile.open(filePath);
    } else {
      print("No se seleccionó ningún archivo.");
    }
  }

  Future<void> _launchFile(String filePath) async {
    if (await canLaunch(filePath)) {
      await launch(filePath);
    } else {
      print("No se pudo abrir el archivo.");
    }
  }
}
