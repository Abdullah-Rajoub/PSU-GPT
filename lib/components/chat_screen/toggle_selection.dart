import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSelector extends StatefulWidget {
  @override
  _ToggleSelectorState createState() => _ToggleSelectorState();
}

class _ToggleSelectorState extends State<ToggleSelector> {
  int _selectedIndex = 0;

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(60),
    //     color: AppColors.verydarkPurple,
    //   ),
    //   width: 275,
    //   height: 55,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       ToggleOption(
    //         icon: Icons.speed,
    //         text: 'PSU - GPT',
    //         isSelected: _selectedIndex == 0,
    //         onTap: () => _onToggle(0),
    //       ),
    //       SizedBox(width: 16),
    //       ToggleOption(
    //         icon: Icons.star_border_purple500_sharp,
    //         text: 'PSU - LLaMA',
    //         isSelected: _selectedIndex == 1,
    //         onTap: () => _onToggle(1),
    //       ),
    //     ],
    //   ),
    // );
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      double minWidth;
      double minHeight;
      double textSize;
      double iconSize;

      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        minWidth = 120;
        iconSize = 17;
        textSize = 14;
        minHeight = 45;
      } else if (maxWidth >= 400) {
        minWidth = 100;
        iconSize = 16;
        minHeight = 25;
        textSize = 9;
      } else {
        iconSize = 15;
        textSize = 8;
        minWidth = 90;
        minHeight = 20;
      }
      print("inside the toggle selection max width is: $maxWidth");
      return ToggleSwitch(
        fontSize: textSize,
        iconSize: iconSize,
        minWidth: minWidth,
        icons: [Icons.speed, Icons.star_border_purple500_sharp],
        minHeight: minHeight,
        cornerRadius: 20.0,
        animationDuration: 500,
        activeBgColors: [
          [isDarkMood ? AppColors.DlightPurple : AppColors.LAccentPurple],
          [isDarkMood ? AppColors.DlightPurple : AppColors.LAccentPurple]
        ],
        activeFgColor:
            isDarkMood ? AppColors.LlightPurple : AppColors.greyContainers,
        inactiveBgColor:
            isDarkMood ? AppColors.verydarkPurple : AppColors.greyContainers,
        inactiveFgColor:
            isDarkMood ? AppColors.accent : AppColors.LAccentPurple,
        initialLabelIndex: 1,
        totalSwitches: 2,
        labels: ['PSU-GPT', 'PSU-LLaMA'],
        radiusStyle: true,
        onToggle: (index) {
          print('switched to: $index');
        },
      );
    });
  }
}
