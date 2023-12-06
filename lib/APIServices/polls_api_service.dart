import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/polls_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PollApiService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<Poll> createPoll({
    required String authToken,
    required String question,
    required List<String> options,
    required String duration,
    required String type,
    required String privacy,
    required List<XFile?> mediaFiles,
     DateTime? endTime, // New parameter
  }) async {
    try {
      String formattedEndTime = endTime?.toIso8601String() ?? '';

      final response = await http.post(
        Uri.parse('$baseUrl/poll/polls/'), // Update the endpoint as needed
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': question,
          'options': options,
          'duration': duration,
          'type': type,
          'privacy': privacy,
          'media_files': mediaFiles.map((file) => file?.path).toList(),
          'end_time': formattedEndTime, // Include endTime in the payload
   
        }),
      );

      print(response.body);

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Poll.fromJson(data);
      } else {
        throw Exception('Failed to create poll');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to create poll');
    }
  }

  Future<List<Poll>> getPolls({
    required String authToken,
  }) async {
    try {
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
}
