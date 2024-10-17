import 'package:flutter/material.dart';

class CustomPrincipalTextTitle extends StatelessWidget {
  final String label;
  const CustomPrincipalTextTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(
          label,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
