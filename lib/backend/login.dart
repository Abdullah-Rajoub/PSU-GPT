import 'dart:convert';

import 'package:gpt_clone/global_data/chats.dart';
import "package:gpt_clone/global_data/user.dart";
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/models/review.dart';
import 'package:gpt_clone/translations/maping_messages.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'routes.dart';

String deleteEndPattern(String input) {
  final RegExp pattern = RegExp(r'\n#+\n+$');
  return input.replaceAll(pattern, '');
}

Future<String> login(
    {required email, required password, required context}) async {
  // send the request to server
  // check if the info enter is valid
  try {
    var jsonObject = {
      "email": email,
      "password": password,
    };
    var stringifiedJson = jsonEncode(jsonObject);
    // Set the url
    Uri url = Uri.parse(AppRoutes.loginRoute);
    // set header
    var headers = {
      'Content-type': 'application/json',
    };
    var respond = await http.post(url, body: stringifiedJson, headers: headers);
    if (respond.statusCode == 200) {
      var decodedRespond = jsonDecode(respond.body);
      String refreshToken = "Bearer ${decodedRespond['refresh']}";
      String accessToken = "Bearer ${decodedRespond['access']}";

      //1-  get all user details and save it locally to be used later
      Uri userDetailsUrl = Uri.parse(AppRoutes.getUserDetials);
      // set header
      var userDetailsheaders = {
        'Authorization': accessToken,
      };

      var userDetialsReponse =
          await http.get(userDetailsUrl, headers: userDetailsheaders);

      if (userDetialsReponse.statusCode != 200) {
        print("something really wrong: ${userDetialsReponse.statusCode}");
      }
      print(jsonDecode(userDetialsReponse.body));
      var userDetails = jsonDecode(userDetialsReponse.body);
      Provider.of<User>(context, listen: false).getUserInfo(
          id: userDetails["id"].toString(),
          email: userDetails["email"],
          firstName: userDetails["first_name"],
          lastName: userDetails["last_name"]);
      // 2- get user messages:
      // Set the url
      Uri userMessagesUrl = Uri.parse(AppRoutes.getUserMessages);
      // set headers
      var userMessagesHeader = {
        'Authorization': accessToken,
      };

      var messagesReponse =
          await http.get(userMessagesUrl, headers: userMessagesHeader);

      if (messagesReponse.statusCode != 200) {
        print("something really wrong: ${messagesReponse.statusCode}");
      }
      print(jsonDecode(messagesReponse.body));
      List messages = jsonDecode(messagesReponse.body);
      // converting the messages we recieved from backend, to the format we use locally in the app.
      List<Message> localMessages = [];
      int index = 0;
      messages.forEach((message) {
        Review review = Review();
        review.setRating(rating: message["rating"]);
        review.setFeedback(feedback: message["feedback"]);
        review.setComment(comment: message["comment"]);
        Message messageTemp = Message(
            messageID: message["id"].toString(),
            modelName: message["model_name"],
            prompt: deleteEndPattern(message["prompt"]).trim(),
            completion: deleteEndPattern(message["completion"]).trim(),
            messageIndex: index);
        messageTemp.addReviewBack(review: review);
        localMessages.add(
          messageTemp,
        );

        index++;
      });
      // updating our temporary local storage using the data received
      Provider.of<AllChats>(context, listen: false)
          .logedinUserChats(messages: localMessages);
      Provider.of<User>(context, listen: false).saveLoginInfo(
          email: email, access: accessToken, refresh: refreshToken);

      return "";
    } else {
      print(jsonDecode(respond.body));
      var mapKey = jsonDecode(respond.body).keys.toList();
      var backendErrorMessage = jsonDecode(respond.body)[mapKey[0]];
      var mappedValue = mapBackendOutput(backendRespond: backendErrorMessage);
      print(backendErrorMessage);
      var errorMessage = mappedValue;
      print(mappedValue);
      return errorMessage;
    }
  } catch (e) {
    var mappedValue = mapBackendOutput(backendRespond: e.toString());
    print("vat?");
    print(e);
    return mappedValue;
  }
  return "";
}
