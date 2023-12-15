import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TicketApiService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<List<Event>> getTickets(String authToken) async {
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
      final List<dynamic> data = json.decode(response.body);

      List<Event> events = data.map((json) => Event.fromJson(json)).toList();

      return events;
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<List<Event>> getUpcomingEvents(String authToken) async {
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
      final List<dynamic> data = json.decode(response.body);

      List<Event> events = data.map((json) => Event.fromJson(json)).toList();

      return events;
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<List<Event>> getActiveEvents(String authToken) async {
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
      final List<dynamic> data = json.decode(response.body);

      List<Event> events = data.map((json) => Event.fromJson(json)).toList();

      return events;
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<List<Event>> getPastEvents(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/ticket/event-past/'),
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
      throw Exception('Failed to load tickets');
    }
  }

  Future<List<Event>> getPopularEvents(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/ticket/event-popular'),
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
      throw Exception('Failed to load tickets');
    }
  }

  Future<List<Event>> getPromotedEvents(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/ticket/event-popular'),
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
      throw Exception('Failed to load tickets');
    }
  }

  
}
