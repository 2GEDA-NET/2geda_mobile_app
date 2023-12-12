// user_service.dart
import 'dart:convert';
import 'package:_2geda/pages/connect/data/get_conct_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetConnectNotifier extends ValueNotifier<DataState<GetConnectModel>> {
  GetConnectNotifier() : super(DataState.loading());

  Future fetchData() async {
    try {
      Map<String, String> serviceHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Token 2c14ffed0ee18a8ed4a31a0b1ec413f42413f96f',
      };
      value = DataState.loading();
      final response = await http.get(
          Uri.parse(
              'https://king-prawn-app-venn6.ondigitalocean.app/users/connect/'),
          headers: serviceHeaders);

      if (response.statusCode == 200) {
        final apiResponse =
            GetConnectModel.fromJson(json.decode(response.body));
        print('Suvvvvvvvvvvvvvvvvv');
        return apiResponse;
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
