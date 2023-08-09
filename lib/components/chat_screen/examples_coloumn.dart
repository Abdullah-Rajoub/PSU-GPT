import 'package:flutter/material.dart';

import 'example.dart';

class ExamplesColoumn extends StatefulWidget {
  var examples;
  var onExamplePress;
  ExamplesColoumn({required examples, required onExamplePress}) {
    this.examples = examples;
    this.onExamplePress = onExamplePress;
  }

  @override
  State<ExamplesColoumn> createState() => _ExamplesColoumnState();
}

class _ExamplesColoumnState extends State<ExamplesColoumn> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.examples.length; i++)
          Column(
            children: [
              Example(
                exampleText: widget.examples[i],
                onPressed: widget.onExamplePress,
              ),
              if (i != widget.examples.length - 1)
                SizedBox(height: 20), // Adjust the height as needed
            ],
          ),
      ],
    );
  }
}
