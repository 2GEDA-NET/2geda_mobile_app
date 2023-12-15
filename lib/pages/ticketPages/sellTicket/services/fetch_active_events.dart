import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;
String? authToken;

Future<List<Event>> getActiveEvents() async {
  authToken = await TokenManager().getToken();

  print("authToken: $authToken");

  final response = await http.get(
    Uri.parse('$baseUrl/ticket/events'),
    headers: {
      'Authorization': 'Token $authToken',
      'Content-Type': 'application/json',
    },
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    if (response.body != null) {
      final List<dynamic> data = json.decode(response.body);

      List<Event> events = data.map((json) => Event.fromJson(json)).toList();

      return events;
    } else {
      throw Exception('Response body is null');
    }
  } else {
    throw Exception('Failed to load events');
  }
}
