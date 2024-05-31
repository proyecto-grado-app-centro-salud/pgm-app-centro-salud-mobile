import 'package:flutter/material.dart';
import 'package:proyecto_grado_flutter/pages/home_page.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app consultas medicas',
      theme: ThemeData(
        primarySwatch: Colores.color4Material,
      ),
      home: const HomePage(),
    );
  }
}
