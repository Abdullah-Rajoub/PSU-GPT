import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  String label;
  Color color;
  Label({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle( fontSize: 9, color: color),
    );
  }
}
