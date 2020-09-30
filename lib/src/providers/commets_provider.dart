import 'dart:convert';

import 'package:new_app/src/models/comments_model.dart';
import 'package:http/http.dart' as http;

class CommentsProvider {
  Future <List<Comments>> getComments(String newsId) async {
    List<Comments> comments = [];
    final String url = 'https://own-news-c8e27.firebaseio.com/comments/$newsId.json';
    final response = await http.get(url);
    if(response.body == 'null') return comments;
    final Map<String, Comments> commentsMap = commentsFromJson(response.body);
    if(commentsMap.length == 0) return [];
    commentsMap.forEach((key, value) {
      comments.add(value);
    });
    return comments;
  }

  Future <bool> sendComments(String newsId, Comments comment) async {
    final String url = 'https://own-news-c8e27.firebaseio.com/comments/$newsId.json';
    final response = await http.post(url, body: jsonEncode(comment.toJson()));
    print(response);
    if(response.body == 'null') return false;
    return true;
  }
}