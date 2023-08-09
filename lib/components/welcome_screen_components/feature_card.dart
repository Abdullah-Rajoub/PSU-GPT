import 'package:flutter/material.dart';

class FeatureCard extends StatefulWidget {
  Widget icon = Container();
  String text = "";
  Color color = Colors.transparent;
  double maxHeight;

  FeatureCard(
      {required this.icon,
      required this.text,
      required this.color,
      required this.maxHeight});

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  @override
  Widget build(BuildContext context) {
    var basicTextStyle = Theme.of(context).textTheme.bodyText1;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Constrains on size are saved here, so we can make the design responsive.

        double fontSize;
        double textHeight;
        // Adjust the font size based on the device width
        if (widget.maxHeight >= 750) {
          fontSize = 10;
          textHeight = 40;
        } else {
          fontSize = 8;
          textHeight = 30;
        }

        return Column(
          children: [
            widget.icon,
            Padding(
              padding: EdgeInsets.only(
                top: 5,
              ),
              child: Container(
                height: textHeight,
                child: Text(
                  widget.text,
                  style: basicTextStyle?.copyWith(
                      color: widget.color, fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
