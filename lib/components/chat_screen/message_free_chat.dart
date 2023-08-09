import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/components/chat_screen/examples_coloumn.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

import '../../translations/locale_keys.g.dart';
import 'message_box.dart';

class MessageFreeChat extends StatefulWidget {
  var _textController;
  var _handleSubmitted;
  var _isLoading;
  var leftSideExamples = [
    LocaleKeys.leftSideExampleOne.tr(),
    LocaleKeys.leftSideExampleTwo.tr(),
    LocaleKeys.leftSideExampleThree.tr(),
  ];
  var rightSideExamples = [
    LocaleKeys.rightSideExampleOne.tr(),
    LocaleKeys.rightSideExampleTwo.tr(),
    LocaleKeys.rightSideExampleThree.tr()
  ];

  MessageFreeChat(
      {required textController, required handleSubmitted, required isLoading}) {
    this._textController = textController;
    this._isLoading = isLoading;
    this._handleSubmitted = handleSubmitted;
  }

  @override
  State<MessageFreeChat> createState() => _MessageFreeChatState();
}

class _MessageFreeChatState extends State<MessageFreeChat> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      double subTitleFontSize = 14;
      double sizeOfChatIcon;
      double titleFontSize = 12;

      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        subTitleFontSize = 14;
        titleFontSize = 16;
        sizeOfChatIcon = 55;
      } else if (maxWidth >= 400) {
        subTitleFontSize = 12;
        titleFontSize = 14;
        sizeOfChatIcon = 45;
      } else {
        subTitleFontSize = 10;
        titleFontSize = 12;
        sizeOfChatIcon = 45;
      }
      print("inside the toggle selection max width is: $maxWidth");
      var appIcon = SvgPicture.asset(
        isDarkMood
            ? 'assets/icons/RIOTUlogo.svg'
            : 'assets/icons/RIOTULogoBlack.svg',
        width: sizeOfChatIcon,
        height: sizeOfChatIcon,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 14,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appIcon,
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    LocaleKeys.title.tr(),
                    style: TextStyle(
                        fontSize: titleFontSize,
                        color:
                            isDarkMood ? AppColors.accent : AppColors.Laccent),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocaleKeys.subtitle.tr(),
                    style: TextStyle(
                        fontSize: subTitleFontSize,
                        color:
                            isDarkMood ? AppColors.accent : AppColors.Laccent),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ExamplesColoumn(
                          examples: widget.leftSideExamples,
                          onExamplePress: widget._handleSubmitted,
                        ),
                      ),
                      Container(
                        width: 20, // Width of the separator
                        color: Colors.white, // Color of the separator
                        child: VerticalDivider(
                          width: 10,
                          color: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: ExamplesColoumn(
                          examples: widget.rightSideExamples,
                          onExamplePress: widget._handleSubmitted,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          MessageBox(
              textController: widget._textController,
              handleSubmitted: widget._handleSubmitted,
              isLoading: widget._isLoading)
        ],
      );
    });
  }
}

// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Transform(
// alignment: Alignment.center,
// transform: Matrix4.rotationY(math.pi),
// child: Icon(
// Icons.chat_outlined,
// size: 89,
// color: AppColors.accent,
// ),
// ),
// Container(
// width: 180,
// height: 78,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// "Start your chat",
// style: TextStyle(
// color: AppColors.accent,
// fontWeight: FontWeight.w600),
// ),
// SizedBox(
// height: 2.5,
// ),
// Text(
// "How can I help you today?",
// style: TextStyle(
// color: AppColors.accent,
// ),
// ),
// ]),
// ),
// ],
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Icon(Icons.lock_clock, color: AppColors.accent),
// SizedBox(
// width: 6,
// ),
// Text(
// "Beta Version",
// style: TextStyle(
// color: AppColors.accent,
// fontSize: 24,
// ),
// ),
// ],
// ),
