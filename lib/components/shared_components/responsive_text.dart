import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  String text;
  TextStyle textStyle = TextStyle();
  ResponsiveText({required this.textStyle, required this.text});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        double fontSize;

        // Adjust the font size based on the device width
        if (maxWidth >= 600) {
          fontSize = 24.0;
        } else if (maxWidth >= 400) {
          fontSize = 18.0;
        } else {
          fontSize = 14.0;
        }

        return Center(
          child: Text(
            text,
            style: textStyle.copyWith(fontSize: fontSize),
          ),
        );
      },
    );
  }
}
