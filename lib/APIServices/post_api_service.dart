import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/mediamodel.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/service/fetch_posts.dart';
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
            data.map((json) async => Post.fromJson(json)).toList(),
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
            data.map((json) async => Post.fromJson(json)).toList(),
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
        Uri.parse('$baseUrl/feed/react/post/'),
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

  Future<void> createComment(String authToken, int postId, String comment,
      List<String> filePaths) async {
    final url = Uri.parse('$baseUrl/feed/create-comment/');

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Token $authToken'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['post_id'] = postId.toString()
        ..fields['content'] = comment;

      for (var i = 0; i < filePaths.length; i++) {
        var file = await http.MultipartFile.fromPath('files[$i]', filePaths[i]);
        request.files.add(file);
      }

      var response = await http.Response.fromStream(await request.send());
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Comment created successfully
        fetchHomePGPosts();
        print('Comment created successfully');
      } else {
        // Handle error
        print('Failed to create comment. Status code: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('Network error');
      }
    } on TimeoutException catch (_) {
      if (kDebugMode) {
        print('Request timeout');
      }
    } catch (e) {
      // Handle network error
      print('Error creating comment: $e');
    }
  }

  // Future<List<PostComment>> getComments(String authToken, int postId) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/feed/get-comment/$postId/'),
  //       headers: {
  //         'Authorization': 'Token $authToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     print(response.body);

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = json.decode(response.body);

  //       return data
  //           .map<PostComment>((json) => PostComment.fromJson(json ?? {}))
  //           .toList();
  //     } else {
  //       print('API Error: ${response.statusCode} - ${response.body}');
  //       throw Exception('Failed to load comments');
  //     }
  //   } catch (error) {
  //     print('Network Error: $error');
  //     throw Exception('Failed to load comments');
  //   }
  // }

  // Future<User> fetchUserDetails(String authToken, int userId) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl$userId/'),
  //     headers: {
  //       'Authorization': 'Token $authToken',
  //       'Content-Type': 'application/json',
  //     },
  //   );

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     // If the server returns a 200 OK response, parse the user details
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     return User.fromJson(data);
  //   } else {
  //     // If the server did not return a 200 OK response, throw an exception
  //     throw Exception('Failed to load user details');
  //   }
  // }
}
