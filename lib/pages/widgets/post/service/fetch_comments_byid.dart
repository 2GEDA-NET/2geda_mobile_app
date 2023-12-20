import 'dart:convert';

import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/post/data/comment_model.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchCommentsByPostID(String id) async {
  try {
    final token = TokenManager().getToken();
    Map<String, String> serviceHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token 65b55bb46605a175c3d5f16be2bcb83e7015305c',
    };

    final response = await http.get(
        Uri.parse(
            'https://king-prawn-app-venn6.ondigitalocean.app/feed/get-comment/$id/'),
        headers: serviceHeaders);

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        final List<dynamic> userList = responseData;
        final List<Post> modelsList =
            userList.map((userData) => Post.fromJson(userData)).toList();

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
