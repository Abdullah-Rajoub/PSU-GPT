import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../translations/locale_keys.g.dart';

class MessageBox extends StatefulWidget {
  var _textController;
  var _handleSubmitted;
  var _isLoading;
  MessageBox(
      {required textController, required handleSubmitted, required isLoading}) {
    this._textController = textController;
    this._handleSubmitted = handleSubmitted;
    this._isLoading = isLoading;
  }

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return Container(
      decoration: BoxDecoration(
          color: isDarkMood ? AppColors.DdarkPurple : Colors.white),
      child: _buildTextComposer(
        isLoading: widget._isLoading,
        textController: widget._textController,
        handleSubmitted: widget._handleSubmitted,
      ),
    );
  }
}

class _buildTextComposerState extends State<_buildTextComposer> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      print("the max width of message box: $maxWidth");
      double textBoxHeight = 0;
      double fontSize = 0;
      double sendIconSize;
      double warningMessageSize;

      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        textBoxHeight = 40;
        sendIconSize = 20;
        fontSize = 12;
        warningMessageSize = 8;
      } else if (maxWidth >= 400) {
        textBoxHeight = 30;
        sendIconSize = 17;
        fontSize = 10;
        warningMessageSize = 7;
      } else {
        textBoxHeight = 25;
        fontSize = 9;
        sendIconSize = 15;
        warningMessageSize = 6;
      }
      return IconTheme(
        data: IconThemeData(color: Theme.of(context).cardColor),
        child: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: textBoxHeight,
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          keyboardAppearance: Brightness.dark,
                          controller: widget._textController,
                          onSubmitted: (text) {
                            widget._handleSubmitted(text);
                            setState(
                              () {
                                // Update the state
                              },
                            );
                          },
                          style: TextStyle(
                              color: isDarkMood
                                  ? Colors.white
                                  : AppColors.LAccentPurple,
                              fontSize: 7),
                          decoration: InputDecoration(
                            fillColor: isDarkMood
                                ? AppColors.DlightPurple
                                : AppColors.greyContainers,
                            filled: true,
                            hintText: LocaleKeys.messageBoxHint.tr(),
                            hintStyle: TextStyle(
                                color: isDarkMood
                                    ? Color.fromRGBO(187, 187, 205, 1)
                                    : Colors.grey,
                                fontSize: 7),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: isDarkMood
                                        ? AppColors.DdarkPurple
                                        : Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: isDarkMood
                                        ? AppColors.DdarkPurple
                                        : Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: widget.isLoading
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.accent,
                            size: sendIconSize,
                          )
                        : Icon(
                            Icons.send,
                            size: sendIconSize,
                            color: isDarkMood
                                ? AppColors.DlightPurpleIcon
                                : Colors.grey,
                          ),
                    onPressed: () =>
                        widget._handleSubmitted(widget._textController.text),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: warningMessageSize,
                              color: isDarkMood
                                  ? Colors.grey.shade400
                                  : AppColors.Laccent),
                          children: [
                        TextSpan(text: LocaleKeys.footerPartOne.tr()),
                        TextSpan(
                            text: LocaleKeys.footerPartTwo.tr(),
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(text: LocaleKeys.footerPartThree.tr())
                      ]))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

class _buildTextComposer extends StatefulWidget {
  var _textController;
  var _handleSubmitted;
  bool isLoading = false;
  _buildTextComposer(
      {required textController, required handleSubmitted, required isLoading}) {
    this._handleSubmitted = handleSubmitted;
    this._textController = textController;
    this.isLoading = isLoading;
  }

  @override
  State<_buildTextComposer> createState() => _buildTextComposerState();
}
