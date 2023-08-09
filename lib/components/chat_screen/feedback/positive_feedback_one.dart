import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/components/chat_screen/feedback/bullet_point.dart';
import 'package:gpt_clone/components/chat_screen/feedback/positive_feedback_two.dart';
import 'package:gpt_clone/components/chat_screen/feedback/rating_row.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'feedback_logo.dart';

Future positiveFeedbackOne(
    {required BuildContext context, required int messageIndex}) async {
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
    },
  );
}

class Dialog extends StatefulWidget {
  int messageIndex;
  Dialog({required this.messageIndex});

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  // used to show loading indicator for close button and not allow more than one request at a time
  bool closeIsLoading = false;
  @override
  Widget build(BuildContext context) {
    // get user info, to check if the user is logged in or not;
    bool isloggedin = Provider.of<User>(context, listen: false).isLoggedin();
    // preprocess: getting the message from the provider
    int messageIndex = widget.messageIndex;
    Message message =
        Provider.of<AllChats>(context).getCurrentChat().messages[messageIndex];
    onClose() async {
      Navigator.pop(context);
    }

    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.4,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
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
            ),
            Expanded(
              child: RatingRow(
                setRating: (int rating) {
                  message.review.setRating(rating: rating);
                },
              ),
            )
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
                          8.0), // Adjust the radius as needed
                    );
                  },
                ),
              ),
              onPressed: closeIsLoading ? () {} : onClose,
              child: closeIsLoading
                  ? LoadingAnimationWidget.prograssiveDots(
                      color: Colors.grey,
                      size: 12,
                    )
                  : Text(
                      LocaleKeys.close.tr(),
                      style: TextStyle(
                          fontSize: 9, color: Colors.black, letterSpacing: 0.6),
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
                      return Color(0xFF53BD00); // Disabled color
                    }
                    return Color(0xFF53BD00); // Default color
                  },
                ),
              ),
              onPressed: closeIsLoading
                  ? () {
                      print("Loading");
                    }
                  : () async {
                      // Add your navigation logic here
                      Navigator.pop(context);
                      await PositiveFeedbackTwo(
                          context: context, messageIndex: messageIndex);
                    },
              child: Text(
                LocaleKeys.next.tr(),
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

// class StyledTextExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Styled Text Example')),
//       body: Center(
//         child: ,
//       ),
//     );
//   }
// }
