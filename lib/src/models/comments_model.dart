// To parse this JSON data, do
//
//     final comments = commentsFromJson(jsonString);

import 'dart:convert';

Map<String, Comments> commentsFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Comments>(k, Comments.fromJson(v)));

String commentsToJson(Map<String, Comments> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Comments {
    Comments({
        this.comment,
        this.commentAt,
        this.newsId,
        this.userId,
        this.username,
    });

    String comment;
    DateTime commentAt;
    String newsId;
    String userId;
    String username;

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        comment: json["comment"],
        commentAt: DateTime.parse(json["commentAt"]),
        newsId: json["newsId"],
        userId: json["userId"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "commentAt": commentAt.toIso8601String(),
        "newsId": newsId,
        "userId": userId,
        "username": username,
    };
}