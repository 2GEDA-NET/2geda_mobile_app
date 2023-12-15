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

  try {
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
      print(response.body);
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Event> events = jsonData.map((data) => Event.fromJson(data)).toList();
      return events;
    } else {
      throw Exception(
          'Failed to load event data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception(
        'Failed to load event data. Check your network connection.');
  }
}
