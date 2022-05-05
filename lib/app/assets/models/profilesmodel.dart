// To parse this JSON data, do
//
//     final profilesModel = profilesModelFromJson(jsonString);

import 'dart:convert';

ProfilesModel profilesModelFromJson(String str) =>
    ProfilesModel.fromJson(json.decode(str));

String profilesModelToJson(ProfilesModel data) => json.encode(data.toJson());

class ProfilesModel {
  ProfilesModel({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.avatarUrl,
    required this.website,
  });

  String id;
  String updatedAt;
  String username;
  String avatarUrl;
  String website;

  factory ProfilesModel.fromJson(Map<String, dynamic> json) => ProfilesModel(
        id: json["id"],
        updatedAt: json["updated_at"],
        username: json["username"],
        avatarUrl: json["avatar_url"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt,
        "username": username,
        "avatar_url": avatarUrl,
        "website": website,
      };

  static List<ProfilesModel> fromJsonList(List list) {
    if (list == null) return List<ProfilesModel>.empty();
    return list.map((item) => ProfilesModel.fromJson(item)).toList();
  }
}


  // "created_at": DateTime.now().toIso8601String()