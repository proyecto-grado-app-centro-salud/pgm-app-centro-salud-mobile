


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/colores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Colores.color4),
        title: Text("app consultas medicas"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const Text(
              'Especialidades',
            ),
            
          ],
        ),
      ),
    );
  }
}
