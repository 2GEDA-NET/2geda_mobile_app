import 'dart:convert';
import 'dart:io';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/mediamodel.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:flutter/foundation.dart';
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

  Future<List<Post>> fetchPosts(String authToken,
      {int page = 1, int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/feed/create_post/?page=$page&limit=$limit'),
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          // Use Future.wait to wait for all the futures to complete
          return Future.wait(
            data.map((json) async => await Post.fromJson(json)).toList(),
          );
        } else {
          // If the data is empty, return an empty list
          return [];
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

  Future<List<Post>> fetchSavedPosts(
    String authToken,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/feed/saved-post/'),
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          // Use Future.wait to wait for all the futures to complete
          return Future.wait(
            data.map((json) async => await Post.fromJson(json)).toList(),
          );
        } else {
          return [];
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

  Future<void> addReaction(
    String authToken,
    int postId,
    String reaction,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://king-prawn-app-venn6.ondigitalocean.app/feed/react/'),
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'post_id': postId,
          'reaction_type': reaction,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        print('Reaction added successfully!');
      } else {
        print('Failed to add reaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

  }
}
