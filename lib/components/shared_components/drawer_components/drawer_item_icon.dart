import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class DrawerItemIcon extends StatelessWidget {
  bool isSelected = false;
  IconData icon = Icons.e_mobiledata;
  var closeDrawer = () {};
  DrawerItemIcon({
    required isSelected,
    required icon,
    required closeDrawer,
  }) {
    this.isSelected = isSelected;
    this.icon = icon;
    this.closeDrawer = closeDrawer;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return Consumer<AllChats>(builder: (context, child, allChat) {
      return Icon(
        icon,
        color: isDarkMood
            ? isSelected
                ? AppColors.LlightPurple
                : Colors.white
            : AppColors.Laccent,
        size: 18,
      );
    });
  }
}
