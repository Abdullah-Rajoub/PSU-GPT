import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class CustomerTextField extends StatefulWidget {
  String hint;
  var onChange;
  bool enabled;
  TextEditingController controller;
  CustomerTextField(
      {required this.hint,
      required this.onChange,
      required this.enabled,
      required this.controller});

  @override
  State<CustomerTextField> createState() => _CustomerTextFieldState();
}

class _CustomerTextFieldState extends State<CustomerTextField> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMood = Provider.of<AppSettings>(context).isDarkMood;
    return Container(
      height: 20,
      child: TextField(
        controller: widget.controller,
        enabled: widget.enabled,
        cursorColor: Colors.grey.shade400,
        style: TextStyle(
            fontSize: 10,
            color: isDarkMood ? Colors.black : Colors.grey.shade400,
            decoration: TextDecoration.none),
        onChanged: widget.onChange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isDarkMood ? AppColors.callToAction : Colors.white),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:
                    isDarkMood ? Colors.grey.shade500 : Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
