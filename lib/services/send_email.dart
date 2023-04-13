import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../enums/constants.dart';

/// The class is an API service that submits form data to a specified URL and returns the
/// response.
class ApiService {
  static Future<dynamic> sendEmail(id) async {
    final apiUrl = '${Constants.apiBaseUrl}/email/$id';
    final url = Uri.parse(apiUrl);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(url, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send email');
    }
  }
}
