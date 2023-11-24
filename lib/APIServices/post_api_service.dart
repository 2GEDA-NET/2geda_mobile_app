import 'dart:convert';
import 'dart:io';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/homeScreens/create_post.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostService {
  final String baseUrl = ApiConfig.baseUrl;
  String? userId;
  Future<Map<String, dynamic>> createPost({
    required String authToken,
    required String postText,
    required List<String> hashtags,
    required List<File> allMediaFiles,
  }) async {
    try {
      // Create a new multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/feed/create_post/'),
      );

      // Add headers
      request.headers['Authorization'] = 'Token $authToken';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add post content
      request.fields['content'] = postText;
      request.fields['hashtags'] = hashtags.join(',');
      // Add all media files
      for (var mediaFile in allMediaFiles) {
        request.files.add(await http.MultipartFile.fromPath(
          'media',
          mediaFile.path,
        ));
      }

      // Print request details for debugging
      print('Request headers: ${request.headers}');
      print('Request fields: ${request.fields}');
      print('Request files: ${request.files}');

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      // Check for success (200 or 201 status code)
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        var responseDataString = responseData.body;
        print('Response body: $responseDataString');
        return {'success': true, 'data': jsonDecode(responseDataString)};
      } else {
        var errorMessage = responseData.reasonPhrase ?? 'Unknown error';
        print('Failed to create post: $errorMessage');
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      return {'success': false, 'error': 'Network error: $error'};
    }
  }

// Helper function to add media files to the request
  Future<void> addMediaFiles(
    http.MultipartRequest request,
    String field,
    List<dynamic>? mediaFiles,
  ) async {
    if (mediaFiles != null) {
      for (var i = 0; i < mediaFiles.length; i++) {
        var mediaFile = mediaFiles[i];
        if (mediaFile is XFile) {
          request.files.add(await http.MultipartFile.fromPath(
            field,
            mediaFile.path,
          ));
        } else if (mediaFile is Uint8List) {
          request.files.add(http.MultipartFile.fromBytes(
            field,
            mediaFile,
            filename: '$field$i', // Provide a generic filename
          ));
        } else if (mediaFile is File) {
          request.files.add(await http.MultipartFile.fromPath(
            field,
            mediaFile.path,
          ));
        }
        // Add other conditions based on the types of media you have
      }
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

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

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

  // ... Rest of the class
}
