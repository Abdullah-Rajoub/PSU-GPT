import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/utility/constant/colors.dart';

class FeatureColumn extends StatefulWidget {
  List<Widget> widgets = [Container()];
  FeatureColumn({required widgets}) {
    this.widgets = widgets;
  }

  @override
  State<FeatureColumn> createState() => _FeatureColumnState();
}

class _FeatureColumnState extends State<FeatureColumn> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: DottedBorder(
        strokeCap: StrokeCap.round,
        strokeWidth: 0.3,
        color: AppColors.accent,
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        radius: Radius.circular(360),
        child: Column(
          children: [
            for (int i = 0; i < widget.widgets.length; i++)
              Column(
                children: [
                  widget.widgets[i],
                  if (i != widget.widgets.length - 1)
                    SizedBox(height: 20), // Adjust the height as needed
                ],
              ),
          ],
        ),
      ),
    );
  }
}
