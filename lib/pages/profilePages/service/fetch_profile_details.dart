import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/profilePages/data/uer_profile_res.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;
String? authToken;

Future<UserProfileModel> userProfileSrv() async {
  final authToken = await TokenManager().getToken();
  print("authToken: $authToken");

  final response = await http.get(
    Uri.parse('$baseUrl/userinfo/'),
    headers: {
      'Authorization': 'Token $authToken',
      'Content-Type': 'application/json',
    },
  );

  if (kDebugMode) {
    print(response.statusCode);
    print(response.body);
  }

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final events = UserProfileModel.fromJson(data);
    print(events);

    return events;
  } else {
    throw Exception('Failed to load Events');
  }
}
