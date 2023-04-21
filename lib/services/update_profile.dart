import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:hub_client/services/base_service.dart';

import '../enums/constants.dart';

/// The `UpdateProfileService` class provides a static method to update a student profile using HTTP PUT request
/// with JSON data.
class UpdateProfileService extends Service {
  static Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> formData, profileId) async {
    final apiUrl = '${Constants.apiBaseUrl}/update_student/$profileId';
    final url = Uri.parse(apiUrl);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(formData);
    final response = await http.put(url, headers: headers, body: body);
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update profile');
      // return json.decode(response.body);
    }
  }
}
