import 'package:flutter/material.dart';

class FeedbackTextField extends StatefulWidget {
  final String hintText;
  var textEditingController;
  var setHeightFactor;
  FeedbackTextField(
      {required this.textEditingController,
      required this.hintText,
      this.setHeightFactor});

  @override
  State<FeedbackTextField> createState() => _FeedbackTextFieldState();
}

class _FeedbackTextFieldState extends State<FeedbackTextField> {
  FocusNode _focusNode = FocusNode();
  void _onFocusChange() {
    print("It is focusing.");

    if (_focusNode.hasFocus) {
      // Function to execute when the text field is focused
      print('Text field focused 1');
      widget.setHeightFactor(0.9);
      // Execute your custom function here
    } else {
      // Function to execute when the text field is unfocused
      print('Text field unfocused');
      widget.setHeightFactor(0.4);
      // Execute your custom function here
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    print("inting 2");
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  double _inputHeight = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.multiline,
        focusNode: _focusNode,
        controller: widget.textEditingController,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        style: TextStyle(color: Colors.black, fontSize: 7),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignLabelWithHint:
              true, // Add this line to align hint text to the top left corner
        ),
      ),
    );
  }
}
