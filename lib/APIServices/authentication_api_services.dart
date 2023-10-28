import 'dart:convert';

import 'package:http/http.dart' as http;
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

  Future<http.Response> signIn(String emailOrPhone, String password) async {
    final Map<String, dynamic> requestBody = {
      'emailOrPhone': emailOrPhone,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {
        'Content-Type': 'application/json', // Replace with your desired headers
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<void> verifyOTP(String otpCode, String token) async {
    final Map<String, dynamic> data = {
      'otp_code': otpCode,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/verify_otp/'), // Replace with the correct endpoint
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // OTP verification succeeded, proceed to the next step
      print('OTP verification successful');
      // Handle successful verification here, e.g., navigate to the next screen
    } else if (response.statusCode == 400) {
      // OTP verification failed
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      print('OTP verification failed: ${errorResponse['error']}');
      // Handle failed verification, e.g., show an error message
    } else {
      // Handle other response codes as needed
      print('OTP verification failed with status code: ${response.statusCode}');
    }
  }
}
