import 'dart:convert';

import "package:gpt_clone/global_data/user.dart";
import 'package:gpt_clone/translations/maping_messages.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'routes.dart';

Future<String> signup(
    {required first_name,
    required last_name,
    required email,
    required password,
    required re_password,
    required context}) async {
  // send the request to server
  // check if the info enter is valid
  try {
    var jsonObject = {
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password,
      "re_password": re_password,
    };
    var stringifiedJson = jsonEncode(jsonObject);
    // Set the url
    Uri url = Uri.parse(AppRoutes.signupRoute);
    // set header
    var headers = {
      'Content-type': 'application/json',
    };
    var respond = await http.post(url, body: stringifiedJson, headers: headers);
    if (respond.statusCode == 201) {
      var decodedRespond = jsonDecode(respond.body);
      String userId = decodedRespond["id"].toString();
      Provider.of<User>(context, listen: false).createUser(
          first_name: first_name,
          last_name: last_name,
          email: email,
          id: userId);
      return "";
    } else {
      print(jsonDecode(respond.body));
      var mapKey = jsonDecode(respond.body).keys.toList();
      var backendErrorMessage = jsonDecode(respond.body)[mapKey[0]][0];
      var mappedValue = mapBackendOutput(backendRespond: backendErrorMessage);
      var errorMessage = mappedValue;
      return errorMessage;
    }
  } catch (e) {
    print(e);
    return e.toString();
  }
  return "";
}
