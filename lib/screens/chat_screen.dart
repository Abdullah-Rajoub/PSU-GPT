import 'package:flutter/material.dart';
import 'package:gpt_clone/backend/guest_api.dart';
import 'package:gpt_clone/backend/user_api.dart';
import 'package:gpt_clone/components/chat_screen/chat_message.dart';
import 'package:gpt_clone/components/chat_screen/message_box.dart';
import 'package:gpt_clone/components/chat_screen/message_free_chat.dart';
import 'package:gpt_clone/components/shared_components/appbar.dart';
import 'package:gpt_clone/components/shared_components/drawer.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/models/chat.dart';
import 'package:gpt_clone/models/message.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  bool isLoading = false;
  static const routeName = "/botChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool shouldResize = true;
  ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  var sentOutput;
  void _handleSubmitted(String prompt) async {
    // Note: modelName is not implemented yet.

    //Preprocessing steps:
    // 1- access the current chat using the index
    Chat currentChat =
        Provider.of<AllChats>(context, listen: false).getCurrentChat();
    // 2- clear the context of textfield widget using the controller
    _textController.clear();
    // processing steps:
    // 1- check if the text box is empty
    if (!prompt.isEmpty) {
      // 2- create message, with the giving user input as prompt, completion == "", nessafeID = "", and  modelName = "".
      Message message = Message(
          messageID: "",
          completion: "",
          prompt: prompt,
          modelName: "",
          messageIndex: currentChat.messages.length);
      // 3- save the message locally to the current chat. This will show the completion (user input) and the loading indicator, and setstate to apply changes
      currentChat.addMessage(message);
      setState(() {
        widget.isLoading = true;
      });
      // this is used to scroll down to the latest message.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('State has been updated');
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      });
      // 4- send request to backend for completion
      bool isLoggedin = Provider.of<User>(context, listen: false).isLoggedin();

      Message messageWithCompletion = isLoggedin
          ? await UserAPI.sendPrompt(
              prompt: prompt, message: message, context: context)
          : await GuestAPI.sendPrompt(
              prompt: prompt, message: message, context: context);
      // 5- replace the empty completion with the actual completion in the local data storage. this will turn off loading indicator.
      currentChat.modifyLastMessage(message: messageWithCompletion);
      setState(() {
        widget.isLoading = false;
      });
      // this is used to scroll down to the latest message.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('State has been updated');
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void turnOffResize() {
    print("turn off");
    setState(() {
      shouldResize = false;
    });
  }

  void turnOnResize() {
    print("turn on");
    setState(() {
      shouldResize = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Access the current chat using the index
    // get user info, to check if the user is logged in or not;

    Chat currentChat =
        Provider.of<AllChats>(context, listen: true).getCurrentChat();
    bool isDarkMood =
        Provider.of<AppSettings>(context, listen: true).isDarkMood;
    return Consumer<AllChats>(
      builder: (context, child, allChat) {
        // this method creates a list of messages widget from list of messages data.
        void createMessagesWidgets(
            List<Message> messages, List<ChatMessage> messagesWidget) {
          messages.forEach((message) {
            messagesWidget.add(ChatMessage(
              message: message,
              turnOnResize: turnOnResize,
              turnOffResize: turnOffResize,
            ));
          });
        }

        //1- get chat messages
        List<Message> chatMessages = currentChat.messages;
        // 2- create the list of messages widgets from the list of messages data.
        List<ChatMessage> messagesWidget = [];
        createMessagesWidgets(currentChat.messages, messagesWidget);

        return Scaffold(
          drawer:
              Container(color: AppColors.verydarkPurple, child: AppDrawer()),
          resizeToAvoidBottomInset: shouldResize,
          appBar: CustomerAppBar(),
          body: Container(
            color: isDarkMood ? AppColors.tabNonHoverdPurple : Colors.white,
            child: chatMessages.length == 0
                ? MessageFreeChat(
                    textController: _textController,
                    handleSubmitted: _handleSubmitted,
                    isLoading: widget.isLoading)
                : Column(
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          reverse: false,
                          child: Column(
                            children: messagesWidget,
                          ),
                        ),
                      ),
                      Divider(height: 1.0),
                      MessageBox(
                          textController: _textController,
                          handleSubmitted: _handleSubmitted,
                          isLoading: widget.isLoading)
                    ],
                  ),
          ),
        );
      },
    );
  }
}
