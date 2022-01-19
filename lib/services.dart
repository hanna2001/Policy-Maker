import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.

import 'Responses.dart';

class Services {
  static const ROOT = 'https://kohli.studio/apps/privacy/insurance_chooser.php';
  static const GET1 = 'table1';
  static const GET2 = 'table2';
  static const GET3 = 'table3';
  static const GET4 = 'table4';
  static const GET5 = 'table5';
  static const GET6 = 'table6';
  static const GET7 = 'table7';
  static const GET8 = 'table8';
  static const GET9 = 'table9';
  static const GET10 = 'table10';
  static const GET11 = 'table11';
  static const GET12 = 'table12';
  // Method to create the table Responsess.
  static Future<List<Responses>> get1() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET1;
      final response = await http.post(ROOT, body: map);
      print('Table 1 response: ${response.body}');
      print(response.statusCode);
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 1);
        print(list);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static List<Responses> parseResponse(String responseBody, int i) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Responses> list =
        parsed.map<Responses>((json) => Responses.fromJson(json, i)).toList();
    print("List is:" + list.length.toString());
    return list;
  }

  static Future<List<Responses>> get2(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET2;
      map['insurance_name'] = insurance[0];
      final response = await http.post(ROOT, body: map);
      print('Table 2 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 2);
        print(list[0].insurance);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> get3(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET3;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      final response = await http.post(ROOT, body: map);
      print('Table 3 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 3);
        print(list[0].insurance);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> get4(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET4;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['member_type'] = insurance[2];
      final response = await http.post(ROOT, body: map);
      print('Table 4 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 4);
        print(list[0].insurance);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> getGST(String parameter) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'table11';
      map['parameter'] = parameter;
      final response = await http.post(ROOT, body: map);
      print('Table 11 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 15);
        print(list[0].insurance);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<String> getDetails(String parameter) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'table11';
      map['parameter'] = parameter;
      final response = await http.post(ROOT, body: map);
      print('Table 11 response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null; // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> get5(List<String> insurance) async {
    try {
      print("In the function");
      var map = Map<String, dynamic>();
      map['action'] = GET5;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['member_type'] = insurance[2];
      map['company_name'] = insurance[3];
      final response = await http.post(ROOT, body: map);
      print('Table 5 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 5);
        print(list[0].insurance);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> getFeature1(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET10;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['company_name'] = insurance[2];
      map['member_type'] = insurance[3];
      map['plan_name'] = insurance[4];
      final response = await http.post(ROOT, body: map);
      print('Table 10 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 10);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> getFeature2(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET11;
      map['p_add_ons_id'] = id;
      final response = await http.post(ROOT, body: map);
      print('Table 11 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 11);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> get6(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET6;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['member_type'] = insurance[2];
      map['company_name'] = insurance[3];
      map['plan_name'] = insurance[4];
      if (int.parse(insurance[5]) > 75) {
        map['age'] = "76";
      } else {
        map['age'] = insurance[5];
      }
      final response = await http.post(ROOT, body: map);
      print('Table 6 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 6);
        print(list[0].insurance);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> get7(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET7;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['member_type'] = insurance[2];
      if (int.parse(insurance[5]) > 75) {
        map['age'] = "76";
      } else {
        map['age'] = insurance[5];
      }
      map['company_name'] = insurance[3];
      map['plan_name'] = insurance[4];
      map['sum_insured'] = insurance[6];
      final response = await http.post(ROOT, body: map);
      print('Table 7 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 7);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<List<Responses>> get8(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET8;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['member_type'] = insurance[2];
      if (int.parse(insurance[5]) > 75) {
        map['age'] = "76";
      } else {
        map['age'] = insurance[5];
      }
      map['company_name'] = insurance[3];
      map['plan_name'] = insurance[4];
      map['sum_insured'] = insurance[6];
      final response = await http.post(ROOT, body: map);
      print('Table 8 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Responses> list = parseResponse(response.body, 8);
        return list;
      } else {
        return List<Responses>();
      }
    } catch (e) {
      return List<Responses>(); // return an empty list on exception/error
    }
  }

  static Future<String> get9(List<String> insurance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET9;
      map['insurance_name'] = insurance[0];
      map['insurance_type'] = insurance[1];
      map['member_type'] = insurance[2];
      if (int.parse(insurance[5]) > 75) {
        map['age'] = "76";
      } else {
        map['age'] = insurance[5];
      }
      map['company_name'] = insurance[3];
      map['plan_name'] = insurance[4];
      map['sum_insured'] = insurance[6];
      final response = await http.post(ROOT, body: map);
      print('Table 9 response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body.toString();
      } else {
        return "0";
      }
    } catch (e) {
      return "0"; // return an empty list on exception/error
    }
  }

  // static Future<List<Final>> get8(String Age, String id) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = GET7;
  //     map['age'] = Age;
  //     map['id'] = id;
  //     final response = await http.post(ROOT, body: map);
  //     print('Table 8 response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       List<Final> list = parseResponseFinal(response.body);
  //       return list;
  //     } else {
  //       return List<Final>();
  //     }
  //   } catch (e) {
  //     return List<Final>(); // return an empty list on exception/error
  //   }
  // }

  // static Future<List<Responses>> getAge(String id) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = GET8;
  //     map['p_add_ons_id'] = id;
  //     final response = await http.post(ROOT, body: map);
  //     print('Table 8 response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       List<Responses> list = parseResponse(response.body, 8);
  //       print(list);
  //       return list;
  //     } else {
  //       return List<Responses>();
  //     }
  //   } catch (e) {
  //     return List<Responses>(); // return an empty list on exception/error
  //   }
  // }

  // static Future<List<Responses>> getSum(String id, String age) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = GET9;
  //     map['p_add_ons_id'] = id;
  //     map['age'] = age;
  //     final response = await http.post(ROOT, body: map);
  //     print('Table getSum response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       List<Responses> list = parseResponse(response.body, 9);
  //       print(list);
  //       return list;
  //     } else {
  //       return List<Responses>();
  //     }
  //   } catch (e) {
  //     return List<Responses>(); // return an empty list on exception/error
  //   }
  // }

  // static Future<List<Responses>> getPremium(
  //     String id, String age, String sumInsured) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = GET12;
  //     map['p_add_ons_id'] = id;
  //     map['age'] = age;
  //     map['sum_insured'] = sumInsured;
  //     final response = await http.post(ROOT, body: map);
  //     print('Table getPremium response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       List<Responses> list = parseResponse(response.body, 12);
  //       print(list);
  //       return list;
  //     } else {
  //       return List<Responses>();
  //     }
  //   } catch (e) {
  //     return List<Responses>(); // return an empty list on exception/error
  //   }
  // }
}
