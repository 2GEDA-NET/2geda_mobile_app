import 'dart:convert';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/post/data/comment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<CommentModel>> fetchCommentsByPostID(String id) async {
  try {
    final token = await TokenManager().getToken();
    Map<String, String> serviceHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };

    final response = await http.get(
        Uri.parse('https://development.2geda.net/feed/get-comment/$id/'),
        headers: serviceHeaders);

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        final List<dynamic> userList = responseData;
        final List<CommentModel> modelsList = userList
            .map((userData) => CommentModel.fromJson(userData))
            .toList();

        if (kDebugMode) {
          print('Data loaded successfully');
        }
        if (kDebugMode) {
          print(modelsList[0].commentText[0].content!.isEmpty
              ? ''
              : modelsList[0].commentText[0].content);
        }

        return modelsList;
      }
    } else {
      throw Exception('Failed to get Comments');
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error getting Comments: $error');
    }
  }
  return [];
}
