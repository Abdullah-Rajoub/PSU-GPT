import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/backend/guest_api.dart';
import 'package:gpt_clone/backend/user_api.dart';
import 'package:gpt_clone/components/chat_screen/feedback/bullet_point.dart';
import 'package:gpt_clone/components/chat_screen/feedback/feedback_text_field.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'feedback_logo.dart';

Future PositiveFeedbackTwo(
    {required BuildContext context, required int messageIndex}) async {
  // preprocess: getting the message from the provider
  Message message = Provider.of<AllChats>(context, listen: false)
      .getCurrentChat()
      .messages[messageIndex];

  //1- show that the message has been liked, by modifying the review on message
  message.review.setFeedback(feedback: "like");
  await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: Dialog(messageIndex: messageIndex),
            ));
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
}

class Dialog extends StatefulWidget {
  int messageIndex;
  Dialog({required this.messageIndex});

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  void successfulSnackBar({required BuildContext context}) {
    showTopSnackBar(
      Overlay.of(context),
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFf0fdf4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFF82d4a5),
          ),
        ),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 18,
              color: Color(0xFF16a35f),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              LocaleKeys.feedbackRecorded.tr(),
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF16a35f),
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
      animationDuration: Duration(milliseconds: 1300),
      reverseAnimationDuration: Duration(milliseconds: 700),
      reverseCurve: Curves.fastOutSlowIn,
      displayDuration: Duration(milliseconds: 2000),
    );
  }

  // used to show loading indicator for close, and stop sending more request.
  bool closeIsLoading = false;
  // used to show loading indicator for submit, and stop sending more request.
  bool submitIsLoading = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  double heightFactor = 0.4;
  void sethieghtFactor(double heightFacotr) {
    print("setting height");
    setState(() {
      heightFactor = heightFacotr;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get user info, to check if the user is logged in or not;
    bool isloggedin = Provider.of<User>(context, listen: false).isLoggedin();
    bool isLoading = closeIsLoading || submitIsLoading;
    // preprocess: getting the message from the provider
    // Create a TextEditingController instance
    int messageIndex = widget.messageIndex;

    Message message =
        Provider.of<AllChats>(context).getCurrentChat().messages[messageIndex];

    onSubmit() async {
      // shows loading indicator for submit
      setState(() {
        submitIsLoading = true;
      });

      message.review.setComment(comment: _textEditingController.value.text);

      await isloggedin
          ? UserAPI.sendReview(messageIndex: messageIndex, context: context)
          : GuestAPI.sendReview(messageIndex: messageIndex, context: context);

      setState(() {
        submitIsLoading = false;
      });
      Navigator.pop(context);
      successfulSnackBar(context: context);
    }

    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: heightFactor,
      child: AlertDialog(
        backgroundColor: Color(0xFFFAF9F6),
        iconPadding: EdgeInsets.only(top: 12, left: 8, right: 8),
        icon: Column(
          children: [
            Row(
              children: [
                FeedbackLogo(
                  isPositiveFeedback: true,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    LocaleKeys.provideAdditionalFeedback.tr(),
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
        title: Container(
          width: double.infinity,
          height: 0.4,
          color: Colors.grey,
        ),
        titlePadding: EdgeInsets.symmetric(
          vertical: 12,
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Row(
                      children: [
                        BulletPoint(),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          LocaleKeys.howRateResponde.tr(),
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                    FeedbackTextField(
                      textEditingController: _textEditingController,
                      hintText: LocaleKeys.whatDidYou.tr(),
                      setHeightFactor: sethieghtFactor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        actionsPadding: EdgeInsets.only(bottom: 8, right: 6, left: 6),
        actions: [
          Container(
            height: 23,
            child: ElevatedButton(
              clipBehavior: Clip.hardEdge,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Color(0xFF53BD00); // Disabled color
                    }
                    return Color(0xFF53BD00); // Default color
                  },
                ),
              ),
              onPressed: isLoading
                  ? () {
                      print("You cant submit, wait till it finish");
                    }
                  : onSubmit,
              child: submitIsLoading
                  ? LoadingAnimationWidget.prograssiveDots(
                      color: Colors.grey,
                      size: 12,
                    )
                  : Text(
                      LocaleKeys.submit.tr(),
                      style: TextStyle(
                          fontSize: 9, color: Colors.white, letterSpacing: 0.6),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
