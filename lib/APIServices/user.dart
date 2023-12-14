
  // static Future<Map<String, dynamic>> fetchUserProfile(int userId) async {
  //   final String? authToken = await TokenManager().getToken();
  //   if (authToken == null) {
  //     throw Exception('No authentication token found.');
  //   }

  //   final response = await http.get(
  //     Uri.parse('$baseUrl/users-list/$userId/'),
  //     headers: {
  //       'Authorization': 'Token $authToken',
  //       'Content-Type': 'application/json',
  //     },
  //   );

  //   print("user profile: ${response.body}");

  //   if (response.statusCode == 200) {
  //     final List<dynamic> userProfiles = json.decode(response.body);
  //     return userProfiles.first['user_profile'][0];
  //   } else {
  //     throw Exception('Failed to load user profile');
  //   }
  // }

  // static Future<Map<String, dynamic>> fetchUserDetails(int userId) async {
  //   final String? authToken = await TokenManager().getToken();
  //   if (authToken == null) {
  //     throw Exception('No authentication token found.');
  //   }

  //   final response = await http.get(
  //     Uri.parse('$baseUrl/users-list/$userId/'),
  //     headers: {
  //       'Authorization': 'Token $authToken',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final List<dynamic> userDetails = json.decode(response.body);
  //     return userDetails.first['user'][0];
  //   } else {
  //     throw Exception('Failed to load user details');
  //   }
  // }

  // static Future<List<String>> fetchUserImages(int userId) async {
  //   final String? authToken = await TokenManager().getToken();
  //   if (authToken == null) {
  //     throw Exception('No authentication token found.');
  //   }

  //   final response = await http.get(
  //     Uri.parse('$baseUrl/users-list/$userId/'),
  //     headers: {
  //       'Authorization': 'Token $authToken',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final List<dynamic> userImages = json.decode(response.body);
  //     return userImages.first['user_image']
  //         .map<String>((item) => item['profile_image'] as String)
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load user images');
  //   }
  // }