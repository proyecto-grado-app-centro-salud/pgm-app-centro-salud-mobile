import 'package:flutter/material.dart';

class CustomTextTitle extends StatelessWidget {
  final String label;
  const CustomTextTitle({super.key, required this.label});

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
            fontSize: 15,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
