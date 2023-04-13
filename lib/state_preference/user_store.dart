import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/getuser_api_service.dart';

Future<UserModel?> getAuthUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? currentUserId = prefs.getString('current_user_id') ?? "";
  print("----------------------$currentUserId");
  return UserModel.fromJson(usersRef.doc(currentUserId).get());
}
