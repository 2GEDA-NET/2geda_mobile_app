import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'api_config.dart';

class AuthenticationApiService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<http.Response> signUp(String username, String password, String input,
      bool isPhoneNumber) async {
    Map<String, String> requestBody = {};

    if (isPhoneNumber) {
      requestBody = {
        'phone_number': input,
        'password': password,
        'username': username,
      };
    } else {
      requestBody = {
        'email': input,
        'password': password,
        'username': username,
      };
    }

    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      body: requestBody,
    );

    return response;
  }

  Future<http.Response> signIn(String username, String password) async {
    final Map<String, String> requestBody = {
      'username': username,
      'password': password,
    };

    print(requestBody);

    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      body: requestBody, // Send the data as form data
    );

    return response;
  }

  Future<http.Response> verifyOTP(String otpCode, String token) async {
    final Map<String, dynamic> data = {
      'otp_code': otpCode,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp/'), // Replace with the correct endpoint
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(data),
    );

    return response;
  }

  Future<http.Response> resendOTP(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/resend-otp/'), // Replace with the correct endpoint
      headers: {
        'Authorization': 'Token $token',
      },
    );

    return response;
  }

  Future<http.Response> updateProfile(
    String token,
    String firstName,
    String lastName,
    String work,
    DateTime dateOfBirth,
    String religion,
    int identity,
    String customGender,
    Map<String, String> user,
  ) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(dateOfBirth);

    final Map<String, dynamic> requestBody = {
      'user': {
        'first_name': firstName,
        'last_name': lastName,
      },
      'work': work,
      'date_of_birth': formattedDate,
      'religion': religion,
      'identity': identity,
      'custom_gender': customGender,
    };

    print(requestBody);

    final response = await http.put(
      Uri.parse('$baseUrl/user-profile/update/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<http.Response> uploadProfileImage(
      String token, String imagePath) async {
    final url = Uri.parse(
        '$baseUrl/update-profile-images/'); // Replace with the correct endpoint

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Token $token'
      ..files.add(
        await http.MultipartFile.fromPath('profile_image', imagePath),
      );

    final response = await http.Response.fromStream(await request.send());

    return response;
  }


  Future<bool> hasUpdatedProfile(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile/update-status/'), // Replace with the correct endpoint
      headers: {
        'Authorization': 'Token $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final bool hasUpdatedProfile = data['response'] ?? false;
      return hasUpdatedProfile;
    } else {
      // Handle error, you can throw an exception or return a default value
      return false;
    }
  }
}
