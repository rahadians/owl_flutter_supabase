// To parse this JSON data, do
//
//     final userResults = userResultsFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

UserResults userResultsFromJson(String str) =>
    UserResults.fromJson(json.decode(str));

String userResultsToJson(UserResults data) => json.encode(data.toJson());

class UserResults {
  UserResults({
    required this.value,
    required this.pesan,
    required this.emailApi,
    required this.usernamedApi,
    required this.iduser,
  });

  int value;
  String pesan;
  String emailApi;
  String usernamedApi;
  int iduser;

  factory UserResults.fromJson(Map<String, dynamic> json) => UserResults(
        value: json["value"],
        pesan: json["pesan"],
        emailApi: json["emailApi"],
        usernamedApi: json["usernamedAPI"],
        iduser: json["iduser"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "pesan": pesan,
        "emailApi": emailApi,
        "usernamedAPI": usernamedApi,
        "iduser": iduser,
      };

  static List<UserResults> fromJsonList(List list) {
    if (list == null) return List<UserResults>.empty();
    return list.map((item) => UserResults.fromJson(item)).toList();
  }
}
