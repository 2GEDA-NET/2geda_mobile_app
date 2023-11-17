import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<Map<String, dynamic>> createPost({
    required String authToken,
    required String postText,
    // Add other necessary parameters for your API
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$baseUrl/feed/create_post/'), // Replace with your actual API endpoint
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'content': postText,
          // Add other necessary fields from your post data
        }),
      );

      if (response.statusCode == 200) {
        // Successfully created post
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        // Failed to create post
        return {'success': false, 'error': response.body};
      }
    } catch (error) {
      // Handle network errors
      return {'success': false, 'error': 'Network error: $error'};
    }
  }

  Future<List<Post>> fetchPosts(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/feed/all-post/'),
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        print('Type of data: ${data.runtimeType}');
        print('First item in data: ${data.isNotEmpty ? data[0] : 'Empty'}');

        if (data.every((item) => item is Map<String, dynamic>)) {
          return data.map((json) => Post.fromJson(json)).toList();
        } else {
          print(
              'API Error: Invalid data format, expected a List<Map<String, dynamic>>');
          throw Exception('Failed to load posts');
        }
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print('Network Error: $error');
      throw Exception('Failed to load posts');
    }
  }
}
