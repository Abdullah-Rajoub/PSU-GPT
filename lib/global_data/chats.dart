import 'package:flutter/foundation.dart';
import 'package:gpt_clone/models/chat.dart';
import 'package:gpt_clone/models/message.dart';

// this class is used to cache chat of a user / guest
// This class makes it possible to fetch user chats once from the database.
// currently only one chat for signed up user. but multiple chat support for guest.
class AllChats extends ChangeNotifier {
  List<Chat> _chatsList = [];
  int _currentChatIndex = 0;
  AllChats({required List<Chat> chatsList}) {
    _chatsList = chatsList;
  }
  // method for adding a new chat.
  void setCurrentChat(index) {
    _chatsList.add(index);
    notifyListeners();
  }

  void addChat({required chatID}) {
    _chatsList
        .add(Chat(chatTitle: "New Chat $chatID", messages: [], chatID: chatID));

    notifyListeners();
  }

  Chat getCurrentChat() {
    return _chatsList[_currentChatIndex];
  }

// method for removing a specifc chat
  void deletChat(index) {
    print(index);
    // first remove element at the index
    _chatsList[index].messages = [];
    notifyListeners();
  }

  // method for logged in users only.
  //NOTE: this method must be changed when we get multiple chat for logged in user supported by backend
  void logedinUserChats({required List<Message> messages}) {
    _chatsList = [
      Chat(
          chatTitle: "First chat",
          messages: messages,
          chatID: "not implememnted yet")
    ];
    _currentChatIndex = 0;
    notifyListeners();
  }
  //
  // // used to add chat at the right place.
  // int newElementIndex() {
  //   return _chatsList.length;
  // }

  void deleteAllChats() {
    print("deleted all");
    this._chatsList = [
      Chat(chatTitle: "New Chat 0", chatID: "0", messages: [])
    ];
    _currentChatIndex = 0;
    notifyListeners();
  }
}
