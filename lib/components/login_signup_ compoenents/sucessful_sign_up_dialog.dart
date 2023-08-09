import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/screens/login_screen.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

void ShowSucessfullSignUp(BuildContext context) {
  // showGeneralDialog(
  //   context: context,
  //   pageBuilder: (ctx, a1, a2) {
  //     return Container();
  //   },
  //   transitionBuilder: (ctx, a1, a2, child) {
  //     var curve = Curves.easeInOut.transform(a1.value);
  //     return Transform.scale(
  //       scale: curve,
  //       child: _dialog(ctx),
  //     );
  //   },
  //   transitionDuration: const Duration(milliseconds: 400),
  // );
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: _dialog(context),
            ));
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
}

Widget _dialog(BuildContext context) {
  var checkIcon = SvgPicture.asset(
      'assets/icons/material-symbols_check-box-sharp.svg', // Replace this with the path to your globe icon SVG file
      width: 120);
  return FractionallySizedBox(
    widthFactor: 1,
    heightFactor: 0.55,
    child: AlertDialog(
      backgroundColor: Color(0xFFFCFCFC),
      iconPadding: EdgeInsets.symmetric(vertical: 6),
      icon: checkIcon,
      titlePadding: EdgeInsets.all(0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Account created successfully!',
              style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 1.08,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Your account has been created Successfully',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    // Default text style
                    style: TextStyle(fontSize: 10),
                    children: <TextSpan>[
                      TextSpan(
                        text: Provider.of<User>(context).email,
                        style: TextStyle(color: AppColors.success),
                      ),
                      TextSpan(
                        text: ' Please proceed to the login page.',
                        style: TextStyle(fontSize: 9, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Container(
                    height: 24,
                    child: FractionallySizedBox(
                      widthFactor: 0.65,
                      child: ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return AppColors.callToAction; // Disabled color
                              }
                              return AppColors.callToAction; // Default color
                            },
                          ),
                        ),
                        onPressed: () {
                          // Add your navigation logic here
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(fontSize: 9, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
  );
}

void _scaleDialog(BuildContext context) {}
// class StyledTextExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Styled Text Example')),
//       body: Center(
//         child: ,
//       ),
//     );
//   }
// }
