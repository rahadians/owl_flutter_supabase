// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    required this.idNews,
    required this.image,
    required this.title,
    required this.createdAt,
    required this.content,
    required this.description,
    required this.dateNews,
    required this.idUser,
  });

  int idNews;
  String image;
  String title;
  String createdAt;
  String content;
  String description;
  String dateNews;
  int idUser;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        idNews: json["id_news"],
        image: json["image"],
        title: json["title"],
        createdAt: json["created_at"],
        content: json["content"],
        description: json["description"],
        dateNews: json["date_news"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_news": idNews,
        "image": image,
        "title": title,
        "created_at": createdAt,
        "content": content,
        "description": description,
        "date_news": dateNews,
        "id_user": idUser,
      };
  static List<NewsModel> fromJsonList(List list) {
    if (list == null) return List<NewsModel>.empty();
    return list.map((item) => NewsModel.fromJson(item)).toList();
  }
}
