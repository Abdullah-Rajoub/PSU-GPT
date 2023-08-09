import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/components/chat_screen/feedback/negative_feedback.dart';
import 'package:gpt_clone/components/chat_screen/feedback/positive_feedback_one.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/models/chat.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/models/review.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../translations/locale_keys.g.dart';

class HalfMessage extends StatefulWidget {
  final String text;
  final bool isUserMessage;
  bool shouldAnimate;
  bool isLoading = false;
  String messageId = "";
  int messageIndex;
  var turnOnResize;
  var turnOffResize;

  HalfMessage(
      {required this.text,
      required this.isUserMessage,
      this.shouldAnimate = false,
      required this.isLoading,
      required this.messageId,
      required this.messageIndex,
      this.turnOnResize,
      this.turnOffResize});

  @override
  State<HalfMessage> createState() => _HalfMessageState();
}

class _HalfMessageState extends State<HalfMessage> {
  void sendReview(review) async {
    var jsonObject = {'feedback': review};
    var sentOutput = jsonEncode(jsonObject);
    String url =
        "http://192.168.1.133:3000/psu_support_gpt/${widget.messageId}";
    var res = await http.patch(Uri.parse(url), body: sentOutput, headers: {
      'Content-type': 'application/json',
    });
    if (res.statusCode == 200) {
      print("working");
    } else {
      print(res.statusCode);
      print(res.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    print("inting");
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          widget.shouldAnimate = false;
        }));
  }

  var copy_icon = Icons.copy;
  @override
  Widget build(BuildContext context) {
    Chat currentChat = Provider.of<AllChats>(context).getCurrentChat();
    Message message = currentChat.messages[widget.messageIndex];
    Review review = message.review;
    bool isLike() {
      return "like" == review.getFeedback();
    }

    bool isDisLike() {
      return "dislike" == review.getFeedback();
    }

    void changeLoadingState(isLoading) {
      setState(() {
        widget.isLoading = isLoading;
      });
    }

    return LayoutBuilder(builder: (context, constraints) {
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      double MessageFontSize;
      double avatarIconSize;
      double circularAvatarRadius;
      double userOptionsIconsSize;
      double loadingIndicatorSize;
      double messageSourceFontSize;
      print("inside message the width is $maxWidth");

      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        MessageFontSize = 12;
        messageSourceFontSize = 13.0;
        avatarIconSize = 20;
        circularAvatarRadius = 15;
        userOptionsIconsSize = 18;
        loadingIndicatorSize = 20;
      } else if (maxWidth >= 400) {
        MessageFontSize = 10;
        messageSourceFontSize = 11.0;
        avatarIconSize = 14;
        loadingIndicatorSize = 14;
        circularAvatarRadius = 12;
        userOptionsIconsSize = 11;
      } else {
        MessageFontSize = 9;
        messageSourceFontSize = 10.0;
        avatarIconSize = 12;
        loadingIndicatorSize = 12;
        circularAvatarRadius = 9;
        userOptionsIconsSize = 10;
      }

      return Consumer<AllChats>(
        builder: (context, child, allChat) {
          bool isDarkMood =
              Provider.of<AppSettings>(context, listen: true).isDarkMood;
          bool isArabic = context.locale.toString() == "ar";
          isArabic = context.locale.toString() == "ar";
          return Column(
            children: [
              Container(
                color: widget.isUserMessage
                    ? Colors.transparent
                    : isDarkMood
                        ? AppColors.DlightPurple
                        : AppColors.greyContainers,
                padding: widget.isUserMessage
                    ? const EdgeInsets.symmetric(vertical: 10.0)
                    : const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon of the user and his name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            radius: circularAvatarRadius,
                            backgroundColor: widget.isUserMessage
                                ? AppColors.UserIcon
                                : AppColors.BotIcon,
                            child: widget.isUserMessage
                                ? Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: avatarIconSize,
                                  )
                                : Icon(
                                    Icons.support_agent_rounded,
                                    color: Colors.white,
                                    size: avatarIconSize,
                                  ),
                          ),
                        ),
                        widget.isUserMessage
                            ? Text(
                                LocaleKeys.user.tr(),
                                style: TextStyle(
                                    color: isDarkMood
                                        ? AppColors.accent
                                        : AppColors.Laccent,
                                    fontSize: messageSourceFontSize),
                              )
                            : Text(
                                LocaleKeys.psuGPT.tr(),
                                style: TextStyle(
                                    color: isDarkMood
                                        ? AppColors.accent
                                        : AppColors.Laccent,
                                    fontSize: messageSourceFontSize),
                              )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: isArabic
                                ? const EdgeInsets.only(
                                    top: 2.0, left: 0, right: 34)
                                : const EdgeInsets.only(
                                    top: 2.0, left: 34, right: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                  color: isDarkMood
                                      ? Colors.white
                                      : AppColors.Laccent,
                                  fontSize: MessageFontSize),
                              child: widget.shouldAnimate ||
                                      !widget.isUserMessage
                                  ? widget.isLoading
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocaleKeys.loadingMessage.tr(),
                                              style: TextStyle(
                                                  color: isDarkMood
                                                      ? AppColors.accent
                                                      : AppColors.Laccent),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: LoadingAnimationWidget
                                                  .prograssiveDots(
                                                      color: isDarkMood
                                                          ? AppColors.accent
                                                          : AppColors.Laccent,
                                                      size:
                                                          loadingIndicatorSize),
                                            )
                                          ],
                                        )
                                      : AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(widget.text)
                                          ],
                                          totalRepeatCount: 1,
                                          isRepeatingAnimation: false,
                                        )
                                  : Text(widget.text),
                            ),
                          ),
                        ),
                      ],
                    ),
                    !(widget.isUserMessage || widget.isLoading)
                        ? Container(
                            padding: isArabic
                                ? const EdgeInsets.only(
                                    top: 2.0, left: 0, right: 34)
                                : const EdgeInsets.only(
                                    top: 2.0, left: 34, right: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        LocaleKeys.messageQualityCheck.tr(),
                                        style: TextStyle(
                                            color: isDarkMood
                                                ? AppColors.accent
                                                : AppColors.Laccent,
                                            fontSize: MessageFontSize),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (isLike()) {
                                          } else {
                                            setState(() {});
                                            sendReview('like');
                                            await positiveFeedbackOne(
                                                context: context,
                                                messageIndex:
                                                    widget.messageIndex);
                                            setState(() {});
                                          }
                                        },
                                        child: Icon(
                                          Icons.thumb_up_alt_outlined,
                                          size: userOptionsIconsSize,
                                          color: isLike()
                                              ? Colors.green
                                              : AppColors.accent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("dislike");
                                          if (isDisLike()) {
                                          } else {
                                            NegativeFeedback(
                                                context: context,
                                                messageIndex:
                                                    widget.messageIndex,
                                                turnOffResize:
                                                    widget.turnOffResize,
                                                turnOnResize:
                                                    widget.turnOnResize);
                                            setState(() {});
                                            sendReview('dislike');
                                          }
                                        },
                                        child: Icon(
                                          Icons.thumb_down_alt_outlined,
                                          size: userOptionsIconsSize,
                                          color: isDisLike()
                                              ? Colors.redAccent
                                              : AppColors.accent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("Copy");
                                          copy_icon = Icons.check;
                                          FlutterClipboard.copy(widget.text);
                                          setState(() {});
                                          Future.delayed(
                                              Duration(milliseconds: 800), () {
                                            // Your function code here
                                            copy_icon = Icons.copy;
                                            setState(() {});
                                          });
                                        },
                                        child: Icon(
                                          copy_icon,
                                          size: userOptionsIconsSize,
                                          color: AppColors.accent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 14,
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
