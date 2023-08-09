import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/backend/login.dart';
import 'package:gpt_clone/components/login_signup_ compoenents/custom_text_field.dart';
import 'package:gpt_clone/components/login_signup_ compoenents/error_message.dart';
import 'package:gpt_clone/components/shared_components/appbar.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/screens/signup_screen.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/loginScreenOne";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  simulateAsyncOperation() async {
    print("Start of simulateAsyncOperation");

    await Future.delayed(Duration(seconds: 3), () {
      // This code block will be executed after a delay of 2 seconds
      print("Inside Future.delayed - Simulating async operation");
    });

    print("End of simulateAsyncOperation");
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  String backendErrorMessage = "";
  String emailError = "";
  String passwordError = "";
  bool isValidEmail(String email) {
    // Regular expression pattern for validating an email address
    final emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    // Create a RegExp object from the regex pattern
    final regex = RegExp(emailRegex);
    // Use the RegExp hasMatch() method to check if the email matches the pattern
    return regex.hasMatch(email);
  }

  bool passwordIsEmpty() {
    if (passwordController.value.text.isEmpty)
      return true;
    else
      return false;
  }

  bool emailIsEmpty() {
    if (emailController.value.text.isEmpty)
      return true;
    else
      return false;
  }

  bool validateInpute() {
    bool isValid = true;
    // check for valid email address.
    if (!isValidEmail(emailController.value.text)) {
      emailError = LocaleKeys.invalidEmail;
      isValid = false;
      return false;
    }
    if (emailIsEmpty()) {
      emailError = LocaleKeys.invalidEmail;
      isValid = false;
    }
    if (passwordIsEmpty()) {
      backendErrorMessage = LocaleKeys.emptyPassword;
      isValid = false;
    }
    return isValid;
  }

  void successfulSnackBar({required BuildContext context}) {
    showTopSnackBar(
      Overlay.of(context),
      Container(
          decoration: BoxDecoration(
            color: Color(0xFFf0fdf4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFF82d4a5),
            ),
          ),
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: Color(0xFF16a35f),
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                LocaleKeys.successfulLogin.tr(),
                style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF16a35f),
                    decoration: TextDecoration.none),
              ),
            ],
          )),
      animationDuration: Duration(milliseconds: 1300),
      reverseAnimationDuration: Duration(milliseconds: 700),
      reverseCurve: Curves.fastOutSlowIn,
      displayDuration: Duration(milliseconds: 2000),
    );
  }

  @override
  Widget build(BuildContext context) {
    void onLogIn() async {
      String email = emailController.value.text;
      String password = passwordController.value.text;

      // setting everything back to empty for after login attempt.
      backendErrorMessage = "";
      emailError = "";
      // check if inpute is valid locally, then send request.
      if (validateInpute()) {
        // send request for login, and check if there was an error.
        setState(() {
          isLoading = true;
        });
        backendErrorMessage =
            await login(email: email, password: password, context: context);
        setState(() {
          isLoading = false;
        });
        if (backendErrorMessage.isEmpty) {
          Navigator.pushReplacementNamed(context, ChatScreen.routeName);
          successfulSnackBar(context: context);
        }
      }
      setState(() {});
    }

    bool isDarkMood = Provider.of<AppSettings>(context).isDarkMood;
    var logo = SvgPicture.asset(
      isDarkMood
          ? "assets/icons/PSULogoWhite.svg"
          : "assets/icons/PSULogoBlack.svg",
      width: 50,
      height: 50,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomerAppBar(),
      backgroundColor: Provider.of<AppSettings>(context).isDarkMood
          ? AppColors.DdarkPurple
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Expanded(flex: 2, child: logo),
            Expanded(
              child: Text(
                LocaleKeys.welcomeBack.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDarkMood
                        ? Colors.grey.shade300
                        : Colors.grey.shade600),
              ),
            ),
            Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.logIn.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isDarkMood ? Colors.white : Colors.black87),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CustomerTextField(
                          isHidden: false,
                          label: LocaleKeys.email.tr(),
                          hint: "Email address",
                          onChange: (t) {},
                          enabled: true,
                          controller: emailController),
                      emailError.isEmpty
                          ? SizedBox(
                              height: 12,
                            )
                          : ErrorMessage(errorMessage: emailError.tr()),
                      CustomerTextField(
                          isHidden: true,
                          label: LocaleKeys.password.tr(),
                          hint: "Email address",
                          onChange: (t) {},
                          enabled: true,
                          controller: passwordController),
                      backendErrorMessage.isEmpty
                          ? Container()
                          : ErrorMessage(
                              errorMessage: backendErrorMessage.tr()),
                      SizedBox(
                        height: 3,
                      ),
                      // FractionallySizedBox(
                      //   widthFactor: 0.65,
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         LocaleKeys.forgotPassword.tr(),
                      //         style: TextStyle(
                      //             fontSize: 8,
                      //             color: isDarkMood
                      //                 ? Colors.white
                      //                 : Colors.grey.shade600),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {},
                      //         child: Text(
                      //           " " + LocaleKeys.reset.tr(),
                      //           style: TextStyle(
                      //               fontSize: 8,
                      //               decoration: TextDecoration.underline,
                      //               color: isDarkMood
                      //                   ? Colors.white
                      //                   : Colors.grey.shade900),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 12,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.65,
                        child: Container(
                          height: 20,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return isDarkMood
                                        ? Colors.white
                                        : Color(0xFF393a47);
                                    ; // Disabled color
                                  }
                                  return isDarkMood
                                      ? Colors.white
                                      : Color(0xFF393a47);
                                  ; // Default color
                                },
                              ),
                            ),
                            onPressed: isLoading ? () {} : onLogIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                isLoading
                                    ? LoadingAnimationWidget.prograssiveDots(
                                        color: isDarkMood
                                            ? Colors.black
                                            : Colors.white,
                                        size: 30,
                                      )
                                    : Text(
                                        LocaleKeys.contin.tr(),
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: isDarkMood
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.dontHaveAcc.tr(),
                            style: TextStyle(
                                fontSize: 8,
                                color: isDarkMood
                                    ? Colors.white
                                    : Colors.grey.shade600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, SignupScreen.routeName);
                            },
                            child: Text(
                              LocaleKeys.signup.tr(),
                              style: TextStyle(
                                  fontSize: 8,
                                  decoration: TextDecoration.underline,
                                  color: isDarkMood
                                      ? Colors.white
                                      : Colors.grey.shade900),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 0.4,
                                color: isDarkMood
                                    ? Colors.white
                                    : Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  LocaleKeys.or.tr(),
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: isDarkMood
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 0.4,
                                color: isDarkMood
                                    ? Colors.white
                                    : Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.continueAsGuest.tr(),
                            style: TextStyle(
                                fontSize: 8,
                                color: isDarkMood
                                    ? Colors.white
                                    : Colors.grey.shade600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, ChatScreen.routeName);
                            },
                            child: Text(
                              " " + LocaleKeys.guest.tr(),
                              style: TextStyle(
                                  fontSize: 8,
                                  decoration: TextDecoration.underline,
                                  color: isDarkMood
                                      ? Colors.white
                                      : Colors.grey.shade900),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                )),
            FractionallySizedBox(
              widthFactor: 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.loginFooterPartOne.tr(),
                    style: TextStyle(
                        fontSize: 6,
                        color:
                            isDarkMood ? Colors.white : Colors.grey.shade600),
                  ),
                  SvgPicture.asset(
                    isDarkMood
                        ? "assets/icons/RIOTUlogo.svg"
                        : "assets/icons/RIOTULogoBlack.svg",
                    width: 12,
                  ),
                  Text(
                    LocaleKeys.loginFooterPartTwo.tr(),
                    style: TextStyle(
                        fontSize: 6,
                        color:
                            isDarkMood ? Colors.white : Colors.grey.shade500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
