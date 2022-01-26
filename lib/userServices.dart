import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.

import 'User.dart';

class UserServices {
  static const ROOT = 'https://kohli.studio/apps/ks-insurebuddy/user_information.php';

  // Method to create the table Responsess.
  static Future<String> createUser(
      String Phone, String date, String IMEI) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "create_user";
      map['Phone'] = Phone;
      map['Expiry'] = date;
      print(map['Expiry'] + " Expiry Date");
      map['IMEI'] = IMEI;
      print(map);
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      // var res=jsonDecode(response.body);
      print('Table 1 response: $response');
      print(response.toString());
      if (response.body.contains("success"))  {
        return "User created Successfully";
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return '---Err'+e.toString();
    }
  }

  static Future<String> createFeedback(String Phone, String feedback) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "feedback";
      map['Phone'] = Phone;
      map['feedback'] = feedback;
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      print('Table feedback response: ${response.body}');
      print(response.toString());
      if (response.body.contains("success")) {
        return "Feedback registered Successfully";
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> getUsername() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "get_user";
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      print('Table 5 response: ${response.body}');
      print(response.body);
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> getPassword() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "get_password";
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      print('Table 6 response: ${response.body}');
      print(response.body);
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> uploadImage(File picture, String phone) async {
    try {
      var map = Map<dynamic, dynamic>();
      map['action'] = "upload_image";
      // map['picture'] = base64.encode(picture.readAsBytesSync());
      List<int> bytes = await picture.readAsBytesSync();
      map['picture'] = base64Encode(bytes);
      print(map['picture'].toString().length);
      map['Phone'] = phone;
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      print('Table 7 response: ${response.body}');
      print(response.body);
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> userExists(String Phone) async {
    var map = Map<String, dynamic>();
    map['action'] = "user_exists";
    map['Phone'] = Phone;
    var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map,);
    print('------Table 4 response: ${response.body}');
    print(response.statusCode);
    if (200 == response.statusCode) {
      if (response.body == "Exists") {
        return true;
      }
    }
    return false;
  }

  static Future<String> updateUser(
      String parameter, String value, String phone) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "update_user";
      map['parameter'] = parameter;
      map['value'] = value;
      map['Phone'] = phone;
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      print('Table 2 response: ${response.body}');
      print(response.statusCode);
      if (response.body == "success") {
        return "User updated Successfully";
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<User>> getData(String phone) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "get_user";
      map['Phone'] = phone;
      var url=Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      print('Table 3 response: ${response.body}');
      // print(response.statusCode);
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        // print(list[0].logoUrl.toString().length);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }

  static List<User> parseResponse(String responseBody) {
    dynamic parsed;
    parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    try {
      List<User> list =
          parsed.map<User>((json) => User.fromJson(json)).toList();
      return list;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
