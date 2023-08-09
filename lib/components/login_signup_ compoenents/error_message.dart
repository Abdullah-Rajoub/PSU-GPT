import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  String errorMessage;
  ErrorMessage({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: FractionallySizedBox(
        widthFactor: 0.65,
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              errorMessage,
              style: TextStyle(fontSize: 8, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
