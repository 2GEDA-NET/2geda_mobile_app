import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StereoApiService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<List<AudioModel>> fetchQuickPickAudioList(String authToken) async {
    try {
      // Check if cached data is available
      final String cachedData = await getLocalData('quickPickAudioList');
      if (cachedData.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return parseAudioList(jsonList, authToken);
      }

      // If no cached data, fetch from the network
      final response = await http.get(
        Uri.parse('$baseUrl/stereo/quick-pick-songs/'),
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        // Save the fetched data to local cache
        saveDataLocally('quickPickAudioList', json.encode(jsonList));

        return parseAudioList(jsonList, authToken);
      } else {
        throw Exception('Failed to load audio list');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }

  Future<List<AudioModel>> parseAudioList(List<dynamic> list, String authToken) async {
    // Create a list of Futures for fetching audio details
    final List<Future<AudioModel>> futures = list.map((json) async {
      final audioModel = await AudioModel.fromJson(json, authToken);
      return audioModel;
    }).toList();

    // Execute all futures in parallel
    return Future.wait(futures);
  }

  Future<void> saveDataLocally(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getLocalData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? ''; // Default to an empty string if no data is found
  }
}
