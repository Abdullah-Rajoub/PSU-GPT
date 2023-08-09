import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class SibilingTextFields extends StatefulWidget {
  String label;
  String hint;
  var onChange;
  bool enabled;
  TextEditingController controllerOne;
  TextEditingController controllerTwo;
  SibilingTextFields(
      {required this.label,
      required this.hint,
      required this.onChange,
      required this.enabled,
      required this.controllerOne,
      required this.controllerTwo});

  @override
  State<SibilingTextFields> createState() => _SibilingTextFieldsState();
}

class _SibilingTextFieldsState extends State<SibilingTextFields> {
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controllerOne,
                    enabled: widget.enabled,
                    cursorColor: isDarkMood ? Colors.white : Colors.black,
                    style: TextStyle(
                        fontSize: 9,
                        color: isDarkMood ? Colors.white : Colors.black,
                        decoration: TextDecoration.none),
                    onChanged: widget.onChange,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isDarkMood
                                ? Colors.white
                                : AppColors.callToAction),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isDarkMood
                                ? Colors.white
                                : Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controllerTwo,
                    enabled: widget.enabled,
                    cursorColor: Colors.grey.shade400,
                    style: TextStyle(
                        fontSize: 9,
                        color: isDarkMood ? Colors.white : Colors.black,
                        decoration: TextDecoration.none),
                    onChanged: widget.onChange,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isDarkMood
                                ? Colors.white
                                : AppColors.callToAction),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isDarkMood
                                ? Colors.white
                                : Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
