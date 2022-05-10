// To parse this JSON data, do
//
//     final addnews = addnewsFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

Addnews addnewsFromJson(String str) => Addnews.fromJson(json.decode(str));

String addnewsToJson(Addnews data) => json.encode(data.toJson());

class Addnews {
  Addnews({
    required this.idUser,
    required this.title,
    required this.content,
    required this.description,
    required this.image,
  });

  String idUser;
  String title;
  String content;
  String description;
  File image;

  factory Addnews.fromJson(Map<String, dynamic> json) => Addnews(
        idUser: json["idUser"],
        title: json["title"],
        content: json["content"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "title": title,
        "content": content,
        "description": description,
        "image": image,
      };

  static List<Addnews> fromJsonList(List list) {
    if (list == null) return List<Addnews>.empty();
    return list.map((item) => Addnews.fromJson(item)).toList();
  }
}
