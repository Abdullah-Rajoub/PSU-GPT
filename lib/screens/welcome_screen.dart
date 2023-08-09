import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/components/welcome_screen_components/feature_card.dart';
import 'package:gpt_clone/components/welcome_screen_components/feature_colunm.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/screens/login_screen.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

import '../translations/locale_keys.g.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static const String routeName = "\welcomeScreen";
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    void changeLocale() async {
      if (context.locale.toString() == "ar") {
        await context.setLocale(Locale('en'));
      } else {
        await context.setLocale(Locale('ar'));
      }
    }

    void changeAppMood() {
      Provider.of<AppSettings>(context, listen: false).changeAppMode();
    }

    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      final maxHeight = constraints.maxHeight;
      double appIconSize;
      double titleFontSize;
      double paragraphFontSize;
      double paddingBetweenSections;
      double headerIconsSize;
      double headerTitleSize;
      double paddingBetweenElements;
      double innerHeaderIcons;
      double buttonHeight;
      double buttonIconSize;
      double topOfScreenPadding;
      double colounmSeperator;
      double sizeOfOptionsIcons = 2;
      if (maxHeight >= 900) {
        paddingBetweenSections = 15;
        topOfScreenPadding = 30;
        paddingBetweenElements = 8;
      } else if (maxHeight >= 750) {
        topOfScreenPadding = 15;
        paddingBetweenSections = 10;
        paddingBetweenElements = 6;
      } else {
        paddingBetweenElements = 4;
        paddingBetweenSections = 8;
        topOfScreenPadding = 0;
      }
      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        sizeOfOptionsIcons = 28;
        buttonHeight = 40;
        colounmSeperator = 40;
        headerTitleSize = 13;
        headerIconsSize = 30;

        titleFontSize = 25;
        appIconSize = 90;
        paragraphFontSize = 12;

        innerHeaderIcons = 50;
        buttonIconSize = 25;
      } else if (maxWidth >= 400) {
        sizeOfOptionsIcons = 25;
        buttonHeight = 40;
        colounmSeperator = 30;
        innerHeaderIcons = 40;

        headerTitleSize = 12;
        headerIconsSize = 20;

        appIconSize = 75;
        titleFontSize = 25;
        paragraphFontSize = 10;
        buttonIconSize = 20;
      } else {
        sizeOfOptionsIcons = 20;
        buttonHeight = 40;
        colounmSeperator = 10;
        innerHeaderIcons = 30;

        headerTitleSize = 11;
        headerIconsSize = 20;

        appIconSize = 60;
        titleFontSize = 15;
        paragraphFontSize = 8;
        buttonIconSize = 15;
      }
      var basicTextStyle = Theme?.of(context).textTheme.bodyText1;
      return Consumer<AllChats>(builder: (context, allChats, child) {
        bool isDarkMood =
            Provider.of<AppSettings>(context, listen: true).isDarkMood;
        return Consumer<AllChats>(
          builder: (context, child, allChat) {
            bool isDarkMood =
                Provider.of<AppSettings>(context, listen: true).isDarkMood;
            var appIcon = SvgPicture.asset(
              isDarkMood
                  ? 'assets/icons/RIOTUlogo.svg'
                  : 'assets/icons/RIOTULogoBlack.svg',
              width: appIconSize,
              height: appIconSize,
            );
            var limitationHeader = SvgPicture.asset(
              'assets/icons/limitationHeader.svg',
              width: headerIconsSize,
              height: headerIconsSize,
              color: Color(0xFFea3546),
            );
            var capabilities = SvgPicture.asset(
              'assets/icons/Capabilities.svg',
              width: headerIconsSize,
              height: headerIconsSize,
              color: isDarkMood ? Color(0xFFcaf0f8) : Color(0xFF90e0ef),
            );
            var multiModel = SvgPicture.asset(
              'assets/icons/multicast.svg',
              width: innerHeaderIcons,
              height: innerHeaderIcons,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            );
            var incorrectAnswers = SvgPicture.asset(
              'assets/icons/car-brake-alert.svg',
              width: innerHeaderIcons,
              height: innerHeaderIcons,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            );
            var limitation = SvgPicture.asset(
              'assets/icons/telescope.svg',
              width: innerHeaderIcons,
              height: innerHeaderIcons,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            );
            var answersQuestions = SvgPicture.asset(
              'assets/icons/electron-framework.svg',
              width: innerHeaderIcons,
              height: innerHeaderIcons,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            );
            var translation = SvgPicture.asset(
              'assets/icons/translate-off.svg',
              width: innerHeaderIcons,
              height: innerHeaderIcons,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            );
            var local = SvgPicture.asset(
              'assets/icons/palm-tree.svg',
              width: innerHeaderIcons,
              height: innerHeaderIcons,
              color: isDarkMood ? Colors.white : AppColors.Laccent,
            );
            var featuresWidgets = [
              FeatureCard(
                  maxHeight: maxHeight,
                  icon: answersQuestions,
                  text: LocaleKeys.capabilitiesThree.tr(),
                  color: isDarkMood ? AppColors.accent : AppColors.Laccent),
              FeatureCard(
                  maxHeight: maxHeight,
                  icon: multiModel,
                  text: LocaleKeys.capabilitiesTwo.tr(),
                  color: isDarkMood ? AppColors.accent : AppColors.Laccent),
              FeatureCard(
                  maxHeight: maxHeight,
                  icon: local,
                  text: LocaleKeys.capabilitiesOne.tr(),
                  color: isDarkMood ? AppColors.accent : AppColors.Laccent)
            ];
            var limitationsWidgets = [
              FeatureCard(
                  maxHeight: maxHeight,
                  icon: incorrectAnswers,
                  text: LocaleKeys.limitationOne.tr(),
                  color: isDarkMood ? AppColors.accent : AppColors.Laccent),
              FeatureCard(
                  maxHeight: maxHeight,
                  icon: limitation,
                  text: LocaleKeys.limitationTwo.tr(),
                  color: isDarkMood ? AppColors.accent : AppColors.Laccent),
              FeatureCard(
                  maxHeight: maxHeight,
                  icon: translation,
                  text: LocaleKeys.capabilitiesThree.tr(),
                  color: isDarkMood ? AppColors.accent : AppColors.Laccent)
            ];
            var sunIcon = SvgPicture.asset(
              'assets/icons/sun.svg', // Replace this with the path to your globe icon SVG file
              width: sizeOfOptionsIcons,
              height: sizeOfOptionsIcons,
              color: isDarkMood ? AppColors.accent : AppColors.Laccent,
            );
            var moonIcon = SvgPicture.asset(
              'assets/icons/moon.svg', // Replace this with the path to your globe icon SVG file
              width: sizeOfOptionsIcons,
              height: sizeOfOptionsIcons,
              color: isDarkMood ? AppColors.accent : AppColors.Laccent,
            );
            var globeIcon = SvgPicture.asset(
              'assets/icons/globe.svg', // Replace this with the path to your globe icon SVG file
              width: sizeOfOptionsIcons,
              height: sizeOfOptionsIcons,
              color: isDarkMood ? AppColors.accent : AppColors.Laccent,
            );

            return Scaffold(
              backgroundColor:
                  isDarkMood ? AppColors.DdarkPurple : Colors.white,
              body: Center(
                child: SafeArea(
                  child: Container(
                    height: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        changeAppMood();
                                      },
                                      icon: Provider.of<AppSettings>(context)
                                              .isDarkMood
                                          ? moonIcon
                                          : sunIcon),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        changeLocale();
                                      },
                                      icon: globeIcon)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: topOfScreenPadding,
                            ),
                            appIcon,
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                LocaleKeys.welcomeScreenTitle.tr(),
                                style: basicTextStyle?.copyWith(
                                    color: isDarkMood
                                        ? Colors.white
                                        : AppColors.Laccent,
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: paddingBetweenSections,
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.95,
                              child: Text(
                                LocaleKeys.welcomeScreenParagraph.tr(),
                                style: basicTextStyle?.copyWith(
                                    fontSize: paragraphFontSize,
                                    color: isDarkMood
                                        ? AppColors.accent
                                        : AppColors.Laccent),
                              ),
                            ),
                            SizedBox(
                              height: paddingBetweenSections,
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.95,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        capabilities,
                                        SizedBox(
                                          height: paddingBetweenElements,
                                        ),
                                        Text(
                                          LocaleKeys.capabilitiesTitle.tr(),
                                          style: basicTextStyle?.copyWith(
                                              color: isDarkMood
                                                  ? Color(0xFFcaf0f8)
                                                  : Color(0xFF90e0ef),
                                              fontSize: headerTitleSize,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        colounmSeperator, // Width of the separator
                                    color:
                                        Colors.white, // Color of the separator
                                    child: VerticalDivider(
                                      width: 10,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(right: 15, left: 15),
                                      child: Column(
                                        children: [
                                          limitationHeader,
                                          SizedBox(
                                            height: paddingBetweenElements,
                                          ),
                                          Text(
                                            LocaleKeys.limitationsHeader.tr(),
                                            style: basicTextStyle?.copyWith(
                                                color: Color(0xFFea3546),
                                                fontSize: headerTitleSize,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FeatureColumn(
                                        widgets: featuresWidgets,
                                      ),
                                    ),
                                    Container(
                                      width:
                                          colounmSeperator, // Width of the separator
                                      color: Colors
                                          .white, // Color of the separator
                                      child: VerticalDivider(
                                        width: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Expanded(
                                      child: FeatureColumn(
                                        widgets: limitationsWidgets,
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            widthFactor: 0.4,
                            child: Container(
                              width: double.infinity,
                              height: buttonHeight,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return isDarkMood
                                              ? Colors.white
                                              : Color(
                                                  0xFF393a47); // Disabled color
                                        }
                                        return isDarkMood
                                            ? Colors.white
                                            : Color(
                                                0xFF393a47); // Default color
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, LoginScreen.routeName);
                                    // Add your navigation logic here
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        LocaleKeys.callToActionButtonTitle.tr(),
                                        style: basicTextStyle?.copyWith(
                                            fontSize: headerTitleSize,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkMood
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                      Icon(
                                        size: buttonIconSize,
                                        Icons.send,
                                        color: isDarkMood
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
    });
  }
}
