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

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Event> events = data.map((json) => Event.fromJson(json)).toList();

      return events;
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<bool> createEvent({
    required String authToken,
    required String title,
    required String description,
    required String platform,
    required String websiteUrl,
    required LatLng location,
    required String address,
    required String ticketName,
    required String category,
    required String feeSettingCategory,
    required int quantity,
    required String price,
    required bool isPrivate,
    required bool isPublic,
    required bool isPaid,
    required bool isFree,
    required bool showRemainingTicket,
    XFile? selectedImage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/ticket/events/'),
      );

      request.headers['Authorization'] = 'Token $authToken';

      print('Request Headers: ${request.headers}');

      // Add form data
      request.fields['title'] = title;
      request.fields['desc'] = description;
      request.fields['platform'] = platform;
      request.fields['events_category_name'] = category;
      request.fields['url'] = websiteUrl;
      request.fields['location'] = address;
      request.fields['is_paid'] = isPaid.toString();
      // request.fields['is_free'] = isFree.toString();
      request.fields['ticket_category'] = ticketName;
      request.fields['ticket_price'] = price.toString();
      request.fields['ticket_quantity'] = quantity.toString();

      // Add image file if available
      if (selectedImage != null) {
        var file = await http.MultipartFile.fromPath(
          'events_category_image',
          selectedImage.path,
        );
        request.files.add(file);
      }

      var response = await request.send();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonResponse = json.decode(await response.stream.bytesToString());
        return true; // Return a value for success
      } else {
        print('Error: ${response.statusCode}');
        print('Body: ${await response.stream.bytesToString()}');
        return false; // Return a value for failure
      }
    } catch (e) {
      print('Exception: $e');
      return false; // Return a value for exception
    }
  }
}
