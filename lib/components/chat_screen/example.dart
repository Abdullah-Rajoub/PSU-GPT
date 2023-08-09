import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class Example extends StatefulWidget {
  String exampleText = "";
  Function _onPressed = (String) {};
  Example({required exampleText, required onPressed}) {
    this.exampleText = exampleText;
    this._onPressed = onPressed;
  }

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  var _isHovered = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      double fontSize;
      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        fontSize = 9;
      } else if (maxWidth >= 400) {
        fontSize = 8;
      } else {
        fontSize = 7;
      }
      print("inside the toggle selection max width is: $maxWidth");
      return GestureDetector(
        onTapCancel: () {
          print("okay");
          // Execute your function here
          setState(() {
            _isHovered = false;
          });
        },
        onTapDown: (t) {
          print("pressed");
          setState(() {
            _isHovered = true;
          });
        },
        onTapUp: (details) {
          print("okay");
          // Execute your function here
          setState(() {
            _isHovered = false;
          });
          widget._onPressed(widget.exampleText);
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDarkMood
                  ? _isHovered
                      ? AppColors.DdarkPurple
                      : Color(0xFF4A4E69)
                  : _isHovered
                      ? Colors.white
                      : Color(0xFFF0F0F0)),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              "\"" + widget.exampleText + "\"",
              style: TextStyle(
                  color: isDarkMood ? Colors.white : AppColors.Laccent,
                  fontSize: fontSize,
                  height: 1.3),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
