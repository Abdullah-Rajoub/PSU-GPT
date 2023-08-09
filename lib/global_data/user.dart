import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String email = "";
  String firstName = "";
  String lastName = "";
  String accessToken = "";
  String refreshToken = "";
  String id = "";
  // used on sign up:
  // 1- saves user info to be used in other parts of app
  // 2- Makes sure that it logs you out of the previous account by delete the accee, and refresh tokens
  void createUser(
      {required email, required first_name, required last_name, required id}) {
    this.email = email;
    this.firstName = first_name;
    this.lastName = last_name;
    this.id = id;
    // we start with no tokens
    this.accessToken = "";
    this.refreshToken = "";
    notifyListeners();
  }

  void updateFullName({required firstName, required lastName}) {
    this.firstName = firstName;
    this.lastName = lastName;
    notifyListeners();
  }

  void saveLoginInfo({required email, required access, required refresh}) {
    this.email = email;
    this.refreshToken = refresh;
    this.accessToken = access;
  }

  void getUserInfo(
      {required String id,
      required String email,
      required String firstName,
      required String lastName}) {
    this.email = email;
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
  }

  void logout() {
    this.accessToken = "";
    this.refreshToken = "";
    this.email = "";
    this.lastName = "";
    this.firstName = "";
    this.id = "";
    notifyListeners();
  }

  bool isLoggedin() {
    if (!email.isEmpty)
      return true;
    else
      return false;
  }
}
