import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class CustomerTextField extends StatefulWidget {
  String label;
  String hint;
  var onChange;
  bool enabled;
  bool isHidden;
  TextEditingController controller;
  CustomerTextField(
      {required this.label,
      required this.hint,
      required this.onChange,
      required this.enabled,
      required this.controller,
      required this.isHidden});

  @override
  State<CustomerTextField> createState() => _CustomerTextFieldState();
}

bool _obscureText = true;

class _CustomerTextFieldState extends State<CustomerTextField> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMood = Provider.of<AppSettings>(context).isDarkMood;
    return FractionallySizedBox(
      widthFactor: 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                fontSize: 9,
                color: isDarkMood ? Colors.white : Colors.grey.shade600),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            height: 24,
            child: TextField(
              obscureText: widget.isHidden && _obscureText,
              controller: widget.controller,
              enabled: widget.enabled,
              cursorColor: Colors.grey.shade400,
              style: TextStyle(
                  fontSize: 9,
                  color: isDarkMood ? Colors.white : Colors.black87,
                  decoration: TextDecoration.none),
              decoration: InputDecoration(
                suffixIcon: widget.isHidden
                    ? IconButton(
                        icon: _obscureText
                            ? Icon(
                                Icons.visibility_off,
                                size: 8,
                                color: isDarkMood ? Colors.white : Colors.grey,
                              )
                            : Icon(
                                Icons.visibility,
                                size: 8,
                                color: isDarkMood ? Colors.white : Colors.grey,
                              ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : Text(""),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          isDarkMood ? Colors.white : AppColors.callToAction),
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkMood ? Colors.white : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
