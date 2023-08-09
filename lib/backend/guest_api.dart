import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gpt_clone/backend/routes.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GuestAPI {
  List<AllChats> userChatList = [];

  //Sends review to the backend
  static Future<String> sendReview(
      {required int messageIndex, required BuildContext context}) async {
    //Preprocessing:
    Message message = Provider.of<AllChats>(context, listen: false)
        .getCurrentChat()
        .messages[messageIndex];
    Review review = message.review;
    String feedback = review.getFeedback();
    String comment = review.getComment();
    int rating = review.getRating();
    print(rating);
    print(feedback);
    print(comment);
    // review body requirement:
    // Make sure to send comment and rating key even as null
    // comment can be null or a string with 1000 characters cap
    // rating can be null or a Whole number between 0 and 5 inclusive
    var reviewBody = {
      "feedback": feedback.isEmpty ? null : feedback,
      "comment": comment.isEmpty ? null : comment,
      "rating": rating == -1 ? null : rating,
    };
    var stringifiedJson = jsonEncode(reviewBody);
    String url = AppRoutes.guestReviewRoute(messageID: message.messageID);
    var headers = {
      'Content-type': 'application/json',
    };
    try {
      var res = await http.patch(Uri.parse(url),
          body: stringifiedJson, headers: headers);
      if (res.statusCode == 200) {
        print("worked!");
        return "";
      } else {
        print("didn't work.");
        return "Sorry, could not send your feedback. Please try again later.";
      }
    } catch (exception) {
      print("didnt work:$exception");
      return "Sorry, could not send your feedback. Please try again later.";
    }
  }

  // sending a message to the backend to get the completion (answer).
  static Future<Message> sendPrompt(
      {required prompt,
      required Message message,
      required BuildContext context}) async {
    // back end settings.
    var url = AppRoutes.guestChatRoute;
    Map<String, String> body = {"prompt": prompt};
    var stringifiedBody = jsonEncode(body);
    var headers = {
      'Content-type': 'application/json',
    };

    //sending request
    try {
      var response = await http.post(Uri.parse(url),
          body: stringifiedBody, headers: headers);
      if (response.statusCode == 200) {
        // getting the completion from the respond
        String completion = jsonDecode(response.body)["result"].trim();
        //getting the id from the respond
        String messageID = jsonDecode(response.body)["id"].toString().trim();
        //Adding them to the message
        Message modifiedMessage = message.modifyMessage(
            completion: completion,
            messageID: messageID,
            messageIndex: message.messageIndex);
        // sending the modified message back
        return modifiedMessage;
      } else {
        Message modifiedMessage = message.modifyMessage(
            completion: "Sorry, something went wrong. Please try again later.",
            messageID: "",
            messageIndex: message.messageIndex);
        return modifiedMessage;
      }
    } catch (exception) {
      Message modifiedMessage = message.modifyMessage(
          completion: "Sorry, Server not responding.",
          messageID: "",
          messageIndex: -1);
      return modifiedMessage;
    }
  }
}
