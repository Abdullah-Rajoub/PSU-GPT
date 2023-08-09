import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/backend/guest_api.dart';
import 'package:gpt_clone/backend/user_api.dart';
import 'package:gpt_clone/components/chat_screen/feedback/feedback_text_field.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'feedback_logo.dart';

void NegativeFeedback(
    {required BuildContext context,
    required int messageIndex,
    required var turnOnResize,
    required var turnOffResize}) async {
  print("turning off");
  turnOffResize();
  Message message = Provider.of<AllChats>(context, listen: false)
      .getCurrentChat()
      .messages[messageIndex];
  await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: dialog(
                messageIndex: messageIndex,
              ),
            ));
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
  turnOnResize();
  print("turning on 2");
}

class dialog extends StatefulWidget {
  int messageIndex;

  dialog({
    required this.messageIndex,
  });

  @override
  State<dialog> createState() => _dialogState();
}

class _dialogState extends State<dialog> with WidgetsBindingObserver {
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // Add this line to register this class as an observer
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    // Add this line to remove this class as an observer
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset =
        WidgetsBinding.instance?.window.viewInsets.bottom ?? 0.0;
    setState(() {
      // Check if the keyboard is visible by measuring the bottomInset value.
      isKeyboardVisible = bottomInset > 0.0;
    });
  }

  bool closeIsLoading = false;
  bool submitLoading = false;

  @override
  Widget build(BuildContext context) {
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
            )),
        animationDuration: Duration(milliseconds: 1300),
        reverseAnimationDuration: Duration(milliseconds: 700),
        reverseCurve: Curves.fastOutSlowIn,
        displayDuration: Duration(milliseconds: 2000),
      );
    }

    @override
    initState() {
      super.initState();
    }

    @override
    dispose() {
      super.dispose();
    }

    // get user info, to check if the user is logged in or not;
    bool isloggedin = Provider.of<User>(context, listen: false).isLoggedin();
    // preprocess: getting the message from the provider
    bool isLoading = closeIsLoading || submitLoading;
    int messageIndex = widget.messageIndex;
    Message message =
        Provider.of<AllChats>(context).getCurrentChat().messages[messageIndex];
    onClose() async {
      Navigator.pop(context);
    }

    TextEditingController textEditingController = TextEditingController();
    onSubmit() async {
      setState(() {
        submitLoading = true;
      });
      message.review.setFeedback(feedback: "dislike");
      message.review.setComment(comment: textEditingController.value.text);
      isloggedin
          ? await UserAPI.sendReview(
              messageIndex: messageIndex, context: context)
          : await GuestAPI.sendReview(
              messageIndex: messageIndex, context: context);
      setState(() {
        submitLoading = false;
      });
      Navigator.pop(context);
      successfulSnackBar(context: context);
    }

    return Listener(
      onPointerDown: (_) {
        // Close the keyboard if it's open when the user taps outside the text field.
        if (isKeyboardVisible) {
          FocusScope.of(context).unfocus();
        }
      },
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: AlertDialog(
          backgroundColor: Color(0xFFFAF9F6),
          iconPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          icon: Column(
            children: [
              Row(
                children: [
                  FeedbackLogo(isPositiveFeedback: false),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.provideAdditionalFeedback.tr(),
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
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
          content: FeedbackTextField(
            textEditingController: textEditingController,
            hintText: LocaleKeys.whatWasTheIssue.tr(),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15, vertical: true ? 0 : 0),
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
                      return Colors.white;
                      // Default color
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey, // Grey border color
                          width: 0.5, // Adjust the width as needed
                        ),
                        borderRadius: BorderRadius.circular(
                            5.5), // Adjust the radius as needed
                      );
                    },
                  ),
                ),
                onPressed: isLoading
                    ? () {
                        print("Loading");
                      }
                    : onClose,
                child: closeIsLoading
                    ? LoadingAnimationWidget.prograssiveDots(
                        color: Colors.grey,
                        size: 12,
                      )
                    : Text(
                        LocaleKeys.close.tr(),
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.black,
                            letterSpacing: 0.6),
                      ),
              ),
            ),
            Container(
              height: 23,
              child: ElevatedButton(
                clipBehavior: Clip.hardEdge,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Color(0xFFDC2626); // Disabled color
                      }
                      return Color(0xFFDC2626); // Default color
                    },
                  ),
                ),
                onPressed: isLoading
                    ? () {
                        print("Loading");
                      }
                    : onSubmit,
                child: submitLoading
                    ? LoadingAnimationWidget.prograssiveDots(
                        color: Colors.grey,
                        size: 12,
                      )
                    : Text(
                        LocaleKeys.submit.tr(),
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            letterSpacing: 0.6),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
