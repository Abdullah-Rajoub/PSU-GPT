import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class DrawerIconButton extends StatefulWidget {
  bool isSelected = false;
  IconData icon = Icons.e_mobiledata;
  bool isPressed = false;

  var onPressed;
  DrawerIconButton({required isSelected, required icon, required onPressed}) {
    this.isSelected = isSelected;
    this.icon = icon;
    this.onPressed = onPressed;
  }

  @override
  State<DrawerIconButton> createState() => _DrawerIconButtonState();
}

class _DrawerIconButtonState extends State<DrawerIconButton> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    var onPressed = widget.onPressed;
    Icon createdIcon = Icon(
      widget.icon,
      size: 18,
      color: isDarkMood
          ? widget.isSelected
              ? AppColors.LlightPurple
              : AppColors.accent
          : AppColors.Laccent,
    );
    return Consumer(builder: (context, child, allChat) {
      return GestureDetector(
        onTapUp: (t) {
          setState(() {
            widget.isPressed = false;
          });
        },
        onTapDown: (t) {
          onPressed();
          setState(() {
            widget.isPressed = true;
          });
        },
        child: createdIcon,
      );
    });
  }
}
