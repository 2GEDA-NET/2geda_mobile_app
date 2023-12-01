import 'dart:convert';
import 'dart:io';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/mediamodel.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PostService {
  final String baseUrl = ApiConfig.baseUrl;
  late String? userId;

  Future<Map<String, dynamic>> createPost({
    required String authToken,
    required String postText,
    required List<String> hashtags,
    required List<File> allMediaFiles,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/feed/create_post/'),
      );

      _addHeaders(request, authToken);

      _addPostContent(request, postText, hashtags);

      await _addAllMediaFiles(request, allMediaFiles);

      _printRequestDetails(request);

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      // Check for success (200 or 201 status code)
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseDataString = jsonDecode(responseData.body);
        final rs = MediaModel.fromJson(responseDataString);
        if (kDebugMode) {
          print('Response body: $responseDataString');
          print('Response Media: ${rs.eachMedia}');
        }
        return {'success': true, 'data': responseDataString};
      } else {
        var errorMessage = responseData.reasonPhrase ?? 'Unknown error';
        if (kDebugMode) {
          print('Failed to create post: $errorMessage');
        }
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      return {'success': false, 'error': 'Network error: $error'};
    }
  }

  void _addHeaders(http.MultipartRequest request, String authToken) {
    request.headers['Authorization'] = 'Token $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
  }

  void _addPostContent(
    http.MultipartRequest request,
    String postText,
    List<String> hashtags,
  ) {
    request.fields['content'] = postText;
    request.fields['hashtags'] = hashtags.join(',');
  }

  Future<void> _addAllMediaFiles(
    http.MultipartRequest request,
    List<File> allMediaFiles,
  ) async {
    for (var mediaFile in allMediaFiles) {
      request.files.add(await http.MultipartFile.fromPath(
        'media',
        mediaFile.path,
      ));
    }
  }

  void _printRequestDetails(http.MultipartRequest request) {
    if (kDebugMode) {
      print('Request headers: ${request.headers}');
    }
    if (kDebugMode) {
      print('Request fields: ${request.fields}');
    }
    if (kDebugMode) {
      print('Request files: ${request.files}');
    }
    if (kDebugMode) {
      print('Request url: $baseUrl/feed/create_post/');
    }
  }

  //!

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
