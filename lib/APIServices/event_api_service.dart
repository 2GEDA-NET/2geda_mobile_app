import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
    required bool showRemainingTicket,
    XFile? selectedImage,
  }) async {
    try {
       var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/ticket/events/'),
      );

      request.headers['Authorization'] = 'Token $authToken';
      request.headers['Content-Type'] = 'application/json';

      print('Request Headers: ${request.headers}');

      request.fields['title'] = title;
      request.fields['desc'] = description;
      request.fields['platform'] = platform;
      request.fields['url'] = websiteUrl;
      request.fields['location'] = address;
      request.fields['ticket[category]'] = ticketName;
      request.fields['ticket[price]'] = price.toString();
      request.fields['ticket[quantity]'] = quantity.toString();

      // Add image file if available
      if (selectedImage != null) {
        var file = await http.MultipartFile.fromPath(
          'image',
          selectedImage.path,
        );
        request.files.add(file);
      }

      var response = await request.send();

      // Check for a successful response (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response if necessary
        // You might want to decode the response depending on your API
        // For example, if your API returns JSON, you could do:
        var jsonResponse = json.decode(await response.stream.bytesToString());

        // Form submission was successful
        return true;
      } else {
        // Form submission failed
        print('Error: ${response.statusCode}');
        print('Body: ${await response.stream.bytesToString()}');
        return false;
      }
    } catch (e) {
      // Exception occurred during form submission
      print('Exception: $e');
      return false;
    }
  }
}
