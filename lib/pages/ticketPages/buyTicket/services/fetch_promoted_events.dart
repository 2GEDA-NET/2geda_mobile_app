import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;
String? authToken;

Future<List<Event>> getPromotedEvents() async {
  final authToken = TokenManager().getToken();
  print("authToken: $authToken");

  final response = await http.get(
    Uri.parse('$baseUrl/ticket/event-promoted'),
    headers: {
      'Authorization': 'Token $authToken',
      'Content-Type': 'application/json',
    },
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    List<Event> events = data.map((json) => Event.fromJson(json)).toList();

    return events;
  } else {
    throw Exception('Failed to load events');
  }
}
