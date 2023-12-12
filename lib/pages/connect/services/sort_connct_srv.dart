import 'dart:convert';

import 'package:_2geda/APIServices/api_config.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class SortConnctServiceNotifier extends ValueNotifier<bool> {
  SortConnctServiceNotifier() : super(false);

  Future sortConnctService({
    required int startAge,
    required int endAge,
    required String location,
    required String gender,
    required bool verifiedAccount,
  }) async {
    try {
      value = true;
      final Map<String, dynamic> requestData = {
        "start_age": startAge,
        "end_age": endAge,
        "location": location,
        "gender": gender,
        "verified_account": verifiedAccount
      };
      const baseUrl = ApiConfig.baseUrl;
      const apiUrl = '$baseUrl/users/connect/sort/';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token 2c14ffed0ee18a8ed4a31a0b1ec413f42413f96f',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = jsonDecode(response.body);
        if (kDebugMode) {
          print('Data posted successfully');
        }
        value = false;
        return responseData;
      } else {
        value = false;
        throw Exception('Failed to post data');
      }
    } catch (error) {
      value = false;
      if (kDebugMode) {
        print('Error posting data: $error');
      }
    }
  }
}
