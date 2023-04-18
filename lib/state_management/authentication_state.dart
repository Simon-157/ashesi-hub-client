import 'package:hub_client/models/user_model.dart';

class AuthenticationState {
  final UserModel? user;
  final bool isAuthenticated;

  AuthenticationState({
    required this.user,
    required this.isAuthenticated,
  });
}
