import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/screens/welcome_screen.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

import './translations/codegen_loader.g.dart';
import 'global_data/app_setting.dart';
import 'global_data/user.dart';
import 'models/chat.dart';
import 'screens/chat_screen.dart';
import 'screens/confirmation.dart';
import 'screens/feedback_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_page.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    assetLoader: CodegenLoader(),
    supportedLocales: [Locale("en"), Locale("ar")],
    path: "assets/translations",
    fallbackLocale: Locale("en"),
    child: ChangeNotifierProvider(
        create: (context) => AllChats(chatsList: []), child: PSU_Assistant()),
  ));
}

class PSU_Assistant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textHeightStyle;
    bool isArabic = context.locale.toString() == "ar";
    isArabic ? textHeightStyle = 1.0 : textHeightStyle = null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllChats>(
          create: (context) => AllChats(
            chatsList: [
              Chat(chatTitle: "New Chat 0", messages: [], chatID: "0")
            ],
          ),
        ),
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
        ChangeNotifierProvider<AppSettings>(
          create: (context) => AppSettings(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        color: AppColors.DdarkPurple,
        theme: ThemeData(
          textTheme: TextTheme(
              bodyText1: TextStyle(
            height: textHeightStyle,
          )),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: Colors.black),
        ),
        routes: {
          ChatScreen.routeName: (context) => ChatScreen(),
          FeedbackScreen.routeName: (context) => FeedbackScreen(),
          ConfirmationScreen.routeName: (context) => ConfirmationScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          ProfilePage.routeName: (context) => ProfilePage(),
          SignupScreen.routeName: (context) => SignupScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
        },
        home: WelcomeScreen(),
      ),
    );
  }
}
