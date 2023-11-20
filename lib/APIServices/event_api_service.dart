import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:http/http.dart' as http;

class TicketApiService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<List<Ticket>> getTickets(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/ticket/events'),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Ticket> tickets = data.map((json) => Ticket.fromJson(json)).toList();

      return tickets;
    } else {
      throw Exception('Failed to load tickets');
    }
  }
}
