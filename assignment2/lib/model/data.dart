import 'dart:convert';

import 'package:assignment2/model/user_model.dart';
import 'package:http/http.dart' as http;

class Users {
  List<UserData> userslist = [];

  Future<void> getData() async {
    String url = "https://reqres.in/api/users?page=2";

    var response = await http.get(url);
    var json = jsonDecode(response.body);

    if (json["page"] != null) {
      json["data"].forEach((element) {
        UserData model = UserData(
            firstName: element["first_name"],
            lastName: element["last_name"],
            email: element["email"],
            avatar: element["avatar"]);
        userslist.add(model);
      });
    }
  }
}
