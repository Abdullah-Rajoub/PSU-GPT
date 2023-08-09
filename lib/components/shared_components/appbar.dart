import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:gpt_clone/utility/constant/constants.dart';
import 'package:provider/provider.dart';

import '../../translations/locale_keys.g.dart';

class CustomerAppBar extends AppBar {
  var isDarkMood = true;
  CustomerAppBar() {}

  @override
  State<CustomerAppBar> createState() => _CustomerAppBarState();
}

class _CustomerAppBarState extends State<CustomerAppBar> {
  void changeLocale() async {
    print(context.toString());
    if (context.locale.toString() == "ar") {
      await context.setLocale(Locale('en'));
    } else {
      await context.setLocale(Locale('ar'));
    }
  }

  void changeAppMood() {
    Provider.of<AppSettings>(context, listen: false).changeAppMode();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    var realContext = context;
    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      double iconsSize;
      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        iconsSize = 24;
      } else if (maxWidth >= 400) {
        iconsSize = 22;
      } else {
        iconsSize = 20;
      }
      var sunIcon = SvgPicture.asset(
        'assets/icons/sun.svg', // Replace this with the path to your globe icon SVG file
        width: iconsSize,
        height: iconsSize,
        color: isDarkMood ? Colors.white : AppColors.Laccent,
      );
      var moonIcon = SvgPicture.asset(
        'assets/icons/moon.svg', // Replace this with the path to your globe icon SVG file
        width: iconsSize,
        height: iconsSize,
        color: isDarkMood ? Colors.white : AppColors.Laccent,
      );
      return AppBar(
        iconTheme:
            IconThemeData(color: isDarkMood ? Colors.white : AppColors.Laccent),
        backgroundColor:
            isDarkMood ? AppColors.verydarkPurple : AppColors.greyContainers,
        centerTitle: true,
        title: Container(
          width: 130,
          child: Row(
            children: [
              Hero(
                  tag: Constants.logoTag,
                  child: isDarkMood
                      ? Image.asset(
                          'assets/icons/RIOTUlogo.png',
                          filterQuality: FilterQuality.high,
                          height: 12,
                        )
                      : SvgPicture.asset(
                          "assets/icons/RIOTULogoBlack.svg",
                          width: 12,
                          height: 12,
                        )),
              SizedBox(
                width: 5,
              ),
              Hero(
                child: Text(
                  LocaleKeys.appName.tr(),
                  style: TextStyle(
                      fontSize: 12,
                      color: isDarkMood ? Colors.white : AppColors.Laccent),
                ),
                tag: Constants.titleTag,
              )
            ],
          ),
        ),
        actions: [
          FloatingActionButton(
            onPressed: () {
              print("The chat context: ${context.locale}");
              changeLocale();
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: SvgPicture.asset(
              'assets/icons/globe.svg', // Replace this with the path to your globe icon SVG file
              width: iconsSize,
              height: iconsSize,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            ),
          ),
          FloatingActionButton(
              onPressed: () {
                changeAppMood();
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Provider.of<AppSettings>(context).isDarkMood
                  ? moonIcon
                  : sunIcon)
        ],
      );
    });
  }
}

// leading: PopupMenuButton(
// icon: Icon(
// Icons.more_vert,
// color: AppColors.accent,
// ),
// itemBuilder: (BuildContext context) {
// return [
// PopupMenuItem(
// child: Row(
// children: [
// GestureDetector(
// onTap: () {
// widget.firstOptionFunction();
// },
// onTapUp: (t) {
// widget.firstOptionFunction();
// },
// child: Text(
// widget.firstOptionText,
// ))
// ],
// ),
// value: 1,
// ),
// PopupMenuItem(
// child: GestureDetector(
// onTap: () {
// widget.secondOptionFunction();
// },
// onTapUp: (t) {
// widget.secondOptionFunction();
// },
// child: Text(
// widget.secondOptionText,
// )),
// value: 2,
// ),
// ];
// },
// onSelected: (value) {
// // Handle menu item selection here
// if (value == 1) {
// // Option 1 selected
// } else if (value == 2) {
// // Option 2 selected
// }
// },
// )
