// To parse this JSON data, do
//
//     final readmeNews = readmeNewsFromJson(jsonString);

import 'dart:convert';

ReadmeNews readmeNewsFromJson(String str) =>
    ReadmeNews.fromJson(json.decode(str));

String readmeNewsToJson(ReadmeNews data) => json.encode(data.toJson());

class ReadmeNews {
  ReadmeNews({
    required this.imgUrl,
    required this.newsModelImg,
    required this.newsModelTitle,
    required this.newsModelContent,
  });

  String imgUrl;
  String newsModelImg;
  String newsModelTitle;
  String newsModelContent;

  factory ReadmeNews.fromJson(Map<String, dynamic> json) => ReadmeNews(
        imgUrl: json["imgUrl"],
        newsModelImg: json["newsModelImg"],
        newsModelTitle: json["newsModelTitle"],
        newsModelContent: json["newsModelContent"],
      );

  Map<String, dynamic> toJson() => {
        "imgUrl": imgUrl,
        "newsModelImg": newsModelImg,
        "newsModelTitle": newsModelTitle,
        "newsModelContent": newsModelContent,
      };

  static List<ReadmeNews> fromJsonList(List list) {
    if (list == null) return List<ReadmeNews>.empty();
    return list.map((item) => ReadmeNews.fromJson(item)).toList();
  }
}
