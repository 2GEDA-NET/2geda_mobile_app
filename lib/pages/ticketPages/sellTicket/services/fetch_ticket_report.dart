import 'dart:convert';

import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;

Future<List<TicketReportData>> getTicketReport() async {
  final authToken = await TokenManager().getToken();
  final response = await http.get(
    Uri.parse('$baseUrl/ticket/report'),
    headers: {
      'Authorization': 'Token $authToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    List<TicketReportData>? ticketDataList =
        data.map((json) => TicketReportData.fromJson(json)).cast<TicketReportData>().toList();

    return ticketDataList;
  } else {
    throw Exception('Failed to load tickets report');
  }
}
