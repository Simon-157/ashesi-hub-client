import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../enums/constants.dart';


/// The UserService class provides methods to get the current authenticated user's UID and update their
/// online status.
class UserService extends Service {
  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }


  setUserStatus(bool isOnline) {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      usersRef
          .doc(user.uid)
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }


  static Future<dynamic> submitFormData(Map<String, dynamic> formData) async {
    const apiUrl = '${Constants.apiBaseUrl}/register';
    final url = Uri.parse(apiUrl);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(formData);
    final response = await http.post(url, headers: headers, body: body);
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit form data');
    }
  }


/// This function updates a student profile by sending a PUT request to an API endpoint with the
/// provided form data and returns the response as a JSON object.
/// Returns:
///   a Future that resolves to a Map<String, dynamic> object.
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


/// This function retrieves a student's data from an API using their ID.
/// Returns:
///   a Future that resolves to a Map. The Map contains data about a student, retrieved from an API
/// endpoint. If the API call is successful (response status code is 200), the function returns the
/// 'data' field of the response body as a Map. If the API call fails, the function throws an Exception
/// with the message 'Failed to submit form data'.
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
