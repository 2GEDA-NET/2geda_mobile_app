import 'dart:convert';

import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/post/data/post_reaction_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostReactionServiceNotifier extends ValueNotifier<bool> {
  PostReactionServiceNotifier() : super(false);

  Future postReactionService({
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
      const apiUrl = '$baseUrl/feed/react/post/';
      final token = await TokenManager().getToken();
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
        final PostReactionModel model =
            PostReactionModel.fromJson(responseData);

        //! Store reaction type uniquely to local
        // await UserPreference.setReactionType(
        //     model.reaction[0].reactionType!, model.id.toString());

        if (kDebugMode) {
          print('reactionType: ${model.reaction[0].reactionType}');
        }

        value = false;
        return model;
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
