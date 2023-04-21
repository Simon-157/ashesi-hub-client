import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../enums/constants.dart';

class ApiService {
  static Future<Map> getStudent(String id) async {
    String apiUrl = '${Constants.apiBaseUrl}/get_student/$id';
    final url = Uri.parse(apiUrl);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(url, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to submit form data');
    }
  }
}
