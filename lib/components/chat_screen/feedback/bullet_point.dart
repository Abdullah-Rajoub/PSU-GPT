import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 5, // Adjust the width as per your requirement
      height: 5, // Adjust the height as per your requirement
      decoration: BoxDecoration(
        color: Color(0xFFc9e9b0), // Set the color to green
        shape: BoxShape.circle, // Make the container circular
      ),
      child: Container(
        width: 3, // Adjust the width as per your requirement
        height: 3, // Adjust the height as per your requirement
        decoration: BoxDecoration(
          color: Colors.white, // Set the color to green
          shape: BoxShape.circle, // Make the container circular
        ),
      ),
    );
    // Add any child widgets here if needed
  }
}
