import 'dart:convert';
import 'dart:io';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;
String? authToken;

Future<Map<String, dynamic>> updateProfile({
  required String postText,
  required List<String> hashtags,
  required List<File> allMediaFiles,
}) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/profile/update/'),
    );
    final authToken = await TokenManager().getToken();

    _addHeaders(request, '2c14ffed0ee18a8ed4a31a0b1ec413f42413f96f');

    _addPostContent(request, postText, hashtags);

    await _addAllMediaFiles(request, allMediaFiles);

    _printRequestDetails(request);

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    // Check for success (200 or 201 status code)
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseDataString = jsonDecode(responseData.body);
      // final rs = MediaModel.fromJson(responseDataString);
      if (kDebugMode) {
        print('Response body: $responseDataString');
        // print('Response Media: ${rs.eachMedia}');
      }
      return {'success': true, 'data': responseDataString};
    } else {
      var errorMessage = responseData.reasonPhrase ?? 'Unknown error';
      if (kDebugMode) {
        print('Failed to update profile: $errorMessage');
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
