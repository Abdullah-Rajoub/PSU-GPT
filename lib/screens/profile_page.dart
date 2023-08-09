import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/backend/user_api.dart';
import 'package:gpt_clone/components/profile/customer_text_field.dart';
import 'package:gpt_clone/components/profile/errorMessage.dart';
import 'package:gpt_clone/components/profile/label.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profilePage";
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String errorMessage = "";
  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController =
      TextEditingController(text: 'Last Name');
  TextEditingController emailController =
      TextEditingController(text: '218110141@psu.edu.sa');
  TextEditingController oldPasswordController = TextEditingController(text: '');
  TextEditingController newPasswordController = TextEditingController(text: '');
  var changePasswordIcon = Icons.lock_outline;
  Color dropDownIconColor = Colors.grey.shade400;
  Color dropDownTextColor = Colors.grey.shade400;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  IconData changePasswordDropDownIcon = Icons.keyboard_arrow_down;

  @override
  Widget build(BuildContext context) {
    void onSuccessfulUpdate() {
      Navigator.pop(context);
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
            child: const Row(
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
                  "User details has been updated successfully.",
                  style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF16a35f),
                      decoration: TextDecoration.none),
                ),
              ],
            )),
      );
    }

    User userInfo = Provider.of<User>(context, listen: false);
    String firstName = userInfo.firstName;
    String lastName = userInfo.lastName;
    String email = userInfo.email;
    String profileImage = firstName.trim()[0].toUpperCase() +
        "." +
        lastName.trim()[0].toUpperCase();
    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    emailController = TextEditingController(text: email);
    bool isArabic = context.locale.toString() == "ar";
    bool isDarkMood = Provider.of<AppSettings>(context).isDarkMood;
    simulateAsyncOperation() async {
      print("Start of simulateAsyncOperation");

      await Future.delayed(Duration(seconds: 3), () {
        // This code block will be executed after a delay of 2 seconds
        print("Inside Future.delayed - Simulating async operation");
      });

      print("End of simulateAsyncOperation");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
              color: isDarkMood
                  ? AppColors.verydarkPurple
                  : AppColors.LlightPurple,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: isDarkMood
                                ? Colors.white
                                : AppColors.verydarkPurple,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 0),
                      child: FractionallySizedBox(
                        widthFactor: 0.85,
                        heightFactor: 0.95,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors
                                    .transparent, // Set the border color to transparent
                                width: 0.0, // Adjust the border width as needed
                              )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: FractionallySizedBox(
                                          heightFactor: 0.10,
                                          widthFactor: 1,
                                          child: Container(
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.transparent),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: FractionallySizedBox(
                                          heightFactor: 0.90,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: isDarkMood
                                                    ? Colors.white
                                                    : AppColors
                                                        .tabNonHoverdPurple,
                                                border: Border.all(
                                                    color: isDarkMood
                                                        ? Colors.white
                                                        : AppColors
                                                            .tabNonHoverdPurple),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 18),
                                              child: Column(
                                                children: [
                                                  Expanded(child: Container()),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      LocaleKeys
                                                          .profileInformation
                                                          .tr(),
                                                      style: TextStyle(
                                                          color: isDarkMood
                                                              ? Colors.black
                                                              : Colors.white,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          letterSpacing:
                                                              isArabic
                                                                  ? null
                                                                  : 1.3),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Label(
                                                              label: LocaleKeys
                                                                  .fullName
                                                                  .tr(),
                                                              color: isDarkMood
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      CustomerTextField(
                                                                    controller:
                                                                        firstNameController,
                                                                    enabled:
                                                                        true,
                                                                    hint: "a",
                                                                    onChange:
                                                                        (currentText) {},
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container()),
                                                                Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      CustomerTextField(
                                                                    controller:
                                                                        lastNameController,
                                                                    enabled:
                                                                        true,
                                                                    hint: "a",
                                                                    onChange:
                                                                        (currentText) {},
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Label(
                                                              label: LocaleKeys
                                                                  .email
                                                                  .tr(),
                                                              color: isDarkMood
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            CustomerTextField(
                                                              controller:
                                                                  emailController,
                                                              enabled: false,
                                                              hint: "a",
                                                              onChange:
                                                                  (currentText) {},
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              "* ${LocaleKeys.emailNote.tr()}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                fontSize: 8,
                                                                height: isArabic
                                                                    ? 1
                                                                    : null,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            errorMessage.isEmpty
                                                                ? Container()
                                                                : ErrorMessage(
                                                                    errorMessage:
                                                                        errorMessage)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: ExpansionTile(
                                                      children: [
                                                        // Container(
                                                        //   width:
                                                        //       double.infinity,
                                                        //   child: Column(
                                                        //     crossAxisAlignment:
                                                        //         CrossAxisAlignment
                                                        //             .start,
                                                        //     children: [
                                                        //       Label(
                                                        //         label: LocaleKeys
                                                        //             .oldPassword
                                                        //             .tr(),
                                                        //         color: isDarkMood
                                                        //             ? Colors
                                                        //                 .black
                                                        //             : Colors
                                                        //                 .white,
                                                        //       ),
                                                        //       CustomerTextField(
                                                        //           hint: "a",
                                                        //           onChange:
                                                        //               (t) {},
                                                        //           enabled: true,
                                                        //           controller:
                                                        //               oldPasswordController),
                                                        //       SizedBox(
                                                        //         height: 6,
                                                        //       ),
                                                        //       Label(
                                                        //         label: AutofillHints
                                                        //             .newPassword
                                                        //             .tr(),
                                                        //         color: isDarkMood
                                                        //             ? Colors
                                                        //                 .black
                                                        //             : Colors
                                                        //                 .white,
                                                        //       ),
                                                        //       CustomerTextField(
                                                        //           hint: "a",
                                                        //           onChange:
                                                        //               (t) {},
                                                        //           enabled: true,
                                                        //           controller:
                                                        //               newPasswordController)
                                                        //     ],
                                                        //   ),
                                                        // )
                                                      ],
                                                      onExpansionChanged:
                                                          (isExpanded) {
                                                        if (isExpanded) {
                                                          setState(() {
                                                            changePasswordDropDownIcon =
                                                                Icons
                                                                    .keyboard_arrow_up;
                                                            dropDownIconColor =
                                                                isDarkMood
                                                                    ? AppColors
                                                                        .callToAction
                                                                    : Colors
                                                                        .white;
                                                            dropDownTextColor =
                                                                isDarkMood
                                                                    ? Colors
                                                                        .black87
                                                                    : Colors
                                                                        .white;
                                                            changePasswordIcon =
                                                                Icons
                                                                    .lock_open_sharp;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            changePasswordDropDownIcon =
                                                                Icons
                                                                    .keyboard_arrow_down;
                                                            dropDownIconColor =
                                                                Colors.grey
                                                                    .shade400;
                                                            dropDownTextColor =
                                                                Colors.grey
                                                                    .shade400;
                                                            changePasswordIcon =
                                                                Icons
                                                                    .lock_outlined;
                                                          });
                                                        }
                                                      },
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            changePasswordIcon,
                                                            color:
                                                                dropDownIconColor,
                                                            size: 16,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            LocaleKeys
                                                                .changePassword
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    dropDownTextColor,
                                                                height: isArabic
                                                                    ? 1
                                                                    : null),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Icon(
                                                              changePasswordDropDownIcon,
                                                              color:
                                                                  dropDownIconColor,
                                                              size: 16),
                                                        ],
                                                      ),
                                                      trailing: Container(
                                                        width: 0,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          child:
                                                              FractionallySizedBox(
                                                            widthFactor: 0.55,
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .callToAction,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                width: double
                                                                    .infinity,
                                                                height: double
                                                                    .infinity,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child:
                                                                      TextButton(
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    onPressed:
                                                                        () async {
                                                                      String
                                                                          firstName =
                                                                          firstNameController
                                                                              .value
                                                                              .text;
                                                                      String
                                                                          lastName =
                                                                          lastNameController
                                                                              .value
                                                                              .text;

                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            true;
                                                                      });
                                                                      String
                                                                          reponde =
                                                                          "";
                                                                      if (isLoading)
                                                                        reponde = await UserAPI.editUserDetails(
                                                                            firstName:
                                                                                firstName,
                                                                            lastName:
                                                                                lastName,
                                                                            context:
                                                                                context);
                                                                      else
                                                                        print(
                                                                            "it is laoding");
                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            false;
                                                                      });
                                                                      setState(
                                                                          () {
                                                                        errorMessage =
                                                                            reponde;
                                                                      });
                                                                      if (errorMessage
                                                                          .isEmpty)
                                                                        onSuccessfulUpdate();
                                                                    },
                                                                    child: isLoading
                                                                        ? LoadingAnimationWidget.prograssiveDots(
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                30,
                                                                          )
                                                                        : Text(
                                                                            LocaleKeys.update.tr(),
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12,
                                                                                height: isArabic ? 1 : null),
                                                                          ),
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors
                                                  .transparent, // Set the border color to transparent
                                              width:
                                                  0.0, // Adjust the border width as needed
                                            ),
                                            shape: BoxShape.circle,
                                            color: AppColors.callToAction,
                                          ),
                                          width: 100,
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              profileImage,
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
