import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_clone/screens/confirmation.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  static const routeName = "\feedbackScreen";
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  bool _validateEmail = false;
  bool _validateFeedback = false;
  var isDarkMood = true;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String feedback = _feedbackController.text;

      if (feedback.isEmpty) {
        // Feedback field is empty, handle the validation logic here
        return;
      }

      sendPostRequest(email, feedback);
      email = _emailController.text;

      _emailController.text = "";
      _feedbackController.text = "";
      Navigator.pushNamed(context, ConfirmationScreen.routeName, arguments: {
        'email': email,
      });
      print('Email: $email');
      print('Feedback: $feedback');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> sendPostRequest(email, feedback) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse('http://192.168.1.151:3000/review_feedback');
    var body = jsonEncode({
      'email': email,
      'feedback': feedback,
    });
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var sunIcon = SvgPicture.asset(
      'assets/icons/sun.svg', // Replace this with the path to your globe icon SVG file
      width: 24,
      height: 24,
      color: Colors.white,
    );
    var moonIcon = SvgPicture.asset(
      'assets/icons/moon.svg', // Replace this with the path to your globe icon SVG file
      width: 24,
      height: 24,
      color: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Feeback Center"),
        actions: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: SvgPicture.asset(
              'assets/icons/globe.svg', // Replace this with the path to your globe icon SVG file
              width: 24,
              height: 24,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
              onPressed: () {
                print("pressed");
                setState(() {
                  isDarkMood = isDarkMood;
                });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: isDarkMood ? moonIcon : sunIcon)
        ],
        backgroundColor: Color.fromRGBO(85, 54, 218, 1),
      ),
      backgroundColor: Color.fromARGB(68, 70, 84, 255),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Color.fromRGBO(85, 54, 218, 1),
                child: Icon(Icons.person, color: Colors.white, size: 160),
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please enter your email",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  errorText:
                      _validateEmail ? 'Please enter a valid email' : null,
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    setState(() {
                      _validateEmail = true;
                    });
                    return '';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Feedback",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _validateFeedback = true;
                    });
                    return 'Please provide your feedback before submitting!';
                  }
                  return null;
                },
                maxLines: null,
                controller: _feedbackController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  labelText: 'Please provide your feedback here!',
                  labelStyle: TextStyle(color: Colors.grey),
                  errorText:
                      _validateFeedback ? 'Please Provide a feedback!' : null,
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.purple,
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.20,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(85, 54, 218, 1),
                        minimumSize:
                            Size(200, 48), // Set the desired width and height
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Submit'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.send_outlined,
                              color: Colors.grey.shade300,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Color.fromRGBO(85, 54, 218, 1),
                child: Icon(Icons.person, color: Colors.white, size: 160),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  errorText:
                      _validateEmail ? 'Please enter a valid email' : null,
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    setState(() {
                      _validateEmail = true;
                    });
                    return '';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                maxLines: null,
                controller: _feedbackController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  labelText: 'Please provide your feedback here!',
                  labelStyle: TextStyle(color: Colors.grey),
                  errorText:
                      _validateEmail ? 'Please enter a valid email' : null,
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.purple,
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.32,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(85, 54, 218, 1),
                        minimumSize:
                            Size(200, 48), // Set the desired width and height
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Submit'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.send_outlined,
                              color: Colors.grey.shade300,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
