import 'package:gpt_clone/models/message.dart';

class Chat {
  String chatTitle;
  // this index is only used for guest messages. put it as 100 for non-guest chats.
  String chatID;

  List<Message> messages = [];

  Chat({required this.chatTitle, required this.messages, required this.chatID});

  void addMessage(Message message) {
    messages.add(message);
  }

  void modifyLastMessage({required Message message}) {
    this.messages.removeLast();
    // // giving the message data to the chatMessage widget
    // ChatMessage chatMessage = ChatMessage(
    //   message: message,
    // );
    this.messages.add(message);
  }
}
