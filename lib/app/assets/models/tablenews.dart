// To parse this JSON data, do
//
//     final tableNews = tableNewsFromJson(jsonString);

import 'dart:convert';

TableNews tableNewsFromJson(String str) => TableNews.fromJson(json.decode(str));

String tableNewsToJson(TableNews data) => json.encode(data.toJson());

class TableNews {
  TableNews({
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

  factory TableNews.fromJson(Map<String, dynamic> json) => TableNews(
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

  static List<TableNews> fromJsonList(List list) {
    if (list == null) return List<TableNews>.empty();
    return list.map((item) => TableNews.fromJson(item)).toList();
  }
}
