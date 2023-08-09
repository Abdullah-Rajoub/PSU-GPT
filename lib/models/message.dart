import 'package:gpt_clone/models/review.dart';

class Message {
  String prompt;
  String completion;

  var modelName;
  //Primary key used in database
  String messageID;
  // used to access a specifc message from array of messages saved in chat
  int messageIndex;
  // if review.feedback == "", then there is no review set for the message.
  Review review = Review();
  Message(
      {required this.messageID,
      required this.modelName,
      required this.prompt,
      required this.completion,
      required this.messageIndex});

  void addReviewBack({required Review review}) {
    this.review = review;
  }

  Message modifyMessage(
      {required String completion,
      required String messageID,
      required messageIndex}) {
    return Message(
        messageID: messageID,
        modelName: modelName,
        prompt: prompt,
        completion: completion,
        messageIndex: messageIndex);
  }
}
