import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:http/http.dart' as http;

class StereoApiService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<List<AudioModel>> fetchQuickPickAudioList(
    String authToken,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stereo/quick-pick-songs/'),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return parseAudioList(jsonList);
    } else {
      throw Exception('Failed to load audio list');
    }
  }

  List<AudioModel> parseAudioList(List<dynamic> list) {
    return list.map((json) => AudioModel.fromJson(json)).toList();
  }
}
