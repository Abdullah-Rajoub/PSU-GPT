import 'package:flutter/material.dart';

class FeedbackLogo extends StatelessWidget {
  bool isPositiveFeedback;
  FeedbackLogo({required this.isPositiveFeedback});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30, // Adjust the width as per your requirement
      height: 30, // Adjust the height as per your requirement
      decoration: BoxDecoration(
        color: isPositiveFeedback
            ? Color(0xFFc9e9b0)
            : Color(0xFFeab0b0), // Set the color to green
        shape: BoxShape.circle, // Make the container circular
      ),
      child: Icon(
        isPositiveFeedback ? Icons.thumb_up_off_alt : Icons.thumb_down_off_alt,
        size: 17,
        color: isPositiveFeedback ? Color(0xA6315A00) : Color(0xFFc51b1b),
      ),
      // Add any child widgets here if needed
    );
  }
}
