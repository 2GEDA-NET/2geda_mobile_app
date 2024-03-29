import 'dart:convert';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/connect/data/get_conct_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GetConnectNotifier
    extends ValueNotifier<DataState<List<GetConnectModel>>> {
  GetConnectNotifier() : super(DataState.loading());

  Future fetchData() async {
    try {
      final token = await TokenManager().getToken();
      Map<String, String> serviceHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      };
      value = DataState.loading();
      final response = await http.get(
          Uri.parse('https://development.2geda.net/users/connect/'),
          headers: serviceHeaders);

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List<dynamic>) {
          final List<dynamic> userList = responseData;
          final List<GetConnectModel> modelsList = userList
              .map((userData) => GetConnectModel.fromJson(userData))
              .toList();

          value = DataState.loaded(modelsList);
          if (kDebugMode) {
            print('Data loaded successfully');
          }
          if (kDebugMode) {
            print(modelsList[0].media[0].profileImage);
          }

          return modelsList;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      value = DataState.error(error.toString());
    }
  }
}

class DataState<T> {
  final T? data;
  final String? error;
  final bool isLoading;

  DataState({this.data, this.error, required this.isLoading});

  factory DataState.loading() => DataState(isLoading: true);

  factory DataState.loaded(T data) => DataState(data: data, isLoading: false);

  factory DataState.error(String error) =>
      DataState(error: error, isLoading: false);
}
