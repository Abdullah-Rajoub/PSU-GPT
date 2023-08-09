// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:flutter_login/flutter_login.dart';
// import 'package:gpt_clone/models/chats.dart';
// import 'package:gpt_clone/screens/chat_screen.dart';
// import 'package:gpt_clone/screens/login_screen.dart';
// import 'package:gpt_clone/utility/constant/colors.dart';
// import 'package:gpt_clone/utility/constant/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// // [
// // const UserFormField(
// // keyName: 'Username',
// // icon: Icon(FontAwesomeIcons.userLarge),
// // ),
// // const UserFormField(keyName: 'Name'),
// // const UserFormField(keyName: 'Surname'),
// // UserFormField(
// // keyName: 'phone_number',
// // displayName: 'Phone Number',
// // userType: LoginUserType.phone,
// // fieldValidator: (value) {
// // final phoneRegExp = RegExp(
// // '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
// // );
// // if (value != null &&
// // value.length < 7 &&
// // !phoneRegExp.hasMatch(value)) {
// // return "This isn't a valid phone number";
// // }
// // return null;
// // },
// // ),
// // ]
//
// class _LoginState extends State<Login> {
//   Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
//
//   // Future<String?> _loginUser(LoginData data) {
//   //   return Future.delayed(loginTime).then((_) {
//   //     if (!mockUsers.containsKey(data.name)) {
//   //       return 'User not exists';
//   //     }
//   //     if (mockUsers[data.name] != data.password) {
//   //       return 'Password does not match';
//   //     }
//   //     return null;
//   //   });
//   // }
//   //
//   // Future<String?> _signupUser(SignupData data) {
//   //   return Future.delayed(loginTime).then((_) {
//   //     return null;
//   //   });
//   // }
//   //
//   // Future<String?> _recoverPassword(String name) {
//   //   return Future.delayed(loginTime).then((_) {
//   //     if (!mockUsers.containsKey(name)) {
//   //       return 'User not exists';
//   //     }
//   //     return null;
//   //   });
//   // }
//   //
//   // Future<String?> _signupConfirm(String error, LoginData data) {
//   //   return Future.delayed(loginTime).then((_) {
//   //     return null;
//   //   });
//   // }
//
// // Function to show the alert when users data is confilted with database
//   void showAlert(BuildContext context, errorMesage) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('An error has accoured'),
//           content: Text('$errorMesage'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Close the alert dialog
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMood = Provider.of<AllChats>(context, listen: true).isDarkMood;
//     return LayoutBuilder(builder: (context, constraints) {
//       // Constrains on size are saved here, so we can make the design responsive.
//       final maxWidth = constraints.maxWidth;
//       final maxHeight = constraints.maxHeight;
//       double titleFontSize;
//       double textFieldFontSize;
//
//       if (maxHeight > 750) {
//       } else {}
//       // Adjust the font size based on the device width
//       if (maxWidth >= 600) {
//         titleFontSize = 18;
//         textFieldFontSize = 12;
//       } else if (maxWidth >= 400) {
//         titleFontSize = 16;
//         textFieldFontSize = 10;
//       } else {
//         titleFontSize = 12;
//         textFieldFontSize = 8;
//       }
//
//       print("inside the toggle selection max width is: $maxWidth");
//       return Consumer<AllChats>(builder: (context, allChats, child) {
//         bool isDarkMood =
//             Provider.of<AllChats>(context, listen: true).isDarkMood;
//         return Consumer<AllChats>(
//           builder: (context, child, allChat) {
//             return FlutterLogin(
//               footer: "PSU-GPT Beta Version | PSU RIOTU Lab",
//               additionalSignupFields: [
//                 UserFormField(
//                   keyName: "first_name",
//                   displayName: "First Name",
//                 ),
//                 UserFormField(
//                   keyName: "last_name",
//                   displayName: "Last Name",
//                 )
//               ],
//               title: "PSU Assistant",
//               logo: isDarkMood
//                   ? "assets/icons/RIOTUlogo.png"
//                   : "assets/icons/RIOTULogoBlack.png",
//               logoTag: Constants.logoTag,
//               titleTag: Constants.titleTag,
//               navigateBackAfterRecovery: true,
//               // onConfirmRecover: _signupConfirm,
//               // onConfirmSignup: _signupConfirm,
//               loginAfterSignUp: true,
//               // scrollable: true,
//               // hideProvidersTitle: false,
//               // loginAfterSignUp: false,
//               // hideForgotPasswordButton: true,
//               // hideSignUpButton: true,
//               disableCustomPageTransformer: true,
//
//               messages: LoginMessages(
//                 providersTitleFirst: "Or",
//                 providersTitleSecond: "or",
//               ),
//               loginProviders: [
//                 LoginProvider(
//                     callback: () {},
//                     label: "Keep using in guest mood",
//                     button: Buttons.anonymous)
//               ],
//
//               theme: LoginTheme(
//                 footerTextStyle:
//                     TextStyle(color: AppColors.accent, fontSize: 10),
//                 accentColor: AppColors.callToAction,
//                 primaryColor: isDarkMood ? AppColors.accent : AppColors.Laccent,
//
//                 // accentColor: Colors.yellow,
//                 // errorColor: Colors.deepOrange,
//                 pageColorLight:
//                     isDarkMood ? AppColors.loginBackground : Colors.white,
//                 pageColorDark:
//                     isDarkMood ? AppColors.loginBackground : Colors.white,
//                 // pageColorDark: Colors.indigo.shade500,
//
//                 titleStyle: TextStyle(
//                   color: isDarkMood ? Colors.white : AppColors.Laccent,
//                   fontFamily: 'Quicksand',
//                   letterSpacing: 4,
//                   fontSize: titleFontSize,
//                 ),
//                 // beforeHeroFontSize: 50,
//                 // afterHeroFontSize: 20,
//                 bodyStyle: TextStyle(
//                   fontStyle: FontStyle.italic,
//                   decoration: TextDecoration.underline,
//                 ),
//                 textFieldStyle: TextStyle(
//                   fontSize: textFieldFontSize,
//                   color: isDarkMood ? AppColors.Laccent : AppColors.Laccent,
//                 ),
//                 buttonStyle: TextStyle(
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.accent,
//                 ),
//                 cardTheme: CardTheme(
//                   color: AppColors.LdarkPurple,
//                   elevation: 5,
//                   margin: EdgeInsets.only(top: 15),
//                   shape: ContinuousRectangleBorder(
//                       borderRadius: BorderRadius.circular(100.0)),
//                 ),
//                 inputTheme: InputDecorationTheme(
//                   filled: true,
//                   fillColor: Colors.transparent,
//                   contentPadding: EdgeInsets.zero,
//                   errorStyle: TextStyle(color: AppColors.invalidInout),
//                   labelStyle: TextStyle(fontSize: 12),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.accent, width: 1),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: AppColors.DlightPurple, width: 1),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: AppColors.invalidInout, width: 1),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.accent, width: 1),
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 1),
//                   ),
//                 ),
//                 buttonTheme: LoginButtonTheme(
//                   splashColor: AppColors.UserIcon,
//                   backgroundColor: AppColors.callToAction,
//                   elevation: 9.0,
//                   highlightElevation: 6.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(60),
//                   ),
//                   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                   // shape: CircleBorder(side: BorderSide(color: Colors.green)),
//                   // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
//                 ),
//               ),
//               userValidator: (value) {
//                 if (!value!.contains('@') || !value.endsWith('.com')) {
//                   return "Email must contain '@' and end with '.com'";
//                 }
//                 return null;
//               },
//               passwordValidator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Password is empty';
//                 }
//                 return null;
//               },
//               onLogin: (loginData) async {
//                 Map<String, String> jsonObject = {
//                   'email': "${loginData.name}",
//                   'password': "${loginData.password}",
//                 };
//                 var sentOutput = jsonEncode(jsonObject);
//                 String url = "http://10.0.2.2:8000/auth/jwt/create/";
//                 var response =
//                     await http.post(Uri.parse(url), body: sentOutput, headers: {
//                   'Content-type': 'application/json',
//                 });
//                 print("sent");
//                 if (response.statusCode == 200) {
//                   print("working");
//                 } else {
//                   Provider.of<AllChats>(context, listen: false).createUser(
//                       email: loginData.name, error: response.body.toString());
//                   Navigator.pushNamed(context, LoginScreen.namedRoute);
//                   showAlert(context, jsonDecode(response.body)["detail"]);
//
//                   print("Not working");
//                   print(response.reasonPhrase);
//                   print(response.body.toString());
//                 }
//                 debugPrint('Login info');
//                 debugPrint('Name: ${loginData.name}');
//                 debugPrint('Password: ${loginData.password}');
//                 // return _loginUser(loginData);
//               },
//               onSignup: (signupData) async {
//                 Map<String, String> jsonObject = {
//                   'email': "${signupData.name}",
//                   'password': "${signupData.password}",
//                   're_password': "${signupData.password}"
//                 };
//                 signupData.additionalSignupData?.forEach((key, value) {
//                   jsonObject[key] = value;
//                 });
//                 var sentOutput = jsonEncode(jsonObject);
//                 String url = "http://10.0.2.2:8000/auth/users/";
//                 var response =
//                     await http.post(Uri.parse(url), body: sentOutput, headers: {
//                   'Content-type': 'application/json',
//                 });
//                 print("sent");
//                 if (response.statusCode == 200) {
//                   print("working");
//                 } else {
//                   Provider.of<AllChats>(context, listen: false).createUser(
//                       email: signupData.name, error: response.body.toString());
//                   Navigator.pushNamed(context, LoginScreen.namedRoute);
//
//                   showAlert(context, jsonDecode(response.body)["detail"]);
//                   print("Not working");
//                   print(response.reasonPhrase);
//                   print(response.body.toString());
//                 }
//                 debugPrint('Signup info');
//                 debugPrint('Name: ${signupData.name}');
//                 debugPrint('Password: ${signupData.password}');
//
//                 signupData.additionalSignupData?.forEach((key, value) {
//                   debugPrint('$key: $value');
//                 });
//                 if (signupData.termsOfService.isNotEmpty) {
//                   debugPrint('Terms of service: ');
//                   for (final element in signupData.termsOfService) {
//                     debugPrint(
//                       ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
//                     );
//                   }
//                 }
//                 // return _signupUser(signupData);
//               },
//               onSubmitAnimationCompleted: () {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => ChatScreen(),
//                 ));
//               },
//               onRecoverPassword: (name) {
//                 debugPrint('Recover password info');
//                 debugPrint('Name: $name');
//                 // return _recoverPassword(name);
//                 // Show new password dialog
//               },
//               // headerWidget: const IntroWidget(),
//             );
//           },
//         );
//       });
//     });
//   }
// }
