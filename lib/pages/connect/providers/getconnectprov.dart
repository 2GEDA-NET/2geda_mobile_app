// user_provider.dart
import 'package:_2geda/pages/connect/data/get_conct_model.dart';
import 'package:_2geda/pages/connect/services/getconnect_srv.dart';
import 'package:flutter/foundation.dart';

// class GetConnectProvider extends ChangeNotifier {
//   final GetConnectService _cnnctService = GetConnectService(
//       'https://king-prawn-app-venn6.ondigitalocean.app/users/connect/');
//   List<GetConnectModel> _cnncts = [];

//   List<GetConnectModel> get cnncts => _cnncts;

//   Future<void> fetchUsers() async {
//     try {
//       _cnncts = await _cnnctService.getUsers();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching cnncts: $e');
//     }
//   }
// }
