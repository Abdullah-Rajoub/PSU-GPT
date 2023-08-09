import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/backend/signup.dart';
import 'package:gpt_clone/components/login_signup_ compoenents/custom_text_field.dart';
import 'package:gpt_clone/components/login_signup_ compoenents/error_message.dart';
import 'package:gpt_clone/components/login_signup_ compoenents/sibling_text_fields.dart';
import 'package:gpt_clone/components/login_signup_ compoenents/sucessful_sign_up_dialog.dart';
import 'package:gpt_clone/components/shared_components/appbar.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/screens/chat_screen.dart';
import 'package:gpt_clone/screens/login_screen.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/SignupScreen";
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String backendErrorMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String emailError = "";
  String fullNameError = "";

  String passwordError = "";
  @override
  Widget build(BuildContext context) {
    if (!backendErrorMessage.isEmpty) passwordError = backendErrorMessage.tr();
    bool isDarkMood = Provider.of<AppSettings>(context).isDarkMood;
    var logo = SvgPicture.asset(
      isDarkMood
          ? "assets/icons/PSULogoWhite.svg"
          : "assets/icons/PSULogoBlack.svg",
      width: 50,
      height: 50,
    );

    bool isValidEmail(String email) {
      // Regular expression pattern for validating an email address
      final emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
      // Create a RegExp object from the regex pattern
      final regex = RegExp(emailRegex);
      // Use the RegExp hasMatch() method to check if the email matches the pattern
      return regex.hasMatch(email);
    }

    bool arePasswordsMatching() {
      if (passwordController.value.text == confirmPasswordController.value.text)
        return true;
      else
        return false;
    }

    bool passwordIsEmpty() {
      if (passwordController.value.text.isEmpty ||
          confirmPasswordController.value.text.isEmpty)
        return true;
      else
        return false;
    }

    bool isPasswordTooShort() {
      if (passwordController.value.text.length <= 8)
        return true;
      else
        return false;
    }

    bool validateInpute() {
      bool isValid = true;
      // check if the full name is empty
      if (fNameController.value.text.isEmpty ||
          lNameController.value.text.isEmpty) {
        fullNameError = fullNameError = LocaleKeys.fillFullName;
        isValid = false;
      }
      // check for valid email address.
      if (!isValidEmail(emailController.value.text)) {
        emailError = LocaleKeys.invalidEmail;
        isValid = false;
      }
      if (passwordIsEmpty()) {
        passwordError = LocaleKeys.emptyPassword;
        isValid = false;
      } else if (isPasswordTooShort()) {
        passwordError = LocaleKeys.passwordTooShort;
        isValid = false;
      } else if (!arePasswordsMatching()) {
        isValid = false;
        passwordError = LocaleKeys.passwordNoMatch;
      }
      setState(() {});
      return isValid;
    }

    return Scaffold(
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
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.createUrAccount.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isDarkMood ? Colors.white : Colors.black87),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SibilingTextFields(
                        label: LocaleKeys.fullName.tr(),
                        hint: "aaa",
                        onChange: (t) {},
                        enabled: true,
                        controllerOne: fNameController,
                        controllerTwo: lNameController,
                      ),
                      fullNameError.isEmpty
                          ? SizedBox(
                              height: 8,
                            )
                          : ErrorMessage(errorMessage: fullNameError.tr()),
                      CustomerTextField(
                          isHidden: false,
                          label: LocaleKeys.email.tr(),
                          hint: "Email address",
                          onChange: (t) {},
                          enabled: true,
                          controller: emailController),
                      emailError.isEmpty
                          ? SizedBox(
                              height: 8,
                            )
                          : ErrorMessage(errorMessage: emailError.tr()),
                      CustomerTextField(
                          isHidden: true,
                          label: LocaleKeys.password.tr(),
                          hint: "Password",
                          onChange: (t) {},
                          enabled: true,
                          controller: passwordController),
                      SizedBox(
                        height: 8,
                      ),
                      CustomerTextField(
                          isHidden: true,
                          label: LocaleKeys.confirmPassword.tr(),
                          hint: "Confirm password",
                          onChange: (t) {},
                          enabled: true,
                          controller: confirmPasswordController),
                      passwordError.isEmpty
                          ? SizedBox(
                              height: 12,
                            )
                          : ErrorMessage(errorMessage: passwordError.tr()),
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
                            onPressed: isLoading
                                ? () {
                                    print("currently laoding");
                                  }
                                : () async {
                                    // getting all the data ready for login request.
                                    String first_name =
                                        fNameController.value.text;
                                    String last_name =
                                        lNameController.value.text;
                                    String email = emailController.value.text;
                                    String password =
                                        passwordController.value.text;
                                    String re_password =
                                        confirmPasswordController.value.text;
                                    // setting everything back to empty for after login attempt.
                                    backendErrorMessage = "";
                                    emailError = "";
                                    fullNameError = "";
                                    // check if inpute is valid locally, then send request.
                                    if (validateInpute()) {
                                      print("validated locally");
                                      setState(() {
                                        isLoading = true;
                                      });
                                      // send request for login, and check if there was an error.
                                      backendErrorMessage = await signup(
                                          first_name: first_name,
                                          last_name: last_name,
                                          email: email,
                                          password: password,
                                          re_password: re_password,
                                          context: context);
                                      setState(() {
                                        isLoading = false;
                                      });

                                      if (backendErrorMessage.isEmpty)
                                        ShowSucessfullSignUp(context);
                                      else {
                                        print(backendErrorMessage);
                                        // reload the back to show backend error message.
                                        setState(() {
                                          passwordError =
                                              backendErrorMessage.tr();
                                        });
                                      }
                                    }
                                  },
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
                            LocaleKeys.alreadyHaveAcc.tr(),
                            style: TextStyle(
                                fontSize: 8,
                                color: isDarkMood
                                    ? Colors.white
                                    : Colors.grey.shade600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              " " + LocaleKeys.login.tr(),
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom),
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
                              context.locale.toString() == "en"
                                  ? " ${LocaleKeys.guest.tr()}"
                                  : "${LocaleKeys.guest.tr()}",
                              style: TextStyle(
                                  fontSize: 8,
                                  decoration: TextDecoration.underline,
                                  color: isDarkMood
                                      ? Colors.white
                                      : Colors.grey.shade900),
                            ),
                          )
                        ],
                      )
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
                    " " + LocaleKeys.loginFooterPartTwo.tr(),
                    style: TextStyle(
                        fontSize: 6,
                        color:
                            isDarkMood ? Colors.white : Colors.grey.shade500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
