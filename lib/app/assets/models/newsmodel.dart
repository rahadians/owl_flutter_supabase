// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    required this.idNews,
    required this.content,
    required this.title,
    required this.createdAt,
    required this.description,
    required this.dateNews,
    required this.idUser,
    required this.imageUrl,
  });

  int idNews;
  String content;
  String title;
  String createdAt;
  String description;
  String dateNews;
  String idUser;
  String imageUrl;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        idNews: json["id_news"],
        content: json["content"],
        title: json["title"],
        createdAt: json["created_at"],
        description: json["description"],
        dateNews: json["date_news"],
        idUser: json["id_user"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id_news": idNews,
        "content": content,
        "title": title,
        "created_at": createdAt,
        "description": description,
        "date_news": dateNews,
        "id_user": idUser,
        "imageUrl": imageUrl,
      };

  static List<NewsModel> fromJsonList(List list) {
    if (list == null) {
      print("data kosong");
      return List<NewsModel>.empty();
    }
    // }return List<NewsModel>.empty();
    return list.map((item) => NewsModel.fromJson(item)).toList();
  }
}
