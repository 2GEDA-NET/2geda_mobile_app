import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/polls_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;

Future<List<Poll>> getPolls() async {
  try {
    final authToken = await TokenManager().getToken(); // Await here
    print(authToken);

    final response = await http.get(
      Uri.parse('$baseUrl/poll/polls/'), // Update the endpoint as needed
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Poll.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get polls');
    }
  } catch (e) {
    print('Exception: $e');
    throw Exception('Failed to get polls');
  }
}
