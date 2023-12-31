import 'dart:convert';

import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostCommentsNotifier extends ValueNotifier<bool> {
  PostCommentsNotifier() : super(false);

  Future postCommentsService({
    required int postId,
    required String reactionType,
  }) async {
    try {
      value = true;
      final Map<String, dynamic> requestData = {
        "post_id": postId,
        "reaction_type": reactionType,
      };
      const baseUrl = ApiConfig.baseUrl;
      final token = await TokenManager().getToken();
      const apiUrl = '$baseUrl/feed/create-comment/';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(requestData),
      );

      if (kDebugMode) {
        print(postId);
        print(reactionType);
        print(apiUrl);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = jsonDecode(response.body);

        if (kDebugMode) {
          print('reactionType: $responseData');
        }

        value = false;
      } else {
        value = false;
        throw Exception('Failed to post data');
      }
    } catch (error) {
      value = false;
      if (kDebugMode) {
        print('Error posting data: $error');
      }
    }
  }
}
