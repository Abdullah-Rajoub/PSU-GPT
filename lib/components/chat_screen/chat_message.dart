import 'package:flutter/material.dart';
import 'package:gpt_clone/components/chat_screen/half_message.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/models/review.dart';

class ChatMessage extends StatefulWidget {
  Message message;
  var turnOnResize;
  var turnOffResize;
  ChatMessage(
      {required Message this.message,
      required this.turnOffResize,
      required this.turnOnResize});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  var copy_icon = Icons.copy;
  bool isLike({required Review review}) {
    print(review.getFeedback());
    if (review?.getFeedback() == "like") return true;
    return false;
  }

  bool isDislike({required Review review}) {
    print(review.toString());
    if (review?.getFeedback() == "dislike") return true;
    return false;
  }

  bool isLoading({required Message message}) {
    if (message.completion.isEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Message message = widget.message;
    Review review = message.review;
    return Column(
      children: [
        HalfMessage(
          text: message.prompt,
          isUserMessage: true,
          messageId: message.messageID,
          isLoading: false,
          messageIndex: message.messageIndex,
        ),
        HalfMessage(
          text: message.completion,
          isUserMessage: false,
          messageId: message.messageID,
          isLoading: isLoading(
            message: message,
          ),
          messageIndex: message.messageIndex,
          turnOffResize: widget.turnOffResize,
          turnOnResize: widget.turnOnResize,
        )
      ],
    );
  }
}
