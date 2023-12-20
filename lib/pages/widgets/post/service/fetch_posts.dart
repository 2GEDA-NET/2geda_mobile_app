import 'dart:convert';

import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchHomePGPosts() async {
  try {
    final token = TokenManager().getToken();
    Map<String, String> serviceHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token 65b55bb46605a175c3d5f16be2bcb83e7015305c',
    };

    final response = await http.get(
        Uri.parse(
            'https://king-prawn-app-venn6.ondigitalocean.app/feed/create_post/'),
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
          print(modelsList[0].user!.username);
        }

        return modelsList;
      }
    } else {
      throw Exception('Failed to get Posts');
    }
  } catch (error) {
    if (error == http.ClientException) {
      if (kDebugMode) {
        print('No internet');
      }
    }
    if (kDebugMode) {
      print('Error getting Posts: $error');
    }
  }
  return [];
}
