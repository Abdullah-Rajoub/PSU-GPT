import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  static const routeName = "\\ConfimationScreen";

  ConfirmationScreen();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Color.fromARGB(68, 70, 84, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 48),
            child: Icon(
              Icons.check_circle_rounded,
              size: 200,
              color: Colors.lightGreen,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Submitted Successfully',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 58),
          Text(
            'Thank you for your feedback. Your feedback was submitted successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text.rich(
            TextSpan(
              text: 'Review of your feedback will be sent to your email ',
              style: TextStyle(fontSize: 11, color: Colors.white),
              children: [
                TextSpan(
                  text: arguments['email'],
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.16,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(85, 54, 218, 1),
                    minimumSize:
                        Size(200, 48), // Set the desired width and height
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('BACK'),
                        ),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
